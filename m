Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbTDVVgq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 17:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263505AbTDVVgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 17:36:46 -0400
Received: from [66.212.224.118] ([66.212.224.118]:19465 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id S263493AbTDVVgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 17:36:43 -0400
Date: Tue, 22 Apr 2003 17:40:50 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: 2.5.68 aic7(whoppers) touches freed memory
Message-ID: <Pine.LNX.4.50.0304221731480.2085-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ahc_pci:1:13:0: Using left over BIOS settings
ahc_pci:1:14:0: Using left over BIOS settings
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.31
        <Adaptec aic7870 SCSI adapter>
        aic7870: Wide Channel A, SCSI Id=7, 16/253 SCBs

anticipatory scheduling elevator
(scsi0:A:3): 5.000MB/s transfers (5.000MHz, offset 15)
(scsi0:A:5): 4.032MB/s transfers (4.032MHz, offset 15)
anticipatory scheduling elevator
anticipatory scheduling elevator
anticipatory scheduling elevator
  Vendor: DEC       Model: DLT2000           Rev: 830A
  Type:   Sequential-Access                  ANSI SCSI revision: 02
anticipatory scheduling elevator
anticipatory scheduling elevator
anticipatory scheduling elevator
  Vendor: TOSHIBA   Model: CD-ROM XM-5401TA  Rev: 3605
  Type:   CD-ROM                             ANSI SCSI revision: 02

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.31
        <Adaptec aic7870 SCSI adapter>
        aic7870: Wide Channel A, SCSI Id=7, 16/253 SCBs

anticipatory scheduling elevator
(scsi1:A:0): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
(scsi1:A:1): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
(scsi1:A:2): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
(scsi1:A:3): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
(scsi1:A:4): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
(scsi1:A:5): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
  Vendor: SEAGATE   Model: ST15150W          Rev: 9103
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
anticipatory scheduling elevator
anticipatory scheduling elevator
  Vendor: SEAGATE   Model: ST15150W          Rev: 9103
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1:A:1:0: Tagged Queuing enabled.  Depth 32
anticipatory scheduling elevator
anticipatory scheduling elevator
  Vendor: SEAGATE   Model: ST15150W          Rev: 9103
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1:A:2:0: Tagged Queuing enabled.  Depth 32
anticipatory scheduling elevator
anticipatory scheduling elevator
  Vendor: SEAGATE   Model: ST15150W          Rev: 9103
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1:A:3:0: Tagged Queuing enabled.  Depth 32
anticipatory scheduling elevator
anticipatory scheduling elevator
  Vendor: SEAGATE   Model: ST15150W          Rev: 9103
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1:A:4:0: Tagged Queuing enabled.  Depth 32
anticipatory scheduling elevator
anticipatory scheduling elevator
 Vendor: SEAGATE   Model: ST15150W          Rev: 9103
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1:A:5:0: Tagged Queuing enabled.  Depth 32

<snip>

Bringing up interface eth0:  ext3_abort called.
EXT3-fs abort (device sd(8,1)): ext3_journal_start: Detected aborted 
journal
Remounting filesystem read-only
Unable to handle kernel paging request at virtual address 6b6b6b6f
*pde = 00000000
Oops: 0000 [#1]
CPU:    2
EIP:    0060:[<c01281bd>]    Not tainted
EFLAGS: 00010046
EIP is at mod_timer+0xcd/0x2a0
eax: 00000002   ebx: 6b6b6b6b   ecx: cbf7e000   edx: 00c71b80
esi: c11e7fc0   edi: c151c770   ebp: c151c77c   esp: cbf7de28
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=cbf7c000 task=c14fcc80)
Stack: 00000000 00000016 00000270 11df8340 c1528000 c1528000 c02e4196 cc81104c 
       c0468380 c1604000 cbdf4440 c1528000 cbdf8340 c02da87a c151c770 0025be3e 
       c0533dc8 c0533920 00000000 c1523800 c1523800 c1523900 00000007 00000000 
Call Trace:
 [<c02e4196>] ahc_qinfifo_requeue_tail+0xd6/0xe0
 [<c02da87a>] ahc_handle_seqint+0x1a3a/0x1b70
 [<c02f6522>] ahc_linux_isr+0x2c2/0x370
 [<c010b94d>] handle_IRQ_event+0x2d/0x50
 [<c010bc1b>] do_IRQ+0xfb/0x1d0
 [<c010a208>] common_interrupt+0x18/0x20
 [<c01247ed>] do_softirq+0x5d/0xd0
 [<c0115fe5>] smp_apic_timer_interrupt+0xe5/0x150
 [<c0106eb0>] default_idle+0x0/0x40
 [<c010a28a>] apic_timer_interrupt+0x1a/0x20
 [<c0106eb0>] default_idle+0x0/0x40
 [<c0106ede>] default_idle+0x2e/0x40
 [<c0106f6a>] cpu_idle+0x3a/0x50
 [<c0120cb7>] printk+0x1b7/0x230
 [<c054092b>] print_cpu_info+0x7b/0xd0

Code: 81 7b 04 ad 4e ad de 74 19 68 b4 81 12 c0 68 37 70 41 c0 e8 
NMI Watchdog detected LOCKUP on CPU2, eip c01290b7, registers:
CPU:    2
EIP:    0060:[<c01290b7>]    Not tainted
EFLAGS: 00000086
EIP is at .text.lock.timer+0x5a/0x93
eax: 00000002   ebx: 00000000   ecx: 00000000   edx: 00c71b80
esi: c11e7fc0   edi: c059be00   ebp: c059be0c   esp: cbf7dcc4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=cbf7c000 task=c14fcc80)
Stack: 00000000 00000093 0000c530 ffffffff 0000c52f 00000046 c0120e11 0000c52f 
       00000096 00000000 00000000 c14fcc80 6b6b6b6f c026c7e5 c059be00 0049ecd4 
       0000000f c0119375 cbf7ddf4 c010a8d8 00000000 c042694e c0417cc8 c041ddce 
Call Trace:
 [<c0120e11>] release_console_sem+0x91/0x120
 [<c026c7e5>] unblank_screen+0xb5/0xe0
 [<c0119375>] bust_spinlocks+0x25/0x50
 [<c010a8d8>] die+0x88/0x110
 [<c01195fd>] do_page_fault+0x25d/0x46a
 [<c011bcb9>] __wake_up+0x49/0x80
 [<c01209e5>] call_console_drivers+0x55/0x100
 [<c0120e11>] release_console_sem+0x91/0x120
 [<c0120cb7>] printk+0x1b7/0x230
 [<c01193a0>] do_page_fault+0x0/0x46a
 [<c010a32d>] error_code+0x2d/0x40
 [<c01281bd>] mod_timer+0xcd/0x2a0
 [<c02e4196>] ahc_qinfifo_requeue_tail+0xd6/0xe0
 [<c02da87a>] ahc_handle_seqint+0x1a3a/0x1b70
 [<c02f6522>] ahc_linux_isr+0x2c2/0x370
 [<c010b94d>] handle_IRQ_event+0x2d/0x50
 [<c010bc1b>] do_IRQ+0xfb/0x1d0
 [<c010a208>] common_interrupt+0x18/0x20
 [<c01247ed>] do_softirq+0x5d/0xd0
 [<c0115fe5>] smp_apic_timer_interrupt+0xe5/0x150
 [<c0106eb0>] default_idle+0x0/0x40
 [<c010a28a>] apic_timer_interrupt+0x1a/0x20
 [<c0106eb0>] default_idle+0x0/0x40
 [<c0106ede>] default_idle+0x2e/0x40
 [<c0106f6a>] cpu_idle+0x3a/0x50
 [<c0120cb7>] printk+0x1b7/0x230
 [<c054092b>] print_cpu_info+0x7b/0xd0

Code: 7e f9 e9 a2 f2 ff ff f3 90 80 3b 00 7e f9 e9 18 f3 ff ff f3 
console shuts up ...
