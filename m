Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751969AbWCBNke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbWCBNke (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 08:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbWCBNkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 08:40:33 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:157 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1751969AbWCBNkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 08:40:33 -0500
Date: Thu, 2 Mar 2006 14:40:39 +0100
From: Sander <sander@humilis.net>
To: Paolo Roberti <tesla@thgnet.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: My desperation: Oops during mkfs.ext3 on large partitions
Message-ID: <20060302134039.GB10924@favonius>
Reply-To: sander@humilis.net
References: <001501c63dfb$298d2780$040010ac@Tesla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001501c63dfb$298d2780$040010ac@Tesla>
X-Uptime: 13:35:36 up 3 days, 19:28, 19 users,  load average: 3.81, 3.16, 3.00
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Roberti wrote (ao):
> I've tried remapping IRQs, switching PCI slots, removing unused PCI cards, 
> attaching this HD as slave and running mkfs.ext3 from a running system with 
> Red Hat 9 (i'd always been trying from a PXE booted Fedora Core 4). There 
> seems to be NO way to run mkfs from this computer.
> 
> What drives me crazy is that badblocks (read and read/write) runs smooth, 
> so the partition is fully addressable from the PCI controller...

Do you get any output at all from mkfs.ext3?

Can you try mkfs.ext2 and mkreiserfs?

Can you try to mkfs the whole disk? (/dev/hda)

Can you try 'dd if=/dev/zero of=/dev/hda bs=1k' ?

What controller do you have? (lspci -v)

Can you swap the controller or is it onboard?

Can you try a vanilla kernel?

Maybe this helps to get more info about what you experience.

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
