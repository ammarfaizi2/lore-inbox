Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbVFVLSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVFVLSy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 07:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbVFVLSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 07:18:54 -0400
Received: from mx.sileman.pl ([217.173.160.41]:21915 "EHLO mx.sileman.pl")
	by vger.kernel.org with ESMTP id S262477AbVFVLSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 07:18:39 -0400
Date: Wed, 22 Jun 2005 13:18:20 +0200
From: RedIpS <ris@elsat.net.pl>
To: linux-kernel@vger.kernel.org
Subject: BUG - realtime-preempt-2.6.12-final-V0.7.50
Message-ID: <20050622131820.4aa2554e@redips.elsat.net.pl>
X-Mailer: Sylpheed-Claws 1.0.1cvs1.3 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SILEMAN-MailScanner-Information: Please contact the ISP for more information
X-SILEMAN-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SILEMAN-MCPCheck: MCP-Clean, MCP-Checker (score=-4.9, required 1,
	BAYES_00 -4.90)
X-SILEMAN-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.9,
	required 5, autolearn=not spam, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DMESG:

Linux agpgart interface v0.101 (c) Dave Jones
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7664  Wed May
25 10:47:55 PDT 2005 ufsd: driver loaded
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
PCI: Via IRQ fixup for 0000:00:11.5, from 5 to 6
PCI: Setting latency timer of device 0000:00:11.5 to 64
int3: 0000 [#1]
PREEMPT 
Modules linked in: snd_via82xx snd_ac97_codec snd_mpu401_uart
snd_rawmidi nls_iso8859_2 ufsd nvidia agpgart lm90 i2c_sensor tuner bttv
video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc tveeprom
i2c_core usblp videodev uhci_hcd psmouse ehci_hcd usbcore rtc CPU:    0
EIP:    0060:[<c03f1961>]    Tainted: P      VLI
EFLAGS: 00000086   (2.6.12-ris6) 
EIP is at print_IO_APIC+0x1/0x430
eax: 00000200   ebx: d674e000   ecx: 00000009   edx: 00000002
esi: 00000016   edi: 00000016   ebp: 00000000   esp: d674ef64
ds: 007b   es: 007b   ss: 0068   preempt: 00000002
Process IRQ 22 (pid: 5353, threadinfo=d674e000 task=d6b022f0)
Stack: c011317f 00000016 c03de540 c03de540 c03de540 d674e000 c013972f
00000016        c03de540 00000000 d953eba0 d674e000 c03de540 c03de540
c01397c0 c013982e        c03de540 00000001 d674efb0 00000025 d674e000
d673ddb0 c012f165 c03de540 Call Trace:
 [<c011317f>] end_level_ioapic_irq+0x4f/0xb0 (4)
 [<c013972f>] do_hardirq+0x7f/0x110 (24)
 [<c01397c0>] do_irqd+0x0/0xa0 (32)
 [<c013982e>] do_irqd+0x6e/0xa0 (4)
 [<c012f165>] kthread+0xa5/0xb0 (28)
 [<c012f0c0>] kthread+0x0/0xb0 (28)
 [<c0101381>] kernel_thread_helper+0x5/0x14 (16)
Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc <cc> cc
cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  <6>note: IRQ
22[5353] exited with preempt_count 1 BUG: scheduling while atomic: IRQ
22/0x00000001/5353 caller is do_exit+0x1f1/0x3a0
 [<c0304bbe>] __schedule+0x67e/0x6d0 (8)
 [<c011cc11>] do_exit+0x1f1/0x3a0 (8)
 [<c011cb58>] do_exit+0x138/0x3a0 (20)
 [<c0133081>] up_mutex+0x31/0x80 (12)
 [<c011cc11>] do_exit+0x1f1/0x3a0 (36)
 [<c01044ee>] die+0x17e/0x180 (40)
 [<c0104776>] do_int3+0x86/0xa0 (60)
 [<e106a4e4>] snd_via82xx_interrupt+0xb4/0xc0 [snd_via82xx] (56)
 [<c0103e8a>] int3+0x1e/0x24 (16)
 [<c03f1961>] print_IO_APIC+0x1/0x430 (44)
 [<c011317f>] end_level_ioapic_irq+0x4f/0xb0 (12)
 [<c013972f>] do_hardirq+0x7f/0x110 (24)
 [<c01397c0>] do_irqd+0x0/0xa0 (32)
 [<c013982e>] do_irqd+0x6e/0xa0 (4)
 [<c012f165>] kthread+0xa5/0xb0 (28)
 [<c012f0c0>] kthread+0x0/0xb0 (28)
 [<c0101381>] kernel_thread_helper+0x5/0x14 (16)
prev->state: 2 != TASK_RUNNING??
IRQ 22/5353: BUG in __schedule at kernel/sched.c:2968
 [<c0304ae4>] __schedule+0x5a4/0x6d0 (8)
 [<c011cb58>] do_exit+0x138/0x3a0 (28)
 [<c011cc11>] do_exit+0x1f1/0x3a0 (48)
 [<c01044ee>] die+0x17e/0x180 (40)
 [<c0104776>] do_int3+0x86/0xa0 (60)
 [<e106a4e4>] snd_via82xx_interrupt+0xb4/0xc0 [snd_via82xx] (56)
 [<c0103e8a>] int3+0x1e/0x24 (16)
 [<c03f1961>] print_IO_APIC+0x1/0x430 (44)
 [<c011317f>] end_level_ioapic_irq+0x4f/0xb0 (12)
 [<c013972f>] do_hardirq+0x7f/0x110 (24)
 [<c01397c0>] do_irqd+0x0/0xa0 (32)
 [<c013982e>] do_irqd+0x6e/0xa0 (4)
 [<c012f165>] kthread+0xa5/0xb0 (28)
 [<c012f0c0>] kthread+0x0/0xb0 (28)
 [<c0101381>] kernel_thread_helper+0x5/0x14 (16)
BUG: Unable to handle kernel NULL pointer dereference at virtual address
00000200 printing eip:
c03f1960
*pde = 00000000
Oops: 0002 [#2]
PREEMPT 
Modules linked in: snd_via82xx snd_ac97_codec snd_mpu401_uart
snd_rawmidi nls_iso8859_2 ufsd nvidia agpgart lm90 i2c_sensor tuner bttv
video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc tveeprom
i2c_core usblp videodev uhci_hcd psmouse ehci_hcd usbcore rtc CPU:    0
EIP:    0060:[<c03f1960>]    Tainted: P      VLI
EFLAGS: 00010086   (2.6.12-ris6) 
EIP is at print_IO_APIC+0x0/0x430
eax: 00000200   ebx: dede1000   ecx: 00000009   edx: 00020000
esi: 00000011   edi: 00000011   ebp: 00000001   esp: dede1f64
ds: 007b   es: 007b   ss: 0068   preempt: 00000002
Process IRQ 17 (pid: 2152, threadinfo=dede1000 task=df3bf6f0)
Stack: c011317f 00000011 c03de2c0 c03de2c0 c03de2c0 dede1000 c013972f
00000011        c03de2c0 00000001 df23be20 dede1000 c03de2c0 c03de2c0
c01397c0 c013982e        c03de2c0 00000001 dede1fb0 00000027 dede1000
df3a0d84 c012f165 c03de2c0 Call Trace:
 [<c011317f>] end_level_ioapic_irq+0x4f/0xb0 (4)
 [<c013972f>] do_hardirq+0x7f/0x110 (24)
 [<c01397c0>] do_irqd+0x0/0xa0 (32)
 [<c013982e>] do_irqd+0x6e/0xa0 (4)
 [<c012f165>] kthread+0xa5/0xb0 (28)
 [<c012f0c0>] kthread+0x0/0xb0 (28)
 [<c0101381>] kernel_thread_helper+0x5/0x14 (16)
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  <6>note: IRQ
17[2152] exited with preempt_count 1 BUG: scheduling while atomic: IRQ
17/0x00000001/2152 caller is do_exit+0x1f1/0x3a0
 [<c0304bbe>] __schedule+0x67e/0x6d0 (8)
 [<c011cc11>] do_exit+0x1f1/0x3a0 (8)
 [<c011cb58>] do_exit+0x138/0x3a0 (20)
 [<c0133081>] up_mutex+0x31/0x80 (12)
 [<c011cc11>] do_exit+0x1f1/0x3a0 (36)
 [<c01044ee>] die+0x17e/0x180 (40)
 [<c011a887>] printk+0x17/0x20 (48)
 [<c0114569>] do_page_fault+0x2b9/0x590 (12)
 [<c0305b00>] __down_mutex+0x30/0x1c0 (56)
 [<c0304e1f>] preempt_schedule_irq+0x4f/0x70 (56)
 [<c0248b7d>] rtl8139_interrupt+0xbd/0x1c0 (24)
 [<c0133081>] up_mutex+0x31/0x80 (12)
 [<c0248b7d>] rtl8139_interrupt+0xbd/0x1c0 (12)
 [<c03060de>] _spin_lock+0x2e/0x40 (4)
 [<c0248afa>] rtl8139_interrupt+0x3a/0x1c0 (8)
 [<c0248b7d>] rtl8139_interrupt+0xbd/0x1c0 (12)
 [<c01142b0>] do_page_fault+0x0/0x590 (20)
 [<c0103cdf>] error_code+0x4f/0x54 (8)
 [<c03f1960>] print_IO_APIC+0x0/0x430 (44)
 [<c011317f>] end_level_ioapic_irq+0x4f/0xb0 (12)
 [<c013972f>] do_hardirq+0x7f/0x110 (24)
 [<c01397c0>] do_irqd+0x0/0xa0 (32)
 [<c013982e>] do_irqd+0x6e/0xa0 (4)
 [<c012f165>] kthread+0xa5/0xb0 (28)
 [<c012f0c0>] kthread+0x0/0xb0 (28)
 [<c0101381>] kernel_thread_helper+0x5/0x14 (16)
prev->state: 2 != TASK_RUNNING??
IRQ 17/2152: BUG in __schedule at kernel/sched.c:2968
 [<c0304ae4>] __schedule+0x5a4/0x6d0 (8)
 [<c011cb58>] do_exit+0x138/0x3a0 (28)
 [<c011cc11>] do_exit+0x1f1/0x3a0 (48)
 [<c01044ee>] die+0x17e/0x180 (40)
 [<c011a887>] printk+0x17/0x20 (48)
 [<c0114569>] do_page_fault+0x2b9/0x590 (12)
 [<c0305b00>] __down_mutex+0x30/0x1c0 (56)
 [<c0304e1f>] preempt_schedule_irq+0x4f/0x70 (56)
 [<c0248b7d>] rtl8139_interrupt+0xbd/0x1c0 (24)
 [<c0133081>] up_mutex+0x31/0x80 (12)
 [<c0248b7d>] rtl8139_interrupt+0xbd/0x1c0 (12)
 [<c03060de>] _spin_lock+0x2e/0x40 (4)
 [<c0248afa>] rtl8139_interrupt+0x3a/0x1c0 (8)
 [<c0248b7d>] rtl8139_interrupt+0xbd/0x1c0 (12)
 [<c01142b0>] do_page_fault+0x0/0x590 (20)
 [<c0103cdf>] error_code+0x4f/0x54 (8)
 [<c03f1960>] print_IO_APIC+0x0/0x430 (44)
 [<c011317f>] end_level_ioapic_irq+0x4f/0xb0 (12)
 [<c013972f>] do_hardirq+0x7f/0x110 (24)
 [<c01397c0>] do_irqd+0x0/0xa0 (32)
 [<c013982e>] do_irqd+0x6e/0xa0 (4)
 [<c012f165>] kthread+0xa5/0xb0 (28)
 [<c012f0c0>] kthread+0x0/0xb0 (28)
 [<c0101381>] kernel_thread_helper+0x5/0x14 (16)
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0005 c07f media 00.
eth0: Tx queue start entry 381  dirty entry 377.
eth0:  Tx descriptor 0 is 0008a03c.
eth0:  Tx descriptor 1 is 0008a03e. (queue head)
eth0:  Tx descriptor 2 is 0008a03c.
eth0:  Tx descriptor 3 is 0008a03c.
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0055 c07f media 00.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a03c. (queue head)
eth0:  Tx descriptor 1 is 0008a03c.
eth0:  Tx descriptor 2 is 0008a03c.
eth0:  Tx descriptor 3 is 0008a03c.
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0055 c07f media 00.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a03c. (queue head)
eth0:  Tx descriptor 1 is 0008a03c.
eth0:  Tx descriptor 2 is 0008a03c.
eth0:  Tx descriptor 3 is 0008a03c.
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31
cpu 0 cold: low 0, high 62, batch 31
HighMem per-cpu: empty

Free pages:        6300kB (0kB HighMem)
Active:89541 inactive:28619 dirty:3 writeback:0 unstable:0 free:1575
slab:4282 mapped:64770 pagetables:386 DMA free:2216kB min:88kB low:108kB
high:132kB active:10368kB inactive:212kB present:16384kB pages_scanned:0
all_unreclaimable? no lowmem_reserve[]: 0 495 495
Normal free:4084kB min:2804kB low:3504kB high:4204kB active:347796kB
inactive:114264kB present:507840kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 HighMem free:0kB min:128kB low:160kB high:192kB
active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable?
no lowmem_reserve[]: 0 0 0
DMA: 0*4kB 3*8kB 3*16kB 3*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
1*2048kB 0*4096kB = 2216kB Normal: 59*4kB 53*8kB 10*16kB 0*32kB 1*64kB
1*128kB 0*256kB 2*512kB 0*1024kB 1*2048kB 0*4096kB = 4084kB HighMem:
empty Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 646592kB
Total swap = 646592kB
Free swap:       646592kB
131056 pages of RAM
0 pages of HIGHMEM
3339 reserved pages
100720 pages shared
0 pages swap cached
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0055 c07f media 00.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a03c. (queue head)
eth0:  Tx descriptor 1 is 0008a03c.
eth0:  Tx descriptor 2 is 0008a03c.
eth0:  Tx descriptor 3 is 0008a03c.
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0055 c07f media 00.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a03c. (queue head)
eth0:  Tx descriptor 1 is 0008a03c.
eth0:  Tx descriptor 2 is 0008a03c.
eth0:  Tx descriptor 3 is 0008a03c.
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0055 c07f media 00.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a03c. (queue head)
eth0:  Tx descriptor 1 is 0008a03c.
eth0:  Tx descriptor 2 is 0008a03c.
eth0:  Tx descriptor 3 is 0008a03c.
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
