Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbSKTRvW>; Wed, 20 Nov 2002 12:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261642AbSKTRvW>; Wed, 20 Nov 2002 12:51:22 -0500
Received: from air-2.osdl.org ([65.172.181.6]:63194 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261568AbSKTRvV>;
	Wed, 20 Nov 2002 12:51:21 -0500
Date: Wed, 20 Nov 2002 11:57:43 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Mike Anderson <andmike@us.ibm.com>
cc: Rick Lindsley <ricklind@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.47: sysfs hierarchy can begin to disintegrate
In-Reply-To: <20021120175127.GC1366@beaverton.ibm.com>
Message-ID: <Pine.LNX.4.33.0211201153590.1134-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 20 Nov 2002, Mike Anderson wrote:

> Rick Lindsley [ricklind@us.ibm.com] wrote:
> > 2.5.47 (top of bk tree on 11/14, to be precise)
> > 
> > /sys has a sysfs file system on it.  I'd expect /sys/block to contain
> > hd[abc], an assortment of ram disks, and perhaps some SCSI disks.
> > However, these all appear under /sys instead of /sys/block.  /sys/block
> > exists but is empty.
> > 
> > Interesting observation: the megaraid controller has some problem right
> > now (suspected to be hardware) wherein its scsi disks appear at boot
> > time but then cannot be accessed later and are subsequently detached.
> > Since this could well be a little-used and little-tested path, my
> > suspicion is that either the megaraid, scsi, or sysfs code has a bug when
> > disks are detached.  So far, I've not been able to find one, however, so
> > I thought I'd report this in case others might know just where to peek.
> > Could it be that removing entries from sysfs is done incorrectly in
> > some cases?
> 
> Rick,
> 	There are cleanup issues in sysfs previous reported by others.
> 	The patch below previously sent to the list by patmans and
> 	myself helps in repeated insmod / rmmod / shutdown testing of
> 	scsi modules for us. We have not seen the null parent pointer
> 	problem you are seeing which causes your objects to show up
> 	under /sys/ (YMMV).

I have not seen it, either. What SCSI driver is it? Is it modular or not? 
Or, does it matter?

I apologize for the long delay in replying and integrating patches. I've 
been moving, and readjusting, and sifting through email from the past 1.5 
months, and tryign to fix up the various problems that people have 
reported. I have integrated the patch just posted, BTW.

	-pat


