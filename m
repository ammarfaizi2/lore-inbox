Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267405AbTAGQkJ>; Tue, 7 Jan 2003 11:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267406AbTAGQkI>; Tue, 7 Jan 2003 11:40:08 -0500
Received: from adsl-67-113-154-34.dsl.sntc01.pacbell.net ([67.113.154.34]:58868
	"EHLO postbox.aslab.com") by vger.kernel.org with ESMTP
	id <S267405AbTAGQkF>; Tue, 7 Jan 2003 11:40:05 -0500
Message-ID: <3E1B0500.2030500@aslab.com>
Date: Tue, 07 Jan 2003 08:49:04 -0800
From: Michael Madore <mmadore@aslab.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Reproducible SCSI Error with Adaptec 7902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am receiving the following messages in my system log when stress testing
with Cerberus (http://sourceforge.net/projects/va-ctcs).  This is with an
onboard Adaptec 7902 Ultra 320 SCSI adapter.  The messages are reproducible
on two different systems.  This is with the 1.1.0 aic79xx driver, on 
both the
stock Redhat kernel, and with a kernel compiled from the 2.4.19 sources. 
The
system does not seem to be harmed by the messages, but I would like to 
know if
they point to a problem or not.  Interestingly, if I put and Adaptec 
29320 PCI
card into the same machine, and use the same driver, the error is not 
reproducible.

Mike

Jan  4 05:00:01 asl200 kernel: DevQ(0:2:0): 44 waiting
Jan  4 05:00:01 asl200 kernel: DevQ(0:6:0): 0 waiting
Jan  4 05:00:01 asl200 kernel: Abort called for cmd f78b5200
Jan  4 05:00:01 asl200 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins 
<<<<<<<<<<<<<<<<<
Jan  4 05:00:01 asl200 kernel: scsi0: Dumping Card State at program 
address 0x71 Mode 0x22
Jan  4 05:00:02 asl200 kernel: SCSISEQ0[0x0] 
SCSISEQ1[0x12]:(ENAUTOATNP|ENRSELI)
Jan  4 05:00:02 asl200 kernel: SEQINTCTL[0x80]:(INTVEC1DSL) 
SCSISIGI[0x0]:(P_DATAOUT)
Jan  4 05:00:02 asl200 kernel: SCSIPHASE[0x0] SCSIBUS[0x0] 
LASTPHASE[0x1]:(P_DATAOUT|P_BUSFREE)
Jan  4 05:00:02 asl200 kernel: SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0] 
SSTAT0[0x0] SSTAT1[0x8]:(BUSFREE)
Jan  4 05:00:02 asl200 kernel: SSTAT2[0x0] SSTAT3[0x0] 
PERRDIAG[0x8]:(AIPERR) SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO)
Jan  4 05:00:03 asl200 kernel: LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x0] 
LQOSTAT0[0x0]
Jan  4 05:00:03 asl200 kernel: LQOSTAT1[0x0] LQOSTAT2[0x1]:(LQOSTOP0)
Jan  4 05:00:03 asl200 kernel: SCB Count = 108 LASTSCB 0x30 CURRSCB 0x30 
NEXTSCB 0xff00
Jan  4 05:00:03 asl200 kernel: qinstart = 21755 qinfifonext = 21755
Jan  4 05:00:03 asl200 kernel: QINFIFO:
Jan  4 05:00:03 asl200 kernel: WAITING_TID_QUEUES:
Jan  4 05:00:03 asl200 kernel: Pending list:
Jan  4 05:00:03 asl200 kernel:  67 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x43]
Jan  4 05:00:03 asl200 kernel:  55 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x37]
Jan  4 05:00:03 asl200 kernel:  26 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x1a]
Jan  4 05:00:03 asl200 kernel:  58 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x3a]
Jan  4 05:00:03 asl200 kernel:   0 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x0]
Jan  4 05:00:03 asl200 kernel:  31 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x1f]
Jan  4 05:00:03 asl200 kernel:  25 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x19]
Jan  4 05:00:03 asl200 kernel:  56 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x38]
Jan  4 05:00:03 asl200 kernel:  24 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x18]
Jan  4 05:00:03 asl200 kernel:  37 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x25]
Jan  4 05:00:03 asl200 kernel:   9 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x9]
Jan  4 05:00:03 asl200 kernel:  52 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x34]
Jan  4 05:00:03 asl200 kernel:  60 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x3c]
Jan  4 05:00:03 asl200 kernel:  47 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x2f]
Jan  4 05:00:03 asl200 kernel:  12 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0xc]
Jan  4 05:00:03 asl200 kernel:  43 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x2b]
Jan  4 05:00:03 asl200 kernel:  17 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x11]
Jan  4 05:00:03 asl200 kernel:  11 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0xb]
Jan  4 05:00:03 asl200 kernel:  32 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x20]
Jan  4 05:00:03 asl200 kernel:  50 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x32]
Jan  4 05:00:03 asl200 kernel:  16 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x10]
Jan  4 05:00:03 asl200 kernel:   8 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x8]
Jan  4 05:00:03 asl200 kernel:  57 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x39]
Jan  4 05:00:04 asl200 kernel:  14 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0xe]
Jan  4 05:00:04 asl200 kernel:  29 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x1d]
Jan  4 05:00:04 asl200 kernel:  33 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x21]
Jan  4 05:00:04 asl200 kernel:  61 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x3d]
Jan  4 05:00:04 asl200 kernel:   2 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x2]
Jan  4 05:00:06 asl200 kernel:  45 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x2d]
Jan  4 05:00:07 asl200 kernel:  19 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x13]
Jan  4 05:00:10 asl200 kernel:   3 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x3]
Jan  4 05:00:12 asl200 kernel:  53 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x35]
Jan  4 05:00:14 asl200 kernel:  34 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x22]
Jan  4 05:00:16 asl200 kernel:  15 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0xf]
Jan  4 05:00:18 asl200 kernel:  54 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x36]
Jan  4 05:00:18 asl200 kernel:  28 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x1c]
Jan  4 05:00:19 asl200 kernel:  59 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x3b]
Jan  4 05:00:20 asl200 kernel:  35 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x23]
Jan  4 05:00:21 asl200 kernel:  62 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x3e]
Jan  4 05:00:22 asl200 kernel:   5 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x5]
Jan  4 05:00:23 asl200 kernel:  39 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x27]
Jan  4 05:00:24 asl200 kernel:  49 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x31]
Jan  4 05:00:29 asl200 kernel:  40 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x28]
Jan  4 05:00:31 asl200 kernel:  30 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x1e]
Jan  4 05:00:40 asl200 kernel:  10 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0xa]
Jan  4 05:00:40 asl200 kernel:  20 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x14]
Jan  4 05:00:40 asl200 kernel:  18 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x12]
Jan  4 05:00:40 asl200 kernel:   4 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x4]
Jan  4 05:00:40 asl200 kernel:   1 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x1]
Jan  4 05:00:41 asl200 kernel:  44 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x2c]
Jan  4 05:00:41 asl200 kernel:  36 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x24]
Jan  4 05:00:42 asl200 kernel:  27 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x1b]
Jan  4 05:00:46 asl200 kernel:  22 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x16]
Jan  4 05:00:50 asl200 kernel:  23 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x17]
Jan  4 05:00:54 asl200 kernel:  51 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x33]
Jan  4 05:00:54 asl200 kernel:  42 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x2a]
Jan  4 05:00:55 asl200 kernel:  21 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x15]
Jan  4 05:00:55 asl200 kernel:  38 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x26]
Jan  4 05:00:55 asl200 kernel:   7 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x7]
Jan  4 05:00:56 asl200 kernel:  13 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0xd]
Jan  4 05:00:57 asl200 kernel:  46 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x2e]
Jan  4 05:00:59 asl200 kernel:  63 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) 
SCB_SCSIID[0x27] SCB_TAG[0x3f]
Jan  4 05:01:02 asl200 kernel: Kernel Free SCB list: 48 41 6 104 105 106 
107 100 101 102 103 96 97 98 99 92 93 94 95 88 89 90 91 84 85 86 87 80 
81 82 83 76 77 78 79 72 73 74 75 68 69 70 71 64 65 66
Jan  4 05:01:02 asl200 kernel: Sequencer Complete DMA-inprog list:
Jan  4 05:01:03 asl200 kernel: Sequencer Complete list:
Jan  4 05:01:03 asl200 kernel: Sequencer DMA-Up and Complete list:
Jan  4 05:01:03 asl200 kernel: scsi0: FIFO0 Free, LONGJMP == 0x825c, SCB 
0x30, LJSCB 0x30
Jan  4 05:01:03 asl200 kernel: 
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS) 

Jan  4 05:01:03 asl200 kernel: SEQINTSRC[0x0] DFCNTRL[0x0] 
DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)
Jan  4 05:01:03 asl200 kernel: SG_CACHE_SHADOW[0x2]:(LAST_SEG) 
SG_STATE[0x0] DFFSXFRCTL[0x0]
Jan  4 05:01:03 asl200 kernel: SOFFCNT[0x0] 
MDFFSTAT[0x5]:(FIFOFREE|DLZERO) SHADDR = 0x00, SHCNT = 0x0
Jan  4 05:01:03 asl200 kernel: HADDR = 0x00, HCNT = 
0x0CCSGCTL[0x10]:(SG_CACHE_AVAIL)
Jan  4 05:01:03 asl200 kernel: scsi0: FIFO1 Free, LONGJMP == 0x8226, SCB 
0x26, LJSCB 0x2e
Jan  4 05:01:03 asl200 kernel: 
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS) 

Jan  4 05:01:03 asl200 kernel: SEQINTSRC[0x0] DFCNTRL[0x0] 
DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)
Jan  4 05:01:03 asl200 kernel: SG_CACHE_SHADOW[0x2]:(LAST_SEG) 
SG_STATE[0x0] DFFSXFRCTL[0x0]
Jan  4 05:01:03 asl200 kernel: SOFFCNT[0x0] 
MDFFSTAT[0x5]:(FIFOFREE|DLZERO) SHADDR = 0x00, SHCNT = 0x0
Jan  4 05:01:03 asl200 kernel: HADDR = 0x00, HCNT = 
0x0CCSGCTL[0x10]:(SG_CACHE_AVAIL)
Jan  4 05:01:03 asl200 kernel: LQIN: 0x55 0x0 0x0 0x30 0x0 0x0 0x0 0x0 
0x0 0x0 0x0 0x0 0x0 0x0 0x0 0xc 0x0 0x0 0x0 0x0
Jan  4 05:01:03 asl200 kernel: scsi0: LQISTATE = 0x0, LQOSTATE = 0x0, 
OPTIONMODE = 0x42
Jan  4 05:01:03 asl200 kernel: scsi0: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1
Jan  4 05:01:03 asl200 kernel: scsi0: REG0 == 0x30, SINDEX = 0x133, 
DINDEX = 0x106
Jan  4 05:01:03 asl200 kernel: scsi0: SCBPTR == 0x30, SCB_NEXT == 
0xff80, SCB_NEXT2 == 0xff91
Jan  4 05:01:03 asl200 kernel: CDB 2a 0 0 85 86 e2
Jan  4 05:01:03 asl200 kernel: STACK: 0x1 0x104 0x0 0x0 0x21f 0x21f 
0x25c 0x27
Jan  4 05:01:03 asl200 kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends 
 >>>>>>>>>>>>>>>>>>
Jan  4 05:01:03 asl200 kernel: DevQ(0:2:0): 44 waiting
Jan  4 05:01:03 asl200 kernel: DevQ(0:6:0): 0 waiting
Jan  4 05:01:03 asl200 kernel: dev reset called for cmd f7880000
Jan  4 05:01:03 asl200 kernel: bus reset called for cmd f7880000
Jan  4 05:01:03 asl200 kernel: (scsi0:A:2:0): Now packetized.

