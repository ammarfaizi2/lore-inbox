Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267163AbSKSV3v>; Tue, 19 Nov 2002 16:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267321AbSKSV3v>; Tue, 19 Nov 2002 16:29:51 -0500
Received: from boxer.fnal.gov ([131.225.80.86]:24463 "EHLO boxer.fnal.gov")
	by vger.kernel.org with ESMTP id <S267163AbSKSV3t>;
	Tue, 19 Nov 2002 16:29:49 -0500
Date: Tue, 19 Nov 2002 15:36:53 -0600 (CST)
From: Steven Timm <timm@fnal.gov>
To: <linux-kernel@vger.kernel.org>
Subject: AMD 760MPX dma_intr: error=0x40 { UncorrectableError }
Message-ID: <Pine.LNX.4.31.0211191529360.12125-100000@boxer.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have recently observed a large frequency of this error on
a bunch of compute servers with brand new disks.

Nov 15 01:42:52 fnd0172 kernel: hdb: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Nov 15 01:42:52 fnd0172 kernel: hdb: dma_intr: error=0x40 {
UncorrectableError }, LBAsect=44763517, sector=11235856
Nov 15 01:42:52 fnd0172 kernel: end_request: I/O error, dev 03:42 (hdb),
sector 11235856

Configuration is the following:
Tyan 2466 motherboard which has AMD760MPX chipset, dual Athlon MP2000+
processors  (supports UltraATA100)

hda=Seagate ST340016A 40 GB drive, ext2 FS
hdb=Seagate ST380021A 80 GB drive, ext2 FS.

There are many entries in this mailing list saying that
the above error is a sign of a bad disk.  Seagate diagnostics
say so too.. It is just hard to believe that 30 hard drives could
go bad in less than a month.

I know errors of this type were common on machines with Serverworks
OSB4 chipsets.  Has anyone else heard of this error happening on
non-serverworks chipsets such as VIA or AMD?  And is the drive
really bad or will a low level format clear the bad blocks
and let the drive operate again?

Steve Timm

------------------------------------------------------------------

SMART shows the following error structure:

SMART Error Log:
SMART Error Logging Version: 1
Error Log Data Structure Pointer: 03
ATA Error Count: 13
Non-Fatal Count: 0

Error Log Structure 1:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
 00   00   08   57   09   ab    f2   c8     40315
 00   00   08   5f   09   ab    f2   c8     40315
 00   00   08   67   09   ab    f2   c8     40315
 00   00   08   6f   09   ab    f2   c8     40315
 00   00   08   77   09   ab    f2   c8     40315
 00   40   00   7d   09   ab    f2   51     922746
Error condition:  33    Error State:       3
Number of Hours in Drive Life: 1021 (life of the drive in hours)

Error Log Structure 2:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
 00   00   08   07   d5   55    f1   ca     40320
 00   00   08   3f   00   5c    f1   ca     40320
 00   00   08   97   33   5d    f1   ca     40320
 00   00   08   87   97   0f    f2   ca     40320
 00   00   08   77   09   ab    f2   c8     40320
 00   40   00   7d   09   ab    f2   51     922746
Error condition:  33    Error State:       3
Number of Hours in Drive Life: 1021 (life of the drive in hours)

Error Log Structure 3:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
 00   00   28   bf   8f   52    f1   c8     23662
 00   00   98   e7   8f   52    f1   c8     23662
 00   00   68   ff   9a   52    f1   c8     23662
 00   00   d8   67   9b   52    f1   c8     23662
 00   00   28   07   a3   52    f1   c8     23662
 00   40   00   25   a3   52    f1   51     1124073
Error condition: 161    Error State:       3
Number of Hours in Drive Life: 1040 (life of the drive in hours)

Error Log Structure 4:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
 00   00   e0   4f   09   ab    f2   c8     40280
 00   00   d8   57   09   ab    f2   c8     40285
 00   00   d0   5f   09   ab    f2   c8     40290
 00   00   c8   67   09   ab    f2   c8     40296
 00   00   c0   6f   09   ab    f2   c8     40301
 00   40   00   7d   09   ab    f2   51     922746
Error condition:  33    Error State:       3
Number of Hours in Drive Life: 1021 (life of the drive in hours)

Error Log Structure 5:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
 00   00   d8   57   09   ab    f2   c8     40285
 00   00   d0   5f   09   ab    f2   c8     40290
 00   00   c8   67   09   ab    f2   c8     40296
 00   00   c0   6f   09   ab    f2   c8     40301
 00   00   b8   77   09   ab    f2   c8     40306
 00   40   00   7d   09   ab    f2   51     922746
Error condition:  33    Error State:       3
Number of Hours in Drive Life: 1021 (life of the drive in hours)



Steven C. Timm (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Division/Operating Systems Support
Scientific Computing Support Group--Computing Farms Operations

