Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265306AbUFHUOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265306AbUFHUOu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 16:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265310AbUFHUOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 16:14:50 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:59009 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265306AbUFHUOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 16:14:49 -0400
Date: Tue, 8 Jun 2004 22:14:46 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       shaggy@austin.ibm.com
Subject: Re: Linux 2.4.26 JFS: cannot mount
Message-ID: <20040608201446.GA13764@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	shaggy@austin.ibm.com
References: <20040608195610.GA4757@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040608195610.GA4757@merlin.emma.line.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Jun 2004, Matthias Andree wrote:

> I recently had a mount failure for a jfs file system at boot-up, mount
> complained about bad options or superblock, but no messages were stuffed
> in dmesg.
> 
> Running fsck.jfs /dev/hda6 without further argument fixed this problem,
> after fsck.jfs, I could mount the file system normally.
> (fsck.jfs version 1.1.1, 17-Dec-2002)

Further info, it turned out that the fsck column for the respective file
system was 0. It has now been fixed to 2.

Question: is the JFS kernel driver supposed to mount a dirty file system
(replaying journal or whatever) without user space help - for instance,
if it's used as root file system?
