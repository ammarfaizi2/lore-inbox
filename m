Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292290AbSBTUoo>; Wed, 20 Feb 2002 15:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292295AbSBTUof>; Wed, 20 Feb 2002 15:44:35 -0500
Received: from gw.wmich.edu ([141.218.1.100]:7666 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S292290AbSBTUo0>;
	Wed, 20 Feb 2002 15:44:26 -0500
Subject: ide cd-recording not working in 2.4.18-rc2-ac1
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 20 Feb 2002 15:44:32 -0500
Message-Id: <1014237877.441.7.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this on every cd I try and I've tried more than I'd have liked to.


Performing OPC...
/usr/bin/cdrecord: Input/output error. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 00 00 1F 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 21 00 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x21 Qual 0x00 (logical block address out of range) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.003s timeout 40s
Track 01:   0 of 628 MB written.
write track data: error after 63488 bytes
Writing  time:   10.171s
Sense Bytes: 70 00 00 00 00 00 00 0A 00 00 00 00 00 00 00 00 00 00
/usr/bin/cdrecord: Input/output error. close track/session: scsi
sendcmd: no error
CDB:  5B 00 02 00 00 00 00 00 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 2C 00 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x2C Qual 0x00 (command sequence error) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.001s timeout 480s
cmd finished after 0.001s timeout 480s



Now I know every cd isn't bad because they used to work in older
2.4.17ish kernels.  I have scsi-generic support compiled as a module as
well as ide-scsi.  This is what the kernel detects the drive as

SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: CREATIVE  Model:  CD-RW RW8438E    Rev: FC03
  Type:   CD-ROM                             ANSI SCSI revision: 02

That is correct.  This is what hdparm tells about the drive 
/dev/hdc:
 HDIO_GET_MULTCOUNT failed: Input/output error
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 HDIO_GET_NOWERR failed: Input/output error
 readonly     =  0 (off)
 BLKRAGET failed: Input/output error
 HDIO_GETGEO failed: Invalid argument
 busstate     =  1 (on)

not sure what else I can get informationwize about what the drive is
doing.  

