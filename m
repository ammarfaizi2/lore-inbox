Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265626AbRGDHED>; Wed, 4 Jul 2001 03:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266511AbRGDHDx>; Wed, 4 Jul 2001 03:03:53 -0400
Received: from mcp.physics.ucsb.edu ([128.111.16.33]:47378 "EHLO
	mcp.physics.ucsb.edu") by vger.kernel.org with ESMTP
	id <S265626AbRGDHDk>; Wed, 4 Jul 2001 03:03:40 -0400
Date: Wed, 4 Jul 2001 00:03:34 -0700 (PDT)
From: David Whysong <dwhysong@physics.ucsb.edu>
To: <linux-kernel@vger.kernel.org>
Subject: __alloc_pages failure while burning a CD-R (fwd)
Message-ID: <Pine.LNX.4.30.0107040003110.27351-100000@sal.physics.ucsb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

[Please CC replies to me, as I am not subscribed to linux-kernel.]

When I use xcdroast to burn a CD, I see a zillion messages like this in
the syslog:

__alloc_pages: 3-order allocation failed.
__alloc_pages: 2-order allocation failed.

The burn inevitably stopes due to a "servo failure" but I suspect the real
problem is software. The CD-RW drive has been reliable, and worked fine
with earlier 2.4.x kernels.

Any suggestions? System information follows.

Dave


Linux sleepy 2.4.6-pre9 #8 SMP Mon Jul 2 22:24:05 PDT 2001 i686 unknown
Dual Celeron 300 MHz, 256 MB ECC memory, Intel 440BX chipset motherboard
(Tyan Tiger 100). The hardware has been running fine for years.

The CD-RW is a SCSI device, on an NCR 810A controller.

[dwhysong@sleepy dwhysong]$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: PIONEER  Model: DVD-ROM DVD-303  Rev: 1.06
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: YAMAHA   Model: CRW4260          Rev: 1.0j
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: TOSHIBA  Model: CD-ROM XM-6201TA Rev: 1037
  Type:   CD-ROM                           ANSI SCSI revision: 02

[dwhysong@sleepy dwhysong]$ lsmod
Module                  Size  Used by
sg                     22064   0 (autoclean)
mga                   100224   1
agpgart                14784   3
mga_vid                 7808   0
sr_mod                 11584   1 (autoclean)
ncr53c8xx              51744   1
scsi_mod               82016   3 (autoclean) [sg sr_mod ncr53c8xx]
cdrom                  27168   0 (autoclean) [sr_mod]
serial                 44016   0 (autoclean)
isa-pnp                28240   0 (autoclean) [serial]
emu10k1                46592   0
soundcore               4336   4 [emu10k1]
3c59x                  25488   1 (autoclean)
nls_iso8859-1           2848   3 (autoclean)
nls_cp437               4352   2 (autoclean)
vfat                    8976   2 (autoclean)
fat                    31904   0 (autoclean) [vfat]

