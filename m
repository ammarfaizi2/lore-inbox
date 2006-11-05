Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422694AbWKEV4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422694AbWKEV4o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 16:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422730AbWKEV4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 16:56:44 -0500
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:58047 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S1422694AbWKEV4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 16:56:43 -0500
Date: Sun, 5 Nov 2006 22:56:38 +0100 (CET)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: Oops on 2.6.18
In-Reply-To: <Pine.LNX.4.64.0611041006250.25218@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0611052242210.25619@oceanic.wsisiz.edu.pl>
References: <Pine.LNX.4.64.0610311923100.28672@oceanic.wsisiz.edu.pl>
 <Pine.LNX.4.64.0611041006250.25218@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Nov 2006, Linus Torvalds wrote:

Hello, Thank You for replay.

> Ok, this should be fixed with the commit I just checked in and pushed
> out.. That said, I don't think you'd be likely to ever be able to
> reproduce it - it looks like a very unlikely race. I think the race
> condition has been there for a long time, and googling doesn't actually
> show anybody else seemingly having ever triggered it.

Well, when I posted this post i didn't know what exactly going with system 
but after two days after this post we had problem again with system, 
but in this case, I had more info about problems, it's look like hardware 
problem, with scsi disk, scsi cable or scsi controler.


Nov  2 00:08:17 oceanic kernel: sd 1:0:1:0: Attempting to queue an ABORT message:CDB: 0x28 0x0 0x1 0x7c 0x8e 0x64 0x0 0x0 0xaa 0x0
Nov  2 00:08:17 oceanic kernel: scsi1: At time of recovery, card was not paused
Nov  2 00:08:17 oceanic kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Nov  2 00:08:17 oceanic kernel: scsi1: Dumping Card State at program address 0x3b Mode 0x22
Nov  2 00:08:17 oceanic kernel: Card was paused
Nov  2 00:08:17 oceanic kernel: INTSTAT[0x0] SELOID[0x2] SELID[0x20] HS_MAILBOX[0x0] 
Nov  2 00:08:17 oceanic kernel: INTCTL[0xc0] SEQINTSTAT[0x10] SAVED_MODE[0x11] 
Nov  2 00:08:17 oceanic kernel: DFFSTAT[0x33] SCSISIGI[0x0] SCSIPHASE[0x0] SCSIBUS[0x0] 
Nov  2 00:08:17 oceanic kernel: LASTPHASE[0x1] SCSISEQ0[0x0] SCSISEQ1[0x12] SEQCTL0[0x0] 
Nov  2 00:08:17 oceanic kernel: SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x4] QFREEZE_COUNT[0x6] 
Nov  2 00:08:17 oceanic kernel: KERNEL_QFREEZE_COUNT[0x6] MK_MESSAGE_SCB[0xff00] 
Nov  2 00:08:17 oceanic kernel: MK_MESSAGE_SCSIID[0xff] SSTAT0[0x0] SSTAT1[0x8] 
Nov  2 00:08:18 oceanic kernel: SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0x0] SIMODE1[0xa4] 
Nov  2 00:08:18 oceanic kernel: LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x0] LQOSTAT0[0x0] 
Nov  2 00:08:18 oceanic kernel: LQOSTAT1[0x0] LQOSTAT2[0xe1] 
Nov  2 00:08:18 oceanic kernel: 
Nov  2 00:08:18 oceanic kernel: SCB Count = 180 CMDS_PENDING = 1 LASTSCB 0x1e CURRSCB 0x1e NEXTSCB 0xff80
Nov  2 00:08:18 oceanic kernel: qinstart = 24205 qinfifonext = 24205
Nov  2 00:08:18 oceanic kernel: QINFIFO:
Nov  2 00:08:18 oceanic kernel: WAITING_TID_QUEUES:
Nov  2 00:08:18 oceanic kernel: Pending list:
Nov  2 00:08:18 oceanic kernel: 161 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x17] 
Nov  2 00:08:18 oceanic kernel: Total 1
Nov  2 00:08:18 oceanic kernel: Kernel Free SCB list: 30 73 152 36 121 90 60 20 133 7 42 5 39 56 107 11 51 21 131 179 84 2 15 0 132 136 67 43 110 45 81 129 32 139 44 75 151 138 83 17 19 14 98 126 124 33 41 155 47 168 16 52 28 55 105 170 29 94 148 173 97 59 78 158 164 58 70 66 149 92 62 22 74 167 118 120 141 72 96 91 4 63 140 34 154 1 102 6 142 108 163 160 80 171 57 109 137 119 37 145 26 157 76 123 122 69 27 156 18 46 9 87 117 127 89 48 111 115 86 106 143 130 64 175 153 116 172 169 65 128 93 165 150 10 54 100 144 162 68 82 146 3 147 125 50 134 135 79 77 40 99 113 8 174 95 35 12 101 103 61 88 24 159 166 114 25 71 85 23 53 31 49 13 38 112 104 178 177 176 
Nov  2 00:08:18 oceanic kernel: Sequencer Complete DMA-inprog list: 
Nov  2 00:08:18 oceanic kernel: Sequencer Complete list: 
Nov  2 00:08:18 oceanic kernel: Sequencer DMA-Up and Complete list: 
Nov  2 00:08:18 oceanic kernel: Sequencer On QFreeze and Complete list: 
Nov  2 00:08:18 oceanic kernel: 
Nov  2 00:08:18 oceanic kernel: 
Nov  2 00:08:18 oceanic kernel: scsi1: FIFO0 Free, LONGJMP == 0x825a, SCB 0x1e
Nov  2 00:08:18 oceanic kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
Nov  2 00:08:18 oceanic kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Nov  2 00:08:18 oceanic kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Nov  2 00:08:18 oceanic kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Nov  2 00:08:18 oceanic kernel: 
Nov  2 00:08:18 oceanic kernel: scsi1: FIFO1 Free, LONGJMP == 0x8272, SCB 0x81
Nov  2 00:08:18 oceanic kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x4] DFSTATUS[0x89] 
Nov  2 00:08:18 oceanic kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Nov  2 00:08:18 oceanic kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Nov  2 00:08:18 oceanic kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Nov  2 00:08:18 oceanic kernel: LQIN: 0x8 0x0 0x0 0x1e 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
Nov  2 00:08:18 oceanic kernel: scsi1: LQISTATE = 0x0, LQOSTATE = 0x0, OPTIONMODE = 0x52
Nov  2 00:08:18 oceanic kernel: scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1
Nov  2 00:08:18 oceanic kernel: scsi1: SAVED_SCSIID = 0x0 SAVED_LUN = 0x0
Nov  2 00:08:18 oceanic kernel: SIMODE0[0xc] 
Nov  2 00:08:18 oceanic kernel: CCSCBCTL[0x0] 
Nov  2 00:08:18 oceanic kernel: scsi1: REG0 == 0x1e, SINDEX = 0x11a, DINDEX = 0x106
Nov  2 00:08:18 oceanic kernel: scsi1: SCBPTR == 0x1e, SCB_NEXT == 0xff80, SCB_NEXT2 == 0xfffe
Nov  2 00:08:18 oceanic kernel: CDB 28 0 2 80 18 8
Nov  2 00:08:18 oceanic kernel: STACK: 0x24 0x0 0x0 0x0 0x0 0x0 0x0 0x0
Nov  2 00:08:18 oceanic kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
Nov  2 00:08:18 oceanic kernel: (scsi1:A:1:0): Device is disconnected, re-queuing SCB
Nov  2 00:08:18 oceanic kernel: (scsi1:A:1:0): scsi1: Recovery code sleeping
Nov  2 00:08:18 oceanic kernel: Task Management Func 0x1 Complete
Nov  2 00:08:18 oceanic kernel: Recovery SCB completes
Nov  2 00:08:18 oceanic kernel: scsi1: device overrun (status 9) on 0:1:0
Nov  2 00:08:18 oceanic kernel: Recovery code awake
Nov  2 00:08:18 oceanic kernel: sd 1:0:1:0: Attempting to queue a TARGET RESET message:CDB: 0x28 0x0 0x1 0x7c 0x8e 0x64 0x0 0x0 0xaa 0x0
Nov  2 00:08:18 oceanic kernel: scsi1: Device reset code sleeping
Nov  2 00:08:18 oceanic kernel: scsi1: device overrun (status 9) on 0:1:0
Nov  2 00:08:18 oceanic kernel: (scsi1:A:1:0): Task Management Func 0x8 Complete
Nov  2 00:08:18 oceanic kernel: Recovery SCB completes
Nov  2 00:08:18 oceanic kernel: scsi1: Device reset returning 0x2002
Nov  2 00:08:28 oceanic kernel: sd 1:0:1:0: scsi: Device offlined - not ready after error recovery
Nov  2 00:08:28 oceanic kernel: sd 1:0:1:0: SCSI error: return code = 0x00070000
Nov  2 00:08:28 oceanic kernel: end_request: I/O error, dev sdh, sector 24940132
Nov  2 00:08:28 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:08:28 oceanic kernel: Buffer I/O error on device sdh2, logical block 31236100
Nov  2 00:08:28 oceanic kernel: lost page write due to I/O error on sdh2
Nov  2 00:08:28 oceanic kernel: Buffer I/O error on device sdh2, logical block 31236101
Nov  2 00:08:28 oceanic kernel: lost page write due to I/O error on sdh2
Nov  2 00:08:28 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:08:28 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:08:28 oceanic kernel: Buffer I/O error on device sdh2, logical block 11665538
Nov  2 00:08:28 oceanic kernel: Buffer I/O error on device sdh2, logical block 11665539
Nov  2 00:08:28 oceanic kernel: Buffer I/O error on device sdh2, logical block 11665540
Nov  2 00:08:28 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:08:28 oceanic kernel: Buffer I/O error on device sdh2, logical block 11665499
Nov  2 00:08:28 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:08:28 oceanic kernel: Buffer I/O error on device sdh2, logical block 31244291
Nov  2 00:08:28 oceanic kernel: lost page write due to I/O error on sdh2
Nov  2 00:08:28 oceanic kernel: Buffer I/O error on device sdh2, logical block 31244292
Nov  2 00:09:08 oceanic kernel: lost page write due to I/O error on sdh2
Nov  2 00:09:08 oceanic kernel: Buffer I/O error on device sdh2, logical block 31244293
Nov  2 00:09:08 oceanic kernel: lost page write due to I/O error on sdh2
Nov  2 00:09:08 oceanic kernel: Buffer I/O error on device sdh2, logical block 31244294
Nov  2 00:09:08 oceanic kernel: lost page write due to I/O error on sdh2
Nov  2 00:09:08 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:09:34 oceanic kernel: printk: 1170 messages suppressed.
Nov  2 00:09:34 oceanic kernel: Buffer I/O error on device sdh2, logical block 31883267
Nov  2 00:09:34 oceanic kernel: lost page write due to I/O error on sdh2
Nov  2 00:09:34 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:09:34 oceanic kernel: sd 1:0:1:0: rejectinvice
Nov  2 00:09:34 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:09:34 oceanic kernel: printk: 781 messages suppressed.
Nov  2 00:09:34 oceanic kernel: Buffer I/O error on device sdh2, logical block 15204972
Nov  2 00:09:34 oceanic kernel: Buffer I/O error on device sdh2, logical block 15204973
Nov  2 00:09:34 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:09:34 oceanic kernel: Buffer I/O error on device sdh2, logical block 15204975
Nov  2 00:09:34 oceanic kernel: Buffer I/O error on device sdh2, logical block 15204976
Nov  2 00:09:34 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:09:34 oceanic kernel: Buffer I/O error on device sdh2, logical block 15204975
Nov  2 00:09:34 oceanic kernel: Buffer I/O error on device sdh2, logical block 15204976
Nov  2 00:09:34 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:09:34 oceanic kernel: Buffer I/O error on device sdh2, logical block 15204972
Nov  2 00:09:34 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:09:34 oceanic kernel: printk: 271 messages suppressed.
Nov  2 00:09:34 oceanic kernel: Buffer I/O error on device sdh2, logical block 15204801
Nov  2 00:09:34 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:09:34 oceanic kernel: Buffer I/O error on device sdh2, logical block 15204813
Nov  2 00:09:34 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:09:34 oceanic kernel: printk: 48 messages suppressed.
Nov  2 00:09:34 oceanic kernel: Buffer I/O error on device sdh2, logical block 15204842
Nov  2 00:09:34 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:09:34 oceanic kernel: printk: 47 messages suppressed.
Nov  2 00:09:34 oceanic kernel: Buffer I/O error on device sdh2, logical block 34290948
Nov  2 00:09:34 oceanic kernel: Buffer I/O error on device sdh2, logical block 34290949
Nov  2 00:09:34 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:10:19 oceanic kernel: ce
Nov  2 00:10:19 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:10:53 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:13:33 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:13:33 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:13:33 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:13:33 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:13:33 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:13:33 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:13:33 oceanic kernel: 0: rejecting I/O to offline device
Nov  2 00:13:33 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:13:33 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:13:33 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:13:33 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:13:33 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:13:33 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:13:33 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:13:33 oceanic kernel: EXT3-fs error (device sdh3): ext3_journal_start_sb: Detected aborted journal
Nov  2 00:13:33 oceanic kernel: Remounting filesystem read-only
Nov  2 00:14:58 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:15:02 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:15:18 oceanic kernel: EXT3-fs error (device sdh3): ext3_find_entry: reading directory #295505 offset 0
Nov  2 00:15:18 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:15:18 oceanic kernel: EXT3-fs error (device sdh3): ext3_find_entry: reading directory #295505 offset 0
Nov  2 00:15:18 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:15:18 oceanic kernel: EXT3-fs error (device sdh3): ext3_find_entry: reading directory #295505 offset 0
Nov  2 00:16:01 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:16:02 oceanic kernel: printk: 420 messages suppressed.
Nov  2 00:16:02 oceanic kernel: Buffer I/O error on device sdh2, logical block 13870607
Nov  2 00:16:02 oceanic kernel: Buffer I/O error on device sdh2, logical block 13870608
Nov  2 00:16:02 oceanic kernel: Buffer I/O error on device sdh2, logical block 13870609
Nov  2 00:16:02 oceanic kernel: Buffer I/O error on device sdh2, logical block 13870610
Nov  2 00:16:02 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:16:02 oceanic kernel: Buffer I/O error on device sdh2, logical block 13870607
Nov  2 00:16:02 oceanic kernel: Buffer I/O error on device sdh2, logical block 13870608
Nov  2 00:16:02 oceanic kernel: Buffer I/O error on device sdh2, logical block 13870609
Nov  2 00:16:02 oceanic kernel: Buffer I/O error on device sdh2, logical block 13870610
Nov  2 00:16:04 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:16:04 oceanic kernel: Buffer I/O error on device sdh2, logical block 13870607
Nov  2 00:16:04 oceanic kernel: Buffer I/O error on device sdh2, logical block 13870608
Nov  2 00:16:04 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:19:34 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:19:35 oceanic kernel: EXT3-fs error (device sdh3): ext3_find_entry: reading directory #2158739 offset 0
Nov  2 00:19:35 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:19:35 oceanic kernel: EXT3-fs error (device sdh3): ext3_find_entry: reading directory #2158739 offset 1
Nov  2 00:19:35 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:19:35 oceanic kernel: EXT3-fs error (device sdh3): ext3_find_entry: reading directory #2158739 offset 0
Nov  2 00:19:35 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:19:35 oceanic kernel: EXT3-fs error (device sdh3): ext3_find_entry: reading directory #2158739 offset 1
Nov  2 00:19:35 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:19:35 oceanic kernel: EXT3-fs error (device sdh3): ext3_find_entry: reading directory #2158739 offset 0
Nov  2 00:19:35 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:19:35 oceanic kernel: EXT3-fs error (device sdh3): ext3_find_entry: reading directory #2158739 offset 1
Nov  2 00:22:02 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:22:02 oceanic kernel: EXT3-fs error (device sdh3): ext3_find_entry: reading directory #2135197 offset 0
Nov  2 00:22:02 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:22:02 oceanic kernel: EXT3-fs error (device sdh3): ext3_find_entry: reading directory #2135197 offset 0
Nov  2 00:30:02 oceanic crond[17263]: (lukasz) CMD (/home/others/lukasz/bin/kernel)
Nov  2 00:36:36 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:36:36 oceanic kernel: EXT3-fs error (device sdh3): ext3_find_entry: reading directory #123905 offset 0
Nov  2 00:36:37 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:36:37 oceanic kernel: EXT3-fs error (device sdh3): ext3_find_entry: reading directory #123905 offset 0
Nov  2 00:36:37 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:36:37 oceanic kernel: EXT3-fs error (device sdh3): ext3_find_entry: reading directory #123905 offset 0
Nov  2 00:37:48 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:37:48 oceanic kernel: EXT3-fs error (device sdh3): ext3_find_entry: reading directory #415767 offset 0
Nov  2 00:37:48 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:37:48 oceanic kernel: EXT3-fs error (device sdh3): ext3_find_entry: reading directory #415767 offset 0
Nov  2 00:37:48 oceanic kernel: sd 1:0:1:0: rejecting I/O to offline device
Nov  2 00:37:48 oceanic kernel: EXT3-fs error (device sdh3): ext3_find_entry: reading directory #415767 offset 0
