Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265173AbUELT33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265173AbUELT33 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 15:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbUELT3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 15:29:02 -0400
Received: from netsonic.fi ([194.29.192.20]:35251 "EHLO nalle.netsonic.fi")
	by vger.kernel.org with ESMTP id S265173AbUELTXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 15:23:16 -0400
Date: Wed, 12 May 2004 22:22:32 +0300 (EEST)
From: Sampsa Ranta <sampsa@netsonic.fi>
To: linux-kernel@vger.kernel.org
Subject: Kernel hung on Geode(TM)
Message-ID: <Pine.LNX.4.44.0405122200460.11014-100000@nalle.netsonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am running RedHat kernel 2.4.20-31.9 on Geode 300Mhz processor with 128M 
memory, no swap. The system boots itself from flash, root and most of 
the stuff are on flash, test system files are over NFS.

I get the kernel to hang it self with no Oops, system no longer seems to
respond anything except sysrq.

I can reproduce the problem, it occurs around 15-17 hours uptime while the 
system is running Cerberus Test Control with memory test by calculating 
prime numbers, continous MD5  checksumming of the flash, the network 
traffic is very light.

CPU temperature is also observed during the tests but it doesn't peak.

Boot time information, PCI bus configuration and SysRq: Show State 
included below.

Could somebody give me a hint on this one?

Thanks,
 Sampsa Ranta

--- Boot time information:

Linux version 2.4.20-31.9 (bhcompile@porky.devel.redhat.com) (gcc version 3.2.2 
20030222 (Red Hat Linux 3.2.2-5)) #1 Tue Apr 13 17:41:45 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007e80000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
126MB LOWMEM available.
On node 0 totalpages: 32384
zone(0): 4096 pages.
zone(1): 28288 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=2.4.20-31.9 ro BOOT_FILE=/boot/vmlinuz-2.4.20-31.9 root=LABEL=flash console=ttyS0,38400
Initializing CPU#0
Working around Cyrix MediaGX virtual DMA bugs.
Detected 300.684 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 599.65 BogoMIPS
Memory: 123524k/129536k available (1215k kernel code, 4616k reserved, 1010k data, 112k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... 
Ok.
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Working around Cyrix MediaGX virtual DMA bugs.
CPU: Cyrix Geode(TM) Integrated Processor by National Semi stepping 02
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
PCI: PCI BIOS revision 2.10 entry at 0xfae70, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router NatSemi [1078/0100] at 00:12.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Detected PS/2 Mouse Port.
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT 
SHARE_IRQ SER
IAL_PCI ISAPNP enabled
ttyS0 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
CS5530: IDE controller at PCI slot 00:12.2
CS5530: chipset revision 0
CS5530: not 100% native mode: will probe irqs later
PCI: 00:12.0 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:12.0 PCI cache line size corrected to 16.
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: Hitachi XXM2.3.0, CFA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

--- PCI bus configuration:
# cat /proc/pci 
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Cyrix Corporation PCI Master (rev 0).
  Bus  0, device  14, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 16).
      IRQ 12.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xe000 [0xe0ff].
      Non-prefetchable 32 bit memory at 0xd0000000 [0xd00000ff].
  Bus  0, device  15, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (#2) (rev 16).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xe400 [0xe4ff].
      Non-prefetchable 32 bit memory at 0xd0001000 [0xd00010ff].
  Bus  0, device  16, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (#3) (rev 16).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xe800 [0xe8ff].
      Non-prefetchable 32 bit memory at 0xd0002000 [0xd00020ff].
  Bus  0, device  18, function  0:
    ISA bridge: Cyrix Corporation 5530 Legacy [Kahlua] (rev 48).
      Master Capable.  Latency=64.  
  Bus  0, device  18, function  1:
    Bridge: Cyrix Corporation 5530 SMI [Kahlua] (rev 0).
      Non-prefetchable 32 bit memory at 0x40012000 [0x400120ff].
  Bus  0, device  18, function  2:
    IDE interface: Cyrix Corporation 5530 IDE [Kahlua] (rev 0).
      I/O at 0xf000 [0xf00f].
  Bus  0, device  18, function  3:
    Multimedia audio controller: Cyrix Corporation 5530 Audio [Kahlua] (rev 0).
      Non-prefetchable 32 bit memory at 0x40011000 [0x4001107f].
  Bus  0, device  18, function  4:
    VGA compatible controller: Cyrix Corporation 5530 Video [Kahlua] (rev 0).
      Non-prefetchable 32 bit memory at 0x40800000 [0x40ffffff].


-- System request / Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init          R 0000007D  3296     1      0     2               (NOTLB)
Call Trace:   [<c01169b7>] sys_sched_yield [kernel] 0x73 (0xc1435e14))
[<c013669a>] __alloc_pages [kernel] 0x106 (0xc1435e28))
[<c012c35c>] page_cache_read [kernel] 0x7c (0xc1435e5c))
[<c012c3e1>] read_cluster_nonblocking [kernel] 0x39 (0xc1435e74))
[<c012dba9>] filemap_nopage [kernel] 0x101 (0xc1435e88))
[<c0129be5>] do_no_page [kernel] 0x71 (0xc1435eac))
[<c0129e13>] handle_mm_fault [kernel] 0x6f (0xc1435edc))
[<c01148a8>] do_page_fault [kernel] 0x140 (0xc1435f08))
[<c014334a>] sys_stat64 [kernel] 0x26 (0xc1435f70))
[<c0114768>] do_page_fault [kernel] 0x0 (0xc1435fb0))
[<c0108e6c>] error_code [kernel] 0x34 (0xc1435fb8))

keventd       S C02EDCB8  5424     2      1             3       (L-TLB)
Call Trace:   [<c012651c>] context_thread [kernel] 0x0 (0xc1433f9c))
[<c01265ed>] context_thread [kernel] 0xd1 (0xc1433fac))
[<c012651c>] context_thread [kernel] 0x0 (0xc1433fc4))
[<c012651c>] context_thread [kernel] 0x0 (0xc1433fe0))
[<c0106fc1>] kernel_thread_helper [kernel] 0x5 (0xc1433ff0))

kapmd         S C03569F4  5392     3      1             4     2 (L-TLB)
Call Trace:   [<c0121592>] schedule_timeout [kernel] 0x52 (0xc1431f7c))
[<c0121534>] process_timeout [kernel] 0x0 (0xc1431f94))
[<c0113861>] check_events [kernel] 0x9 (0xc1431fa0))
[<c0113aca>] apm_mainloop [kernel] 0x6e (0xc1431fac))
[<c01140f0>] apm [kernel] 0x0 (0xc1431fd0))
[<c01141cf>] apm [kernel] 0xdf (0xc1431fd8))
[<c0106fc1>] kernel_thread_helper [kernel] 0x5 (0xc1431ff0))

ksoftirqd_CPU S 00000000  5824     4      1             9     3 (L-TLB)
Call Trace:   [<c011ddc2>] ksoftirqd [kernel] 0x6a (0xc151ffe0))
[<c011dd58>] ksoftirqd [kernel] 0x0 (0xc151ffe4))
[<c0106fc1>] kernel_thread_helper [kernel] 0x5 (0xc151fff0))

bdflush       S C02EF224  6388     9      1             5     4 (L-TLB)
Call Trace:   [<c011626a>] interruptible_sleep_on [kernel] 0x36 
(0xc11bdfc4))
[<c014098d>] bdflush [kernel] 0xf5 (0xc11bdfe0))
[<c0140898>] bdflush [kernel] 0x0 (0xc11bdfe4))
[<c0106fc1>] kernel_thread_helper [kernel] 0x5 (0xc11bdff0))

kswapd        R current   5212     5      1             6     9 (L-TLB)
Call Trace:   [<c0134b3e>] rebalance_inactive_zone [kernel] 0x96 
(0xc151df64))
[<c0134b83>] rebalance_inactive [kernel] 0x37 (0xc151df84))
[<c0134c66>] do_try_to_free_pages_kswapd [kernel] 0x2e (0xc151dfa8))
[<c0134ed2>] kswapd [kernel] 0x72 (0xc151dfdc))
[<c0134e60>] kswapd [kernel] 0x0 (0xc151dfe4))
[<c0106fc1>] kernel_thread_helper [kernel] 0x5 (0xc151dff0))

kscand/DMA    S C03568B4  5532     6      1             7     5 (L-TLB)
Call Trace:   [<c0121592>] schedule_timeout [kernel] 0x52 (0xc151bfa8))
[<c0121534>] process_timeout [kernel] 0x0 (0xc151bfc0))
[<c0135381>] kscand [kernel] 0x95 (0xc151bfcc))
[<c013534b>] kscand [kernel] 0x5f (0xc151bfd8))
[<c01352ec>] kscand [kernel] 0x0 (0xc151bfe0))
[<c0106fc1>] kernel_thread_helper [kernel] 0x5 (0xc151bff0))

kscand/Normal S C0356B14  5508     7      1             8     6 (L-TLB)
Call Trace:   [<c0121592>] schedule_timeout [kernel] 0x52 (0xc1519fa8))
[<c0121534>] process_timeout [kernel] 0x0 (0xc1519fc0))
[<c01353b5>] kscand [kernel] 0xc9 (0xc1519fcc))
[<c013534b>] kscand [kernel] 0x5f (0xc1519fd8))
[<c01352ec>] kscand [kernel] 0x0 (0xc1519fe0))
[<c0106fc1>] kernel_thread_helper [kernel] 0x5 (0xc1519ff0))

kscand/HighMe S C035626C  5828     8      1            10     7 (L-TLB)
Call Trace:   [<c0121592>] schedule_timeout [kernel] 0x52 (0xc11bffa8))
[<c0121534>] process_timeout [kernel] 0x0 (0xc11bffc0))
[<c0130068>] mlock_fixup_middle [kernel] 0x1c (0xc11bffc4))
[<c0130068>] mlock_fixup_middle [kernel] 0x1c (0xc11bffc8))
[<c013534b>] kscand [kernel] 0x5f (0xc11bffd8))
[<c01352ec>] kscand [kernel] 0x0 (0xc11bffe0))
[<c0106fc1>] kernel_thread_helper [kernel] 0x5 (0xc11bfff0))

kupdated      S C7844098  4716    10      1            11     8 (L-TLB)
Call Trace:   [<c0121592>] schedule_timeout [kernel] 0x52 (0xc11bbfb0))
[<c0121534>] process_timeout [kernel] 0x0 (0xc11bbfc8))
[<c014075a>] sync_old_buffers [kernel] 0xe (0xc11bbfd4))
[<c0140a30>] kupdate [kernel] 0x60 (0xc11bbfe0))
[<c01409d0>] kupdate [kernel] 0x0 (0xc11bbfe4))
[<c0106fc1>] kernel_thread_helper [kernel] 0x5 (0xc11bbff0))

mdrecoveryd   S 00000000  6344    11      1            63    10 (L-TLB)
Call Trace:   [<c01ca791>] md_thread [kernel] 0x12d (0xc11b3fbc))
[<c01ca664>] md_thread [kernel] 0x0 (0xc11b3fe0))
[<c0106fc1>] kernel_thread_helper [kernel] 0x5 (0xc11b3ff0))

khubd         S 00000000  6352    63      1           239    11 (L-TLB)
Call Trace:   [<c88117ce>] usb_hub_thread [usbcore] 0x86 (0xc15b1fc4))
[<c881e140>] khubd_wait [usbcore] 0x0 (0xc15b1fd8))
[<c881e140>] khubd_wait [usbcore] 0x0 (0xc15b1fdc))
[<c8811748>] usb_hub_thread [usbcore] 0x0 (0xc15b1fe0))
[<c0106fc1>] kernel_thread_helper [kernel] 0x5 (0xc15b1ff0))

eth0          S C032824C  5104   239      1           331    63 (L-TLB)
Call Trace:   [<c0121592>] schedule_timeout [kernel] 0x52 (0xc7847f8c))
[<c0121534>] process_timeout [kernel] 0x0 (0xc7847fa4))
[<c01162c7>] interruptible_sleep_on_timeout [kernel] 0x3b (0xc7847fbc))
[<c8830eb5>] rtl8139_thread [8139too] 0x71 (0xc7847fdc))
[<c8830e44>] rtl8139_thread [8139too] 0x0 (0xc7847fe0))
[<c0106fc1>] kernel_thread_helper [kernel] 0x5 (0xc7847ff0))

eth1          S C03562C4     0   331      1           336   239 (L-TLB)
Call Trace:   [<c0121592>] schedule_timeout [kernel] 0x52 (0xc7e37f8c))
[<c0121534>] process_timeout [kernel] 0x0 (0xc7e37fa4))
[<c01162c7>] interruptible_sleep_on_timeout [kernel] 0x3b (0xc7e37fbc))
[<c8830eb5>] rtl8139_thread [8139too] 0x71 (0xc7e37fdc))
[<c8830e44>] rtl8139_thread [8139too] 0x0 (0xc7e37fe0))
[<c0106fc1>] kernel_thread_helper [kernel] 0x5 (0xc7e37ff0))

eth2          S C03562CC     0   336      1           403   331 (L-TLB)
Call Trace:   [<c0121592>] schedule_timeout [kernel] 0x52 (0xc7e39f8c))
[<c0121534>] process_timeout [kernel] 0x0 (0xc7e39fa4))
[<c01162c7>] interruptible_sleep_on_timeout [kernel] 0x3b (0xc7e39fbc))
[<c8830eb5>] rtl8139_thread [8139too] 0x71 (0xc7e39fdc))
[<c8830e44>] rtl8139_thread [8139too] 0x0 (0xc7e39fe0))
[<c0106fc1>] kernel_thread_helper [kernel] 0x5 (0xc7e39ff0))

rpciod        S 00000000     0   403      1           404   336 (L-TLB)
Call Trace:   [<c884069e>] rpciod [sunrpc] 0x1a6 (0xc7d29fcc))
[<c884ce18>] rpciod_idle [sunrpc] 0x0 (0xc7d29fd8))
[<c884ce18>] rpciod_idle [sunrpc] 0x0 (0xc7d29fdc))
[<c88404f8>] rpciod [sunrpc] 0x0 (0xc7d29fe0))
[<c0106fc1>] kernel_thread_helper [kernel] 0x5 (0xc7d29ff0))
[<c884ce20>] rpciod_killer [sunrpc] 0x0 (0xc7d29ff4))

lockd         S 7FFFFFFF     0   404      1           524   403 (L-TLB)
Call Trace:   [<c01215dd>] schedule_timeout [kernel] 0x9d (0xc787df5c))
[<c88437b5>] svc_recv_R4c8a0558 [sunrpc] 0x359 (0xc787df88))
[<c013c3f7>] filp_close [kernel] 0x37 (0xc787df8c))
[<c8851d23>] lockd [lockd] 0x10b (0xc787dfcc))
[<c8851c18>] lockd [lockd] 0x0 (0xc787dfe0))
[<c0106fc1>] kernel_thread_helper [kernel] 0x5 (0xc787dff0))

login         S 00000000  4664   524      1   530     525   404 (NOTLB)
Call Trace:   [<c011c60a>] sys_wait4 [kernel] 0x192 (0xc7bbbf84))
[<c0108d7b>] system_call [kernel] 0x33 (0xc7bbbfc0))

mingetty      S 7FFFFFFF     0   525      1           526   524 (NOTLB)
Call Trace:   [<c01215dd>] schedule_timeout [kernel] 0x9d (0xc77bff00))
[<c01739d6>] write_chan [kernel] 0x156 (0xc77bff10))
[<c0173484>] read_chan [kernel] 0x260 (0xc77bff2c))
[<c016fe19>] tty_read [kernel] 0xa9 (0xc77bff7c))
[<c013cc30>] sys_read [kernel] 0x84 (0xc77bff9c))
[<c0108d7b>] system_call [kernel] 0x33 (0xc77bffc0))

mingetty      S 7FFFFFFF     0   526      1           527   525 (NOTLB)
Call Trace:   [<c01215dd>] schedule_timeout [kernel] 0x9d (0xc7813f00))
[<c01739d6>] write_chan [kernel] 0x156 (0xc7813f10))
[<c0173484>] read_chan [kernel] 0x260 (0xc7813f2c))
[<c016fe19>] tty_read [kernel] 0xa9 (0xc7813f7c))
[<c013cc30>] sys_read [kernel] 0x84 (0xc7813f9c))
[<c0108d7b>] system_call [kernel] 0x33 (0xc7813fc0))

mingetty      S 7FFFFFFF     0   527      1           528   526 (NOTLB)
Call Trace:   [<c01215dd>] schedule_timeout [kernel] 0x9d (0xc7bb3f00))
[<c01739d6>] write_chan [kernel] 0x156 (0xc7bb3f10))
[<c0173484>] read_chan [kernel] 0x260 (0xc7bb3f2c))
[<c016fe19>] tty_read [kernel] 0xa9 (0xc7bb3f7c))
[<c013cc30>] sys_read [kernel] 0x84 (0xc7bb3f9c))
[<c0108d7b>] system_call [kernel] 0x33 (0xc7bb3fc0))

mingetty      S 7FFFFFFF    16   528      1           529   527 (NOTLB)
Call Trace:   [<c01215dd>] schedule_timeout [kernel] 0x9d (0xc7719f00))
[<c01739d6>] write_chan [kernel] 0x156 (0xc7719f10))
[<c0173484>] read_chan [kernel] 0x260 (0xc7719f2c))
[<c016fe19>] tty_read [kernel] 0xa9 (0xc7719f7c))
[<c013cc30>] sys_read [kernel] 0x84 (0xc7719f9c))
[<c0108d7b>] system_call [kernel] 0x33 (0xc7719fc0))

mingetty      S 7FFFFFFF     0   529      1           585   528 (NOTLB)
Call Trace:   [<c01215dd>] schedule_timeout [kernel] 0x9d (0xc7e5df00))
[<c01739d6>] write_chan [kernel] 0x156 (0xc7e5df10))
[<c0173484>] read_chan [kernel] 0x260 (0xc7e5df2c))
[<c016fe19>] tty_read [kernel] 0xa9 (0xc7e5df7c))
[<c013cc30>] sys_read [kernel] 0x84 (0xc7e5df9c))
[<c0108d7b>] system_call [kernel] 0x33 (0xc7e5dfc0))

bash          R 00000074  4752   530    524                     (NOTLB)
Call Trace:   [<c01169b7>] sys_sched_yield [kernel] 0x73 (0xc7ac7e14))
[<c013669a>] __alloc_pages [kernel] 0x106 (0xc7ac7e28))
[<c012c35c>] page_cache_read [kernel] 0x7c (0xc7ac7e5c))
[<c012c3e1>] read_cluster_nonblocking [kernel] 0x39 (0xc7ac7e74))
[<c012dba9>] filemap_nopage [kernel] 0x101 (0xc7ac7e88))
[<c0129be5>] do_no_page [kernel] 0x71 (0xc7ac7eac))
[<c0129e13>] handle_mm_fault [kernel] 0x6f (0xc7ac7edc))
[<c01148a8>] do_page_fault [kernel] 0x140 (0xc7ac7f08))
[<c01734c3>] read_chan [kernel] 0x29f (0xc7ac7f2c))
[<c016fe19>] tty_read [kernel] 0xa9 (0xc7ac7f7c))
[<c0114768>] do_page_fault [kernel] 0x0 (0xc7ac7fb0))
[<c0108e6c>] error_code [kernel] 0x34 (0xc7ac7fb8))

sshd          S 7FFFFFFF     0   585      1   590           529 (NOTLB)
Call Trace:   [<c01215dd>] schedule_timeout [kernel] 0x9d (0xc7773ef8))
[<c01d8c3b>] sock_poll [kernel] 0x1b (0xc7773f0c))
[<c014a8e0>] do_select [kernel] 0xe4 (0xc7773f24))
[<c014adb0>] sys_select [kernel] 0x3a0 (0xc7773f5c))
[<c0108d7b>] system_call [kernel] 0x33 (0xc7773fc0))

sshd          S 7FFFFFFF  4972   590    585   592               (NOTLB)
Call Trace:   [<c01215dd>] schedule_timeout [kernel] 0x9d (0xc7923ef8))
[<c0170df4>] tty_poll [kernel] 0x60 (0xc7923f04))
[<c014a8e0>] do_select [kernel] 0xe4 (0xc7923f24))
[<c014adb0>] sys_select [kernel] 0x3a0 (0xc7923f5c))
[<c0109e5f>] do_IRQ [kernel] 0x8b (0xc7923fa8))
[<c0108d7b>] system_call [kernel] 0x33 (0xc7923fc0))

bash          S 00000000    16   592    590   630               (NOTLB)
Call Trace:   [<c011c60a>] sys_wait4 [kernel] 0x192 (0xc15adf84))
[<c0108d7b>] system_call [kernel] 0x33 (0xc15adfc0))

sohoprime     S 00000000     0   630    592   641               (NOTLB)
Call Trace:   [<c011c60a>] sys_wait4 [kernel] 0x192 (0xc7335f84))
[<c0108d7b>] system_call [kernel] 0x33 (0xc7335fc0))

run           R 00000073   500   641    630   675               (NOTLB)
Call Trace:   [<c01169b7>] sys_sched_yield [kernel] 0x73 (0xc73ade14))
[<c013669a>] __alloc_pages [kernel] 0x106 (0xc73ade28))
[<c012c35c>] page_cache_read [kernel] 0x7c (0xc73ade5c))
[<c012c3e1>] read_cluster_nonblocking [kernel] 0x39 (0xc73ade74))
[<c012dba9>] filemap_nopage [kernel] 0x101 (0xc73ade88))
[<c0129be5>] do_no_page [kernel] 0x71 (0xc73adeac))
[<c0129e13>] handle_mm_fault [kernel] 0x6f (0xc73adedc))
[<c01148a8>] do_page_fault [kernel] 0x140 (0xc73adf08))
[<c0120e28>] add_timer [kernel] 0x14 (0xc73adf1c))
[<c01a5d45>] ide_set_handler [kernel] 0x19 (0xc73adf28))
[<c01adbe5>] read_intr [kernel] 0x69 (0xc73adf40))
[<c01adb7c>] read_intr [kernel] 0x0 (0xc73adf48))
[<c01ad632>] ide_intr [kernel] 0x9a (0xc73adf64))
[<c01adb7c>] read_intr [kernel] 0x0 (0xc73adf6c))
[<c0109ce8>] handle_IRQ_event [kernel] 0x34 (0xc73adf80))
[<c0109e40>] do_IRQ [kernel] 0x6c (0xc73adfa0))
[<c0114768>] do_page_fault [kernel] 0x0 (0xc73adfb0))
[<c0108e6c>] error_code [kernel] 0x34 (0xc73adfb8))

runtest       T C691A000  4580   675    641   780     680       (NOTLB)
Call Trace:   [<c0122b43>] finish_stop [kernel] 0x2f (0xc691bf08))
[<c0122ea5>] get_signal_to_deliver [kernel] 0x211 (0xc691bf0c))
[<c0108b6f>] do_signal [kernel] 0x33 (0xc691bf28))
[<c0115ef9>] schedule [kernel] 0x169 (0xc691bf60))
[<c011c62b>] sys_wait4 [kernel] 0x1b3 (0xc691bf84))
[<c0108db4>] signal_return [kernel] 0x14 (0xc691bfc0))

runtest       S 00000000     0   680    641 30214     685   675 (NOTLB)
Call Trace:   [<c011c60a>] sys_wait4 [kernel] 0x192 (0xc6907f84))
[<c0108d7b>] system_call [kernel] 0x33 (0xc6907fc0))

runtest       S 00000000  3104   685    641   751     696   680 (NOTLB)
Call Trace:   [<c011c60a>] sys_wait4 [kernel] 0x192 (0xc68f9f84))
[<c0108d7b>] system_call [kernel] 0x33 (0xc68f9fc0))

runtest       S 00000000  2384   696    641 30157     707   685 (NOTLB)
Call Trace:   [<c011c60a>] sys_wait4 [kernel] 0x192 (0xc694ff84))
[<c0108d7b>] system_call [kernel] 0x33 (0xc694ffc0))

runtest       S 00000000     0   707    641 30336     726   696 (NOTLB)
Call Trace:   [<c011c60a>] sys_wait4 [kernel] 0x192 (0xc6949f84))
[<c0108d7b>] system_call [kernel] 0x33 (0xc6949fc0))

runtest       S 00000000     0   726    641 30232     738   707 (NOTLB)
Call Trace:   [<c011c60a>] sys_wait4 [kernel] 0x192 (0xc158bf84))
[<c0108d7b>] system_call [kernel] 0x33 (0xc158bfc0))

runtest       S 00000000     0   738    641   809     759   726 (NOTLB)
Call Trace:   [<c011c60a>] sys_wait4 [kernel] 0x192 (0xc6d47f84))
[<c0108d7b>] system_call [kernel] 0x33 (0xc6d47fc0))

mprime        R 0000008B     0   751    685                     (NOTLB)
Call Trace:   [<c01169b7>] sys_sched_yield [kernel] 0x73 (0xc7033e14))
[<c013669a>] __alloc_pages [kernel] 0x106 (0xc7033e28))
[<c012c35c>] page_cache_read [kernel] 0x7c (0xc7033e5c))
[<c012c3e1>] read_cluster_nonblocking [kernel] 0x39 (0xc7033e74))
[<c012dba9>] filemap_nopage [kernel] 0x101 (0xc7033e88))
[<c0129be5>] do_no_page [kernel] 0x71 (0xc7033eac))
[<c0129e13>] handle_mm_fault [kernel] 0x6f (0xc7033edc))
[<c01148a8>] do_page_fault [kernel] 0x140 (0xc7033f08))
[<c0120e28>] add_timer [kernel] 0x14 (0xc7033f1c))
[<c01a5d45>] ide_set_handler [kernel] 0x19 (0xc7033f28))
[<c01adbe5>] read_intr [kernel] 0x69 (0xc7033f40))
[<c01adb7c>] read_intr [kernel] 0x0 (0xc7033f48))
[<c01ad632>] ide_intr [kernel] 0x9a (0xc7033f64))
[<c01adb7c>] read_intr [kernel] 0x0 (0xc7033f6c))
[<c0109ce8>] handle_IRQ_event [kernel] 0x34 (0xc7033f80))
[<c0115ef9>] schedule [kernel] 0x169 (0xc7033f9c))
[<c0114768>] do_page_fault [kernel] 0x0 (0xc7033fb0))
[<c0108e6c>] error_code [kernel] 0x34 (0xc7033fb8))

runtest       S 00000000     0   759    641   859     786   738 (NOTLB)
Call Trace:   [<c011c60a>] sys_wait4 [kernel] 0x192 (0xc6ed5f84))
[<c0108d7b>] system_call [kernel] 0x33 (0xc6ed5fc0))

dmesg         T C70FC000     0   780    675   942               (NOTLB)
Call Trace:   [<c0122b43>] finish_stop [kernel] 0x2f (0xc70fdf08))
[<c0122ea5>] get_signal_to_deliver [kernel] 0x211 (0xc70fdf0c))
[<c0108b6f>] do_signal [kernel] 0x33 (0xc70fdf28))
[<c0115ef9>] schedule [kernel] 0x169 (0xc70fdf60))
[<c011c62b>] sys_wait4 [kernel] 0x1b3 (0xc70fdf84))
[<c0108db4>] signal_return [kernel] 0x14 (0xc70fdfc0))

runtest       S 00000000     0   786    641 30287     814   759 (NOTLB)
Call Trace:   [<c011c60a>] sys_wait4 [kernel] 0x192 (0xc6fcff84))
[<c0108d7b>] system_call [kernel] 0x33 (0xc6fcffc0))

loop          S 00000000     0   809    738   864               (NOTLB)
Call Trace:   [<c011c60a>] sys_wait4 [kernel] 0x192 (0xc3eb5f84))
[<c0108d7b>] system_call [kernel] 0x33 (0xc3eb5fc0))

runtest       S 00000000     0   814    641 30223           786 (NOTLB)
Call Trace:   [<c011c60a>] sys_wait4 [kernel] 0x192 (0xc6fcbf84))
[<c0108d7b>] system_call [kernel] 0x33 (0xc6fcbfc0))

loop          S 00000000     0   859    759   882               (NOTLB)
Call Trace:   [<c011c60a>] sys_wait4 [kernel] 0x192 (0xc6edff84))
[<c0108d7b>] system_call [kernel] 0x33 (0xc6edffc0))

loop          S 7FFFFFFF     0   864    809                     (NOTLB)
Call Trace:   [<c01215dd>] schedule_timeout [kernel] 0x9d (0xc6eefe4c))
[<c01fb507>] wait_for_connect [kernel] 0x173 (0xc6eefe78))
[<c01fb618>] tcp_accept [kernel] 0xe8 (0xc6eefeb0))
[<c021349e>] inet_accept [kernel] 0x26 (0xc6eefec8))
[<c01d92bd>] sys_accept [kernel] 0x5d (0xc6eefee4))
[<c01148a8>] do_page_fault [kernel] 0x140 (0xc6eeff08))
[<c0114a22>] do_page_fault [kernel] 0x2ba (0xc6eeff18))
[<c0206385>] tcp_v4_hash [kernel] 0x19 (0xc6eeff34))
[<c01f7b42>] tcp_listen_start [kernel] 0x10e (0xc6eeff40))
[<c0212bd9>] inet_listen [kernel] 0xd1 (0xc6eeff64))
[<c01d9be2>] sys_socketcall [kernel] 0x9a (0xc6eeff8c))
[<c0114768>] do_page_fault [kernel] 0x0 (0xc6eeffb0))
[<c0108e6c>] error_code [kernel] 0x34 (0xc6eeffb8))
[<c0108d7b>] system_call [kernel] 0x33 (0xc6eeffc0))

loop          S 7FFFFFFF     0   882    859                     (NOTLB)
Call Trace:   [<c01215dd>] schedule_timeout [kernel] 0x9d (0xc7055e4c))
[<c01fb507>] wait_for_connect [kernel] 0x173 (0xc7055e78))
[<c01fb618>] tcp_accept [kernel] 0xe8 (0xc7055eb0))
[<c021349e>] inet_accept [kernel] 0x26 (0xc7055ec8))
[<c01d92bd>] sys_accept [kernel] 0x5d (0xc7055ee4))
[<c01148a8>] do_page_fault [kernel] 0x140 (0xc7055f08))
[<c0114a22>] do_page_fault [kernel] 0x2ba (0xc7055f18))
[<c0206385>] tcp_v4_hash [kernel] 0x19 (0xc7055f34))
[<c01f7b42>] tcp_listen_start [kernel] 0x10e (0xc7055f40))
[<c0212bd9>] inet_listen [kernel] 0xd1 (0xc7055f64))
[<c01d9be2>] sys_socketcall [kernel] 0x9a (0xc7055f8c))
[<c0114768>] do_page_fault [kernel] 0x0 (0xc7055fb0))
[<c0108e6c>] error_code [kernel] 0x34 (0xc7055fb8))
[<c0108d7b>] system_call [kernel] 0x33 (0xc7055fc0))

grep          T C07DE000   336   942    780                     (NOTLB)
Call Trace:   [<c0122b43>] finish_stop [kernel] 0x2f (0xc07dff08))
[<c0122ea5>] get_signal_to_deliver [kernel] 0x211 (0xc07dff0c))
[<c0108b6f>] do_signal [kernel] 0x33 (0xc07dff28))
[<c016fe19>] tty_read [kernel] 0xa9 (0xc07dff7c))
[<c0115ef9>] schedule [kernel] 0x169 (0xc07dff9c))
[<c0108db4>] signal_return [kernel] 0x14 (0xc07dffc0))

flash         S 00000000  2388 30157    696 30164               (NOTLB)
Call Trace:   [<c011c60a>] sys_wait4 [kernel] 0x192 (0xc1c91f84))
[<c0108d7b>] system_call [kernel] 0x33 (0xc1c91fc0))

sleep         R 0000007D     0 30164  30157                     (NOTLB)
Call Trace:   [<c01169b7>] sys_sched_yield [kernel] 0x73 (0xc73b7e14))
[<c013669a>] __alloc_pages [kernel] 0x106 (0xc73b7e28))
[<c012c35c>] page_cache_read [kernel] 0x7c (0xc73b7e5c))
[<c012c3e1>] read_cluster_nonblocking [kernel] 0x39 (0xc73b7e74))
[<c012dba9>] filemap_nopage [kernel] 0x101 (0xc73b7e88))
[<c0129be5>] do_no_page [kernel] 0x71 (0xc73b7eac))
[<c0129e13>] handle_mm_fault [kernel] 0x6f (0xc73b7edc))
[<c01148a8>] do_page_fault [kernel] 0x140 (0xc73b7f08))
[<c0115ef9>] schedule [kernel] 0x169 (0xc73b7f50))
[<c0121598>] schedule_timeout [kernel] 0x58 (0xc73b7f70))
[<c0121534>] process_timeout [kernel] 0x0 (0xc73b7f8c))
[<c012160a>] sys_nanosleep [kernel] 0x1a (0xc73b7f98))
[<c01216af>] sys_nanosleep [kernel] 0xbf (0xc73b7fa4))
[<c0114768>] do_page_fault [kernel] 0x0 (0xc73b7fb0))
[<c0108e6c>] error_code [kernel] 0x34 (0xc73b7fb8))

timestamp     S 00000000  2384 30214    680 30221               (NOTLB)
Call Trace:   [<c011c60a>] sys_wait4 [kernel] 0x192 (0xc6a8ff84))
[<c0108d7b>] system_call [kernel] 0x33 (0xc6a8ffc0))

sleep         R 0000007D  2384 30221  30214                     (NOTLB)
Call Trace:   [<c01169b7>] sys_sched_yield [kernel] 0x73 (0xc7ad9e14))
[<c013669a>] __alloc_pages [kernel] 0x106 (0xc7ad9e28))
[<c012c35c>] page_cache_read [kernel] 0x7c (0xc7ad9e5c))
[<c012c3e1>] read_cluster_nonblocking [kernel] 0x39 (0xc7ad9e74))
[<c012dba9>] filemap_nopage [kernel] 0x101 (0xc7ad9e88))
[<c0129be5>] do_no_page [kernel] 0x71 (0xc7ad9eac))
[<c0129e13>] handle_mm_fault [kernel] 0x6f (0xc7ad9edc))
[<c01148a8>] do_page_fault [kernel] 0x140 (0xc7ad9f08))
[<c0115ef9>] schedule [kernel] 0x169 (0xc7ad9f50))
[<c0121598>] schedule_timeout [kernel] 0x58 (0xc7ad9f70))
[<c0121534>] process_timeout [kernel] 0x0 (0xc7ad9f8c))
[<c012160a>] sys_nanosleep [kernel] 0x1a (0xc7ad9f98))
[<c01216af>] sys_nanosleep [kernel] 0xbf (0xc7ad9fa4))
[<c0114768>] do_page_fault [kernel] 0x0 (0xc7ad9fb0))
[<c0108e6c>] error_code [kernel] 0x34 (0xc7ad9fb8))

loopdata      S 00000000  4504 30223    814 30230               (NOTLB)
Call Trace:   [<c011c60a>] sys_wait4 [kernel] 0x192 (0xc1e05f84))
[<c0108d7b>] system_call [kernel] 0x33 (0xc1e05fc0))

sleep         R 0000007D     0 30230  30223                     (NOTLB)
Call Trace:   [<c01169b7>] sys_sched_yield [kernel] 0x73 (0xc710fe14))
[<c013669a>] __alloc_pages [kernel] 0x106 (0xc710fe28))
[<c012c35c>] page_cache_read [kernel] 0x7c (0xc710fe5c))
[<c012c3e1>] read_cluster_nonblocking [kernel] 0x39 (0xc710fe74))
[<c012dba9>] filemap_nopage [kernel] 0x101 (0xc710fe88))
[<c0129be5>] do_no_page [kernel] 0x71 (0xc710feac))
[<c0129e13>] handle_mm_fault [kernel] 0x6f (0xc710fedc))
[<c01148a8>] do_page_fault [kernel] 0x140 (0xc710ff08))
[<c0115ef9>] schedule [kernel] 0x169 (0xc710ff50))
[<c0121598>] schedule_timeout [kernel] 0x58 (0xc710ff70))
[<c0115ef9>] schedule [kernel] 0x169 (0xc710ff9c))
[<c0114768>] do_page_fault [kernel] 0x0 (0xc710ffb0))
[<c0108e6c>] error_code [kernel] 0x34 (0xc710ffb8))

mii           S 00000000     0 30232    726 30281               (NOTLB)
Call Trace:   [<c011c60a>] sys_wait4 [kernel] 0x192 (0xc7c35f84))
[<c0108d7b>] system_call [kernel] 0x33 (0xc7c35fc0))

sleep         R 0000007D  2384 30281  30232                     (NOTLB)
Call Trace:   [<c01169b7>] sys_sched_yield [kernel] 0x73 (0xc39ffe14))
[<c013669a>] __alloc_pages [kernel] 0x106 (0xc39ffe28))
[<c012c35c>] page_cache_read [kernel] 0x7c (0xc39ffe5c))
[<c012c3e1>] read_cluster_nonblocking [kernel] 0x39 (0xc39ffe74))
[<c012dba9>] filemap_nopage [kernel] 0x101 (0xc39ffe88))
[<c0129be5>] do_no_page [kernel] 0x71 (0xc39ffeac))
[<c0129e13>] handle_mm_fault [kernel] 0x6f (0xc39ffedc))
[<c01148a8>] do_page_fault [kernel] 0x140 (0xc39fff08))
[<c0115ef9>] schedule [kernel] 0x169 (0xc39fff50))
[<c0121598>] schedule_timeout [kernel] 0x58 (0xc39fff70))
[<c0115ef9>] schedule [kernel] 0x169 (0xc39fff9c))
[<c0114768>] do_page_fault [kernel] 0x0 (0xc39fffb0))
[<c0108e6c>] error_code [kernel] 0x34 (0xc39fffb8))

loopdata      S 00000000  2384 30287    786 30294               (NOTLB)
Call Trace:   [<c011c60a>] sys_wait4 [kernel] 0x192 (0xc2087f84))
[<c0108d7b>] system_call [kernel] 0x33 (0xc2087fc0))

sleep         R 0000007D     0 30294  30287                     (NOTLB)
Call Trace:   [<c01169b7>] sys_sched_yield [kernel] 0x73 (0xc557fe14))
[<c013669a>] __alloc_pages [kernel] 0x106 (0xc557fe28))
[<c012c35c>] page_cache_read [kernel] 0x7c (0xc557fe5c))
[<c012c3e1>] read_cluster_nonblocking [kernel] 0x39 (0xc557fe74))
[<c012dba9>] filemap_nopage [kernel] 0x101 (0xc557fe88))
[<c0129be5>] do_no_page [kernel] 0x71 (0xc557feac))
[<c0129e13>] handle_mm_fault [kernel] 0x6f (0xc557fedc))
[<c01148a8>] do_page_fault [kernel] 0x140 (0xc557ff08))
[<c0115ef9>] schedule [kernel] 0x169 (0xc557ff50))
[<c0121598>] schedule_timeout [kernel] 0x58 (0xc557ff70))
[<c0121534>] process_timeout [kernel] 0x0 (0xc557ff8c))
[<c012160a>] sys_nanosleep [kernel] 0x1a (0xc557ff98))
[<c01216af>] sys_nanosleep [kernel] 0xbf (0xc557ffa4))
[<c0114768>] do_page_fault [kernel] 0x0 (0xc557ffb0))
[<c0108e6c>] error_code [kernel] 0x34 (0xc557ffb8))

memtst        R 0000007D  1360 30336    707                     (NOTLB)
Call Trace:   [<c01169b7>] sys_sched_yield [kernel] 0x73 (0xc31bbe14))
[<c013669a>] __alloc_pages [kernel] 0x106 (0xc31bbe28))
[<c8864ff0>] nfs_readpage [nfs] 0x74 (0xc31bbe34))
[<c012c35c>] page_cache_read [kernel] 0x7c (0xc31bbe5c))
[<c012c3e1>] read_cluster_nonblocking [kernel] 0x39 (0xc31bbe74))
[<c012dba9>] filemap_nopage [kernel] 0x101 (0xc31bbe88))
[<c0129be5>] do_no_page [kernel] 0x71 (0xc31bbeac))
[<c0129e13>] handle_mm_fault [kernel] 0x6f (0xc31bbedc))
[<c01148a8>] do_page_fault [kernel] 0x140 (0xc31bbf08))
[<c01f1eb3>] ip_rcv_finish [kernel] 0x1a7 (0xc31bbf28))
[<c01df6e1>] netif_receive_skb [kernel] 0x101 (0xc31bbf40))
[<c01df7ed>] process_backlog [kernel] 0x69 (0xc31bbf60))
[<c01df8eb>] net_rx_action [kernel] 0x5f (0xc31bbf78))
[<c0115ef9>] schedule [kernel] 0x169 (0xc31bbf9c))
[<c0114768>] do_page_fault [kernel] 0x0 (0xc31bbfb0))
[<c0108e6c>] error_code [kernel] 0x34 (0xc31bbfb8))



