Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270696AbTG0Iyj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 04:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270697AbTG0Iyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 04:54:39 -0400
Received: from luli.rootdir.de ([213.133.108.222]:14509 "HELO luli.rootdir.de")
	by vger.kernel.org with SMTP id S270696AbTG0Iya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 04:54:30 -0400
Date: Sun, 27 Jul 2003 11:09:40 +0200
From: Claas Langbehn <claas@rootdir.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.0-test1-ac3: ide-scsi woes
Message-ID: <20030727090940.GA870@rootdir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Reply-By: Mit Jul 30 10:58:31 CEST 2003
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0-test1-ac3 i686
X-No-archive: yes
X-Uptime: 10:58:31 up 18 min,  2 users,  load average: 0.03, 0.17, 0.15
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


i just want to report a possible bug:

Ide-scsi of kernel 2.6.0-test1-ac3 is not working very good.
When burning a cd with cdrdao 1.1.7 there are errors on the
bus (see below). I could not kill -9 cdrdao to get the drive
to be usable again. I had to reboot.


Regards, Claas

--

Jul 26 19:33:25 zoo kernel: hdc: irq timeout: status=0xd8 { Busy }
Jul 26 19:33:25 zoo kernel: hdc: DMA disabled
Jul 26 19:33:25 zoo kernel: ide-scsi: abort called for 10155
Jul 26 19:33:25 zoo kernel: hdc: ATAPI reset complete
Jul 26 19:33:25 zoo kernel: hdc: irq timeout: status=0xd0 { Busy }
Jul 26 19:33:25 zoo kernel: hdc: ATAPI reset complete
Jul 26 19:33:25 zoo kernel: hdc: irq timeout: status=0xd0 { Busy }
Jul 26 19:34:04 zoo kernel: hdc: irq timeout: status=0xd8 { Busy }
Jul 26 19:34:04 zoo kernel: ide-scsi: abort called for 11720
Jul 26 19:34:04 zoo kernel: hdc: ATAPI reset complete
Jul 26 19:34:04 zoo kernel: hdc: irq timeout: status=0xd0 { Busy }
Jul 26 19:34:04 zoo kernel: hdc: ATAPI reset complete
Jul 26 19:34:04 zoo kernel: hdc: irq timeout: status=0xd0 { Busy }
Jul 26 19:34:46 zoo kernel: hdc: irq timeout: status=0xd8 { Busy }
Jul 26 19:34:46 zoo kernel: hdc: ATAPI reset complete
Jul 26 19:34:46 zoo kernel: hdc: irq timeout: status=0xd0 { Busy }
Jul 26 19:34:46 zoo kernel: hdc: ATAPI reset complete
Jul 26 19:34:46 zoo kernel: hdc: irq timeout: status=0xd0 { Busy }
Jul 26 19:34:46 zoo kernel: ide-scsi: abort called for 13561
Jul 26 19:34:46 zoo kernel: ide-scsi: (IO,CoD) != (0,1) while issuing a
packet command
Jul 26 19:34:46 zoo kernel: hdc: ATAPI reset complete
Jul 26 19:38:22 zoo kernel: hdc: irq timeout: status=0xd8 { Busy }
Jul 26 19:38:22 zoo kernel: ide-scsi: abort called for 19633
Jul 26 19:38:22 zoo kernel: Debug: sleeping function called from invalid
context at include/asm/semaphore.h:119
Jul 26 19:38:22 zoo kernel: Call Trace:
Jul 26 19:38:22 zoo kernel:  [<c011b11b>] __might_sleep+0x5b/0x80
Jul 26 19:38:22 zoo kernel:  [<c02da1a8>] scsi_sleep+0x68/0x90
Jul 26 19:38:22 zoo kernel:  [<c02da120>] scsi_sleep_done+0x0/0x20
Jul 26 19:38:22 zoo kernel:  [<c02e0768>] idescsi_abort+0xa8/0xb0
Jul 26 19:38:22 zoo kernel:  [<c02d9b35>]
scsi_try_to_abort_cmd+0x45/0x50
Jul 26 19:38:22 zoo kernel:  [<c02d9c50>] scsi_eh_abort_cmds+0x40/0x80
Jul 26 19:38:22 zoo kernel:  [<c02da5c5>] scsi_unjam_host+0x85/0xb0
Jul 26 19:38:22 zoo kernel:  [<c02da6a5>] scsi_error_handler+0xb5/0xf0
Jul 26 19:38:22 zoo kernel:  [<c02da5f0>] scsi_error_handler+0x0/0xf0
Jul 26 19:38:22 zoo kernel:  [<c0107229>] kernel_thread_helper+0x5/0xc
Jul 26 19:38:22 zoo kernel:
Jul 26 19:38:22 zoo kernel: hdc: ATAPI reset complete
Jul 26 19:38:22 zoo kernel: hdc: irq timeout: status=0xd0 { Busy }
Jul 26 19:38:22 zoo kernel: hdc: ATAPI reset complete
Jul 26 19:38:22 zoo kernel: hdc: irq timeout: status=0xd0 { Busy }
Jul 26 19:40:39 zoo kernel: hdc: irq timeout: status=0xd8 { Busy }
Jul 26 19:40:39 zoo kernel: ide-scsi: abort called for 21428
Jul 26 19:40:39 zoo kernel: Debug: sleeping function called from invalid
context at include/asm/semaphore.h:119
Jul 26 19:40:39 zoo kernel: Call Trace:
Jul 26 19:40:39 zoo kernel:  [<c011b11b>] __might_sleep+0x5b/0x80
Jul 26 19:40:39 zoo kernel:  [<c02da1a8>] scsi_sleep+0x68/0x90
Jul 26 19:40:39 zoo kernel:  [<c02da120>] scsi_sleep_done+0x0/0x20
Jul 26 19:40:39 zoo kernel:  [<c02e0768>] idescsi_abort+0xa8/0xb0
Jul 26 19:40:39 zoo kernel:  [<c02d9b35>]
scsi_try_to_abort_cmd+0x45/0x50
Jul 26 19:40:39 zoo kernel:  [<c02d9c50>] scsi_eh_abort_cmds+0x40/0x80
Jul 26 19:40:39 zoo kernel:  [<c02da5c5>] scsi_unjam_host+0x85/0xb0
Jul 26 19:40:39 zoo kernel:  [<c02da6a5>] scsi_error_handler+0xb5/0xf0
Jul 26 19:40:39 zoo kernel:  [<c02da5f0>] scsi_error_handler+0x0/0xf0
Jul 26 19:40:39 zoo kernel:  [<c0107229>] kernel_thread_helper+0x5/0xc
Jul 26 19:40:39 zoo kernel:
Jul 26 19:40:47 zoo kernel: ide-scsi: reset called for 21428
Jul 26 19:40:47 zoo kernel: ------------[ cut here ]------------
Jul 26 19:40:47 zoo kernel: kernel BUG at kernel/timer.c:166!
Jul 26 19:40:47 zoo kernel: invalid operand: 0000 [#1]
Jul 26 19:40:47 zoo kernel: CPU:    0
Jul 26 19:40:47 zoo kernel: EIP:    0060:[<c01239bd>]    Not tainted
Jul 26 19:40:47 zoo kernel: EFLAGS: 00010002
Jul 26 19:40:47 zoo kernel: EIP is at add_timer+0x5d/0x70
Jul 26 19:40:47 zoo kernel: eax: 00000001   ebx: 00000000   ecx:
c04d5fa0   edx: c04e5b4c
Jul 26 19:40:47 zoo kernel: esi: dfe129e4   edi: c04e5b4c   ebp:
dfda9ee0   esp: dfda9ed0
Jul 26 19:40:47 zoo kernel: ds: 007b   es: 007b   ss: 0068
Jul 26 19:40:47 zoo kernel: Process scsi_eh_0 (pid: 14,
threadinfo=dfda8000 task=dfdf06c0)
Jul 26 19:40:47 zoo kernel: Stack: 00000032 00000000 00000000 00000000
dfda9f10 c02c4e3d dfe129e4 c02c4840
Jul 26 19:40:47 zoo kernel:        00000032 00000000 dfe129c0 c04e5aa0
00000096 00000000 c04e5b4c c04e5b5c
Jul 26 19:40:47 zoo kernel:        dfda9f20 c02c4e79 c04e5b4c 00000000
dfda9f40 c02e0833 c04e5b4c 000053b4
Jul 26 19:40:47 zoo kernel: Call Trace:
Jul 26 19:40:47 zoo kernel:  [<c02c4e3d>] do_reset1+0x1fd/0x220
Jul 26 19:40:47 zoo kernel:  [<c02c4840>] atapi_reset_pollfunc+0x0/0x130
Jul 26 19:40:47 zoo kernel:  [<c02c4e79>] ide_do_reset+0x19/0x20
Jul 26 19:40:47 zoo kernel:  [<c02e0833>] idescsi_reset+0xc3/0x100
Jul 26 19:40:47 zoo kernel:  [<c02d9cd8>]
scsi_try_bus_device_reset+0x48/0x70
Jul 26 19:40:47 zoo kernel:  [<c02d9d5e>]
scsi_eh_bus_device_reset+0x5e/0xf0
Jul 26 19:40:47 zoo kernel:  [<c02da478>] scsi_eh_ready_devs+0x28/0x70
Jul 26 19:40:47 zoo kernel:  [<c02da5df>] scsi_unjam_host+0x9f/0xb0
Jul 26 19:40:47 zoo kernel:  [<c02da6a5>] scsi_error_handler+0xb5/0xf0
Jul 26 19:40:47 zoo kernel:  [<c02da5f0>] scsi_error_handler+0x0/0xf0
Jul 26 19:40:47 zoo kernel:  [<c0107229>] kernel_thread_helper+0x5/0xc
Jul 26 19:40:47 zoo kernel:
Jul 26 19:40:47 zoo kernel: Code: 0f 0b a6 00 80 20 3c c0 eb c1 89 f6 8d
bc 27 00 00 00 00
55
Jul 26 19:41:17 zoo kernel:  hdc: ATAPI reset timed-out, status=0x88
Jul 26 19:41:47 zoo kernel: ide1: reset timed-out, status=0x88
Jul 26 19:48:54 zoo modprobe: FATAL: Module /dev/:0 not found.
Jul 26 19:48:54 zoo shutdown[918]: shutting down for system reboot


# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host
Bridge (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b198
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97
Audio Controller (rev 50)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]
(rev 74)
01:00.0 VGA compatible controller: nVidia Corporation: Unknown device
0322 (rev a1)


# lspci -v    (IDE only)
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
Subsystem: Unknown device 1695:3005
Flags: bus master, medium devsel, latency 32, IRQ 22
I/O ports at dc00 [size=16]
Capabilities: [c0] Power Management version 2


# cat /proc/ide/hdc/model
LITE-ON LTR-12101B


# cat /proc/ide/via
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.37
South Bridge:                       VIA vt8235
Revision:                           ISA 0x0 IDE 0x6
Highest DMA rate:                   UDMA133
BM-DMA base:                        0xdc00
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                 yes
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 80w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       DMA       PIO
Address Setup:      120ns     120ns     120ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:          22ns     600ns     120ns     600ns
Transfer Rate:   88.8MB/s   3.3MB/s  16.6MB/s   3.3MB/s


I can attach my kernel .config, too if neccessary.
