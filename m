Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316804AbSFUVdu>; Fri, 21 Jun 2002 17:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316799AbSFUVdt>; Fri, 21 Jun 2002 17:33:49 -0400
Received: from waste.org ([209.173.204.2]:35258 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S316798AbSFUVds>;
	Fri, 21 Jun 2002 17:33:48 -0400
Date: Fri, 21 Jun 2002 16:33:28 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Patrick Mochel <mochel@osdl.org>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
       Linus Torvalds <torvalds@transmeta.com>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <Pine.LNX.4.33.0206201230190.654-100000@geena.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0206211616510.16808-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2002, Patrick Mochel wrote:

> > But it was entierly behind me how to fit this
> > in to the sheme other sd@4,0:h,raw
> > OS-es are using. And finally how would one fit this in to the
> > partitioning shemes? For the system aprtitions are simply
> > block devices hanging off the corresponding block device.
>
> Partitions are purely logical entities on a physical disk. They have no
> presence in the physical device tree.

As I raised elsewhere in this thread, the distinction between physical and
logical is troubling. Consider iSCSI, (aka SCSI-over-IP). It's analogous
to SCSI-over-Fibre Channel, except that rather than using an embedded FC
stack, it's using the kernel's IP stack. But it's every bit as much a SCSI
disk/tape/whatever as a local device. Ergo, it ought to show up in the
device tree so that it can be discovered in the same way. But where?

This is only one step (the SCSI midlayer) removed from the logical devices
created by partitioning, LVM, NBD, MD, loopback, ramdisk and the like,
that again, ought to be discoverable in the same way as all other block
devices. Perhaps we need root/{virtual,logical}?

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

