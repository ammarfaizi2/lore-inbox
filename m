Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUDHPS3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 11:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUDHPS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 11:18:29 -0400
Received: from nick.procc.fiocruz.br ([157.86.152.50]:49585 "EHLO
	nick.procc.fiocruz.br") by vger.kernel.org with ESMTP
	id S261988AbUDHPSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 11:18:15 -0400
Message-ID: <40756CFA.7040400@fiocruz.br>
Date: Thu, 08 Apr 2004 12:17:14 -0300
From: Nicholas Anderson <nicholas@fiocruz.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: pt-br, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SCSI Tape  (st) problem ....
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

i'm using Slack 9 in a PIII machine with a DLT7000 tape drive, and 
kernel 2.4.25.

Everything was working fine before i changed my scsi disk.
Since then i've been receiving errors like this one below in my syslog, 
and my tape backup stopped working.
The system didnt change (i made a disk mirror before changing it).

I'm trying to backup 2GB of data and im getting the error below in 
syslog and a "End of Tape" as the command output.
The tape supports up to 70GB (with compression) i guess, and it was 
working 3 weeks ago ...
I tryed changing the tape but it still doesnt work.

As u kernel mantainers, r those who knows best this low-level problems, 
im sending u this email asking for help.

Any idea ?? Is it a hardware error ? Or only a module error ?
Should i try to use "st" as fix instead of module ?


My SCSI tape:

Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: TANDBERG Model: DLT7000          Rev: 2151
  Type:   Sequential-Access                ANSI SCSI revision: 02


My SCSI card/module:

Adaptec AIC7xxx driver version: 6.2.36
Adaptec 2940 Ultra2 SCSI adapter
aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs


The syslog error:

Apr  8 11:09:15 backup2 kernel: (scsi0:A:4): 20.000MB/s transfers 
(10.000MHz, offset 15, 16bit)
Apr  8 11:49:11 backup2 kernel: scsi0:0:4:0: Attempting to queue an 
ABORT message
Apr  8 11:49:11 backup2 kernel: CDB: 0xa 0x0 0x0 0x2 0x0 0x0
Apr  8 11:49:11 backup2 kernel: scsi0: At time of recovery, card was not 
paused
Apr  8 11:49:11 backup2 kernel: >>>>>>>>>>>>>>>>>> Dump Card State 
Begins <<<<<<<<<<<<<<<<<
Apr  8 11:49:11 backup2 kernel: scsi0: Dumping Card State while idle, at 
SEQADDR 0x8
Apr  8 11:49:11 backup2 kernel: Card was paused
Apr  8 11:49:11 backup2 kernel: ACCUM = 0x0, SINDEX = 0xb, DINDEX = 
0xe4, ARG_2 = 0x0
Apr  8 11:49:11 backup2 kernel: HCNT = 0x0 SCBPTR = 0x8
Apr  8 11:49:11 backup2 kernel: SCSISIGI[0x0] ERROR[0x0] SCSIBUSL[0x0] 
LASTPHASE[0x1]
Apr  8 11:49:11 backup2 kernel: SCSISEQ[0x12] SBLKCTL[0x6] SCSIRATE[0x0] 
SEQCTL[0x10]
Apr  8 11:49:11 backup2 kernel: SEQ_FLAGS[0xc0] SSTAT0[0x0] SSTAT1[0xa] 
SSTAT2[0x0]
Apr  8 11:49:11 backup2 kernel: SSTAT3[0x0] SIMODE0[0x8] SIMODE1[0xa4] 
SXFRCTL0[0x80]
Apr  8 11:49:11 backup2 kernel: DFCNTRL[0x0] DFSTATUS[0x89]
Apr  8 11:49:11 backup2 kernel: STACK: 0x83 0x166 0x10c 0x3
Apr  8 11:49:11 backup2 kernel: SCB count = 35
Apr  8 11:49:11 backup2 kernel: Kernel NEXTQSCB = 1
Apr  8 11:49:11 backup2 kernel: Card NEXTQSCB = 1
Apr  8 11:49:11 backup2 kernel: QINFIFO entries:
Apr  8 11:49:11 backup2 kernel: Waiting Queue entries:
Apr  8 11:49:11 backup2 kernel: Disconnected Queue entries: 13:31
Apr  8 11:49:11 backup2 kernel: QOUTFIFO entries:
Apr  8 11:49:11 backup2 kernel: Sequencer Free SCB List: 8 24 5 22 31 10 
28 11 18 6 4 15 0 26 30 23 12 9 16 20 7 25 3 2 1 21 27 29 19 14 17
Apr  8 11:49:11 backup2 kernel: Sequencer SCB Info:
Apr  8 11:49:11 backup2 kernel:   0 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:   1 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:   2 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:   3 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:   4 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:   5 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:   6 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:   7 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:   8 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:   9 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  10 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  11 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  12 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  13 SCB_CONTROL[0x44] SCB_SCSIID[0x47] 
SCB_LUN[0x0] SCB_TAG[0x1f]
Apr  8 11:49:11 backup2 kernel:  14 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  15 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  16 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  17 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  18 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  19 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  20 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  21 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  22 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  23 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  24 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  25 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  26 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  27 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  28 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  29 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  30 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel:  31 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff]
Apr  8 11:49:11 backup2 kernel: Pending list:
Apr  8 11:49:11 backup2 kernel:  31 SCB_CONTROL[0x40] SCB_SCSIID[0x47] 
SCB_LUN[0x0]
Apr  8 11:49:11 backup2 kernel: Kernel Free SCB list: 11 20 16 28 29 2 4 
0 12 24 25 15 7 26 13 14 33 34 22 18 5 3 9 32 21 6 27 19 23 17 8 10 30
Apr  8 11:49:11 backup2 kernel: Untagged Q(4): 31
Apr  8 11:49:11 backup2 kernel: DevQ(0:0:0): 0 waiting
Apr  8 11:49:11 backup2 kernel: DevQ(0:4:0): 0 waiting
Apr  8 11:49:11 backup2 kernel:
Apr  8 11:49:11 backup2 kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends 
 >>>>>>>>>>>>>>>>>>
Apr  8 11:49:11 backup2 kernel: (scsi0:A:4:0): Device is disconnected, 
re-queuing SCB
Apr  8 11:49:11 backup2 kernel: Recovery code sleeping
Apr  8 11:49:11 backup2 kernel: (scsi0:A:4:0): Abort Message Sent
Apr  8 11:49:11 backup2 kernel: (scsi0:A:4:0): SCB 31 - Abort Completed.
Apr  8 11:49:11 backup2 kernel: Recovery SCB completes
Apr  8 11:49:11 backup2 kernel: Recovery code awake
Apr  8 11:49:11 backup2 kernel: aic7xxx_abort returns 0x2002
Apr  8 11:49:11 backup2 kernel: (scsi0:A:4:0): data overrun detected in 
Data-out phase.  Tag == 0x1f.
Apr  8 11:49:11 backup2 kernel: (scsi0:A:4:0): Have seen Data Phase.  
Length = 512.  NumSGs = 1.
Apr  8 11:49:11 backup2 kernel: sg[0] - Addr 0x08000 : Length 512
Apr  8 11:49:11 backup2 kernel: scsi0:0:4:0: Attempting to queue a 
TARGET RESET message
Apr  8 11:49:11 backup2 kernel: CDB: 0xa 0x0 0x0 0x2 0x0 0x0
Apr  8 11:49:11 backup2 kernel: scsi0:0:4:0: Command not found
Apr  8 11:49:11 backup2 kernel: aic7xxx_dev_reset returns 0x2002
Apr  8 11:49:11 backup2 kernel: (scsi0:A:4:0): data overrun detected in 
Data-out phase.  Tag == 0x1f.
Apr  8 11:49:11 backup2 kernel: (scsi0:A:4:0): Have seen Data Phase.  
Length = 512.  NumSGs = 1.
Apr  8 11:49:11 backup2 kernel: sg[0] - Addr 0x08000 : Length 512

TIA

Nick

-- 

Nicholas Anderson
Administrador Linux/Unix
Rede Fiocruz
http://www.redefiocruz.fiocruz.br
e-mail: nicholas@fiocruz.br
Tel:(21)2598-4499


