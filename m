Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVB1RVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVB1RVn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 12:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVB1RVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 12:21:42 -0500
Received: from mail3.cwo.com ([209.210.78.52]:33462 "EHLO mail.cwo.com")
	by vger.kernel.org with ESMTP id S261705AbVB1RR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 12:17:57 -0500
Message-ID: <4223524F.9000902@cwo.com>
Date: Mon, 28 Feb 2005 09:18:07 -0800
From: "Jorg B." <jorg_b@cwo.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: scsi errors with kernel 2.4.29
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Lately I have been getting the errors below on my server... These errors 
first started when the machine was doing backups but now they seem to 
occur even during slow "IO" times. When I get these errors the machine 
becomes unresponsive and the only way to recover is by rebooting the 
server...
This machine is running Slackware Linux with kernel 2.4.29 on a 
Pentium-4 3.0 G with two 3960 Ultra 160 scsi adapters.
This machine is running Reiserfs ver. 3.6 on IBM Ultrastar drives 
(model: IC35L018UWD210-0).

Does anybody know what's causing these errors ?

Thanks for your help...

Jorg B.



Feb 25 12:37:34 linux_2.4.29 kernel: scsi0:0:0:0: Attempting to queue an 
ABORT message
Feb 25 12:37:34 linux_2.4.29 kernel: CDB: 0x2a 0x0 0x0 0x0 0xd4 0xef 0x0 
0x0 0x8 0x0
Feb 25 12:37:34 linux_2.4.29 kernel: scsi0: At time of recovery, card 
was not paused
Feb 25 12:37:34 linux_2.4.29 kernel: >>>>>>>>>>>>>>>>>> Dump Card State 
Begins <<<<<<<<<<<<<<<<<
Feb 25 12:37:34 linux_2.4.29 kernel: scsi0: Dumping Card State while 
idle, at SEQADDR 0x8
Feb 25 12:37:34 linux_2.4.29 kernel: Card was paused
Feb 25 12:37:34 linux_2.4.29 kernel: ACCUM = 0x4, SINDEX = 0x64, DINDEX 
= 0x65, ARG_2 = 0x6
Feb 25 12:37:34 linux_2.4.29 kernel: HCNT = 0x0 SCBPTR = 0x1c
Feb 25 12:37:34 linux_2.4.29 kernel: SCSIPHASE[0x0] SCSISIGI[0x0] 
ERROR[0x0] SCSIBUSL[0x0]
Feb 25 12:37:34 linux_2.4.29 kernel: LASTPHASE[0x1] SCSISEQ[0x12] 
SBLKCTL[0xa] SCSIRATE[0x0]
Feb 25 12:37:34 linux_2.4.29 kernel: SEQCTL[0x10] SEQ_FLAGS[0xc0] 
SSTAT0[0x0] SSTAT1[0x8]
Feb 25 12:37:34 linux_2.4.29 kernel: SSTAT2[0x0] SSTAT3[0x0] 
SIMODE0[0x8] SIMODE1[0xa4]
Feb 25 12:37:34 linux_2.4.29 kernel: SXFRCTL0[0x80] DFCNTRL[0x0] 
DFSTATUS[0x89]
Feb 25 12:37:34 linux_2.4.29 kernel: STACK: 0x0 0x163 0x178 0x3
Feb 25 12:37:34 linux_2.4.29 kernel: SCB count = 35
Feb 25 12:37:34 linux_2.4.29 kernel: Kernel NEXTQSCB = 32
Feb 25 12:37:34 linux_2.4.29 kernel: Card NEXTQSCB = 32
Feb 25 12:37:34 linux_2.4.29 kernel: QINFIFO entries:
Feb 25 12:37:34 linux_2.4.29 kernel: Waiting Queue entries:
Feb 25 12:37:34 linux_2.4.29 kernel: Disconnected Queue entries: 28:24 0:34
Feb 25 12:37:34 linux_2.4.29 kernel: QOUTFIFO entries:
Feb 25 12:37:34 linux_2.4.29 kernel: Sequencer Free SCB List: 16 19 21 9 
13 7 17 20 5 24 23 1 18 12 4 31 11 2 29 3 14 26 27 30 25 10 15 22 8 6
Feb 25 12:37:34 linux_2.4.29 kernel: Sequencer SCB Info:
Feb 25 12:37:34 linux_2.4.29 kernel:   0 SCB_CONTROL[0x64] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0x22]
Feb 25 12:37:34 linux_2.4.29 kernel:   1 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:   2 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:   3 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:   4 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:   5 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:   6 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:   7 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:   8 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:   9 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:  10 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:  11 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:  12 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:  13 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:  14 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:  15 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:  16 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:  17 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:  18 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:  19 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:  20 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:  21 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:  22 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:  23 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel:  24 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:34 linux_2.4.29 kernel: Pending list:
Feb 25 12:37:34 linux_2.4.29 kernel: DevQ(0:0:0): 0 waiting
Feb 25 12:37:34 linux_2.4.29 kernel:
Feb 25 12:37:44 linux_2.4.29 kernel: scsi0:0:0:0: Attempting to queue an 
ABORT message
Feb 25 12:37:44 linux_2.4.29 kernel: CDB: 0x0 0x0 0x0 0x0 0x0 0x0
Feb 25 12:37:44 linux_2.4.29 kernel: scsi0: At time of recovery, card 
was not paused
Feb 25 12:37:44 linux_2.4.29 kernel: >>>>>>>>>>>>>>>>>> Dump Card State 
Begins <<<<<<<<<<<<<<<<<
Feb 25 12:37:44 linux_2.4.29 kernel: scsi0: Dumping Card State while 
idle, at SEQADDR 0x8
Feb 25 12:37:44 linux_2.4.29 kernel: Card was paused
Feb 25 12:37:44 linux_2.4.29 kernel: ACCUM = 0x4, SINDEX = 0x64, DINDEX 
= 0x65, ARG_2 = 0x8
Feb 25 12:37:44 linux_2.4.29 kernel: HCNT = 0x0 SCBPTR = 0x0
Feb 25 12:37:44 linux_2.4.29 kernel: SCSIPHASE[0x0] SCSISIGI[0x0] 
ERROR[0x0] SCSIBUSL[0x0]
Feb 25 12:37:44 linux_2.4.29 kernel: LASTPHASE[0x1] SCSISEQ[0x12] 
SBLKCTL[0xa] SCSIRATE[0x0]
Feb 25 12:37:44 linux_2.4.29 kernel: SEQCTL[0x10] SEQ_FLAGS[0xc0] 
SSTAT0[0x0] SSTAT1[0x8]
Feb 25 12:37:44 linux_2.4.29 kernel: SSTAT2[0x0] SSTAT3[0x0] 
SIMODE0[0x8] SIMODE1[0xa4]
Feb 25 12:37:44 linux_2.4.29 kernel: SXFRCTL0[0x80] DFCNTRL[0x0] 
DFSTATUS[0x89]
Feb 25 12:37:44 linux_2.4.29 kernel: STACK: 0xe1 0x0 0x178 0x3
Feb 25 12:37:44 linux_2.4.29 kernel: SCB count = 35
Feb 25 12:37:44 linux_2.4.29 kernel: Kernel NEXTQSCB = 34
Feb 25 12:37:44 linux_2.4.29 kernel: Card NEXTQSCB = 34
Feb 25 12:37:44 linux_2.4.29 kernel: QINFIFO entries:
Feb 25 12:37:44 linux_2.4.29 kernel: Waiting Queue entries:
Feb 25 12:37:44 linux_2.4.29 kernel: Disconnected Queue entries: 0:32 28:24
Feb 25 12:37:44 linux_2.4.29 kernel: QOUTFIFO entries:
Feb 25 12:37:44 linux_2.4.29 kernel: Sequencer Free SCB List: 16 19 21 9 
13 7 17 20 5 24 23 1 18 12 4 31 11 2 29 3 14 26 27 30 25 10 15 22 8 6
Feb 25 12:37:44 linux_2.4.29 kernel: Sequencer SCB Info:
Feb 25 12:37:44 linux_2.4.29 kernel:   0 SCB_CONTROL[0x64] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0x20]
Feb 25 12:37:44 linux_2.4.29 kernel:   1 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:   2 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:   3 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:   4 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:   5 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:   6 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:   7 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:   8 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:   9 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:  10 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:  11 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:  12 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:  13 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:  14 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:  15 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:  16 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:  17 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:  18 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:  19 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:  20 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:  21 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:  22 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:  23 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:  24 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel:  25 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:44 linux_2.4.29 kernel: Pending list:
Feb 25 12:37:54 linux_2.4.29 kernel: scsi0:0:0:0: Attempting to queue an 
ABORT message
Feb 25 12:37:54 linux_2.4.29 kernel: CDB: 0x0 0x0 0x0 0x0 0x0 0x0
Feb 25 12:37:54 linux_2.4.29 kernel: scsi0: At time of recovery, card 
was not paused
Feb 25 12:37:54 linux_2.4.29 kernel: >>>>>>>>>>>>>>>>>> Dump Card State 
Begins <<<<<<<<<<<<<<<<<
Feb 25 12:37:54 linux_2.4.29 kernel: scsi0: Dumping Card State while 
idle, at SEQADDR 0x8
Feb 25 12:37:54 linux_2.4.29 kernel: Card was paused
Feb 25 12:37:54 linux_2.4.29 kernel: ACCUM = 0x4, SINDEX = 0x64, DINDEX 
= 0x65, ARG_2 = 0x8
Feb 25 12:37:54 linux_2.4.29 kernel: HCNT = 0x0 SCBPTR = 0x1c
Feb 25 12:37:54 linux_2.4.29 kernel: SCSIPHASE[0x0] SCSISIGI[0x0] 
ERROR[0x0] SCSIBUSL[0x0]
Feb 25 12:37:54 linux_2.4.29 kernel: LASTPHASE[0x1] SCSISEQ[0x12] 
SBLKCTL[0xa] SCSIRATE[0x0]
Feb 25 12:37:54 linux_2.4.29 kernel: SEQCTL[0x10] SEQ_FLAGS[0xc0] 
SSTAT0[0x0] SSTAT1[0x8]
Feb 25 12:37:54 linux_2.4.29 kernel: SSTAT2[0x0] SSTAT3[0x0] 
SIMODE0[0x8] SIMODE1[0xa4]
Feb 25 12:37:54 linux_2.4.29 kernel: SXFRCTL0[0x80] DFCNTRL[0x0] 
DFSTATUS[0x89]
Feb 25 12:37:54 linux_2.4.29 kernel: STACK: 0xe1 0xe1 0x178 0x3
Feb 25 12:37:54 linux_2.4.29 kernel: SCB count = 35
Feb 25 12:37:54 linux_2.4.29 kernel: Kernel NEXTQSCB = 24
Feb 25 12:37:54 linux_2.4.29 kernel: Card NEXTQSCB = 24
Feb 25 12:37:54 linux_2.4.29 kernel: QINFIFO entries:
Feb 25 12:37:54 linux_2.4.29 kernel: Waiting Queue entries:
Feb 25 12:37:54 linux_2.4.29 kernel: Disconnected Queue entries: 28:34
Feb 25 12:37:54 linux_2.4.29 kernel: QOUTFIFO entries:
Feb 25 12:37:54 linux_2.4.29 kernel: Sequencer Free SCB List: 0 16 19 21 
9 13 7 17 20 5 24 23 1 18 12 4 31 11 2 29 3 14 26 27 30 25 10 15 22 8 6
Feb 25 12:37:54 linux_2.4.29 kernel: Sequencer SCB Info:
Feb 25 12:37:54 linux_2.4.29 kernel:   0 SCB_CONTROL[0x64] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:   1 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:   2 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:   3 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:   4 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:   5 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:   6 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:   7 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:   8 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:   9 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:  10 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:  11 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:  12 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:  13 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:  14 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:  15 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:  16 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:  17 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:  18 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:  19 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:  20 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:  21 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:  22 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:  23 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:  24 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel:  25 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:37:54 linux_2.4.29 kernel: Pending list:
Feb 25 12:38:04 linux_2.4.29 kernel: scsi0:0:0:0: Attempting to queue an 
ABORT message
Feb 25 12:38:04 linux_2.4.29 kernel: CDB: 0x0 0x0 0x0 0x0 0x0 0x0
Feb 25 12:38:04 linux_2.4.29 kernel: scsi0: At time of recovery, card 
was not paused
Feb 25 12:38:04 linux_2.4.29 kernel: >>>>>>>>>>>>>>>>>> Dump Card State 
Begins <<<<<<<<<<<<<<<<<
Feb 25 12:38:04 linux_2.4.29 kernel: scsi0: Dumping Card State while 
idle, at SEQADDR 0x9
Feb 25 12:38:04 linux_2.4.29 kernel: Card was paused
Feb 25 12:38:04 linux_2.4.29 kernel: ACCUM = 0x4, SINDEX = 0x64, DINDEX 
= 0x65, ARG_2 = 0x6
Feb 25 12:38:04 linux_2.4.29 kernel: HCNT = 0x0 SCBPTR = 0x1c
Feb 25 12:38:04 linux_2.4.29 kernel: SCSIPHASE[0x0] SCSISIGI[0x0] 
ERROR[0x0] SCSIBUSL[0x0]
Feb 25 12:38:04 linux_2.4.29 kernel: LASTPHASE[0x1] SCSISEQ[0x12] 
SBLKCTL[0xa] SCSIRATE[0x0]
Feb 25 12:38:04 linux_2.4.29 kernel: SEQCTL[0x10] SEQ_FLAGS[0xc0] 
SSTAT0[0x0] SSTAT1[0x8]
Feb 25 12:38:04 linux_2.4.29 kernel: SSTAT2[0x0] SSTAT3[0x0] 
SIMODE0[0x8] SIMODE1[0xa4]
Feb 25 12:38:04 linux_2.4.29 kernel: SXFRCTL0[0x80] DFCNTRL[0x0] 
DFSTATUS[0x89]
Feb 25 12:38:04 linux_2.4.29 kernel: STACK: 0xe1 0xe1 0x178 0x3
Feb 25 12:38:04 linux_2.4.29 kernel: SCB count = 35
Feb 25 12:38:04 linux_2.4.29 kernel: Kernel NEXTQSCB = 34
Feb 25 12:38:04 linux_2.4.29 kernel: Card NEXTQSCB = 34
Feb 25 12:38:04 linux_2.4.29 kernel: QINFIFO entries:
Feb 25 12:38:04 linux_2.4.29 kernel: Waiting Queue entries:
Feb 25 12:38:04 linux_2.4.29 kernel: Disconnected Queue entries: 28:24
Feb 25 12:38:04 linux_2.4.29 kernel: QOUTFIFO entries:
Feb 25 12:38:04 linux_2.4.29 kernel: Sequencer Free SCB List: 0 16 19 21 
9 13 7 17 20 5 24 23 1 18 12 4 31 11 2 29 3 14 26 27 30 25 10 15 22 8 6
Feb 25 12:38:04 linux_2.4.29 kernel: Sequencer SCB Info:
Feb 25 12:38:04 linux_2.4.29 kernel:   0 SCB_CONTROL[0x64] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:   1 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:   2 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:   3 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:   4 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:   5 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:   6 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:   7 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:   8 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:   9 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:  10 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:  11 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:  12 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:  13 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:  14 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:  15 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:  16 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:  17 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:  18 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:  19 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:  20 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:  21 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:  22 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:  23 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:  24 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel:  25 SCB_CONTROL[0xe0] 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Feb 25 12:38:04 linux_2.4.29 kernel: Pending list:
Feb 25 12:38:09 linux_2.4.29 kernel:  I/O error: dev 08:03, sector 2326384
Feb 25 12:38:09 linux_2.4.29 kernel:  I/O error: dev 08:01, sector 54448
Feb 25 12:38:09 linux_2.4.29 kernel: journal-615: buffer write failed
Feb 25 12:38:09 linux_2.4.29 kernel:  (device sd(8,1))
Feb 25 12:38:09 linux_2.4.29 kernel: kernel BUG at prints.c:341!
Feb 25 12:38:09 linux_2.4.29 kernel: invalid operand: 0000
Feb 25 12:38:09 linux_2.4.29 kernel: CPU:    0
Feb 25 12:38:09 linux_2.4.29 kernel: EIP:    0010:[<c017d68c>]    Not 
tainted
Feb 25 12:38:09 linux_2.4.29 kernel: EFLAGS: 00010282
Feb 25 12:38:09 linux_2.4.29 kernel: eax: 00000036   ebx: c0242e60   
ecx: f77be000   edx: 00000001
Feb 25 12:38:09 linux_2.4.29 kernel: esi: f7e83800   edi: f7d98000   
ebp: f7e83800   esp: f7ee9e0c
Feb 25 12:38:09 linux_2.4.29 kernel: ds: 0018   es: 0018   ss: 0018
Feb 25 12:38:09 linux_2.4.29 kernel: Process kupdated (pid: 6, 
stackpage=f7ee9000)
Feb 25 12:38:09 linux_2.4.29 kernel: Stack: c0240efb c02c9920 c02c7be0 
00000801 c0242e60 f7ee9e38 00000009 e1789480
Feb 25 12:38:09 linux_2.4.29 kernel:        c01881c0 f7e83800 c0242e60 
00001a7b e1789480 efa5eac4 f880c000 c5e77000
Feb 25 12:38:09 linux_2.4.29 kernel:        e17894b8 e1789498 0000000a 
00000000 ef540500 c018cbe3 f7e83800 e1789480
Feb 25 12:38:09 linux_2.4.29 kernel: Call Trace:    [<c01881c0>] 
[<c018cbe3>] [<c018b9c2>] [<c017ad41>] [<c017ad5a>]
Feb 25 12:38:09 linux_2.4.29 kernel:   [<c0131c52>] [<c013120a>] 
[<c01314c5>] [<c0106ada>] [<c01313a8>] [<c0105518>]
Feb 25 12:38:09 linux_2.4.29 kernel:
Feb 25 12:38:09 linux_2.4.29 kernel: Code: 0f 0b 55 01 0e 0f 24 c0 68 20 
99 2c c0 85 f6 74 13 0f b7 46
Feb 25 12:38:09 linux_2.4.29 kernel:  <6>Device 08:03 not ready.
Feb 25 12:38:09 linux_2.4.29 kernel:  I/O error: dev 08:03, sector 2326384
Feb 25 12:38:09 linux_2.4.29 kernel: sd(8,3):vs-13050: 
reiserfs_update_sd: i/o failure occurred trying to update [92741 92742 
0x0 SD] stat data
Feb 25 12:38:35 linux_2.4.29 kernel: SCSI disk error : host 0 channel 0 
id 0 lun 0 return code = 8000002
Feb 25 12:38:35 linux_2.4.29 kernel: Info fld=0xd4a7, Deferred sd08:03: 
sns = f1  4
Feb 25 12:38:35 linux_2.4.29 kernel: ASC= 2 ASCQ= 0
Feb 25 12:38:35 linux_2.4.29 kernel: Raw sense data:0xf1 0x00 0x04 0x00 
0x00 0xd4 0xa7 0x18 0x00 0x00 0x00 0x00 0x02 0x00 0x00 0x80 0xff 0xfd 
0x03 0x07 0x00 0x01 0x00 0x00 0x00 0x19 0x00 0xeb 0x00 0xeb 0x00 0x00
Feb 25 12:38:35 linux_2.4.29 kernel:  I/O error: dev 08:03, sector 3112288
Feb 25 12:38:35 linux_2.4.29 kernel:  I/O error: dev 08:03, sector 1910440
Feb 25 12:38:35 linux_2.4.29 kernel:  I/O error: dev 08:03, sector 1911664
Feb 25 12:38:35 linux_2.4.29 kernel:  I/O error: dev 08:03, sector 2290320
Feb 25 12:38:35 linux_2.4.29 kernel:  I/O error: dev 08:03, sector 2291000
Feb 25 12:38:35 linux_2.4.29 kernel:  I/O error: dev 08:03, sector 2323288
Feb 25 12:38:35 linux_2.4.29 kernel:  I/O error: dev 08:03, sector 2323440
Feb 25 12:38:35 linux_2.4.29 kernel:  I/O error: dev 08:03, sector 2325768
Feb 25 12:38:35 linux_2.4.29 kernel:  I/O error: dev 08:03, sector 2326096
Feb 25 12:38:35 linux_2.4.29 kernel:  I/O error: dev 08:03, sector 2326224
Feb 25 12:38:35 linux_2.4.29 kernel:  I/O error: dev 08:03, sector 2326240
Feb 25 12:38:35 linux_2.4.29 kernel:  I/O error: dev 08:03, sector 2970680
Feb 25 12:38:35 linux_2.4.29 kernel:  I/O error: dev 08:03, sector 2947648
Feb 25 12:38:35 linux_2.4.29 kernel:  I/O error: dev 08:03, sector 3119408
Feb 25 12:38:35 linux_2.4.29 kernel:  I/O error: dev 08:03, sector 62240
Feb 25 12:38:35 linux_2.4.29 kernel: journal-601, buffer write failed
Feb 25 12:38:35 linux_2.4.29 kernel:  (device sd(8,3))
Feb 25 12:38:35 linux_2.4.29 kernel: kernel BUG at prints.c:341!
Feb 25 12:38:35 linux_2.4.29 kernel: invalid operand: 0000
Feb 25 12:38:35 linux_2.4.29 kernel: CPU:    0
Feb 25 12:38:35 linux_2.4.29 kernel: EIP:    0010:[<c017d68c>]    Not 
tainted
Feb 25 12:38:35 linux_2.4.29 kernel: EFLAGS: 00010282
Feb 25 12:38:35 linux_2.4.29 kernel: eax: 00000036   ebx: c0242d60   
ecx: dcbd0000   edx: f183e080
Feb 25 12:38:35 linux_2.4.29 kernel: esi: f7c6c400   edi: f7c27000   
ebp: f7c6c400   esp: dcbd1d6c
Feb 25 12:38:35 linux_2.4.29 kernel: ds: 0018   es: 0018   ss: 0018
Feb 25 12:38:35 linux_2.4.29 kernel: Process httpsd (pid: 6161, 
stackpage=dcbd1000)
Feb 25 12:38:35 linux_2.4.29 kernel: Stack: c0240efb c02c9920 c02c7be0 
00000803 c0242d60 dcbd1d98 00000000 f024f980
Feb 25 12:38:35 linux_2.4.29 kernel:        c018811d f7c6c400 c0242d60 
f891d500 00000000 f024f980 efa5e200 00000000
Feb 25 12:38:35 linux_2.4.29 kernel:        f024f9b8 f024f998 0000001b 
00000000 e5b3c280 c0188728 f7c6c400 f024f980
Feb 25 12:38:35 linux_2.4.29 kernel: Call Trace:    [<c018811d>] 
[<c0188728>] [<c0188fe7>] [<c018c15c>] [<c018caca>]
Feb 25 12:38:35 linux_2.4.29 kernel:   [<c018b756>] [<c017b52f>] 
[<c017b541>] [<c013f452>] [<c0122fb0>] [<c01361c4>]
Feb 25 12:38:35 linux_2.4.29 kernel:   [<c0136195>] [<c01235c3>] 
[<c017725e>] [<c012d6a6>] [<c0106b27>]
Feb 25 12:38:35 linux_2.4.29 kernel:
Feb 25 12:38:35 linux_2.4.29 kernel: Code: 0f 0b 55 01 0e 0f 24 c0 68 20 
99 2c c0 85 f6 74 13 0f b7 46
Feb 25 12:40:18 linux_2.4.29 kernel:  <6>Device 08:01 not ready.
Feb 25 12:40:18 linux_2.4.29 kernel:  I/O error: dev 08:01, sector 1616064
Feb 25 12:40:36 linux_2.4.29 kernel:  I/O error: dev 08:01, sector 1618664

