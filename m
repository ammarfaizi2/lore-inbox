Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261477AbSJYQdr>; Fri, 25 Oct 2002 12:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261478AbSJYQdr>; Fri, 25 Oct 2002 12:33:47 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:52165 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261477AbSJYQdm>; Fri, 25 Oct 2002 12:33:42 -0400
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Vegard.Lima@hia.no,
       matthias.welk@fokus.gmd.de
Subject: Re: [Bug] 2.5.44-ac2 cdrom eject panic
References: <20021025103631.GA588@giantx.co.uk>
	<20021025103938.GN4153@suse.de> <87adl2is1u.fsf@gitteundmarkus.de>
	<20021025144224.GW4153@suse.de>
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <plail@web.de>
Date: Fri, 25 Oct 2002 18:39:26 +0200
In-Reply-To: <20021025144224.GW4153@suse.de> (Jens Axboe's message of "Fri,
 25 Oct 2002 16:42:24 +0200")
Message-ID: <87pttyh3r5.fsf@gitteundmarkus.de>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens!

* Jens Axboe writes:
>Please try:
>*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.44/sgio-16.bz2
                                                                     ^^16b
>That should fix the silly panic.

Yes it does. I can't burn though. I attached the cdrecord output. Hava
a look at the Blocks numbers. Although the image is only 500MB, it says
it wouldn't fit on the disc which is 700MB. In another try it wanted to
start burning although I had a bought audio CD in the burner.

HTH
Markus

[plail@plailis_lfs:001]$ cdburn.sh "Fast and Furious CD 2/2" fast_furious-2.avi test.vob 
Cdrecord 1.11a38 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
TOC Type: 1 = CD-ROM
scsidev: '/dev/hdd'
devname: '/dev/hdd'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.7'
Using libscg transport code version 'schily-scsi-linux-sg.c-1.73'
atapi: 1
Device type    : Removable CD-ROM
Version        : 2
Response Format: 2
Capabilities   : 
Vendor_info    : 'ATAPI   '
Identifikation : 'CD-R/RW 20X10   '
Revision       : 'H.FH'
Device seems to be: Generic mmc CD-RW.
Drive current speed: 16
Drive default speed: 16
Drive max speed    : 16
Selected speed     : 16
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : MMC SWABAUDIO BURNFREE 
Supported modes: TAO PACKET SAO RAW/R16 RAW/R96R
Drive buf size : 1630208 = 1592 KB
FIFO size      : 4194304 = 4096 KB
Encoding speed : 385x (28852 sectors/s) for libedc from Heiko Eißfeldt
Track 01: data   500 MB        
track: 1 start: 0 pregap: 150
Total size:      574 MB (56:53.97) = 256048 sectors
Lout start:      574 MB (56:55/73) = 256048 sectors
 41 00 00 14 00 00 00 00
 41 01 00 10 00 00 00 00
 41 01 01 10 00 00 02 00
 41 AA 01 14 00 38 37 49
Track 1 start 0
Track 2 start 256048
 41 00 A0 00 00 00 00 01 00 00 00 00
 41 00 A1 00 00 00 00 01 00 00 00 00
 41 00 A2 00 00 00 00 56 55 73 00 00
 41 00 01 00 00 00 00 00 02 00 00 00
Current Secsize: 2048
ATIP info from disk:
  Indicated writing power: 4
  Is not unrestricted
  Is not erasable
  Disk sub type: Medium Type A, high Beta category (A+) (3)
  ATIP start of lead in:  -11077 (97:34/23)
  ATIP start of lead out: 359848 (79:59/73)
Disk type:    Long strategy type (Cyanine, AZO or similar)
Manuf. index: 11
Manufacturer: Mitsubishi Chemical Corporation
Blocks total: 359848 Blocks current: 26848 Blocks remaining: -229200
cdrecord: WARNING: Data may not fit on current disk.
cdrecord: Notice: Most recorders cannot write CD's >= 90 minutes.
cdrecord: Notice: Use -ignsize option to allow >= 90 minutes.
cdrecord: Notice: Overburning active. Trying to write more than the official disk capacity.
Starting to write CD/DVD at speed 16 in real RAW/RAW96R mode for single session.
Last chance to quit, starting real write    0 seconds. Operation starts.
Waiting for reader process to fill input buffer ... input buffer ready.
BURN-Free is OFF.
Performing OPC...
cdrecord: WARNING: Drive returns wrong startsec (333000) using 0 from ATIP
cdrecord: Illegal startsec (0)
cdrecord: Could not write Lead-in.
Writing  time:    0.020s
cdrecord: fifo had 64 puts and 0 gets.
cdrecord: fifo was 0 times empty and 0 times full, min fill was 100%.
[plail@plailis_lfs:001]$ 

