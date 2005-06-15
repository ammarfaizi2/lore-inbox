Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVFORBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVFORBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 13:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVFORBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 13:01:32 -0400
Received: from mxsf32.cluster1.charter.net ([209.225.28.156]:43744 "EHLO
	mxsf32.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261226AbVFOQ7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 12:59:43 -0400
X-IronPort-AV: i="3.93,201,1115006400"; 
   d="scan'208"; a="1009142438:sNHT27113264"
Subject: via-rhine broken in 2.6.12-rc6 and 2.6.11 stable
From: Avery Fay <avery@ravencode.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 15 Jun 2005 12:59:38 -0400
Message-Id: <1118854779.3107.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just upgraded to the latest Debian release of 2.6.11. via-rhine
breaks. I also tried 2.6.12-rc6 and it's broken too. A few notes:

1.) this is an Averatec 3225hs laptop
2.) I'm using vmware too w/vmnet module
3.) Worked on previous 2.6.11 debian releases
4.) when i bring this interface up, i'm also enabling nat

Let me know if any other info would help.

I get the following when trying to bring the interface (eth0) up:

Jun 15 12:10:10 mouse kernel: ip_tables: (C) 2000-2002 Netfilter core
team
Jun 15 12:10:10 mouse kernel: ip_conntrack version 2.1 (3839 buckets,
30712 max) - 212 bytes per conntrack
Jun 15 12:10:10 mouse kernel: eth0: link up, 100Mbps, full-duplex, lpa
0xCDE1
Jun 15 12:10:10 mouse kernel: bridge-eth0: enabling the bridge
Jun 15 12:10:10 mouse kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000069
Jun 15 12:10:10 mouse kernel:  printing eip:
Jun 15 12:10:10 mouse kernel: c029f7af
Jun 15 12:10:10 mouse kernel: *pde = 00000000
Jun 15 12:10:10 mouse kernel: Oops: 0000 [#1]
Jun 15 12:10:10 mouse kernel: PREEMPT 
Jun 15 12:10:10 mouse kernel: Modules linked in: ipt_MASQUERADE
iptable_nat ip_conntrack ip_tables via drm vmnet vmmon bc_cast bc_rijn
bc_idea bc_3des bc_bf128 bc_bf448 bc_twofish bc_gost bc_des bc_blowfish
bc snd_via82xx_modem snd_via82xx snd_ac97_codec snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart
snd_rawmidi snd ndiswrapper
Jun 15 12:10:10 mouse kernel: CPU:    0
Jun 15 12:10:10 mouse kernel: EIP:    0060:[sk_alloc+15/224]    Tainted:
PF     VLI
Jun 15 12:10:10 mouse kernel: EFLAGS: 00210286   (2.6.12-rc6-acf1) 
Jun 15 12:10:10 mouse kernel: EIP is at sk_alloc+0xf/0xe0
Jun 15 12:10:10 mouse kernel: eax: 0000000e   ebx: d181a000   ecx:
0000000b   edx: 00000020
Jun 15 12:10:10 mouse kernel: esi: 00000001   edi: dd3bd60c   ebp:
00000000   esp: d181be00
Jun 15 12:10:10 mouse kernel: ds: 007b   es: 007b   ss: 0068
Jun 15 12:10:10 mouse kernel: Process ifconfig (pid: 3011,
threadinfo=d181a000 task=d2f35aa0)
Jun 15 12:10:10 mouse kernel: Stack: 00002000 ddeb2800 d181a000 dd3bd600
dd3bd60c 00000000 df06fc04 00000010 
Jun 15 12:10:10 mouse kernel:        00000020 00000001 00000000 dd3bd600
ddeb2805 dd3bd611 dd3bd60c df06fdf2 
Jun 15 12:10:10 mouse kernel:        dd3bd600 dd3bd60c ddeb2800 00000001
dd3bd600 ddeb2800 00000001 00000000 
Jun 15 12:10:10 mouse kernel: Call Trace:
Jun 15 12:10:10 mouse kernel:  [pg0+516279300/1069462528] VNetBridgeUp
+0xe4/0x1e0 [vmnet]
Jun 15 12:10:10 mouse kernel:  [pg0+516279794/1069462528]
VNetBridgeNotify+0x82/0x170 [vmnet]
Jun 15 12:10:10 mouse kernel:  [notifier_call_chain+45/80]
notifier_call_chain+0x2d/0x50
Jun 15 12:10:10 mouse kernel:  [dev_open+111/144] dev_open+0x6f/0x90
Jun 15 12:10:10 mouse kernel:  [dev_change_flags+81/288]
dev_change_flags+0x51/0x120
Jun 15 12:10:10 mouse kernel:  [dev_load+37/112] dev_load+0x25/0x70
Jun 15 12:10:10 mouse kernel:  [devinet_ioctl+566/1408] devinet_ioctl
+0x236/0x580
Jun 15 12:10:10 mouse kernel:  [inet_ioctl+94/160] inet_ioctl+0x5e/0xa0
Jun 15 12:10:10 mouse kernel:  [sock_ioctl+217/560] sock_ioctl
+0xd9/0x230
Jun 15 12:10:10 mouse kernel:  [do_ioctl+134/160] do_ioctl+0x86/0xa0
Jun 15 12:10:10 mouse kernel:  [sys_socket+61/96] sys_socket+0x3d/0x60
Jun 15 12:10:10 mouse kernel:  [vfs_ioctl+101/464] vfs_ioctl+0x65/0x1d0
Jun 15 12:10:10 mouse kernel:  [sys_ioctl+69/128] sys_ioctl+0x45/0x80
Jun 15 12:10:10 mouse kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun 15 12:10:10 mouse kernel: Code: e8 0b e9 74 fd ff ff 0f b6 41 02 3c
0a 0f 94 c0 e9 00 fe ff ff 8d b4 26 00 00 00 00 55 57 56 53 83 ec 08 8b
74 24 24 8b 54 24 20 <8b> 46 68 85 c0 0f 84 a3 00 00 00 89 54 24 04 89
04 24 e8 ca 0c 
Jun 15 12:10:10 mouse kernel:  <6>note: ifconfig[3011] exited with
preempt_count 1
Jun 15 12:10:10 mouse kernel: scheduling while atomic:
ifconfig/0x10000001/3011
Jun 15 12:10:10 mouse kernel:  [schedule+1495/1504] schedule+0x5d7/0x5e0
Jun 15 12:10:10 mouse kernel:  [call_console_drivers+101/288]
call_console_drivers+0x65/0x120
Jun 15 12:10:10 mouse kernel:  [unmap_page_range+138/176]
unmap_page_range+0x8a/0xb0
Jun 15 12:10:10 mouse kernel:  [cond_resched+41/64] cond_resched
+0x29/0x40
Jun 15 12:10:10 mouse kernel:  [unmap_vmas+411/496] unmap_vmas
+0x19b/0x1f0
Jun 15 12:10:10 mouse kernel:  [exit_mmap+132/352] exit_mmap+0x84/0x160
Jun 15 12:10:10 mouse kernel:  [do_page_fault+0/1433] do_page_fault
+0x0/0x599
Jun 15 12:10:10 mouse kernel:  [mmput+55/160] mmput+0x37/0xa0
Jun 15 12:10:10 mouse kernel:  [do_exit+192/944] do_exit+0xc0/0x3b0
Jun 15 12:10:10 mouse kernel:  [do_page_fault+0/1433] do_page_fault
+0x0/0x599
Jun 15 12:10:10 mouse kernel:  [die+381/384] die+0x17d/0x180
Jun 15 12:10:10 mouse kernel:  [do_page_fault+0/1433] do_page_fault
+0x0/0x599
Jun 15 12:10:10 mouse kernel:  [printk+23/32] printk+0x17/0x20
Jun 15 12:10:10 mouse kernel:  [do_page_fault+701/1433] do_page_fault
+0x2bd/0x599
Jun 15 12:10:10 mouse kernel:  [recalc_task_prio+136/320]
recalc_task_prio+0x88/0x140
Jun 15 12:10:10 mouse kernel:  [preempt_schedule+74/112]
preempt_schedule+0x4a/0x70
Jun 15 12:10:10 mouse kernel:  [release_console_sem+210/224]
release_console_sem+0xd2/0xe0
Jun 15 12:10:10 mouse kernel:  [do_page_fault+0/1433] do_page_fault
+0x0/0x599
Jun 15 12:10:10 mouse kernel:  [error_code+79/84] error_code+0x4f/0x54
Jun 15 12:10:10 mouse kernel:  [sk_alloc+15/224] sk_alloc+0xf/0xe0
Jun 15 12:10:10 mouse kernel:  [pg0+516279300/1069462528] VNetBridgeUp
+0xe4/0x1e0 [vmnet]
Jun 15 12:10:10 mouse kernel:  [pg0+516279794/1069462528]
VNetBridgeNotify+0x82/0x170 [vmnet]
Jun 15 12:10:10 mouse kernel:  [notifier_call_chain+45/80]
notifier_call_chain+0x2d/0x50
Jun 15 12:10:10 mouse kernel:  [dev_open+111/144] dev_open+0x6f/0x90
Jun 15 12:10:10 mouse kernel:  [dev_change_flags+81/288]
dev_change_flags+0x51/0x120
Jun 15 12:10:10 mouse kernel:  [dev_load+37/112] dev_load+0x25/0x70
Jun 15 12:10:10 mouse kernel:  [devinet_ioctl+566/1408] devinet_ioctl
+0x236/0x580
Jun 15 12:10:10 mouse kernel:  [inet_ioctl+94/160] inet_ioctl+0x5e/0xa0
Jun 15 12:10:10 mouse kernel:  [sock_ioctl+217/560] sock_ioctl
+0xd9/0x230
Jun 15 12:10:10 mouse kernel:  [do_ioctl+134/160] do_ioctl+0x86/0xa0
Jun 15 12:10:10 mouse kernel:  [sys_socket+61/96] sys_socket+0x3d/0x60
Jun 15 12:10:10 mouse kernel:  [vfs_ioctl+101/464] vfs_ioctl+0x65/0x1d0
Jun 15 12:10:10 mouse kernel:  [sys_ioctl+69/128] sys_ioctl+0x45/0x80
Jun 15 12:10:10 mouse kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

lspci -vvv:

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8378 [KM400] Chipset
Host Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dde00000-dfefffff
	Prefetchable memory behind bridge: d5d00000-ddcfffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:00:09.0 Network controller: Broadcom Corporation BCM4306 802.11b/g
Wireless LAN Controller (rev 03)
	Subsystem: Broadcom Corporation: Unknown device 0418
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at dfffe000 (32-bit, non-prefetchable) [size=8K]

0000:00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
(rev 20)
	Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device c602
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 1e000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 1e400000-1e7ff000 (prefetchable)
	Memory window 1: 1e800000-1ebff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device c905
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 7
	Region 4: I/O ports at e400 [size=32]
	Capabilities: <available only to root>

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device c905
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 7
	Region 4: I/O ports at e800 [size=32]
	Capabilities: <available only to root>

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device c905
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin C routed to IRQ 7
	Region 4: I/O ports at ec00 [size=32]
	Capabilities: <available only to root>

0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
(prog-if 20 [EHCI])
	Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device c905
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin D routed to IRQ 7
	Region 0: Memory at dfffdf00 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <available only to root>

0000:00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
	Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device 1205
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 255
	Region 4: I/O ports at fc00 [size=16]
	Capabilities: <available only to root>

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
	Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device 0408
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at dc00 [size=256]
	Capabilities: <available only to root>

0000:00:11.6 Communication controller: VIA Technologies, Inc. Intel 537
[AC97 Modem] (rev 80)
	Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device 1005
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at e000 [size=256]
	Capabilities: <available only to root>

0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102
[Rhine-II] (rev 74)
	Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device 0207
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d800 [size=256]
	Region 1: Memory at dfffde00 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:01:00.0 VGA compatible controller: VIA Technologies, Inc. VT8378
[S3 UniChrome] Integrated Video (rev 01) (prog-if 00 [VGA])
	Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device 030d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
	Expansion ROM at dfef0000 [disabled] [size=64K]
	Capabilities: <available only to root>

-- 
Avery Fay <avery@ravencode.com>
