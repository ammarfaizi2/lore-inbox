Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbVL3Mbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbVL3Mbk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 07:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVL3Mbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 07:31:40 -0500
Received: from cmu-24-35-112-99.mivlmd.cablespeed.com ([24.35.112.99]:62930
	"EHLO dad.localdomain") by vger.kernel.org with ESMTP
	id S1750826AbVL3Mbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 07:31:39 -0500
Date: Fri, 30 Dec 2005 07:31:24 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@dad.localdomain
To: Erez Zilber <erezz@voltaire.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: cannot boot 2.6.15-rc6 on Opteron machine
In-Reply-To: <43B3CA9E.7000804@voltaire.com>
Message-ID: <Pine.LNX.4.63.0512300725300.5860@dad.localdomain>
References: <43B3CA9E.7000804@voltaire.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2005, Erez Zilber wrote:

> Hi,
> 
> I've downloaded kernel 2.6.15-rc6 (had the same problem with rc7) and built it
> on RHAS 4:
> 
> When I did that on an Opteron machine, after rebooting and selecting the
> 2.6.15-rc6 entry in the grub menu, I get the following:
> 
> Uncompressing Linux... Ok, booting the kernel.
> Kernel panic - not syncing: VFS: unable to mount root fs on unknown-block(0,0)
> 
> I made sure that ext2 is compiled with the kernel (not as a module).
> 
> When I do the same on an emt64 machine, everything works ok. Any idea?

Check on your /boot/grub.config.  The above error message is typically 
seen when the root= parameter points to a symbolic disk label instead of a 
specific disk such as /dev/hda1.  I'm not sure what the procedure for 
updating where the label points (possibly a mkinitrd) because I normally 
change the grub.conf to point to a specific disk.
