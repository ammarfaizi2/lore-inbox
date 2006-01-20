Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWATTtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWATTtf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWATTtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:49:35 -0500
Received: from sccrmhc12.comcast.net ([63.240.77.82]:16539 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932100AbWATTtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:49:33 -0500
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
cc: Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata_mv important note 
In-reply-to: <58cb370e0601190335w51bb1d25pb5ae575632cedbad@mail.gmail.com> 
References: <43CD07D5.30302@pobox.com> <E1EytdC-0006DE-IS@highlab.com> <200601171734.25598.arekm@pld-linux.org> <E1EyxRD-0007Nd-U5@highlab.com> <58cb370e0601190335w51bb1d25pb5ae575632cedbad@mail.gmail.com>
Comments: In-reply-to Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
   message dated "Thu, 19 Jan 2006 12:35:40 +0100."
Date: Fri, 20 Jan 2006 12:49:37 -0700
From: Sebastian Kuzminsky <seb@highlab.com>
Message-Id: <E1F02GP-0004IR-O2@highlab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On 1/17/06, Sebastian Kuzminsky <seb@highlab.com> wrote:
> > 0000:02:01.0 IDE interface: Marvell Technology Group Ltd. MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
> >
> > I'm running the stock 2.6.15 kernel & the in-kernel driver.  I have four
> > disks on this controller.  The controller and disks seem perfectly stable,
> > I've been running four parallel "badblocks -n" processes (one on each
> > disk) for almost 5 days now.  Using the disks as PVs in LVM works fine,
> > and building a RAID-6 out of them also works fine.
> >
> > But when I build a RAID-6 out of them, and use the array as a PV
> > for LVM, the system locks up within seconds (no errors, no sysrq,
> > no CapsLock-blinky, no network-pingy).  This behavior is perfectly
> > repeatable.
> 
> Have you tried using "nmi_watchdog=1" kernel parameter?

I just tried this and it hung again, with nothing in the logs or on
the console.

Pretty wierd.

I just had another hard lockup with sata_mv -> Raid-6, but without LVM.
This is new for me, first time I've seen it lock up without LVM.  I was
resyncing the raid array and running 'badblocks -svn' on it (/dev/md1)
at the same time, and it locked.

I'm going to shelve the Marvell 6081 controller for a while, and go buy
something else...


-- 
Sebastian Kuzminsky
