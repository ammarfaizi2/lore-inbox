Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135344AbREEVFA>; Sat, 5 May 2001 17:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135363AbREEVEv>; Sat, 5 May 2001 17:04:51 -0400
Received: from gecius-0.dsl.speakeasy.net ([216.254.67.146]:30917 "EHLO
	maniac.gecius.de") by vger.kernel.org with ESMTP id <S135344AbREEVEj> convert rfc822-to-8bit;
	Sat, 5 May 2001 17:04:39 -0400
To: linux-kernel@vger.kernel.org
Subject: ide-scsi / cd-writing 2.4.3
From: Jens Gecius <jens@gecius.de>
Date: 05 May 2001 17:04:38 -0400
Message-ID: <878zkb33tl.fsf@maniac.gecius.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I used to be able to use my cdwriter (Philips CDD3610) on 2.2.17. Now,
with 2.4.4 I'm not able to get it to work. It's not a permission
problem as far as I can see. I suspect ide-scsi?

See the output of cdrecord (I tried to burn 450MB):

Cdrecord 1.10a18 (i686-pc-linux-gnu) Copyright (C) 1995-2001 Jörg Schilling
TOC Type: 1 = CD-ROM
Using libscg version 'schily-0.5'
atapi: 1
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'PHILIPS '
Identifikation : 'CDD3610 CD-R/RW '
Revision       : '3.01'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : SWABAUDIO
Drive buf size : 786432 = 768 KB
FIFO size      : 4194304 = 4096 KB
scsidev: '0,0,0'
scsibus: 0 target: 0 lun: 0
Linux sg driver version: 3.1.17
Track 01: data  unknown length padsize:  30 KB
Lout start:       0 MB (00:02/00) = 0 sectors
Current Secsize: 2048
  ATIP start of lead in:  -11325 (97:31/00)
  ATIP start of lead out: 336225 (74:45/00)
Disk type:    Long strategy type (Cyanine, AZO or similar)
Manuf. index: 22
Manufacturer: Ritek Co.
Starting to write CD/DVD at speed 2 in write mode for single session.
/usr/bin/cdrecord: WARNING: Track size unknown. Data may not fit on disk.
Performing OPC...
/usr/bin/cdrecord: Input/output error. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 00 01 74 00 00 1F 00
status: 0x0 (GOOD STATUS)
cmd finished after 6.818s timeout 40s
Track 01:   0 MB written.
write track data: error after 761856 bytes
Writing  time:   18.023s
Sense Bytes: F0 00 00 00 00 00 00 19 00 00 38 13 00 00 00 00 0C DB
/usr/bin/cdrecord: Input/output error. close track/session: scsi sendcmd: no error
CDB:  5B 00 02 00 00 00 00 00 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.011s timeout 480s
cmd finished after 0.011s timeout 480s
/usr/bin/cdrecord: Input/output error. mode select g1: scsi sendcmd: no error
CDB:  55 10 00 00 00 00 00 00 10 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.005s timeout 40s

Any Ideas?

-- 
Tschoe,                    Get my gpg-public-key here
 Jens                     http://gecius.de/gpg-key.txt
