Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281908AbRLOHb7>; Sat, 15 Dec 2001 02:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282042AbRLOHbu>; Sat, 15 Dec 2001 02:31:50 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:30566 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S281908AbRLOHbb>; Sat, 15 Dec 2001 02:31:31 -0500
Date: Sat, 15 Dec 2001 08:30:45 +0100
From: Christian Ullrich <chris@chrullrich.de>
To: linux-kernel@vger.kernel.org
Subject: SCSI errors on SuSE 2.4.10
Message-ID: <20011215083045.A23746@christian.chrullrich.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Current-Uptime: 4 d, 15:57:46 h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm getting an increasing number of these when accessing my 
DVD drive (with an ordinary CD-ROM in it). The system freezes for
about thirty seconds, no mouse motion in X, I can change virtual
consoles, but not login or start any other processes.

After those thirty seconds, the drive spins up again and all is 
fine. Here is the dmesg output:

scsi0:0:2:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x7
ACCUM = 0x2c, SINDEX = 0xd, DINDEX = 0x8c, ARG_2 = 0x0
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0x2
 DFCNTRL = 0x0, DFSTATUS = 0x29
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x5, SSTAT1 = 0xa
STACK == 0x3, 0xec, 0x147, 0x37
SCB count = 132
Kernel NEXTQSCB = 105
Card NEXTQSCB = 105
QINFIFO entries:
Waiting Queue entries:
Disconnected Queue entries:
QOUTFIFO entries:
Sequencer Free SCB List: 12 0 11 3 13 4 15 5 10 9 1 6 2 8 7 14
Pending list: 97
Kernel Free SCB list: 13 82 32 61 87 10 1 114 71 33 131 41 27 26 3
125 70 7 94  100 121 127 17 31 103 109 88 58 76 63 8 130 86 6 112
25 124 77 57 122 69 14 35  116 48 55 99 39 37 111 36 72 101 18 98
46 74 106 117 65 23 118 102 60 110 19 0  66 40 68 115 90 38 81 62
24 20 80 104 42 52 119 53 43 9 113 15 78 83 91 73 28  12 93 92 96
126 56 2 120 49 50 34 30 22 85 11 5 64 45 75 54 108 59 89 47 4 16 
107 44 21 29 67 123 95 84 51 79 129 128
Untagged Q(2): 97
DevQ(0:0:0): 0 waiting
DevQ(0:2:0): 1 waiting
DevQ(0:3:0): 0 waiting
DevQ(0:6:0): 0 waiting
(scsi0:A:2:0): Queuing a recovery SCB
scsi0:0:2:0: Device is disconnected, re-queuing SCB
Recovery code sleeping
(scsi0:A:2:0): Abort Message Sent
(scsi0:A:2:0): SCB 97 - Abort Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 8194
(scsi0:A:2:0): Unexpected busfree in Command phase
SEQADDR == 0x14d
scsi0:0:2:0: Attempting to queue an ABORT message
scsi0:0:2:0: Command not found
aic7xxx_abort returns 8194
scsi0:0:2:0: Attempting to queue a TARGET RESET message
scsi0:0:2:0: Command not found
aic7xxx_dev_reset returns 8194
Device not ready.  Make sure there is a disc in the drive.

(the line breaks in the free SCB list are mine)

In syslog, there are more of these. I will supply them on request,
as the amount is large.

Hardware:

* Adaptec AHA2940UW controlling:
  - (wide, ID 0) IBM DNES-309170W
  - (wide, ID 6) IBM DNES-309170W
  - (narrow, ID 2) Pioneer DVD-305U
  - (narrow, ID 3) Yamaha CRW4416S

  <6>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.3
  <4>        <Adaptec 2940 Ultra SCSI adapter>
  <4>        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

* AMD Athlon on ASUS A7V133, VIA KT133A chipset:

Software:

* Kernel 2.4.10-4GB, from SuSE 7.3 k_deflt-2.4.10-25.i386.rpm

-- 
Christian Ullrich		     Registrierter Linux-User #125183

"Deliver."
