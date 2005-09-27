Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVI0DAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVI0DAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 23:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVI0DAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 23:00:22 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:6063 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id S1750709AbVI0DAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 23:00:22 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: Re: just a report: 2.6.14-rc2-git[35] (UP) not stable on usenet
 server  where 2.6.12 stays up for weeks
Date: Tue, 27 Sep 2005 03:00:20 +0000 (UTC)
Organization: Cistron
Message-ID: <dhack4$bi2$1@news.cistron.nl>
References: <dh9msb$ko0$1@news.cistron.nl> <Pine.LNX.4.58.0509261459530.3308@g5.osdl.org>
X-Trace: ncc1701.cistron.net 1127790020 11842 62.216.30.70 (27 Sep 2005 03:00:20 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds  <torvalds@osdl.org> wrote:
>Really need to narrow this down a lot more. Either a oops from a serial 
>port, or pinpointing where it started happening.

compiled, installed,rebooted git6

just before crash (snapshot taken every minute & logged)

-------------
Linux 2.6.14-rc2-git6 (root@newsgate) (gcc 4.0.2 ) #1 1CPU [newsgate.(none)]

Memory:      Total        Used        Free      Shared     Buffers
Mem:       4062040     4034532       27508           0         612
Swap:            0           0           0

Bootup: Tue Sep 27 00:02:39 2005    Load average: 4.13 4.06 4.17 1/77 29517

user  :       0:30:23.86  12.2%  page in :        0
nice  :       0:04:43.51   1.9%  page out:        0
system:       1:29:08.64  35.7%  swap in :        0
idle  :       0:01:24.38   0.6%  swap out:        0
uptime:       4:09:21.98         context : 45465958

irq  0:   3736032 timer                 irq 12:         3
irq  1:         8 i8042                 irq 16:   4519576 aic79xx
irq  4:       449 serial                irq 17:  34901765 aic79xx, eth3
irq  9:         0 acpi                  irq 18:  89100231 acenic

--------------


gate:~# scsi1:0:5:0: Attempting to queue an ABORT message:CDB: 0x2a 0x0 0x4 0x8a 0xa5 0x51 0x0 0x0 0x1 0x0
scsi1: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State at program address 0x21 Mode 0x33
Card was paused
HS_MAILBOX[0x0] INTCTL[0xc0]:(SWTMINTEN|SWTMINTMASK)
SEQINTSTAT[0x10]:(SEQ_SWTMRTO) SAVED_MODE[0x11]
DFFSTAT[0x33]:(CURRFIFO_NONE|FIFO0FREE|FIFO1FREE)
SCSISIGI[0x0]:(P_DATAOUT) SCSIPHASE[0x0] SCSIBUS[0x0]
LASTPHASE[0x1]:(P_DATAOUT|P_BUSFREE) SCSISEQ0[0x0]
SCSISEQ1[0x12]:(ENAUTOATNP|ENRSELI) SEQCTL0[0x0]
SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0] SSTAT0[0x0]
SSTAT1[0x8]:(BUSFREE) SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0x0]
SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO)
LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x0] LQOSTAT0[0x0]
LQOSTAT1[0x0] LQOSTAT2[0xe1]:(LQOSTOP0|LQOPKT)

SCB Count = 128 CMDS_PENDING = 32 LASTSCB 0x13 CURRSCB 0x77 NEXTSCB 0xff80
qinstart = 47539 qinfifonext = 47539
QINFIFO:
WAITING_TID_QUEUES:
Pending list:
122 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 91 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 35 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 37 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
108 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 50 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
121 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
  5 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 16 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 86 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
105 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
117 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 83 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 70 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 63 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 87 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 53 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
103 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 41 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 97 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 95 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 57 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 80 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 72 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 46 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 66 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 94 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 81 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 73 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 96 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
 17 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
109 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x57]
Total 32
Kernel Free SCB list: 119 19 82 124 123 77 68 39 51 24 15 48 78 74 43 2 31 65 9 99 23 7 93 32 88 14 112 55 34 101 100 62 10 30 79 92 85 8 115 89 45 38 106 104 111 12 113 71 90 20 116 22 42 107 126 0 75 54 3 127 76 33 1 59 56 84 27 26 6 47 52 36 44 61 29 60 58 102 11 49 120
25 21 40 69 98 118 13 4 67 125 110 64 114 28 18
Sequencer Complete DMA-inprog list:
Sequencer Complete list:
Sequencer DMA-Up and Complete list:

scsi1: FIFO0 Free, LONGJMP == 0x823a, SCB 0x77
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS)
SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)
SG_CACHE_SHADOW[0x2]:(LAST_SEG) SG_STATE[0x0] DFFSXFRCTL[0x0]
SOFFCNT[0x0] MDFFSTAT[0x5]:(FIFOFREE|DLZERO) SHADDR = 0x00, SHCNT = 0x0
HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]:(SG_CACHE_AVAIL)
scsi1: FIFO1 Free, LONGJMP == 0x823a, SCB 0x18
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS)
SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)
Press any key to continue._SEG) SG_STATE[0x0] DFFSXF


More info @  http://newsgate.newsserver.nl/kernel/

Should i open a ticker in bugzilla ?
I did so for prior kernels but no response.
Just for the record than ? ;-)

Danny

