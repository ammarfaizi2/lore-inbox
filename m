Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135636AbRDXOLw>; Tue, 24 Apr 2001 10:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135635AbRDXOLe>; Tue, 24 Apr 2001 10:11:34 -0400
Received: from portal.west.saic.com ([198.151.12.15]:36594 "HELO
	portal.west.saic.com") by vger.kernel.org with SMTP
	id <S135634AbRDXOJX> convert rfc822-to-8bit; Tue, 24 Apr 2001 10:09:23 -0400
Message-Id: <A83EBF650A2CD51189CA00508B444F7F1663B3@abz-irg-exs01.uk.saic.com>
From: "Hamilton, Eamonn" <EAMONN.HAMILTON@saic.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: sym53c875 error
Date: Tue, 24 Apr 2001 07:08:47 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks.

Under all of the kernels I have access to try ( 2.2.19, 2.4.X & 2.4.X-ac* ),
when I try and write an image in XA2 format to my SCSI writer ( Yamaha
CDR-400t ), I get a DMA overrun. When I try with a kernel patched with the
beta symbios driver ( 2.1.9 ), it works just fine.

This is on a Debian woody system, using cdrecord 1.10 ( also 1.9 and 1.8
with the same symptoms ) attached to a Tekram DC390F.

Transcript as follows :

cdrecord dev=0,3,0 -dummy -xa2 firmware.iso

Cdrecord 1.10a18 (i686-pc-linux-gnu) Copyright (C) 1995-2001 Jörg Schilling
scsidev: '0,3,0'
scsibus: 0 target: 3 lun: 0
Linux sg driver version: 3.1.17
Using libscg version 'schily-0.5'
Device type    : Removable CD-ROM
Version        : 2
Response Format: 2
Capabilities   :
Vendor_info    : 'YAMAHA  '
Identifikation : 'CDR400t         '
Revision       : '1.0q'
Device seems to be: Yamaha CDR-400.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : SWABAUDIO
Starting to write CD/DVD at speed 1 in dummy mode for single session.
Last chance to quit, starting dummy write in 1 seconds.
cdrecord: Input/output error. write_g1: scsi sendcmd: retryable error
CDB:  2A 00 00 00 01 C2 00 00 1F 00
status: 0x0 (GOOD STATUS)
DMA overrun, resid: -248
cmd finished after 0.579s timeout 40s
write track data: error after 0 bytes
Sense Bytes: 70 00 00 00 00 00 00 0A 00 00 00 00 00 00 00 00 00 00


And while that lot happens, I get

sym53c875-0-<3,*>: target did not report SYNC.
sym53c875-0-<3,*>: extraneous data discarded.
sym53c875-0-<3,*>: COMMAND FAILED (89 0) @c12a3800.

Standard burns work ok, it's just the xa2 stuff I have a problem with so
far. I also tried using the old NCR driver with the same results.

Anybody got any ideas?

Cheers,
Eamonn
