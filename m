Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129372AbRBBVIC>; Fri, 2 Feb 2001 16:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130058AbRBBVHv>; Fri, 2 Feb 2001 16:07:51 -0500
Received: from gherkin.sa.wlk.com ([192.158.254.49]:42247 "HELO
	gherkin.sa.wlk.com") by vger.kernel.org with SMTP
	id <S129372AbRBBVHn> convert rfc822-to-8bit; Fri, 2 Feb 2001 16:07:43 -0500
Message-Id: <m14OnQj-0005keC@gherkin.sa.wlk.com>
From: rct@gherkin.sa.wlk.com (Bob_Tracy)
Subject: ATAPI CD burner with cdrecord > 1.6.1
To: linux-kernel@vger.kernel.org
Date: Fri, 2 Feb 2001 15:07:41 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UNKNOWN-8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel version is 2.4.1.  For versions of cdrecord later than 1.6.1
(1.8.1 through the latest 1.10 alpha verified), attempting to burn a
CD results in a SCSI error of some kind.  Here's some representative
output from a "dummy" burn session with cdrecord-1.9:


Calling: /usr/local/lib/xcdroast-0.98/bin/cdrecord dev=0,1,0 fs=4096k  -v -useinfo speed=4 -dao -dummy -eject -pad -data "/u3/superrescue/superrescue-1.2.3.raw" ...

pregap1: -1
Cdrecord 1.9 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
TOC Type: 1 = CD-ROM
scsidev: '0,1,0'
scsibus: 0 target: 1 lun: 0
Linux sg driver version: 3.1.17
Using libscg version 'schily-0.1'
atapi: 1
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'HP      '
Identifikation : 'CD-Writer+ 7200 '
Revision       : '3.01'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : SWABAUDIO
Drive buf size : 786432 = 768 KB
FIFO size      : 4194304 = 4096 KB
Track 01: data  498 MB         padsize:  30 KB
Total size:     572 MB (56:41.28) = 255096 sectors
Lout start:     572 MB (56:43/21) = 255096 sectors
Current Secsize: 2048
ATIP start of lead in:  -11754 (97:25/21)
ATIP start of lead out: 335100 (74:30/00)
Disk type:    Long strategy type (Cyanine, AZO or similar)
Manuf. index: 8
Manufacturer: Hitachi Maxell, Ltd.
Blocks total: 335100 Blocks current: 335100 Blocks remaining: 80004
RBlocks total: 346013 RBlocks current: 346013 RBlocks remaining: 90917
Starting to write CD/DVD at speed 2 in dummy mode for single session.
Waiting for reader process to fill input buffer ...
input buffer ready.
cdrecord: Input/output error. mode select g1: scsi sendcmd: retryable error
CDB:  55 10 00 00 00 00 00 00 3C 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.023s timeout 200s
cdrecord: Warning: using default CD write parameter data.
cdrecord: Cannot open new session.
Mode Select Data 00 10 00 00 05 32 12 00 00 00 00 00 00 00 00 00 00 00 00 96 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
cdrecord: fifo had 64 puts and 0 gets.

As I recall, things work just fine with a real SCSI CD burner, so I
think this behavior is limited to the ide-scsi flavor of things.  If
anyone has a clue as to what's really happening here, a fix or workaround
would be appreciated.  In the meantime, I'll continue to use the older
software (xcdroast-0.96e with cdrecord-1.6.1).  Thanks!

-- 
Bob Tracy
rct@frus.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
