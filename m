Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262028AbSJISiV>; Wed, 9 Oct 2002 14:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262022AbSJISiN>; Wed, 9 Oct 2002 14:38:13 -0400
Received: from goliath.sylaba.poznan.pl ([195.216.104.3]:18671 "EHLO
	goliath.sylaba.poznan.pl") by vger.kernel.org with ESMTP
	id <S262432AbSJISgK>; Wed, 9 Oct 2002 14:36:10 -0400
Subject: 2.4.19 and other - Problem with SCSI and CD writing
From: Olaf =?iso-8859-2?Q?Fr=B1czyk?= <olaf@navi.pl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-2
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 09 Oct 2002 20:44:05 +0200
Message-Id: <1034189058.1776.18.camel@venus>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by goliath.sylaba.poznan.pl id g99Ifl107139
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I cannot record CDs when using SCSI drive.
But in the past it worked ok for 100%.
Unfortunately I changed mb + processor + system at the same time.
I don't know what is exactly the cause.
Now I use ASUS A7V133 (via kt 133a chipset) with Duron.
Previous it was Abit BP6 + Celeron (BX chipset).
System is RH 7.3.

When I copy data to any SCSI drive, the burning fails. Also the system
stalls sometimes for few seconds.
If I only copy data from one partition to another on IDE drive,
everything works OK.
I use 2.4.19 + XFS.
But I tested also with:
2.4.18 +XFS, 2.4.18, 2.4.17, 2.4.16, 2.4.12.

I have:
Adaptec 2940U2W
Yamaha 6416S (SCSI CD-RW) Id: 3
1x IBM SCSI 7.2krpm Id: 2
1x IBM SCSI 10krpm Id:4
1x IBM IDE 7.2krpm 
1x DVD-RAM SCSI - Panasonic Id: 5

Please CC me, as I'm not subscribed.

Below are messages from /var/log/messages:
Oct  9 20:17:32 venus kernel: cdrom: This disc doesn't have any tracks I
recognize!
Oct  9 20:21:18 venus kernel: scsi0:0:2:0: Attempting to queue an ABORT
message
Oct  9 20:21:18 venus kernel: scsi0:0:2:0: Command not found
Oct  9 20:21:18 venus kernel: aic7xxx_abort returns 0x2002
Oct  9 20:21:19 venus kernel: scsi0:0:2:0: Attempting to queue an ABORT
message
Oct  9 20:21:19 venus kernel: scsi0:0:2:0: Command not found
Oct  9 20:21:19 venus kernel: aic7xxx_abort returns 0x2002
Oct  9 20:21:19 venus kernel: scsi0:0:2:0: Attempting to queue an ABORT
message
Oct  9 20:21:19 venus kernel: scsi0:0:2:0: Command not found
Oct  9 20:21:19 venus kernel: aic7xxx_abort returns 0x2002
Oct  9 20:21:19 venus kernel: scsi0:0:2:0: Attempting to queue an ABORT
message
Oct  9 20:21:19 venus kernel: scsi0:0:2:0: Command not found
Oct  9 20:21:19 venus kernel: aic7xxx_abort returns 0x2002
Oct  9 20:21:20 venus kernel: scsi0:0:2:0: Attempting to queue an ABORT
message
Oct  9 20:21:27 venus kernel: scsi0:0:2:0: Command not found
Oct  9 20:21:27 venus kernel: aic7xxx_abort returns 0x2002

There are a lot of these messages I putted only a few. For second SCSI
disk are here also:
Oct  9 20:21:32 venus kernel: scsi0:0:4:0: Attempting to queue an ABORT
message
Oct  9 20:21:32 venus kernel: scsi0:0:4:0: Command not found
Oct  9 20:21:32 venus kernel: aic7xxx_abort returns 0x2002

Here is output from CD-burning software:

Cdrecord 1.10 (i686-pc-linux-gnu) Copyright (C) 1995-2001 Jörg Schilling
TOC Type: 1 = CD-ROM
Using libscg version 'schily-0.5'
atapi: 0
Device type    : Removable CD-ROM
Version        : 2
Response Format: 2
Capabilities   : SYNC 
Vendor_info    : 'YAMAHA  '
Identifikation : 'CRW6416S        '
Revision       : '1.0b'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : SWABAUDIO
Drive buf size : 1566432 = 1529 KB
FIFO size      : 4194304 = 4096 KB
scsidev: '0,3,0'
scsibus: 0 target: 3 lun: 0
Linux sg driver version: 3.1.24
Track 01: data  352 MB         padsize:  30 KB
Lout start:     404 MB (40:06/69) = 180369 sectors
Current Secsize: 2048
ATIP info from disk:
  Indicated writing power: 5
  Is not unrestricted
  Is not erasable
  Disk sub type: Medium Type B, low Beta category (B-) (4)
  ATIP start of lead in:  -12520 (97:15/05)
  ATIP start of lead out: 359849 (79:59/74)
Disk type:    Short strategy type (Phthalocyanine or similar)
Manuf. index: 26
Manufacturer: TDK Corporation
Blocks total: 359849 Blocks current: 359849 Blocks remaining: 179480
Starting to write CD/DVD at speed 6 in dummy mode for single session.
Track 01:   0 of 352 MB written./usr/bin/cdrecord: Input/output error.
write_g1: scsi sendcmd: no error
CDB:  2A 00 00 00 74 02 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 21 00 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x21 Qual 0x00 (logical block address out of range) Fru 0x0
Sense flags: Blk 0 (not valid) 
resid: 63488
cmd finished after 1.872s timeout 40s
write track data: error after 60821504 bytes
Writing  time:   73.473s
Sense Bytes: 70 00 00 00 00 00 00 0A 00 00 00 00 00 00 00 00 00 00
WARNING: Some drives don't like fixation in dummy mode.



Regards,

Olaf Fraczyk







