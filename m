Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbTFAGZL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 02:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbTFAGZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 02:25:11 -0400
Received: from moutng.kundenserver.de ([212.227.126.189]:42455 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261312AbTFAGZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 02:25:09 -0400
To: linux-kernel@vger.kernel.org
Subject: cdrecord and 2.5 kernels
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <linux-kernel@gitteundmarkus.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
Date: Sun, 01 Jun 2003 08:38:32 +0200
Message-ID: <8765nqnvyv.fsf@gitteundmarkus.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

I just compiled a few kernels and realized that 2.5.45 was the kernel
that broke writing DVD/CD-Rs for me. The messages at the bottom are
from 2.5.70 plus the second sg_io patch.

regards
Markus


Waiting for reader process to fill input buffer ... input buffer ready.
BURN-Free is ON.
cdrecord: WARNING: Drive returns wrong startsec (-150) using -11077 from ATIP
Writing lead-in at sector -11077
cdrecord: Success. write_g1: scsi sendcmd: no error
CDB:  2A 00 FF FF D7 AD 00 00 1A 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0E 00 00 00 00 21 02 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x21 Qual 0x02 (invalid address for write) Fru 0x0
Sense flags: Blk 0 (not valid) 
resid: 63648
cmd finished after 0.006s timeout 40s
write leadin data: error after 1845792 bytes
cdrecord: Could not write Lead-in.
Writing  time:    1.819s
cdrecord: fifo had 64 puts and 0 gets.
cdrecord: fifo was 0 times empty and 0 times full, min fill was 100%.
[23:34:34]-[Sat May 31]-[~]
[plail@plailis_lfs]

dmesg:
May 31 23:33:54 localhost kernel: hdb: confused, missing data
May 31 23:33:54 localhost kernel: hdb: confused, missing data
May 31 23:33:54 localhost kernel: cdrom_newpc_intr: 63648 residual after xfer
May 31 23:34:08 localhost kernel: hdb: DMA disabled
May 31 23:34:34 localhost kernel: hdb: confused, missing data
May 31 23:34:34 localhost kernel: hdb: confused, missing data
May 31 23:34:34 localhost kernel: cdrom_newpc_intr: 63648 residual after xfer

Note: It was me who disabled DMA to see if it makes a difference.

