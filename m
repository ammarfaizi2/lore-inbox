Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263808AbTE3QoB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 12:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263812AbTE3QoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 12:44:01 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:21748 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263808AbTE3Qnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 12:43:51 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SG_IO readcd and various bugs
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
References: <20030530130230.GD813@suse.de> <878ysopmus.fsf@gitteundmarkus.de>
	<874r3cpmmv.fsf@gitteundmarkus.de> <20030530145845.GI813@suse.de>
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Fri, 30 May 2003 18:57:10 +0200
In-Reply-To: <20030530145845.GI813@suse.de> (Jens Axboe's message of "Fri,
 30 May 2003 16:58:45 +0200")
Message-ID: <87u1bcs789.fsf@gitteundmarkus.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003, Jens Axboe wrote:

> On Fri, May 30 2003, Markus Plail wrote: 
>> On Fri, 30 May 2003, Markus Plail wrote:
>> > The patch makes readcd work just fine here :-) Many thanks!
>> 
>> Just realized that C2 scans don't yet work.
> 
> Updated patch, please give that a shot. These sense_len wasn't being
> set correctly.

Works fine for readcd and cdrecord (same with CD and DVD) now exits in
another way.

regards
Markus

[plail@plailis_lfs]dvdrecord dev=/dev/hdb speed=4 -v -dao driveropts=burnfree -dummy /video-2/trailer_final_1000_dl.mov Cdrecord-ProDVD-Clone 2.01a12 (i586-pc-linux-gnu) Copyright (C) 1995-2003 Jörg Schilling
Unlocked features: ProDVD Clone 
Limited  features: speed 
This copy of cdrecord is licensed for: private/research/educational_non-commercial_use
TOC Type: 1 = CD-ROM
scsidev: '/dev/hdb'
devname: '/dev/hdb'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.7'
Driveropts: 'burnfree'
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
Total power on  hours: 110150
Blocks total: 2298496 Blocks current: 2298496 Blocks remaining: 2248653
Starting to write CD/DVD at speed 2 in dummy SAO mode for single session.
Last chance to quit, starting dummy write    0 seconds. Operation starts.
Waiting for reader process to fill input buffer ... input buffer ready.
BURN-Free is ON.
Starting new track at sector: 0
Track 01:    1 of   97 MB written (fifo  96%) [buf  67%]  10.5x.cdrecord-ProDVD: Success. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 00 03 64 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0E 00 00 00 00 21 02 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x21 Qual 0x02 (invalid address for write) Fru 0x0
Sense flags: Blk 0 (not valid) 
resid: 63488
cmd finished after 0.006s timeout 100s

write track data: error after 1777664 bytes
cdrecord-ProDVD: The current problem looks like a buffer underrun.
cdrecord-ProDVD: It looks like 'driveropts=burnfree' does not work for this drive.
cdrecord-ProDVD: Please report.
cdrecord-ProDVD: Make sure that you are root, enable DMA and check your HW/OS set up.
Writing  time:   46.904s
Average write speed  15.0x.
Fixating...
WARNING: Some drives don't like fixation in dummy mode.
Fixating time:    1.528s
cdrecord-ProDVD: fifo had 95 puts and 32 gets.
cdrecord-ProDVD: fifo was 0 times empty and 19 times full, min fill was 92%.
You have new mail in /var/mail/plail
[18:49:09]-[Fri May 30]-[~]



[root@plailis_lfs]strace /opt/schily/bin/cdrecord dev=/dev/hdb speed=4 -v -dao driveropts=burnfree -dummy /video-2/trailer_final_1000_dl.mov
execve("/opt/schily/bin/cdrecord", ["/opt/schily/bin/cdrecord", "dev=/dev/hdb", "speed=4", "-v", "-dao", "driveropts=burnfree", "-dummy", "/video-2/trailer_final_1000_dl.mov"], [/* 45 vars */]) = 0
brk(0)                                  = 0x8099000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=66034, ...}) = 0
old_mmap(NULL, 66034, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40017000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\10\332"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=5021367, ...}) = 0
old_mmap(NULL, 1215588, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40028000
mprotect(0x40146000, 44132, PROT_NONE)  = 0
old_mmap(0x40146000, 28672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x11d000) = 0x40146000
old_mmap(0x4014d000, 15460, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4014d000
close(3)                                = 0
munmap(0x40017000, 66034)               = 0
getrlimit(0x7, 0xbfffcee4)              = 0
brk(0)                                  = 0x8099000
brk(0x8099180)                          = 0x8099180
brk(0x809a000)                          = 0x809a000
open("/etc/default/cdrecord", O_RDONLY) = -1 ENOENT (No such file or directory)
fstat64(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(136, 0), ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
write(1, "Cdrecord 2.01a15 (i686-pc-linux-"..., 76Cdrecord 2.01a15 (i686-pc-linux-gnu) Copyright (C) 1995-2003 Jörg Schilling
) = 76
fstat64(2, {st_mode=S_IFCHR|0600, st_rdev=makedev(136, 0), ...}) = 0

...
...[snip]
...

gettimeofday({1054313438, 700025}, NULL) = 0
ioctl(3, 0x2285, 0xbfffcd0c)            = 0
gettimeofday({1054313438, 706685}, NULL) = 0
write(2, "/opt/schily/bin/cdrecord: Succes"..., 384/opt/schily/bin/cdrecord: Success. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 00 03 07 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0E 00 00 00 00 21 02 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x21 Qual 0x02 (invalid address for write) Fru 0x0
Sense flags: Blk 0 (not valid) 
resid: 63488
cmd finished after 0.006s timeout 200s
) = 384
write(1, "\nwrite track data: error after 1"..., 45
write track data: error after 1587200 bytes
) = 45
write(2, "/opt/schily/bin/cdrecord: The cu"..., 76/opt/schily/bin/cdrecord: The current problem looks like a buffer underrun.
) = 76
write(2, "/opt/schily/bin/cdrecord: It loo"..., 92/opt/schily/bin/cdrecord: It looks like 'driveropts=burnfree' does not work for this drive.
) = 92
write(2, "/opt/schily/bin/cdrecord: Please"..., 41/opt/schily/bin/cdrecord: Please report.
) = 41
write(2, "/opt/schily/bin/cdrecord: Make s"..., 95/opt/schily/bin/cdrecord: Make sure that you are root, enable DMA and check your HW/OS set up.
) = 95
rt_sigprocmask(SIG_BLOCK, [CHLD], [RTMIN], 8) = 0

