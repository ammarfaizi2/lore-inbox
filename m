Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbSI2EkU>; Sun, 29 Sep 2002 00:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262390AbSI2EkU>; Sun, 29 Sep 2002 00:40:20 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:18436 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262389AbSI2EkT>; Sun, 29 Sep 2002 00:40:19 -0400
Date: Sun, 29 Sep 2002 06:45:24 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.39: SMP, pre-empt, ide-scsi 'sleeping function called from illegal context' during boot
Message-ID: <20020929044524.GA739@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ide-cd: passing drive hdg to ide-scsi emulation.
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 10, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c860 detected 
sym53c860-0: rev 0x13 on pci bus 0 device 10 function 0 irq 17
sym53c860-0: ID 7, Fast-20, Parity Checking
scsi0 : sym53c8xx-1.7.3c-20010512
sym53c860-0-<1,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 8)
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1401  Rev: 1007
  Type:   CD-ROM                             ANSI SCSI revision: 02
sym53c860-0-<2,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 8)
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
sym53c860-0-<5,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 7)
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0N
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: LTR-40125W        Rev: WS05
  Type:   CD-ROM                             ANSI SCSI revision: 02
st: Version 20020822, fixed bufsize 32768, wrt 30720, s/g segs 256
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
Attached scsi CD-ROM sr2 at scsi0, channel 0, id 5, lun 0
Attached scsi CD-ROM sr3 at scsi1, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi-1 drive
sr2: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
sr3: scsi3-mmc drive: 255x/48x writer cd/rw xa/form2 cdda tray
Sleeping function called from illegal context at slab.c:1374
c1b79f14 c0118554 c02df2e0 c02e3d90 0000055e 00001000 c0135dd3 c02e3d90 
       0000055e f8800000 00000246 00001000 00001000 f7c923bc c1b0f060 c0134905 
       0000001c 000001d0 c1b78000 00000246 00001000 000001d2 c0381cc0 c0134bf2 
Call Trace:
 [<c0118554>]__might_sleep+0x54/0x58
 [<c0135dd3>]kmalloc+0x5b/0x1d4
 [<c0134905>]get_vm_area+0x29/0x11c
 [<c0134bf2>]__vmalloc+0x32/0x10c
 [<c0134ce1>]vmalloc+0x15/0x1c
 [<c021680c>]sg_init+0xa0/0x138
 [<c01fcace>]scsi_register_device+0x76/0x120
 [<c01050ab>]init+0x47/0x1bc
 [<c0105064>]init+0x0/0x1bc
 [<c0105501>]kernel_thread_helper+0x5/0xc

Good luck,
Jurriaan
-- 
It would be very much a matter of the pot calling the kettle, eh, eh,
afro-american.
        Raymond in The Thin Blue Line
GNU/Linux 2.5.38 SMP/ReiserFS 2x1380 bogomips load av: 0.00 0.38 0.75
