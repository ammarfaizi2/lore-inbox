Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317011AbSEWWM5>; Thu, 23 May 2002 18:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317024AbSEWWM4>; Thu, 23 May 2002 18:12:56 -0400
Received: from 102-208-ADSL.red.retevision.es ([80.224.208.102]:44855 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S317011AbSEWWMz>;
	Thu, 23 May 2002 18:12:55 -0400
Message-ID: <3CED69EB.2060003@zaralinux.com>
Date: Fri, 24 May 2002 00:15:07 +0200
From: Jorge Nerin <comandante@zaralinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: es-es, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Cannot write a 90' cd
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I tried with kernels 2.5.16, 2.5.15 and 2.4.18 with a ide cdburner:

scsi0 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: SAMSUNG   Model: CD-R/RW SW-208B   Rev: BS03
   Type:   CD-ROM                             ANSI SCSI revision: 02

with cdrecord --version
Cdrecord 1.11a19 (i586-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
but it's a 1.11a21, and a 2x200mmx 96Mb. and the results were rather disapointing:

- 2.5.15 & 2.5.16 both hung my machine the moment cdrecord tried to write.
- 2.4.18 wrote ok, until 702MB, then a scsi stopped the procces, detailed log of 
the cdrecord session follows:

Cdrecord 1.11a19 (i586-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
TOC Type: 1 = CD-ROM
scsidev: '0,0,0'
scsibus: 0 target: 0 lun: 0
Linux sg driver version: 3.1.22
Using libscg version 'schily-0.6'
atapi: 1
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'SAMSUNG '
Identifikation : 'CD-R/RW SW-208B '
Revision       : 'BS03'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : SWABAUDIO
Supported modes: TAO PACKET RAW/R16 RAW/R96R
FIFO size      : 25165824 = 24576 KB
Track 01: data  753 MB
Total size:     865 MB (85:43.10) = 385733 sectors
Lout start:     865 MB (85:45/08) = 385733 sectors
Current Secsize: 2048
   ATIP start of lead in:  -11526 (97:28/24)
   ATIP start of lead out: 359849 (79:59/74)
Disk type:    Long strategy type (Cyanine, AZO or similar)
Manuf. index: 13
Manufacturer: Multi Media Masters & Machinary SA
Blocks total: 359849 Blocks current: 359849 Blocks remaining: -25884
cdrecord: WARNING: Data may not fit on current disk.
cdrecord: Notice: Overburning active. Trying to write more than the official 
disk capacity.
Starting to write CD/DVD at speed 8 in write mode for single session.
Last chance to quit, starting real write in 0 seconds. Operation starts.
Waiting for reader process to fill input buffer ... input buffer ready.
Performing OPC...
Starting new track at sector: 0
Track 01: 702 of 753 MB written (fifo 100%) 8.1x.cdrecord: Input/output error. 
write_g1: scsi sendcmd: no error
CDB:  2A 00 00 05 7D 89 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 63 00 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x63 Qual 0x00 (end of user area encountered on this track) Fru 0x0
Sense flags: Blk 0 (not valid)
cmd finished after 0.004s timeout 40s

write track data: error after 736905216 bytes
Sense Bytes: 70 00 03 00 00 00 00 0A 00 00 00 00 73 04 00 00 00 00
Writing  time:  607.270s
Fixating...
Fixating time:   44.250s
cdrecord: fifo had 11990 puts and 11608 gets.
cdrecord: fifo was 0 times empty and 11261 times full, min fill was 98%.

Note that this was a traxdata 90' silver cd, in the instructions they said that 
it will be detected as a 80' and that you should enable overburnung, cdrecord 
without options said that -overburn should be active, this session is with 
-overburn active.

I don't have more 90' cd to try. I only managed to get one.

-- 
Jorge Nerin
<comandante@zaralinux.com>

