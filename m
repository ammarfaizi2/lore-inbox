Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285052AbRLFING>; Thu, 6 Dec 2001 03:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285053AbRLFIMw>; Thu, 6 Dec 2001 03:12:52 -0500
Received: from net24-164-102-119.neo.rr.com ([24.164.102.119]:28812 "EHLO
	nova.qfire.net") by vger.kernel.org with ESMTP id <S285052AbRLFIMT>;
	Thu, 6 Dec 2001 03:12:19 -0500
Date: Thu, 6 Dec 2001 03:12:10 -0500
From: jcassidy@cs.kent.edu
To: Jorge Carminati <jcarminati@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel freezing....
Message-ID: <20011206031210.A11885@qfire.net>
In-Reply-To: <20011206022037.27ABA4729C@server.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011206022037.27ABA4729C@server.localdomain>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Dec 05, 2001 at 11:20:36PM -0300, Jorge Carminati wrote:
> Hi !
> 
> The problem is that after a couple of minutes of use it starts to 
> dump kernel messages, and it ends freezing completely. Almost all the 
> time I ran in init 1 mode (single user).

	There is a problem with the athlon optimizations, if you compile
for a PPro or lower your kernel should run stable, although probably a little
bit slower.

> 
> If someone needs more information I'll send it.
> 
> The notebook is a Compaq Presario 701LA (700 series) with 256 Mb RAM 
> and an Ext3 partition of 4Gb with a 100Mb swap partition.

Have a 705US here, some other problems you might run into:
	* Compiling IO-APIC into the kernel will cause ACPI to hang on boot.
	* Sound will not work, both OSS and Alsa drivers load fine,
	  the sound even appears to be decoded fine, it just won't
	  reach the speakers. Seen several posts from people having
	  the same problem, haven't seen any solutions yet.
	* The X-windows drivers don't seem to like shared memory much,
	  programs like ogle or mtv appear to crash X, also managed to
	  get LyX to reliable crash X too.
	* If you ruin the keyboard by spilling something on it, lie and
	  and say it just stopped working ;) Telling the truth got me
	  nothing but aggravation trying to find a replacement part, and
	  I wasn't paying anyone $100 to take two screws out and pop the
	  keyboard out in less than 5 minutes.


> 
> *** If someone can help me please CC to jcarminati@yahoo.com as I'm 
> not subscribed to this list ***. 
> 
> Thanks !
> 
> P.S.: The notebook works fine under Windows XP, just to discard a HW 
> failure.
> 
> 
> *** proc/cpuinfo shows: 
> 
> processor	: 0
> vendor_id	: AuthenticAMD
> cpu family	: 6
> model		: 7
> model name	: Mobile AMD Duron(tm) Processor
> stepping	: 0
> cpu MHz		: 946.750
> cache size	: 64 KB
> fdiv_bug	: no
> hlt_bug		: no
> f00f_bug	: no
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 1
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
> pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> bogomips	: 1887.43
> 
> *************************************************
> /proc/interrupts
> 
>            CPU0
>   0:      37092          XT-PIC  timer
>   1:       1259          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   8:          1          XT-PIC  rtc
>  11:        112          XT-PIC  eth0
>  14:       1790          XT-PIC  ide0
>  15:          4          XT-PIC  ide1
> NMI:          0
> ERR:          0
> 
> ***************************************************
> 
> /proc/ioports
> 
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0070-007f : rtc
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 0376-0376 : ide1
> 03c0-03df : vga+
> 03f6-03f6 : ide0
> 0cf8-0cff : PCI conf1
> 1000-10ff : VIA Technologies, Inc. AC97 Audio Controller
> 1400-14ff : Realtek Semiconductor Co., Ltd. RTL-8139
>   1400-14ff : 8139too
> 1800-181f : VIA Technologies, Inc. UHCI USB
> 1840-184f : VIA Technologies, Inc. Bus Master IDE
>   1840-1847 : ide0
>   1848-184f : ide1
> 1850-1853 : VIA Technologies, Inc. AC97 Audio Controller
> 1854-1857 : VIA Technologies, Inc. AC97 Audio Controller
> 1858-185f : Conexant HSF 56k HSFi Modem
> 8100-810f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
> 
> **********************************************************
> * SYSLOG 
> **********************************************************
> 
> Dec  5 19:20:48 notebook syslogd 1.4.1: restart.
> Dec  5 19:20:48 notebook syslog: syslogd startup succeeded
> Dec  5 19:20:48 notebook syslog: klogd startup succeeded
> Dec  5 19:20:48 notebook kernel: klogd 1.4.1, log source = /proc/kmsg 
> started.
> Dec  5 19:20:48 notebook kernel: Inspecting /boot/System.map-2.4.7-10
> Dec  5 19:20:48 notebook portmap: portmap startup succeeded
> Dec  5 19:20:48 notebook kernel: Loaded 15331 symbols from 
> /boot/System.map-2.4.7-10.
> Dec  5 19:20:48 notebook kernel: Symbols match kernel version 2.4.7.
> Dec  5 20:06:48 notebook syslogd 1.4.1: restart.
> Dec  5 20:06:48 notebook syslog: syslogd startup succeeded
> Dec  5 20:06:48 notebook kernel: klogd 1.4.1, log source = /proc/kmsg 
> started.
> Dec  5 20:06:48 notebook kernel: Inspecting /boot/System.map-2.4.7-10
> Dec  5 20:06:48 notebook syslog: klogd startup succeeded
> Dec  5 20:06:48 notebook kernel: Loaded 15331 symbols from 
> /boot/System.map-2.4.7-10.
> Dec  5 20:06:48 notebook kernel: Symbols match kernel version 2.4.7.
> Dec  5 20:06:48 notebook kernel: Loaded 175 symbols from 4 modules.
> Dec  5 20:06:48 notebook kernel: Linux version 2.4.7-10 
> (bhcompile@stripples.devel.redhat.com) (gcc version 2.96 20000731 
> (Red Hat Linux 7.1 2.96-98)) #1 Thu Sep 6 16:46:36 EDT 2001
> Dec  5 20:06:48 notebook kernel: BIOS-provided physical RAM map:
> Dec  5 20:06:48 notebook kernel:  BIOS-e820: 0000000000000000 - 
> 000000000009e800 (usable)
> Dec  5 20:06:48 notebook kernel:  BIOS-e820: 000000000009e800 - 
> 00000000000a0000 (reserved)
> Dec  5 20:06:48 notebook kernel:  BIOS-e820: 00000000000c0000 - 
> 00000000000cc000 (reserved)
> Dec  5 20:06:48 notebook kernel:  BIOS-e820: 00000000000dc000 - 
> 0000000000100000 (reserved)
> Dec  5 20:06:48 notebook kernel:  BIOS-e820: 0000000000100000 - 
> 000000000eef0000 (usable)
> Dec  5 20:06:48 notebook kernel:  BIOS-e820: 000000000eef0000 - 
> 000000000eeff000 (ACPI data)
> Dec  5 20:06:48 notebook kernel:  BIOS-e820: 000000000eeff000 - 
> 000000000ef00000 (ACPI NVS)
> Dec  5 20:06:48 notebook kernel:  BIOS-e820: 000000000ef00000 - 
> 000000000f000000 (usable)
> Dec  5 20:06:48 notebook kernel:  BIOS-e820: 00000000fff80000 - 
> 0000000100000000 (reserved)
> Dec  5 20:06:48 notebook kernel: On node 0 totalpages: 61440
> Dec  5 20:06:48 notebook kernel: zone(0): 4096 pages.
> Dec  5 20:06:48 notebook kernel: zone(1): 57344 pages.
> Dec  5 20:06:48 notebook kernel: zone(2): 0 pages.
> Dec  5 20:06:48 notebook kernel: Local APIC disabled by BIOS -- 
> reenabling.
> Dec  5 20:06:48 notebook kernel: Found and enabled local APIC!
> Dec  5 20:06:48 notebook kernel: Kernel command line: 
> BOOT_IMAGE=linux ro root=302 BOOT_FILE=/boot/vmlinuz-2.4.7-10 single
> Dec  5 20:06:48 notebook kernel: Initializing CPU#0
> Dec  5 20:06:48 notebook kernel: Detected 946.722 MHz processor.
> Dec  5 20:06:48 notebook kernel: Console: colour VGA+ 80x25
> Dec  5 20:06:48 notebook kernel: Calibrating delay loop... 1887.43 
> BogoMIPS
> Dec  5 20:06:49 notebook kernel: Memory: 237056k/245760k available 
> (1279k kernel code, 6448k reserved, 91k data, 232k init, 0k highmem)
> Dec  5 20:06:49 notebook kernel: Dentry-cache hash table entries: 
> 32768 (order: 6, 262144 bytes)
> Dec  5 20:06:49 notebook kernel: Inode-cache hash table entries: 
> 16384 (order: 5, 131072 bytes)
> Dec  5 20:06:49 notebook kernel: Mount-cache hash table entries: 4096 
> (order: 3, 32768 bytes)
> Dec  5 20:06:49 notebook kernel: Buffer-cache hash table entries: 
> 16384 (order: 4, 65536 bytes)
> Dec  5 20:06:49 notebook kernel: Page-cache hash table entries: 65536 
> (order: 7, 524288 bytes)
> Dec  5 20:06:49 notebook kernel: Intel machine check architecture 
> supported.
> Dec  5 20:06:49 notebook kernel: Intel machine check reporting 
> enabled on CPU#0.
> Dec  5 20:06:49 notebook kernel: CPU: L1 I Cache: 64K (64 
> bytes/line), D cache 64K (64 bytes/line)
> Dec  5 20:06:49 notebook kernel: CPU: L2 Cache: 64K (64 bytes/line)
> Dec  5 20:06:49 notebook kernel: CPU: AMD Mobile AMD Duron(tm) 
> Processor stepping 00
> Dec  5 20:06:49 notebook kernel: Enabling fast FPU save and 
> restore... done.
> Dec  5 20:06:49 notebook kernel: Enabling unmasked SIMD FPU exception 
> support... done.
> Dec  5 20:06:49 notebook kernel: Checking 'hlt' instruction... OK.
> Dec  5 20:06:49 notebook kernel: POSIX conformance testing by UNIFIX
> Dec  5 20:06:49 notebook kernel: mtrr: v1.40 (20010327) Richard Gooch 
> (rgooch@atnf.csiro.au)
> Dec  5 20:06:49 notebook kernel: mtrr: detected mtrr type: Intel
> Dec  5 20:06:49 notebook kernel: PCI: PCI BIOS revision 2.10 entry at 
> 0xfd7ae, last bus=1
> Dec  5 20:06:49 notebook kernel: PCI: Using configuration type 1
> Dec  5 20:06:49 notebook kernel: PCI: Probing PCI hardware
> Dec  5 20:06:49 notebook kernel: Unknown bridge resource 0: assuming 
> transparent
> Dec  5 20:06:49 notebook kernel: PCI: Using IRQ router VIA 
> [1106/0686] at 00:07.0
> Dec  5 20:06:49 notebook kernel: Applying VIA southbridge workaround.
> Dec  5 20:06:49 notebook kernel: PCI: Disabling Via external APIC 
> routing
> Dec  5 20:06:49 notebook kernel: isapnp: Scanning for PnP cards...
> Dec  5 20:06:49 notebook kernel: isapnp: No Plug & Play device found
> Dec  5 20:06:49 notebook kernel: Linux NET4.0 for Linux 2.4
> Dec  5 20:06:49 notebook kernel: Based upon Swansea University 
> Computer Society NET3.039
> Dec  5 20:06:49 notebook kernel: Initializing RT netlink socket
> Dec  5 20:06:49 notebook kernel: apm: BIOS version 1.2 Flags 0x03 
> (Driver version 1.14)
> Dec  5 20:06:49 notebook kernel: Starting kswapd v1.8
> Dec  5 20:06:49 notebook kernel: VFS: Diskquotas version dquot_6.5.0 
> initialized
> Dec  5 20:06:49 notebook kernel: pty: 2048 Unix98 ptys configured
> Dec  5 20:06:49 notebook kernel: Serial driver version 5.05c 
> (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP 
> enabled
> Dec  5 20:06:49 notebook kernel: Real Time Clock Driver v1.10d
> Dec  5 20:06:49 notebook kernel: block: queued sectors max/low 
> 157328kB/52442kB, 512 slots per queue
> Dec  5 20:06:49 notebook kernel: RAMDISK driver initialized: 16 RAM 
> disks of 4096K size 1024 blocksize
> Dec  5 20:06:49 notebook kernel: Uniform Multi-Platform E-IDE driver 
> Revision: 6.31
> Dec  5 20:06:49 notebook kernel: ide: Assuming 33MHz PCI bus speed 
> for PIO modes; override with idebus=xx
> Dec  5 20:06:49 notebook kernel: VP_IDE: IDE controller on PCI bus 00 
> dev 39
> Dec  5 20:06:49 notebook kernel: VP_IDE: chipset revision 6
> Dec  5 20:06:49 notebook kernel: VP_IDE: not 100%% native mode: will 
> probe irqs later
> Dec  5 20:06:49 notebook kernel: ide: Assuming 33MHz PCI bus speed 
> for PIO modes; override with idebus=xx
> Dec  5 20:06:49 notebook kernel: VP_IDE: VIA vt82c686b (rev 42) IDE 
> UDMA100 controller on pci00:07.1
> Dec  5 20:06:49 notebook kernel:     ide0: BM-DMA at 0x1840-0x1847, 
> BIOS settings: hda:DMA, hdb:pio
> Dec  5 20:06:49 notebook kernel:     ide1: BM-DMA at 0x1848-0x184f, 
> BIOS settings: hdc:DMA, hdd:pio
> Dec  5 20:06:49 notebook kernel: hda: TOSHIBA MK2017GAP, ATA DISK 
> drive
> Dec  5 20:06:49 notebook kernel: hdc: LG DVD-ROM DRN-8080B, ATAPI 
> CD/DVD-ROM drive
> Dec  5 20:06:49 notebook kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Dec  5 20:06:49 notebook kernel: ide1 at 0x170-0x177,0x376 on irq 15
> Dec  5 20:06:49 notebook kernel: hda: 39070080 sectors (20004 MB), 
> CHS=2432/255/63, UDMA(33)
> Dec  5 20:06:49 notebook kernel: ide-floppy driver 0.97
> Dec  5 20:06:49 notebook kernel: Partition check:
> Dec  5 20:06:49 notebook kernel:  hda: hda1 hda2 hda3
> Dec  5 20:06:49 notebook kernel: Floppy drive(s): fd0 is 1.44M
> Dec  5 20:06:49 notebook kernel: FDC 0 is a post-1991 82077
> Dec  5 20:06:49 notebook kernel: ide-floppy driver 0.97
> Dec  5 20:06:49 notebook kernel: md: md driver 0.90.0 
> MAX_MD_DEVS=256, MD_SB_DISKS=27
> Dec  5 20:06:49 notebook kernel: md: Autodetecting RAID arrays.
> Dec  5 20:06:49 notebook kernel: md: autorun ...
> Dec  5 20:06:49 notebook kernel: md: ... autorun DONE.
> Dec  5 20:06:49 notebook kernel: NET4: Linux TCP/IP 1.0 for NET4.0
> Dec  5 20:06:49 notebook kernel: IP Protocols: ICMP, UDP, TCP, IGMP
> Dec  5 20:06:49 notebook kernel: IP: routing cache hash table of 2048 
> buckets, 16Kbytes
> Dec  5 20:06:49 notebook kernel: TCP: Hash tables configured 
> (established 16384 bind 16384)
> Dec  5 20:06:49 notebook kernel: Linux IP multicast router 0.06 plus 
> PIM-SM
> Dec  5 20:06:50 notebook kernel: NET4: Unix domain sockets 1.0/SMP 
> for Linux NET4.0.
> Dec  5 20:06:50 notebook kernel: RAMDISK: Compressed image found at 
> block 0
> Dec  5 20:06:50 notebook kernel: Freeing initrd memory: 320k freed
> Dec  5 20:06:50 notebook kernel: VFS: Mounted root (ext2 filesystem).
> Dec  5 20:06:50 notebook kernel: Journalled Block Device driver loaded
> Dec  5 20:06:50 notebook kernel: EXT3-fs: INFO: recovery required on 
> readonly filesystem.
> Dec  5 20:06:50 notebook kernel: EXT3-fs: write access will be 
> enabled during recovery.
> Dec  5 20:06:50 notebook kernel: kjournald starting.  Commit interval 
> 5 seconds
> Dec  5 20:06:50 notebook kernel: EXT3-fs: recovery complete.
> Dec  5 20:06:50 notebook kernel: EXT3-fs: mounted filesystem with 
> ordered data mode.
> Dec  5 20:06:50 notebook kernel: Freeing unused kernel memory: 232k 
> freed
> Dec  5 20:06:50 notebook kernel: Adding Swap: 104412k swap-space 
> (priority -1)
> Dec  5 20:06:50 notebook kernel: usb.c: registered new driver usbdevfs
> Dec  5 20:06:50 notebook kernel: usb.c: registered new driver hub
> Dec  5 20:06:50 notebook kernel: usb-uhci.c: $Revision: 1.259 $ time 
> 16:59:02 Sep  6 2001
> Dec  5 20:06:50 notebook kernel: usb-uhci.c: High bandwidth mode 
> enabled
> Dec  5 20:06:50 notebook kernel: PCI: Assigned IRQ 9 for device 
> 00:07.2
> Dec  5 20:06:50 notebook kernel: usb-uhci.c: USB UHCI at I/O 0x1800, 
> IRQ 9
> Dec  5 20:06:50 notebook kernel: usb-uhci.c: Detected 2 ports
> Dec  5 20:06:50 notebook kernel: usb.c: new USB bus registered, 
> assigned bus number 1
> Dec  5 20:06:50 notebook kernel: hub.c: USB hub found
> Dec  5 20:06:50 notebook kernel: hub.c: 2 ports detected
> Dec  5 20:06:50 notebook kernel: usb-uhci.c: v1.251:USB Universal 
> Host Controller Interface driver
> Dec  5 20:06:50 notebook kernel: EXT3 FS 2.4-0.9.8, 25 Aug 2001 on 
> ide0(3,2), internal journal
> Dec  5 20:05:56 notebook rc.sysinit: Mounting proc filesystem:  
> succeeded
> Dec  5 20:05:56 notebook rc.sysinit: Unmounting initrd:  succeeded
> Dec  5 20:05:56 notebook sysctl: net.ipv4.ip_forward = 0
> Dec  5 20:05:56 notebook sysctl: net.ipv4.conf.default.rp_filter = 1
> Dec  5 20:05:56 notebook sysctl: kernel.sysrq = 0
> Dec  5 20:05:56 notebook rc.sysinit: Configuring kernel parameters:  
> succeeded
> Dec  5 20:05:56 notebook date: Wed Dec  5 20:05:45 ART 2001
> Dec  5 20:05:56 notebook rc.sysinit: Setting clock  (localtime): Wed 
> Dec  5 20:05:45 ART 2001 succeeded
> Dec  5 20:05:56 notebook rc.sysinit: Loading default keymap succeeded
> Dec  5 20:05:56 notebook rc.sysinit: Setting default font 
> (lat0-sun16):  succeeded
> Dec  5 20:05:56 notebook rc.sysinit: Activating swap partitions:  
> succeeded
> Dec  5 20:05:56 notebook rc.sysinit: Setting hostname 
> notebook.localdomain:  succeeded
> Dec  5 20:05:56 notebook rc.sysinit: Mounting USB filesystem:  
> succeeded
> Dec  5 20:05:56 notebook rc.sysinit: Initializing USB controller 
> (usb-uhci):  succeeded
> Dec  5 20:05:56 notebook fsck: /: clean, 94317/563360 files, 
> 393803/1126558 blocks
> Dec  5 20:05:56 notebook rc.sysinit: Checking root filesystem 
> succeeded
> Dec  5 20:05:56 notebook rc.sysinit: Remounting root filesystem in 
> read-write mode:  succeeded
> Dec  5 20:05:57 notebook rc.sysinit: Finding module dependencies:  
> succeeded
> Dec  5 20:05:57 notebook rc.sysinit: Checking filesystems succeeded
> Dec  5 20:05:58 notebook rc.sysinit: Mounting local filesystems:  
> succeeded
> Dec  5 20:05:58 notebook rc.sysinit: Enabling local filesystem 
> quotas:  succeeded
> Dec  5 20:05:58 notebook rc.sysinit: Enabling swap space:  succeeded
> Dec  5 20:16:12 notebook kernel: ide-floppy driver 0.97
> Dec  5 20:16:12 notebook kernel: hdc: ATAPI 24X DVD-ROM drive, 512kB 
> Cache, UDMA(33)
> Dec  5 20:16:12 notebook kernel: Uniform CD-ROM driver Revision: 3.12
> Dec  5 20:26:03 notebook kernel: Unable to handle kernel NULL pointer 
> dereference at virtual address 00000004
> Dec  5 20:26:03 notebook kernel:  printing eip:
> Dec  5 20:26:03 notebook kernel: c0125c8d
> Dec  5 20:26:03 notebook kernel: *pde = 00000000
> Dec  5 20:26:03 notebook kernel: Oops: 0002
> Dec  5 20:26:03 notebook kernel: CPU:    0
> Dec  5 20:26:03 notebook kernel: EIP:    0010:[__set_page_dirty+13/64]
> Dec  5 20:26:03 notebook kernel: EIP:    0010:[<c0125c8d>]
> Dec  5 20:26:03 notebook kernel: EFLAGS: 00010246
> Dec  5 20:26:03 notebook kernel: eax: c12cc034   ebx: 080888a1   ecx: 
> bffff218   edx: 00000000
> Dec  5 20:26:03 notebook kernel: esi: 0007f000   edi: 00023000   ebp: 
> c29663ac   esp: c2eefbd0
> Dec  5 20:26:03 notebook kernel: ds: 0018   es: 0018   ss: 0018
> Dec  5 20:26:03 notebook kernel: Process sh (pid: 549, 
> stackpage=c2eef000)
> Dec  5 20:26:03 notebook kernel: Stack: c12cc034 c0122e8f c12cc034 
> 00000024 00000000 08147000 cbd97080 080c8000
> Dec  5 20:26:04 notebook kernel:        00000000 08147000 cbd97080 
> cebfa580 00000000 c2eefca0 cebfa638 c01492ba
> Dec  5 20:26:04 notebook kernel:        cebfa580 00000001 c01271a2 
> cebfa580 00001000 cee01d34 00000001 00000000
> Dec  5 20:26:04 notebook kernel: Call Trace: [zap_page_range+415/624] 
> [update_atime+74/80] [do_generic_file_read+1314/1328] 
> [exit_mmap+184/288] [file_read_actor+0/224]
> Dec  5 20:26:04 notebook kernel: Call Trace: [<c0122e8f>] 
> [<c01492ba>] [<c01271a2>] [<c0125748>] [<c01271b0>]
> Dec  5 20:26:04 notebook kernel:    [exec_mmap+35/288] 
> [flush_old_exec+113/608] [load_elf_binary+1151/2640] 
> [usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.7-10/kernel/drivers/usb+-227113/96] 
> [load_elf_binary+0/2640] [search_binary_handler+113/384]
> Dec  5 20:26:04 notebook kernel:    [<c013d213>] [<c013d381>] 
> [<c014e6ff>] [<cf8018d7>] [<c014e280>] [<c013d991>]
> Dec  5 20:26:04 notebook kernel:    [do_execve+380/480] 
> [getname+94/160] [sys_execve+48/96] [system_call+51/56]
> Dec  5 20:26:04 notebook kernel:    [<c013dc1c>] [<c013eade>] 
> [<c0105b60>] [<c0106f2b>]
> Dec  5 20:26:04 notebook kernel:
> Dec  5 20:26:04 notebook kernel: Code: 89 4a 04 89 11 8d 4b 08 8b 53 
> 08 89 42 04 89 10 89 48 04 89
> Dec  5 20:26:04 notebook kernel:  exit_mmap: map count is 11
> Dec  5 20:27:15 notebook kernel: Unable to handle kernel paging 
> request at virtual address 4155514d
> Dec  5 20:27:15 notebook kernel:  printing eip:
> Dec  5 20:27:15 notebook kernel: c0125c8d
> Dec  5 20:27:15 notebook kernel: *pde = 00000000
> Dec  5 20:27:15 notebook kernel: Oops: 0002
> Dec  5 20:27:15 notebook kernel: CPU:    0
> Dec  5 20:27:15 notebook kernel: EIP:    0010:[__set_page_dirty+13/64]
> Dec  5 20:27:15 notebook kernel: EIP:    0010:[<c0125c8d>]
> Dec  5 20:27:15 notebook kernel: EFLAGS: 00010246
> Dec  5 20:27:15 notebook kernel: eax: c12e80d8   ebx: 55555555   ecx: 
> 55002744   edx: 41555149
> Dec  5 20:27:15 notebook kernel: esi: 00263000   edi: 00024000   ebp: 
> c2b963b0   esp: c8cb3bd0
> Dec  5 20:27:15 notebook kernel: ds: 0018   es: 0018   ss: 0018
> Dec  5 20:27:15 notebook kernel: Process sh (pid: 621, 
> stackpage=c8cb3000)
> Dec  5 20:27:15 notebook kernel: Stack: c12e80d8 c0122e8f c12e80d8 
> 00000025 00000000 0832b000 c8d8f080 080c8000
> Dec  5 20:27:15 notebook kernel:        00000000 0832b000 c8d8f080 
> cebfa580 00000000 c8cb3ca0 cebfa638 c01492ba
> Dec  5 20:27:15 notebook kernel:        cebfa580 00000001 c01271a2 
> cebfa580 00001000 cee01d34 00000001 00000000
> Dec  5 20:27:15 notebook kernel: Call Trace: [zap_page_range+415/624] 
> [update_atime+74/80] [do_generic_file_read+1314/1328] 
> [exit_mmap+184/288] [file_read_actor+0/224]
> Dec  5 20:27:15 notebook kernel: Call Trace: [<c0122e8f>] 
> [<c01492ba>] [<c01271a2>] [<c0125748>] [<c01271b0>]
> Dec  5 20:27:15 notebook kernel:    [exec_mmap+35/288] 
> [flush_old_exec+113/608] [load_elf_binary+1151/2640] 
> [usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.7-10/kernel/drivers/usb+-227113/96] 
> [load_elf_binary+0/2640] [search_binary_handler+113/384]
> Dec  5 20:27:15 notebook kernel:    [<c013d213>] [<c013d381>] 
> [<c014e6ff>] [<cf8018d7>] [<c014e280>] [<c013d991>]
> Dec  5 20:27:15 notebook kernel:    [do_execve+380/480] 
> [getname+94/160] [sys_execve+48/96] [system_call+51/56]
> Dec  5 20:27:15 notebook kernel:    [<c013dc1c>] [<c013eade>] 
> [<c0105b60>] [<c0106f2b>]
> Dec  5 20:27:15 notebook kernel:
> Dec  5 20:27:15 notebook kernel: Code: 89 4a 04 89 11 8d 4b 08 8b 53 
> 08 89 42 04 89 10 89 48 04 89
> Dec  5 20:27:15 notebook kernel:  exit_mmap: map count is 11
> Dec  5 20:27:15 notebook kernel: kernel BUG at page_alloc.c:87!
> Dec  5 20:27:15 notebook kernel: invalid operand: 0000
> Dec  5 20:27:15 notebook kernel: CPU:    0
> Dec  5 20:27:15 notebook kernel: EIP:    0010:[__free_pages_ok+64/768]
> Dec  5 20:27:15 notebook kernel: EIP:    0010:[<c012df00>]
> Dec  5 20:27:15 notebook kernel: EFLAGS: 00010282
> Dec  5 20:27:15 notebook kernel: eax: 0000001f   ebx: c12e80d8   ecx: 
> 00000001   edx: 0000203c
> Dec  5 20:27:15 notebook kernel: esi: 55555555   edi: c12e80d8   ebp: 
> 00000000   esp: c8cb3b8c
> Dec  5 20:27:15 notebook kernel: ds: 0018   es: 0018   ss: 0018
> Dec  5 20:27:15 notebook kernel: Process sh (pid: 622, 
> stackpage=c8cb3000)
> Dec  5 20:27:15 notebook kernel: Stack: c022d0c8 00000057 c1044010 
> c0243764 00000213 ffffffff 00005a79 c12e80d8
> Dec  5 20:27:15 notebook kernel:        c12e80d8 00024000 c29773b0 
> c012eec5 00000000 c1661000 00000000 c51b13c0
> Dec  5 20:27:15 notebook kernel:        c12e80d8 00263000 c0122e96 
> c12e80d8 00000025 00000000 0832b000 c53a8080
> Dec  5 20:27:15 notebook kernel: Call Trace: 
> [call_spurious_interrupt+118835/144011] 
> [free_page_and_swap_cache+197/208] [zap_page_range+422/624] 
> [update_atime+74/80] [do_generic_file_read+1314/1328]
> Dec  5 20:27:15 notebook kernel: Call Trace: [<c022d0c8>] 
> [<c012eec5>] [<c0122e96>] [<c01492ba>] [<c01271a2>]
> Dec  5 20:27:15 notebook kernel:    [exit_mmap+184/288] 
> [file_read_actor+0/224] [exec_mmap+35/288] [flush_old_exec+113/608] 
> [load_elf_binary+1151/2640] 
> [usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.7-10/kernel/drivers/usb+-227113/96]
> Dec  5 20:27:15 notebook kernel:    [<c0125748>] [<c01271b0>] 
> [<c013d213>] [<c013d381>] [<c014e6ff>] [<cf8018d7>]
> Dec  5 20:27:15 notebook kernel:    [load_elf_binary+0/2640] 
> [search_binary_handler+113/384] [do_execve+380/480] [getname+94/160] 
> [sys_execve+48/96] [system_call+51/56]
> Dec  5 20:27:15 notebook kernel:    [<c014e280>] [<c013d991>] 
> [<c013dc1c>] [<c013eade>] [<c0105b60>] [<c0106f2b>]
> Dec  5 20:27:15 notebook kernel:
> Dec  5 20:27:15 notebook kernel: Code: 0f 0b 59 5b 8b 15 0c 01 2b c0 
> 89 f8 29 d0 69 c0 f1 f0 f0 f0
> Dec  5 20:27:15 notebook kernel:  exit_mmap: map count is 11
> Dec  5 20:27:15 notebook kernel: kernel BUG at page_alloc.c:87!
> Dec  5 20:27:15 notebook kernel: invalid operand: 0000
> Dec  5 20:27:15 notebook kernel: CPU:    0
> Dec  5 20:27:15 notebook kernel: EIP:    0010:[__free_pages_ok+64/768]
> Dec  5 20:27:15 notebook kernel: EIP:    0010:[<c012df00>]
> Dec  5 20:27:15 notebook kernel: EFLAGS: 00010282
> Dec  5 20:27:15 notebook kernel: eax: 0000001f   ebx: c12e80d8   ecx: 
> 00000001   edx: 000023e3
> Dec  5 20:27:15 notebook kernel: esi: 55555555   edi: c12e80d8   ebp: 
> 00000000   esp: c8cb3b8c
> Dec  5 20:27:15 notebook kernel: ds: 0018   es: 0018   ss: 0018
> Dec  5 20:27:16 notebook kernel: Process sh (pid: 623, 
> stackpage=c8cb3000)
> Dec  5 20:27:16 notebook kernel: Stack: c022d0c8 00000057 c1044010 
> c0243764 00000217 ffffffff 00003311 c12e80d8
> Dec  5 20:27:16 notebook kernel:        c12e80d8 00024000 c77773b0 
> c012eec5 00000000 c1661000 00000000 c51b1400
> Dec  5 20:27:16 notebook kernel:        c12e80d8 00263000 c0122e96 
> c12e80d8 00000025 00000000 0832b000 c7778080
> Dec  5 20:27:16 notebook kernel: Call Trace: 
> [call_spurious_interrupt+118835/144011] 
> [free_page_and_swap_cache+197/208] [zap_page_range+422/624] 
> [update_atime+74/80] [do_generic_file_read+1314/1328]
> Dec  5 20:27:16 notebook kernel: Call Trace: [<c022d0c8>] 
> [<c012eec5>] [<c0122e96>] [<c01492ba>] [<c01271a2>]
> Dec  5 20:27:16 notebook kernel:    [exit_mmap+184/288] 
> [file_read_actor+0/224] [exec_mmap+35/288] [flush_old_exec+113/608] 
> [load_elf_binary+1151/2640] 
> [usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.7-10/kernel/drivers/usb+-227113/96]
> Dec  5 20:27:16 notebook kernel:    [<c0125748>] [<c01271b0>] 
> [<c013d213>] [<c013d381>] [<c014e6ff>] [<cf8018d7>]
> Dec  5 20:27:16 notebook kernel:    [load_elf_binary+0/2640] 
> [search_binary_handler+113/384] [do_execve+380/480] [getname+94/160] 
> [sys_execve+48/96] [system_call+51/56]
> Dec  5 20:27:16 notebook kernel:    [<c014e280>] [<c013d991>] 
> [<c013dc1c>] [<c013eade>] [<c0105b60>] [<c0106f2b>]
> Dec  5 20:27:16 notebook kernel:
> Dec  5 20:27:16 notebook kernel: Code: 0f 0b 59 5b 8b 15 0c 01 2b c0 
> 89 f8 29 d0 69 c0 f1 f0 f0 f0
> Dec  5 20:27:16 notebook kernel:  exit_mmap: map count is 11
> Dec  5 20:27:16 notebook kernel: kernel BUG at page_alloc.c:87!
> Dec  5 20:27:16 notebook kernel: invalid operand: 0000
> Dec  5 20:27:16 notebook kernel: CPU:    0
> Dec  5 20:27:16 notebook kernel: EIP:    0010:[__free_pages_ok+64/768]
> Dec  5 20:27:16 notebook kernel: EIP:    0010:[<c012df00>]
> Dec  5 20:27:16 notebook kernel: EFLAGS: 00010282
> Dec  5 20:27:16 notebook kernel: eax: 0000001f   ebx: c12e80d8   ecx: 
> 00000001   edx: 0000278a
> Dec  5 20:27:16 notebook kernel: esi: 55555555   edi: c12e80d8   ebp: 
> 00000000   esp: cd3bfb8c
> Dec  5 20:27:16 notebook kernel: ds: 0018   es: 0018   ss: 0018
> Dec  5 20:27:16 notebook kernel: Process sh (pid: 624, 
> stackpage=cd3bf000)
> Dec  5 20:27:16 notebook kernel: Stack: c022d0c8 00000057 c1044010 
> c0243764 00000212 ffffffff 0000428f c12e80d8
> Dec  5 20:27:16 notebook kernel:        c12e80d8 00024000 cd3bc3b0 
> c012eec5 00000000 c1661000 00000000 c51b1480
> Dec  5 20:27:16 notebook kernel:        c12e80d8 00263000 c0122e96 
> c12e80d8 00000025 00000000 0832b000 cd3bd080
> Dec  5 20:27:16 notebook kernel: Call Trace: 
> [call_spurious_interrupt+118835/144011] 
> [free_page_and_swap_cache+197/208] [zap_page_range+422/624] 
> [update_atime+74/80] [do_generic_file_read+1314/1328]
> Dec  5 20:27:16 notebook kernel: Call Trace: [<c022d0c8>] 
> [<c012eec5>] [<c0122e96>] [<c01492ba>] [<c01271a2>]
> Dec  5 20:27:16 notebook kernel:    [exit_mmap+184/288] 
> [file_read_actor+0/224] [exec_mmap+35/288] [flush_old_exec+113/608] 
> [load_elf_binary+1151/2640] [dma_timer_expiry+0/96]
> Dec  5 20:27:16 notebook kernel:    [<c0125748>] [<c01271b0>] 
> [<c013d213>] [<c013d381>] [<c014e6ff>] [<c0195350>]
> Dec  5 20:27:16 notebook kernel:    [start_request+416/528] 
> [load_elf_binary+0/2640] [search_binary_handler+113/384] 
> [do_execve+380/480] [getname+94/160] [sys_execve+48/96]
> Dec  5 20:27:16 notebook kernel:    [<c018be40>] [<c014e280>] 
> [<c013d991>] [<c013dc1c>] [<c013eade>] [<c0105b60>]
> Dec  5 20:27:16 notebook kernel:    [system_call+51/56]
> Dec  5 20:27:16 notebook kernel:    [<c0106f2b>]
> Dec  5 20:27:16 notebook kernel:
> Dec  5 20:27:16 notebook kernel: Code: 0f 0b 59 5b 8b 15 0c 01 2b c0 
> 89 f8 29 d0 69 c0 f1 f0 f0 f0
> Dec  5 20:27:16 notebook kernel:  exit_mmap: map count is 11
> Dec  5 20:27:16 notebook kernel: kernel BUG at page_alloc.c:87!
> Dec  5 20:27:16 notebook kernel: invalid operand: 0000
> Dec  5 20:27:16 notebook kernel: CPU:    0
> Dec  5 20:27:16 notebook kernel: EIP:    0010:[__free_pages_ok+64/768]
> Dec  5 20:27:16 notebook kernel: EIP:    0010:[<c012df00>]
> Dec  5 20:27:16 notebook kernel: EFLAGS: 00010282
> Dec  5 20:27:16 notebook kernel: eax: 0000001f   ebx: c12e80d8   ecx: 
> 00000001   edx: 00002b45
> Dec  5 20:27:16 notebook kernel: esi: 55555555   edi: c12e80d8   ebp: 
> 00000000   esp: c4f2fb8c
> Dec  5 20:27:16 notebook kernel: ds: 0018   es: 0018   ss: 0018
> Dec  5 20:27:16 notebook kernel: Process sh (pid: 625, 
> stackpage=c4f2f000)
> Dec  5 20:27:16 notebook kernel: Stack: c022d0c8 00000057 c1044010 
> c0243764 00000213 ffffffff 00003be5 c12e80d8
> Dec  5 20:27:16 notebook kernel:        c12e80d8 00024000 c4f2d3b0 
> c012eec5 00000000 c1661000 00000000 c51b1480
> Dec  5 20:27:16 notebook kernel:        c12e80d8 00265000 c0122e96 
> c12e80d8 00000025 00000000 0832d000 c5ecc080
> Dec  5 20:27:16 notebook kernel: Call Trace: 
> [call_spurious_interrupt+118835/144011] 
> [free_page_and_swap_cache+197/208] [zap_page_range+422/624] 
> [update_atime+74/80] [do_generic_file_read+1314/1328]
> Dec  5 20:27:16 notebook kernel: Call Trace: [<c022d0c8>] 
> [<c012eec5>] [<c0122e96>] [<c01492ba>] [<c01271a2>]
> Dec  5 20:27:16 notebook kernel:    [exit_mmap+184/288] 
> [file_read_actor+0/224] [exec_mmap+35/288] [flush_old_exec+113/608] 
> [load_elf_binary+1151/2640] 
> [usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.7-10/kernel/drivers/usb+-227113/96]
> Dec  5 20:27:16 notebook kernel:    [<c0125748>] [<c01271b0>] 
> [<c013d213>] [<c013d381>] [<c014e6ff>] [<cf8018d7>]
> Dec  5 20:27:16 notebook kernel:    [load_elf_binary+0/2640] 
> [search_binary_handler+113/384] [do_execve+380/480] [getname+94/160] 
> [sys_execve+48/96] [system_call+51/56]
> Dec  5 20:27:16 notebook kernel:    [<c014e280>] [<c013d991>] 
> [<c013dc1c>] [<c013eade>] [<c0105b60>] [<c0106f2b>]
> Dec  5 20:27:16 notebook kernel:
> Dec  5 20:27:16 notebook kernel: Code: 0f 0b 59 5b 8b 15 0c 01 2b c0 
> 89 f8 29 d0 69 c0 f1 f0 f0 f0
> Dec  5 20:27:16 notebook kernel:  exit_mmap: map count is 11
> Dec  5 20:27:16 notebook kernel: kernel BUG at page_alloc.c:87!
> Dec  5 20:27:16 notebook kernel: invalid operand: 0000
> Dec  5 20:27:16 notebook kernel: CPU:    0
> Dec  5 20:27:16 notebook kernel: EIP:    0010:[__free_pages_ok+64/768]
> Dec  5 20:27:16 notebook kernel: EIP:    0010:[<c012df00>]
> Dec  5 20:27:16 notebook kernel: EFLAGS: 00010282
> Dec  5 20:27:16 notebook kernel: eax: 0000001f   ebx: c12e80d8   ecx: 
> 00000001   edx: 00002eec
> Dec  5 20:27:17 notebook kernel: esi: 55555555   edi: c12e80d8   ebp: 
> 00000000   esp: cbea7b8c
> Dec  5 20:27:17 notebook kernel: ds: 0018   es: 0018   ss: 0018
> Dec  5 20:27:17 notebook kernel: Process sh (pid: 626, 
> stackpage=cbea7000)
> Dec  5 20:27:17 notebook kernel: Stack: c022d0c8 00000057 c1044010 
> c0243764 00000213 ffffffff 000007ef c12e80d8
> Dec  5 20:27:17 notebook kernel:        c12e80d8 00024000 cbea43b0 
> c012eec5 00000000 c1661000 00000000 c51b14c0
> Dec  5 20:27:17 notebook kernel:        c12e80d8 00265000 c0122e96 
> c12e80d8 00000025 00000000 0832d000 cbea5080
> Dec  5 20:27:17 notebook kernel: Call Trace: 
> [call_spurious_interrupt+118835/144011] 
> [free_page_and_swap_cache+197/208] [zap_page_range+422/624] 
> [update_atime+74/80] [do_generic_file_read+1314/1328]
> Dec  5 20:27:17 notebook kernel: Call Trace: [<c022d0c8>] 
> [<c012eec5>] [<c0122e96>] [<c01492ba>] [<c01271a2>] 
> Dec  5 20:27:17 notebook kernel:    [exit_mmap+184/288] 
> [file_read_actor+0/224] [exec_mmap+35/288] [flush_old_exec+113/608] 
> [load_elf_binary+1151/2640] 
> [usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.7-10/kernel/drivers/usb+-227113/96]
> Dec  5 20:27:17 notebook kernel:    [<c0125748>] [<c01271b0>] 
> [<c013d213>] [<c013d381>] [<c014e6ff>] [<cf8018d7>] 
> Dec  5 20:27:17 notebook kernel:    [load_elf_binary+0/2640] 
> [search_binary_handler+113/384] [do_execve+380/480] [getname+94/160] 
> [sys_execve+48/96] [system_call+51/56]
> Dec  5 20:27:17 notebook kernel:    [<c014e280>] [<c013d991>] 
> [<c013dc1c>] [<c013eade>] [<c0105b60>] [<c0106f2b>] 
> Dec  5 20:27:17 notebook kernel:
> Dec  5 20:27:17 notebook kernel: Code: 0f 0b 59 5b 8b 15 0c 01 2b c0 
> 89 f8 29 d0 69 c0 f1 f0 f0 f0 
> Dec  5 20:27:17 notebook kernel:  exit_mmap: map count is 11
> Dec  5 20:29:42 notebook kernel: Unable to handle kernel paging 
> request at virtual address cfcf03fb
> Dec  5 20:29:42 notebook kernel:  printing eip:
> Dec  5 20:29:42 notebook kernel: c0125c8d
> Dec  5 20:29:42 notebook kernel: *pde = 00000000
> Dec  5 20:29:42 notebook kernel: Oops: 0002
> Dec  5 20:29:42 notebook kernel: CPU:    0
> Dec  5 20:29:42 notebook kernel: EIP:    0010:[__set_page_dirty+13/64]
> Dec  5 20:29:42 notebook kernel: EIP:    0010:[<c0125c8d>]
> Dec  5 20:29:42 notebook kernel: EFLAGS: 00010246
> Dec  5 20:29:42 notebook kernel: eax: c12370c0   ebx: cfcf5555   ecx: 
> 00000020   edx: cfcf03f7
> Dec  5 20:29:42 notebook kernel: esi: 00263000   edi: 0006e000   ebp: 
> c722a4d8   esp: c718bbd0
> Dec  5 20:29:42 notebook kernel: ds: 0018   es: 0018   ss: 0018
> Dec  5 20:29:42 notebook kernel: Process sh (pid: 707, 
> stackpage=c718b000)
> Dec  5 20:29:42 notebook kernel: Stack: c12370c0 c0122e8f c12370c0 
> 0000006f 00000000 0832b000 c7268080 080c8000
> Dec  5 20:29:42 notebook kernel:        00000000 0832b000 c7268080 
> cebfa580 00000000 c718bca0 cebfa638 c01492ba 
> Dec  5 20:29:42 notebook kernel:        cebfa580 00000001 c01271a2 
> cebfa580 00001000 cee01d34 00000001 00000000
> Dec  5 20:29:42 notebook kernel: Call Trace: [zap_page_range+415/624] 
> [update_atime+74/80] [do_generic_file_read+1314/1328] 
> [exit_mmap+184/288] [file_read_actor+0/224]
> Dec  5 20:29:42 notebook kernel: Call Trace: [<c0122e8f>] 
> [<c01492ba>] [<c01271a2>] [<c0125748>] [<c01271b0>]
> Dec  5 20:29:42 notebook kernel:    [exec_mmap+35/288] 
> [flush_old_exec+113/608] [load_elf_binary+1151/2640] 
> [usb-uhci:__insmod_usb-uhci_O/lib/modules/2.4.7-10/kernel/drivers/usb+-227113/96] 
> [load_elf_binary+0/2640] [search_binary_handler+113/384]
> Dec  5 20:29:42 notebook kernel:    [<c013d213>] [<c013d381>] 
> [<c014e6ff>] [<cf8018d7>] [<c014e280>] [<c013d991>]
> Dec  5 20:29:42 notebook kernel:    [do_execve+380/480] 
> [getname+94/160] [sys_execve+48/96] [system_call+51/56]
> Dec  5 20:29:42 notebook kernel:    [<c013dc1c>] [<c013eade>] 
> [<c0105b60>] [<c0106f2b>]
> Dec  5 20:29:42 notebook kernel:
> Dec  5 20:29:42 notebook kernel: Code: 89 4a 04 89 11 8d 4b 08 8b 53 
> 08 89 42 04 89 10 89 48 04 89
> Dec  5 20:29:42 notebook kernel:  exit_mmap: map count is 11
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
