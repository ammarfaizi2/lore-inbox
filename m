Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbTEGVDe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 17:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTEGVDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 17:03:34 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:4232 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S264260AbTEGVDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 17:03:04 -0400
From: Nicolas <linux@1g6.biz>
To: linux-kernel@vger.kernel.org
Subject: slab oops with 2.5.69
Date: Wed, 7 May 2003 23:17:47 +0200
User-Agent: KMail/1.5
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305072317.47119.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

I don't know if it is an hardware problem,
(memory tested with memtest86)

but here continues slab oops with 2.5.69,
this one happened when using transcode.

Regards.

Nicolas.


May  7 22:48:10 hal9003 kernel: Slab corruption: start=eff68cb0, 
expend=eff68ccf, problemat=eff68cb0
May  7 22:48:10 hal9003 kernel: Last user: 
[_end+325632194/1070014108](0xd3a18226)
May  7 22:48:10 hal9003 kernel: Last user: [<d3a18226>](0xd3a18226)
May  7 22:48:10 hal9003 kernel: Data: B9 BF DD B9 C2 2F 2C 6A 81 1B AE 17 52 
8F 2D 5E ED 21 0A CC 59 30 E8 C6 93 53 CB 9A 25 C6 DE 04
May  7 22:48:10 hal9003 kernel: Next: AD 14 87 52 26 82 A1 D3 E5 04 D0 C4 6D 
64 65 31 77 EA 8C F8 89 21 A6 00 2C 0D 53 88 3E D9 56 FC
May  7 22:48:10 hal9003 kernel: slab error in check_poison_obj(): cache 
`size-32': object was modified after freeing
May  7 22:48:10 hal9003 kernel: Call Trace:
May  7 22:48:10 hal9003 kernel:  [check_poison_obj+341/405] 
check_poison_obj+0x155/0x195
May  7 22:48:10 hal9003 kernel:  [<c0137637>] check_poison_obj+0x155/0x195
May  7 22:48:10 hal9003 kernel:  [kmalloc+345/394] kmalloc+0x159/0x18a
May  7 22:48:10 hal9003 kernel:  [<c0138a46>] kmalloc+0x159/0x18a
May  7 22:48:10 hal9003 kernel:  [select_bits_alloc+30/34] 
select_bits_alloc+0x1e/0x22
May  7 22:48:10 hal9003 kernel:  [<c0159a0e>] select_bits_alloc+0x1e/0x22
May  7 22:48:10 hal9003 kdm[1197]: Server for display :0 terminated 
unexpectedly
May  7 22:48:11 hal9003 kernel:  [select_bits_alloc+30/34] 
select_bits_alloc+0x1e/0x22
May  7 22:48:11 hal9003 kernel:  [<c0159a0e>] select_bits_alloc+0x1e/0x22
May  7 22:48:11 hal9003 kernel:  [sys_select+237/1310] sys_select+0xed/0x51e
May  7 22:48:11 hal9003 kernel:  [<c0159b08>] sys_select+0xed/0x51e
May  7 22:48:11 hal9003 kernel:  [restore_i387+125/127] restore_i387+0x7d/0x7f
May  7 22:48:11 hal9003 kernel:  [<c010fa19>] restore_i387+0x7d/0x7f
May  7 22:48:11 hal9003 kernel:  [do_gettimeofday+25/144] 
do_gettimeofday+0x19/0x90
May  7 22:48:11 hal9003 kernel:  [<c010e525>] do_gettimeofday+0x19/0x90
May  7 22:48:11 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  7 22:48:11 hal9003 kernel:  [<c0108fe3>] syscall_call+0x7/0xb
May  7 22:48:11 hal9003 kernel:
May  7 22:48:11 hal9003 kernel: slab error in cache_alloc_debugcheck_after(): 
cache `size-32': memory before object was overwritten
May  7 22:48:11 hal9003 kernel: Call Trace:
May  7 22:48:11 hal9003 kernel:  [kmalloc+227/394] kmalloc+0xe3/0x18a
May  7 22:48:11 hal9003 kernel:  [<c01389d0>] kmalloc+0xe3/0x18a
May  7 22:48:11 hal9003 kernel:  [select_bits_alloc+30/34] 
select_bits_alloc+0x1e/0x22
May  7 22:48:11 hal9003 kernel:  [<c0159a0e>] select_bits_alloc+0x1e/0x22
May  7 22:48:11 hal9003 kernel:  [select_bits_alloc+30/34] 
select_bits_alloc+0x1e/0x22
May  7 22:48:11 hal9003 kernel:  [<c0159a0e>] select_bits_alloc+0x1e/0x22
May  7 22:48:11 hal9003 kernel:  [sys_select+237/1310] sys_select+0xed/0x51e
May  7 22:48:11 hal9003 kernel:  [<c0159b08>] sys_select+0xed/0x51e
May  7 22:48:11 hal9003 kernel:  [restore_i387+125/127] restore_i387+0x7d/0x7f
May  7 22:48:11 hal9003 kernel:  [<c010fa19>] restore_i387+0x7d/0x7f
May  7 22:48:11 hal9003 kernel:  [do_gettimeofday+25/144] 
do_gettimeofday+0x19/0x90
May  7 22:48:11 hal9003 kernel:  [<c010e525>] do_gettimeofday+0x19/0x90
May  7 22:48:11 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  7 22:48:11 hal9003 kernel:  [<c0108fe3>] syscall_call+0x7/0xb
May  7 22:48:11 hal9003 kernel:
May  7 22:48:11 hal9003 kernel: slab error in cache_alloc_debugcheck_after(): 
cache `size-32': memory after object was overwritten
May  7 22:48:11 hal9003 kernel: Call Trace:
May  7 22:48:11 hal9003 kernel:  [kmalloc+267/394] kmalloc+0x10b/0x18a
May  7 22:48:11 hal9003 kernel:  [<c01389f8>] kmalloc+0x10b/0x18a
May  7 22:48:11 hal9003 kernel:  [select_bits_alloc+30/34] 
select_bits_alloc+0x1e/0x22
May  7 22:48:11 hal9003 kernel:  [<c0159a0e>] select_bits_alloc+0x1e/0x22
May  7 22:48:11 hal9003 kernel:  [select_bits_alloc+30/34] 
select_bits_alloc+0x1e/0x22
May  7 22:48:11 hal9003 kernel:  [<c0159a0e>] select_bits_alloc+0x1e/0x22
May  7 22:48:11 hal9003 kernel:  [sys_select+237/1310] sys_select+0xed/0x51e
May  7 22:48:11 hal9003 kernel:  [<c0159b08>] sys_select+0xed/0x51e
May  7 22:48:11 hal9003 kernel:  [restore_i387+125/127] restore_i387+0x7d/0x7f
May  7 22:48:11 hal9003 kernel:  [<c010fa19>] restore_i387+0x7d/0x7f
May  7 22:48:11 hal9003 kernel:  [do_gettimeofday+25/144] 
do_gettimeofday+0x19/0x90
May  7 22:48:11 hal9003 kernel:  [<c010e525>] do_gettimeofday+0x19/0x90
May  7 22:48:11 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  7 22:48:11 hal9003 kernel:  [<c0108fe3>] syscall_call+0x7/0xb
May  7 22:48:11 hal9003 kernel:
May  7 22:48:11 hal9003 kernel: kfree_debugcheck: bad ptr eff68cb0h.
May  7 22:48:11 hal9003 kernel: ------------[ cut here ]------------
May  7 22:48:11 hal9003 kernel: kernel BUG at mm/slab.c:1486!
May  7 22:48:11 hal9003 kernel: invalid operand: 0000 [#3]
May  7 22:48:11 hal9003 kernel: CPU:    0
May  7 22:48:11 hal9003 kernel: EIP:    0060:[kfree+746/797]    Not tainted
May  7 22:48:11 hal9003 kernel: EIP:    0060:[<c0139017>]    Not tainted
May  7 22:48:11 hal9003 kernel: EFLAGS: 00013082
May  7 22:48:11 hal9003 kernel: EIP is at kfree+0x2ea/0x31d
May  7 22:48:11 hal9003 kernel: eax: 00000028   ebx: 0002ff68   ecx: 00000001   
edx: c02ca3f8
May  7 22:48:11 hal9003 kernel: esi: 00000000   edi: 0077e840   ebp: f6ee5f10   
esp: f6ee5ee4
May  7 22:48:11 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
May  7 22:48:11 hal9003 kernel: Process X (pid: 4964, threadinfo=f6ee4000 
task=f7944100)
May  7 22:48:11 hal9003 kernel: Stack: c029a3a0 eff68cb0 00000001 00000000 
c0159677 00000000 00000000 00003282
May  7 22:48:11 hal9003 kernel:        00000001 00000000 eff68cb0 f6ee5fbc 
c0159c36 eff68cb0 00000004 00000004
May  7 22:48:11 hal9003 kernel:        00000004 00000001 00000000 00000004 
00000000 6b6b6b6b 6b6b6b6b 00000025
May  7 22:48:11 hal9003 kernel: Call Trace:
May  7 22:48:11 hal9003 kernel:  [__pollwait+0/169] __pollwait+0x0/0xa9
May  7 22:48:11 hal9003 kernel:  [<c0159677>] __pollwait+0x0/0xa9
May  7 22:48:11 hal9003 kernel:  [sys_select+539/1310] sys_select+0x21b/0x51e
May  7 22:48:11 hal9003 kernel:  [<c0159c36>] sys_select+0x21b/0x51e
May  7 22:48:11 hal9003 kernel:  [restore_i387+125/127] restore_i387+0x7d/0x7f
May  7 22:48:11 hal9003 kernel:  [<c010fa19>] restore_i387+0x7d/0x7f
May  7 22:48:11 hal9003 kernel:  [do_gettimeofday+25/144] 
do_gettimeofday+0x19/0x90
May  7 22:48:11 hal9003 kernel:  [<c010e525>] do_gettimeofday+0x19/0x90
May  7 22:48:11 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  7 22:48:11 hal9003 kernel:  [<c0108fe3>] syscall_call+0x7/0xb
May  7 22:48:11 hal9003 kernel:
May  7 22:48:11 hal9003 kernel: Code: 0f 0b ce 05 3b 99 29 c0 8b 15 cc 0f 37 
c0 e9 4d fd ff ff 8b
May  7 22:48:11 hal9003 kernel:  mtrr: MTRR 2 not used
May  7 22:48:11 hal9003 kernel: mtrr: MTRR 2 not used
May  7 22:48:11 hal9003 kernel: mtrr: MTRR 2 not used

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0648 
(rev 03)
        Subsystem: Silicon Integrated Systems [SiS]: Unknown device 0648
        Flags: bus master, medium devsel, latency 32
        Memory at d0000000 (32-bit, non-prefetchable) [size=128M]
        Capabilities: [c0] AGP version 3.0

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SG86C202 (prog-if 00 
[Normal decode])
        Flags: bus master, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: e8500000-e85fffff
        Prefetchable memory behind bridge: d8000000-e7ffffff

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 14)
        Flags: bus master, medium devsel, latency 0

00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire 
Controller (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 701d
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at e8704000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [64] Power Management version 2

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 
[Master])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Flags: bus master, medium devsel, latency 128, IRQ 16
        I/O ports at 4000 [size=16]
        Capabilities: [58] Power Management version 2

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 
PCI Audio Accelerator (rev a0)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Flags: bus master, medium devsel, latency 32, IRQ 18
        I/O ports at b400 [size=256]
        I/O ports at b800 [size=128]
        Capabilities: [48] Power Management version 2

00:03.0 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Flags: bus master, medium devsel, latency 32, IRQ 20
        Memory at e8705000 (32-bit, non-prefetchable) [size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Flags: bus master, medium devsel, latency 32, IRQ 21
        Memory at e8707000 (32-bit, non-prefetchable) [size=4K]

00:03.2 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Flags: bus master, medium devsel, latency 32, IRQ 22
        Memory at e8700000 (32-bit, non-prefetchable) [size=4K]

00:03.3 USB Controller: Silicon Integrated Systems [SiS] SiS7002 USB 2.0 
(prog-if 20 [EHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Flags: bus master, medium devsel, latency 32, IRQ 23
        Memory at e8701000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 2

00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 
Ethernet (rev 91)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0900
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at bc00 [size=256]
        Memory at e8702000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [40] Power Management version 2

00:07.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 02)
        Subsystem: Hewlett-Packard Company NetServer 10/100TX
        Flags: bus master, medium devsel, latency 32, IRQ 18
        Memory at e8703000 (32-bit, prefetchable) [size=4K]
        I/O ports at c000 [size=32]
        Memory at e8400000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]

00:08.0 Multimedia controller: Philips Semiconductors SAA7134 (rev 01)
        Subsystem: Creatix Polymedia GmbH: Unknown device 0003
        Flags: bus master, medium devsel, latency 32, IRQ 19
        Memory at e8706000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [40] Power Management version 1

00:0a.0 Communication controller: Intel Corp. 536EP Data Fax Modem
        Subsystem: Creatix Polymedia GmbH V.9X DSP Data Fax Modem
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at e8000000 (32-bit, non-prefetchable) [size=4M]
        Capabilities: [e0] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R300 NF [Radeon 
9700] (prog-if 00 [VGA])
        Subsystem: Hightech Information System Ltd.: Unknown device 8486
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 32, IRQ 16
        Memory at d8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at 9000 [size=256]
        Memory at e8520000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
        Capabilities: [50] Power Management version 2

01:00.1 Display controller: ATI Technologies Inc Radeon R300 [Radeon 9700] 
(Secondary)
        Subsystem: Hightech Information System Ltd.: Unknown device 8487
        Flags: stepping, 66Mhz, medium devsel
        Memory at e0000000 (32-bit, prefetchable) [disabled] [size=128M]
        Memory at e8530000 (32-bit, non-prefetchable) [disabled] [size=64K]
        Capabilities: [50] Power Management version 2

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MPENTIUM4=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_IEEE1394=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m
CONFIG_NET=y
CONFIG_PACKET=m
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_ARPD=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_XFRM_USER=y
CONFIG_IPV6_SCTP__=y
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_TUN=m
CONFIG_ETHERTAP=m
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_NET_PCI=y
CONFIG_EEPRO100=m
CONFIG_E100=m
CONFIG_SIS900=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SHAPER=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=m
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_PPDEV=m
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_CHARDEV=m
CONFIG_BUSMOUSE=m
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=m
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_AGP=m
CONFIG_AGP_SIS=m
CONFIG_DRM=y
CONFIG_DRM_RADEON=m
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_PROC_FS=y
CONFIG_VIDEO_SAA5249=m
CONFIG_TUNER_3036=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_VIDEOBUF=m
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_REISERFS_FS=y
CONFIG_ROMFS_FS=m
CONFIG_QUOTA=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_CIFS=m
CONFIG_CODA_FS=m
CONFIG_INTERMEZZO_FS=m
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m
CONFIG_FB=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_RADEON=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=m
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=y
CONFIG_SND=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_INTEL8X0=m
CONFIG_SOUND_PRIME=m
CONFIG_SOUND_ICH=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
CONFIG_USB=m
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_OV511=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_EZUSB=y
CONFIG_USB_TEST=m
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_KALLSYMS=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping        : 7
cpu MHz         : 2606.950
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5144.57

