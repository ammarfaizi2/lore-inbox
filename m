Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbUBXQGz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 11:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbUBXQFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 11:05:12 -0500
Received: from mail.ccur.com ([208.248.32.212]:8712 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S262198AbUBXQEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 11:04:40 -0500
Date: Tue, 24 Feb 2004 11:04:39 -0500
From: Joe Korty <joe.korty@ccur.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] SCSI update for 2.6.3
Message-ID: <20040224160439.GA21943@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <1077596668.1983.282.camel@mulgrave> <20040224152451.GA21699@tsunami.ccur.com> <1077636866.2152.55.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077636866.2152.55.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 09:34:25AM -0600, James Bottomley wrote:
> On Tue, 2004-02-24 at 09:24, Joe Korty wrote:
> >  I am getting a panic out of the 2.6.3 Fusion driver when no devices
> > are attached to it.  Does the above update fix it?  If so, I would
> > like to get a copy of the above in patch form.  If not, I can send
> > you a copy of my boot log.
> 
> Well, without a bug report I don't really have any idea.
> 
> The patch is here:
> 
> http://marc.theaimsgroup.com/?l=linux-scsi&m=107670916906716&w=2


Hi James,
Tried the patch, no luck.  The panic is on an Opteron board which has
an IDE rather than a SCSI disk.  I have another system, identical to the
above, that has a SCSI rather than IDE disk, and it boots.  2.6.1 boots
on both systems.

Regards,
Joe



...
Using anticipatory io scheduler
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 5.2.30.1-k1
Copyright (c) 1999-2004 Intel Corporation.
tg3.c:v2.6 (February 3, 2004)
eth0: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCI:33MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:51:d8:fd
eth1: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCI:33MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:51:d8:fe
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: ST380011A, ATA DISK drive
isa bounce pool size: 16 pages
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CD-950E/TKU, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
Red Hat/Adaptec aacraid driver (1.1.2-lk1 Feb 24 2004)
Fusion MPT base driver 3.00.03
Copyright (c) 1999-2003 LSI Logic Corporation
mptbase: Initiating ioc0 bringup
mptbase: ioc0: ERROR - Doorbell ACK timeout(2)!
mptbase: ioc0: ERROR - Diagnostic reset FAILED! (102h)
mptbase: ioc0 NOT READY WARNING!
mptbase: WARNING - ioc0 did not initialize properly! (-1)
mptbase: probe of 0000:02:0a.0 failed with error -1
mptbase: Initiating ioc1 bringup
mptbase: ioc1: ERROR - Doorbell ACK timeout(2)!
mptbase: ioc1: ERROR - Diagnostic reset FAILED! (102h)
mptbase: ioc1 NOT READY WARNING!
mptbase: WARNING - ioc1 did not initialize properly! (-1)
mptbase: probe of 0000:02:0a.1 failed with error -1
Fusion MPT SCSI Host driver 3.00.03
Unable to handle kernel NULL pointer dereference at 0000000000000018 RIP: 
<ffffffff80823a1f>{mptscsih_init+175}PML4 0 
Oops: 0000 [1]
CPU 0 
Pid: 1, comm: swapper Not tainted
RIP: 0010:[<ffffffff80823a1f>] <ffffffff80823a1f>{mptscsih_init+175}
RSP: 0000:000001007afe1f18  EFLAGS: 00010202
RAX: 0000000000000000 RBX: 00000100089a4d20 RCX: 000000000000000c
RDX: 00000100089a4d20 RSI: ffffffff804546b0 RDI: 000001017fe1f398
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 000001017fdfa160 R11: 00000000000000c0 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff807fa540(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000018 CR3: 0000000000101000 CR4: 00000000000006a0
Process swapper (pid: 1, stackpage=10008898500)
Stack: ffffffff8082fb70 ffffffff8080788d 0000000000000246 0000000000000000 
       0000000000000000 ffffffff8010b16e 0000000000000000 ffffffff8010fec7 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff8080788d>{do_initcalls+77} <ffffffff8010b16e>{init+110} 
       <ffffffff8010fec7>{child_rip+8} <ffffffff8010b100>{init+0} 
       <ffffffff8010febf>{child_rip+0} 

Code: 48 8b 70 18 e8 68 d4 c2 ff 48 89 df e8 50 66 c2 ff 48 85 c0 
RIP <ffffffff80823a1f>{mptscsih_init+175} RSP <000001007afe1f18>
CR2: 0000000000000018
 <0>Kernel panic: Attempted to kill init!

