Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263541AbTCUHKV>; Fri, 21 Mar 2003 02:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263542AbTCUHKU>; Fri, 21 Mar 2003 02:10:20 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:22808
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263541AbTCUHKD>; Fri, 21 Mar 2003 02:10:03 -0500
Date: Fri, 21 Mar 2003 02:17:56 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: aic7(censored) dying horribly in 2.5.65-mm2 (fwd)
Message-ID: <Pine.LNX.4.50.0303210217370.2133-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin i got this booting 2.5.65-mm2, 2.5.65 was fine there is an oops 
right at the end. Is there anything specific you want?

01:0d.0 SCSI storage controller: Adaptec AHA-294x / AIC-7870 (rev 03)
01:0e.0 SCSI storage controller: Adaptec AHA-294x / AIC-7870 (rev 03)

There are 6 spindles on that second HBA, and a DLT and CDROM on the first.

CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC7XXX_OLD is not set

Starting NFS statd: [  OK  ]
Loading keymap: scsi1:0:0:0: Attempting to queue an ABORT message
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State while idle, at SEQADDR 0x8
Card was paused
ACCUM = 0x55, SINDEX = 0xa, DINDEX = 0x8c, ARG_2 = 0x0
HCNT = 0x0 SCBPTR = 0x8
SCSISIGI[0xe6]:(REQI|BSYI|MSGI|IOI|CDI) ERROR[0x40]:(PCIERRSTAT) 
SCSIBUSL[0x80] LASTPHASE[0x1]:(P_BUSFREE) 
SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) 
SBLKCTL[0x2]:(SELWIDE) SCSIRATE[0x0] SEQCTL[0x10]:(FASTMODE) 
SEQ_FLAGS[0xc0]:(NO_CDB_SENT|NOT_IDENTIFIED) 
SSTAT0[0x25]:(DMADONE|SDONE|SELDI) 
SSTAT1[0xb]:(REQINIT|PHASECHG|BUSFREE) SSTAT2[0x0] 
SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO) 
SXFRCTL0[0x80]:(DFON) DFCNTRL[0x0] 
DFSTATUS[0x29]:(FIFOEMP|HDONE|FIFOQWDEMP) 
STACK: 0x0 0x169 0x10c 0x3
SCB count = 56
Kernel NEXTQSCB = 8
Card NEXTQSCB = 8
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 0:13 
QOUTFIFO entries: 
Sequencer Free SCB List: 8 3 2 9 13 5 6 4 14 7 1 11 12 10 15 
Sequencer SCB Info: 
  0 SCB_CONTROL[0x64]:(DISCONNECTED|TAG_ENB|DISCENB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xd] 
  1 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  2 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  3 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  4 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  5 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  6 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  7 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  8 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  9 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
 10 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
 11 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
 12 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
 13 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
 14 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
 15 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
Pending list: 
 13 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x7] SCB_LUN[0x0] 
Kernel Free SCB list: 10 11 0 25 41 28 31 40 45 29 30 46 47 24 26 5 20 21 
42 43 27 23 22 49 50 36 37 3 48 4 1 7 18 44 35 
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
DevQ(0:2:0): 0 waiting
DevQ(0:3:0): 0 waiting
DevQ(0:4:0): 0 waiting
DevQ(0:5:0): 0 waiting

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
(scsi1:A:0:0): Device is disconnected, re-queuing SCB
Recovery code sleeping
(scsi1:A:0:0): Abort Tag Message Sent
(scsi1:A:0:0): SCB 13 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 0x2002
scsi1:0:0:0: Attempting to queue an ABORT message
scsi1:0:0:0: Command not found
aic7xxx_abort returns 0x2002
scsi1:0:0:0: Attempting to queue an ABORT message
scsi1:0:0:0: Command not found
aic7xxx_abort returns 0x2002
[  OK  ]
Loading system font:  scsi1:0:0:0: Attempting to queue an ABORT message
scsi1:0:0:0: Command not found
aic7xxx_abort returns 0x2002
scsi1:0:0:0: Attempting to queue an ABORT message
scsi1:0:0:0: Command not found
aic7xxx_abort returns 0x2002
scsi1:0:0:0: Attempting to queue an ABORT message
scsi1:0:0:0: Command not found
aic7xxx_abort returns 0x2002
scsi1:0:0:0: Attempting to queue a TARGET RESET message
scsi1:0:0:0: Command not found
aic7xxx_dev_reset returns 0x2002
scsi1:0:0:0: Attempting to queue an ABORT message
scsi1:0:0:0: Command not found
aic7xxx_abort returns 0x2002
scsi1:0:0:0: Attempting to queue an ABORT message
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State while idle, at SEQADDR 0x8
Card was paused
ACCUM = 0xea, SINDEX = 0x64, DINDEX = 0x65, ARG_2 = 0xa
HCNT = 0x0 SCBPTR = 0x4
SCSISIGI[0x0] ERROR[0x40]:(PCIERRSTAT) SCSIBUSL[0x0] 
LASTPHASE[0x1]:(P_BUSFREE) SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) 
SBLKCTL[0x2]:(SELWIDE) SCSIRATE[0x0] SEQCTL[0x10]:(FASTMODE) 
SEQ_FLAGS[0xc0]:(NO_CDB_SENT|NOT_IDENTIFIED) SSTAT0[0x5]:(DMADONE|SDONE) 
SSTAT1[0xa]:(PHASECHG|BUSFREE) SSTAT2[0x0] SSTAT3[0x0] 
SIMODE0[0x0] SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO) 
SXFRCTL0[0x80]:(DFON) DFCNTRL[0x0] 
DFSTATUS[0x2d]:(FIFOEMP|DFTHRESH|HDONE|FIFOQWDEMP) 
STACK: 0xe4 0x169 0x199 0x3
SCB count = 56
Kernel NEXTQSCB = 8
Card NEXTQSCB = 8
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 4:43 
QOUTFIFO entries: 
Sequencer Free SCB List: 0 2 12 11 14 7 1 15 10 3 9 13 6 5 8 
Sequencer SCB Info: 
  0 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  1 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  2 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  3 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  4 SCB_CONTROL[0x64]:(DISCONNECTED|TAG_ENB|DISCENB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0x2b] 
  5 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  6 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  7 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  8 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  9 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
 10 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
 11 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
 12 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
 13 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
 14 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
 15 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
Pending list: 
 43 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x7] SCB_LUN[0x0] 
Kernel Free SCB list: 31 44 46 30 40 45 29 3 24 23 37 47 20 21 5 42 27 26 
50 22 49 36 1 4 48 18 11 10 7 0 25 28 41 13 35 
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
DevQ(0:2:0): 0 waiting
DevQ(0:3:0): 0 waiting
DevQ(0:4:0): 0 waiting
DevQ(0:5:0): 0 waiting

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
(scsi1:A:0:0): Device is disconnected, re-queuing SCB
(scsi1:A:0:0): Recovery code sleeping
Abort Tag Message Sent
Recovery code awake
Timer Expired
aic7xxx_abort returns 0x2003
SCSI disk error : host 1 channel 0 id 0 lun 0 return code = 6000000
end_request: I/O error, dev sda, sector 133984
Buffer I/O error on device sd(8,1), logical block 16744
SCSI disk error : host 1 channel 0 id 0 lun 0 return code = 6000000
end_request: I/O error, dev sda, sector 4980800
Buffer I/O error on device sd(8,1), logical block 622596
Debug: sleeping function called from illegal context at 
include/linux/rwsem.h:43
Call Trace:
 [<c011ed18>] __might_sleep+0x58/0x60
 [<c028ec00>] __bdevname+0x50/0xc0
 [<c015cb41>] buffer_io_error+0x11/0x30
 [<c015d406>] end_buffer_async_write+0x166/0x190
 [<c0160101>] end_bio_bh_io_sync+0x21/0x30
 [<c0161515>] bio_endio+0x35/0x60
 [<c028df8f>] __end_that_request_first+0x1ff/0x220
 [<c028dfc7>] end_that_request_first+0x17/0x20
 [<c028a864>] elv_next_request+0x84/0xe0
 [<c02e187f>] scsi_request_fn+0x3f/0x2a0
 [<c028c442>] __blk_run_queue+0x12/0x20
 [<c02e022d>] scsi_restart_operations+0xbd/0x120
 [<c02e05b8>] scsi_error_handler+0x138/0x1a0
 [<c02e0480>] scsi_error_handler+0x0/0x1a0
 [<c0107095>] kernel_thread_helper+0x5/0x10
Buffer I/O error on device sd(8,1), logical block 557066
(scsi1:A:0:0): SCB 43 - Abort Tag Completed.
Recovery SCB completes

Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
6b6b6b6b
*pde = 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<6b6b6b6b>]    Not tainted
EFLAGS: 00010002 VLI
EIP is at 0x6b6b6b6b
eax: cbb1ccf8   ebx: 00000000   ecx: cbe31290   edx: 00000000
esi: 00000001   edi: c1509f20   ebp: 00000005   esp: c1509ea0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c1508000 task=c150a660)
Stack: c02ff78c cbb1ccf8 cbb1ccf8 cbe31290 c0305c07 cbe31290 cbb1ccf8 00000292 
       3e7ac717 c17e848c cbffe4f4 04000001 c010bb0d 00000005 cbe31290 c1509f20 
       c05060a0 c1508000 c1508000 00000005 c010be49 00000005 c1509f20 cbffe4f4 
Call Trace:
 [<c02ff78c>] ahc_linux_run_complete_queue+0x3c/0x50
 [<c0305c07>] ahc_linux_isr+0x1d7/0x3a0
 [<c010bb0d>] handle_IRQ_event+0x2d/0x50
 [<c010be49>] do_IRQ+0x109/0x210
 [<c010a398>] common_interrupt+0x18/0x20
 [<c01264f6>] do_softirq+0x56/0xc0
 [<c01168a5>] smp_apic_timer_interrupt+0xf5/0x160
 [<c0106ea0>] default_idle+0x0/0x40
 [<c010a41a>] apic_timer_interrupt+0x1a/0x20
 [<c0106ea0>] default_idle+0x0/0x40
 [<c0106ece>] default_idle+0x2e/0x40
 [<c0106f5a>] cpu_idle+0x3a/0x50
 [<c01226fd>] release_console_sem+0xbd/0x170
 [<c012256b>] printk+0x1eb/0x270

Code:  Bad EIP value.
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

