Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263657AbTE3Nej (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 09:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263658AbTE3Nej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 09:34:39 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:51394 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263657AbTE3Neh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 09:34:37 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SG_IO readcd and various bugs
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
References: <20030530130230.GD813@suse.de>
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Fri, 30 May 2003 15:47:55 +0200
In-Reply-To: <20030530130230.GD813@suse.de> (Jens Axboe's message of "Fri,
 30 May 2003 15:02:30 +0200")
Message-ID: <878ysopmus.fsf@gitteundmarkus.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

The patch makes readcd work just fine here :-) Many thanks!

Now if only writing would also work...

regards
Markus

[15:44:31]-[Fri May 30]-[~]
[plail@plailis_lfs]dvdrecord dev=/dev/hdb speed=4 -v -dummy /video-2/trailer_final_1000_dl.mov 
Cdrecord-ProDVD-Clone 2.01a12 (i586-pc-linux-gnu) Copyright (C) 1995-2003 Jörg Schilling
Unlocked features: ProDVD Clone 
Limited  features: speed 
This copy of cdrecord is licensed for: private/research/educational_non-commercial_use
TOC Type: 1 = CD-ROM
devname: '/dev/hdb'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.7'
atapi: 1
Device type    : Removable CD-ROM
Version        : 0
Response Format: 2
Capabilities   : 
Vendor_info    : 'TEAC    '
Identifikation : 'DV-W50E         '
Revision       : '1.30'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Current: DVD-RW sequential overwrite
Profile: DVD-RW sequential overwrite (current)
Profile: DVD-RW restricted overwrite (current)
Profile: DVD-R sequential recording (current)
Profile: DVD-ROM 
Profile: CD-RW 
Profile: CD-R 
Profile: CD-ROM 
Using generic SCSI-3/mmc-2 DVD-R/DVD-RW driver (mmc_dvd).
Driver flags   : DVD MMC-3 SWABAUDIO BURNFREE 
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
Drive buf size : 1605632 = 1568 KB
FIFO size      : 4194304 = 4096 KB
Track 01: data    97 MB        
Total size:       97 MB = 49843 sectors
Current Secsize: 2048
Total power on  hours: 110055
WARNING: Phys disk size 49843 differs from rzone size 2298496! Prerecorded disk?
WARNING: Phys start: 196608 Phys end 246450
Blocks total: 2298496 Blocks current: 2298496 Blocks remaining: 2248653
Starting to write CD/DVD at speed 2 in dummy TAO mode for single session.
Last chance to quit, starting dummy write    0 seconds. Operation starts.
Waiting for reader process to fill input buffer ... input buffer ready.
BURN-Free is OFF.
Starting new track at sector: 0
Track 01:    1 of   97 MB written (fifo  85%) [buf  67%]  11.5x.cdrecord-ProDVD: Success. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 00 03 07 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70
Sense Key: 0x0 No Additional Sense, Segment 0
Sense Code: 0x00 Qual 0x00 (no additional sense information) Fru 0x0
Sense flags: Blk 0 (not valid) 
resid: 63488
cmd finished after 0.005s timeout 100s

write track data: error after 1587200 bytes
cdrecord-ProDVD: A write error occured.
cdrecord-ProDVD: Please properly read the error message above.
Writing  time:    5.198s
Average write speed  14.3x.
Fixating...
Fixating time:    0.464s
cdrecord-ProDVD: fifo had 89 puts and 26 gets.
cdrecord-ProDVD: fifo was 0 times empty and 2 times full, min fill was 82%.
You have new mail in /var/mail/plail
[15:45:08]-[Fri May 30]-[~]
[plail@plailis_lfs]

