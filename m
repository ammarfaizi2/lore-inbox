Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263664AbTCUSCN>; Fri, 21 Mar 2003 13:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263667AbTCUSCN>; Fri, 21 Mar 2003 13:02:13 -0500
Received: from ulima.unil.ch ([130.223.144.143]:22438 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S263664AbTCUSCK>;
	Fri, 21 Mar 2003 13:02:10 -0500
Date: Fri, 21 Mar 2003 19:13:08 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org, cdwrite@other.debian.org
Subject: Any hope to have a working 2.5 kernels for writing DVD?
Message-ID: <20030321181308.GA23131@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have already reported this "bug" for an older kernel:

Cdrecord-ProDVD-Clone 2.0 (i586-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
Unlocked features: ProDVD Clone 
Limited  features: speed 
This copy of cdrecord is licensed for: private/research/educational_non-commercial_use
TOC Type: 1 = CD-ROM
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.7'
Driveropts: 'burnfree'
atapi: 1
Device type    : Removable CD-ROM
Version        : 2
Response Format: 2
Capabilities   : 
Vendor_info    : 'SONY    '
Identifikation : 'DVD RW DRU-500A '
Revision       : '1.0f'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Using generic SCSI-3/mmc-2 DVD-R/DVD-RW driver (mmc_dvd).
Driver flags   : DVD SWABAUDIO BURNFREE 
Supported modes: TAO PACKET SAO SAO/R96R RAW/R96R
Drive buf size : 8126464 = 7936 KB
FIFO size      : 67108864 = 65536 KB
Track 01: data  4129 MB        
Total size:     4129 MB = 2114048 sectors
Current Secsize: 2048
Blocks total: 2298496 Blocks current: 2298496 Blocks remaining: 184448
Starting to write CD/DVD at speed 1 in dummy TAO mode for single session.
Last chance to quit, starting dummy write in 9 seconds.  0.24% done, estimate finish Fri Mar 21 19:09:11 2003
   8 seconds.  0.47% done, estimate finish Fri Mar 21 19:12:42 2003
   7 seconds.  0.71% done, estimate finish Fri Mar 21 19:13:52 2003
  0.95% done, estimate finish Fri Mar 21 19:14:27 2003
   6 seconds.  1.18% done, estimate finish Fri Mar 21 19:13:24 2003
   5 seconds.  1.42% done, estimate finish Fri Mar 21 19:13:52 2003
   0 seconds. Operation starts.
Waiting for reader process to fill input buffer ... input buffer ready.
BURN-Free is ON.
Starting new track at sector: 0
Track 01:    4 of 4129 MB written (fifo  97%)  16.3x.cdrecord-prodvd: Success. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 00 08 B8 00 00 1F 00
status: 0x1 (GOOD STATUS)
resid: 63488
cmd finished after 0.010s timeout 100s

write track data: error after 4571136 bytes
Sense Bytes: 70 00 00 00 00 00 00 12 00 00 00 00 00 00 00 00 00 00
Writing  time:    5.371s
Average write speed 585.1x.
Fixating...
Fixating time:   77.468s
cdrecord-prodvd: fifo had 1095 puts and 73 gets.
cdrecord-prodvd: fifo was 0 times empty and 1 times full, min fill was 96%.

The command that give me that was:

mkisofs -dvd-video -V $1 $2 | cdrecord-prodvd driveropts=burnfree -dummy -v dev=/dev/hdc fs=64m speed=1 tsize={$SIZE}s -

Thank you very much,
 
	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
