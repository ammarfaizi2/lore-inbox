Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271123AbUJUX6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271123AbUJUX6x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271129AbUJUX4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:56:41 -0400
Received: from bonn.shuttle.de ([194.95.249.247]:25808 "EHLO bonn.shuttle.de")
	by vger.kernel.org with ESMTP id S271133AbUJUXsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:48:08 -0400
Date: Fri, 22 Oct 2004 01:42:33 +0200
From: Christian Garbs <mitch@cgarbs.de>
To: linux-kernel@vger.kernel.org
Subject: OOPS with olympic driver in kernel 2.6.9
Message-ID: <20041021234233.GA31739@cgarbs.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
X-Accept-Language: de, en
X-LinuxCounter: Registered Linux User 158702 at http://counter.li.org
X-Virus: Hi! I'm a header virus! Copy me into yours and join the fun!
X-GPG-Key: http://www.h.shuttle.de/mitch/gpg-key
X-GPG-KeyID: E77F37EE
Organization: http://www.cgarbs.de
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello

I'm using Debian testing/unstable on a box with TokenRing networking.
With kernels up to 2.6.8.1 everything was fine.

I tried kernel 2.6.9, but when dhclient runs ifconfig, I get a kernel
oops from the olympic module (see attachments oops-olympic-1 and
config-1).

I've recompiled the kernel with various (aimlessly picked) debugging
options activated, the resulting oops is attached as oops-olympic-2
and config-2.

Both oopses were logged by booting with "init=/bin/sh" (thus the unset
hostname) to bypass my startup scripts that run dhclient.  Before
running /etc/init.d/networking (which triggers dhclient) I've piped
the output from "lsmod" and "ifconfig -a" through logger to be
included in the syslog.

Please have a look at this.  I'll try to give more information when
needed, just tell me what's missing.

Regards,
Christian

PS: Please CC: me on replies to this message as I'm not subscribed to
    this list.

-- 
....Christian.Garbs.....................................http://www.cgarbs.de

knghtbrd: there may be no spoon, but can you spot the vulnerability in
eye_render_shiny_object.c?                                      -- rcw

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=oops-olympic-1

Oct 21 14:46:07 (none) syslogd 1.4.1#15: restart.
Oct 21 14:47:44 (none) kernel: klogd 1.4.1#15, log source = /proc/kmsg started.
Oct 21 14:47:44 (none) kernel: Inspecting /boot/System.map-2.6.9
Oct 21 14:47:45 (none) kernel: Loaded 24004 symbols from /boot/System.map-2.6.9.
Oct 21 14:47:45 (none) kernel: Symbols match kernel version 2.6.9.
Oct 21 14:47:45 (none) kernel: No module symbols loaded - kernel modules not enabled. 
Oct 21 14:47:45 (none) kernel: Linux version 2.6.9 (root@xf030w5c) (gcc version 3.3.4 (Debian 1:3.3.4-13)) #1 Wed Oct 20 10:46:11 CEST 2004
Oct 21 14:47:45 (none) kernel: BIOS-provided physical RAM map:
Oct 21 14:47:45 (none) kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Oct 21 14:47:45 (none) kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Oct 21 14:47:45 (none) kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Oct 21 14:47:45 (none) kernel:  BIOS-e820: 0000000000100000 - 000000000fffd8c0 (usable)
Oct 21 14:47:45 (none) kernel:  BIOS-e820: 000000000fffd8c0 - 0000000010000000 (ACPI data)
Oct 21 14:47:45 (none) kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Oct 21 14:47:45 (none) kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Oct 21 14:47:45 (none) kernel:  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
Oct 21 14:47:45 (none) kernel: 255MB LOWMEM available.
Oct 21 14:47:45 (none) kernel: On node 0 totalpages: 65533
Oct 21 14:47:45 (none) kernel:   DMA zone: 4096 pages, LIFO batch:1
Oct 21 14:47:45 (none) kernel:   Normal zone: 61437 pages, LIFO batch:14
Oct 21 14:47:45 (none) kernel:   HighMem zone: 0 pages, LIFO batch:1
Oct 21 14:47:45 (none) kernel: DMI 2.1 present.
Oct 21 14:47:45 (none) kernel: Built 1 zonelists
Oct 21 14:47:45 (none) kernel: Kernel command line: BOOT_IMAGE=Linux ro root=801 init=/bin/sh
Oct 21 14:47:45 (none) kernel: No local APIC present or hardware disabled
Oct 21 14:47:45 (none) kernel: Initializing CPU#0
Oct 21 14:47:45 (none) kernel: PID hash table entries: 1024 (order: 10, 16384 bytes)
Oct 21 14:47:45 (none) kernel: Detected 348.629 MHz processor.
Oct 21 14:47:45 (none) kernel: Using tsc for high-res timesource
Oct 21 14:47:45 (none) kernel: Console: colour VGA+ 80x25
Oct 21 14:47:45 (none) kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Oct 21 14:47:45 (none) kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Oct 21 14:47:45 (none) kernel: Memory: 256728k/262132k available (1324k kernel code, 4788k reserved, 520k data, 348k init, 0k highmem)
Oct 21 14:47:45 (none) kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Oct 21 14:47:45 (none) kernel: Calibrating delay loop... 688.12 BogoMIPS (lpj=344064)
Oct 21 14:47:45 (none) kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Oct 21 14:47:45 (none) kernel: CPU: After generic identify, caps: 0183f9ff 00000000 00000000 00000000
Oct 21 14:47:45 (none) kernel: CPU: After vendor identify, caps:  0183f9ff 00000000 00000000 00000000
Oct 21 14:47:45 (none) kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Oct 21 14:47:45 (none) kernel: CPU: L2 cache: 512K
Oct 21 14:47:45 (none) kernel: CPU: After all inits, caps:        0183f9ff 00000000 00000000 00000040
Oct 21 14:47:45 (none) kernel: Intel machine check architecture supported.
Oct 21 14:47:45 (none) kernel: Intel machine check reporting enabled on CPU#0.
Oct 21 14:47:45 (none) kernel: CPU: Intel Pentium II (Deschutes) stepping 02
Oct 21 14:47:45 (none) kernel: Enabling fast FPU save and restore... done.
Oct 21 14:47:45 (none) kernel: Checking 'hlt' instruction... OK.
Oct 21 14:47:45 (none) kernel: NET: Registered protocol family 16
Oct 21 14:47:45 (none) kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd85c, last bus=1
Oct 21 14:47:45 (none) kernel: PCI: Using configuration type 1
Oct 21 14:47:45 (none) kernel: mtrr: v2.0 (20020519)
Oct 21 14:47:45 (none) kernel: SCSI subsystem initialized
Oct 21 14:47:45 (none) kernel: PCI: Probing PCI hardware
Oct 21 14:47:45 (none) kernel: PCI: Probing PCI hardware (bus 00)
Oct 21 14:47:45 (none) kernel: PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:02.0
Oct 21 14:47:45 (none) kernel: PCI: IRQ 0 for device 0000:00:02.2 doesn't match PIRQ mask - try pci=usepirqmask
Oct 21 14:47:45 (none) kernel: devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
Oct 21 14:47:45 (none) kernel: devfs: boot_options: 0x0
Oct 21 14:47:45 (none) kernel: Limiting direct PCI/PCI transfers.
Oct 21 14:47:45 (none) kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Oct 21 14:47:45 (none) kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Oct 21 14:47:45 (none) kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Oct 21 14:47:45 (none) kernel: PCI: Found IRQ 9 for device 0000:00:12.0
Oct 21 14:47:45 (none) kernel: PCI: Sharing IRQ 9 with 0000:01:01.0
Oct 21 14:47:45 (none) kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
Oct 21 14:47:45 (none) kernel:         <Adaptec 2940 Ultra SCSI adapter>
Oct 21 14:47:45 (none) kernel:         aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs
Oct 21 14:47:45 (none) kernel: 
Oct 21 14:47:45 (none) kernel: Using anticipatory io scheduler
Oct 21 14:47:45 (none) kernel: (scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
Oct 21 14:47:45 (none) kernel:   Vendor: IBM-PSG   Model: DNES-309170W  !#  Rev: SAB0
Oct 21 14:47:45 (none) kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Oct 21 14:47:45 (none) kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 8
Oct 21 14:47:45 (none) kernel: (scsi0:A:3): 20.000MB/s transfers (20.000MHz, offset 15)
Oct 21 14:47:45 (none) kernel:   Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
Oct 21 14:47:45 (none) kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Oct 21 14:47:45 (none) kernel: SCSI device sda: 17774160 512-byte hdwr sectors (9100 MB)
Oct 21 14:47:45 (none) kernel: SCSI device sda: drive cache: write through
Oct 21 14:47:45 (none) kernel:  /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
Oct 21 14:47:45 (none) kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Oct 21 14:47:45 (none) kernel: sr0: scsi-1 drive
Oct 21 14:47:45 (none) kernel: Uniform CD-ROM driver Revision: 3.20
Oct 21 14:47:45 (none) kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
Oct 21 14:47:45 (none) kernel: mice: PS/2 mouse device common for all mice
Oct 21 14:47:45 (none) kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Oct 21 14:47:45 (none) kernel: input: PS/2 Generic Mouse on isa0060/serio1
Oct 21 14:47:45 (none) kernel: NET: Registered protocol family 2
Oct 21 14:47:45 (none) kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Oct 21 14:47:45 (none) kernel: TCP: Hash tables configured (established 16384 bind 32768)
Oct 21 14:47:45 (none) kernel: kjournald starting.  Commit interval 5 seconds
Oct 21 14:47:45 (none) kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 21 14:47:45 (none) kernel: VFS: Mounted root (ext3 filesystem) readonly.
Oct 21 14:47:45 (none) kernel: Freeing unused kernel memory: 348k freed
Oct 21 14:47:45 (none) kernel: NET: Registered protocol family 1
Oct 21 14:47:45 (none) kernel: kjournald starting.  Commit interval 5 seconds
Oct 21 14:47:45 (none) kernel: EXT3 FS on sda3, internal journal
Oct 21 14:47:45 (none) kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 21 14:47:45 (none) kernel: EXT3 FS on sda1, internal journal
Oct 21 14:48:20 (none) kernel: PCI: Found IRQ 15 for device 0000:00:10.0
Oct 21 14:48:20 (none) kernel: Olympic.c v1.0.5 6/04/02 - Peter De Schrijver & Mike Phillips 
Oct 21 14:48:20 (none) kernel: 0000:00:10.0. I/O at 7400, MMIO at d0806700, LAP at d0808800, using irq 15
Oct 21 14:48:23 (none) kernel: Olympic: 0000:00:10.0 registered as: tr0
Oct 21 14:48:32 (none) logger: Module                  Size  Used by
Oct 21 14:48:32 (none) logger: olympic                22176  0 
Oct 21 14:48:32 (none) logger: unix                   25876  4 
Oct 21 14:48:49 (none) logger: lo        Link encap:Local Loopback  
Oct 21 14:48:49 (none) logger:           LOOPBACK  MTU:16436  Metric:1
Oct 21 14:48:49 (none) logger:           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
Oct 21 14:48:49 (none) logger:           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
Oct 21 14:48:49 (none) logger:           collisions:0 txqueuelen:0 
Oct 21 14:48:49 (none) logger:           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
Oct 21 14:48:49 (none) logger: 
Oct 21 14:48:49 (none) logger: tr0       Link encap:16/4 Mbps Token Ring (New)  HWaddr 00:06:29:C2:F5:41  
Oct 21 14:48:49 (none) logger:           BROADCAST MULTICAST  MTU:4056  Metric:1
Oct 21 14:48:49 (none) logger:           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
Oct 21 14:48:49 (none) logger:           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
Oct 21 14:48:49 (none) logger:           collisions:0 txqueuelen:100 
Oct 21 14:48:49 (none) logger:           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
Oct 21 14:48:49 (none) logger:           Interrupt:15 Base address:0x7400 
Oct 21 14:48:49 (none) logger: 
Oct 21 14:48:56 (none) dhclient: Internet Software Consortium DHCP Client 2.0pl5
Oct 21 14:48:56 (none) dhclient: Copyright 1995, 1996, 1997, 1998, 1999 The Internet Software Consortium.
Oct 21 14:48:56 (none) dhclient: All rights reserved.
Oct 21 14:48:56 (none) dhclient: 
Oct 21 14:48:56 (none) dhclient: Please contribute if you find this software useful.
Oct 21 14:48:56 (none) dhclient: For info, please visit http://www.isc.org/dhcp-contrib.html
Oct 21 14:48:56 (none) dhclient: 
Oct 21 14:48:56 (none) kernel: Unable to handle kernel paging request at virtual address d081e290
Oct 21 14:48:56 (none) kernel:  printing eip:
Oct 21 14:48:56 (none) kernel: d081e290
Oct 21 14:48:56 (none) kernel: *pde = 01322067
Oct 21 14:48:56 (none) kernel: *pte = 00000000
Oct 21 14:48:56 (none) kernel: Oops: 0000 [#1]
Oct 21 14:48:56 (none) kernel: Modules linked in: olympic unix
Oct 21 14:48:56 (none) kernel: CPU:    0
Oct 21 14:48:56 (none) kernel: EIP:    0060:[pg0+273547920/1070334976]    Not tainted VLI
Oct 21 14:48:56 (none) kernel: EFLAGS: 00010286   (2.6.9) 
Oct 21 14:48:56 (none) kernel: EIP is at 0xd081e290
Oct 21 14:48:56 (none) kernel: eax: cf559800   ebx: c0113f10   ecx: 00000000   edx: cf665aa0
Oct 21 14:48:56 (none) kernel: esi: cf682000   edi: c0113f10   ebp: cf559a20   esp: cf683d5c
Oct 21 14:48:56 (none) kernel: ds: 007b   es: 007b   ss: 0068
Oct 21 14:48:56 (none) kernel: Process ifconfig (pid: 94, threadinfo=cf682000 task=cf665aa0)
Oct 21 14:48:56 (none) kernel: Stack: d0817073 00000001 cf681000 cf67fb80 00000001 cf65cee8 cf5d38e0 cf5d390c 
Oct 21 14:48:56 (none) kernel:        cf65cee8 cf665aa0 c0112664 00000001 00000000 00000001 d0806700 cf559800 
Oct 21 14:48:56 (none) kernel:        00000000 cf665aa0 c0113f10 00000000 00000000 0000000f c13faed0 00000138 
Oct 21 14:48:56 (none) kernel: Call Trace:
Oct 21 14:48:56 (none) kernel:  [pg0+273518707/1070334976] olympic_open+0x73/0x850 [olympic]
Oct 21 14:48:56 (none) kernel:  [do_page_fault+388/1400] do_page_fault+0x184/0x578
Oct 21 14:48:56 (none) kernel:  [default_wake_function+0/16] default_wake_function+0x0/0x10
Oct 21 14:48:56 (none) kernel:  [default_wake_function+0/16] default_wake_function+0x0/0x10
Oct 21 14:48:56 (none) kernel:  [__copy_to_user_ll+89/96] __copy_to_user_ll+0x59/0x60
Oct 21 14:48:56 (none) kernel:  [file_read_actor+197/224] file_read_actor+0xc5/0xe0
Oct 21 14:48:56 (none) kernel:  [buffered_rmqueue+197/336] buffered_rmqueue+0xc5/0x150
Oct 21 14:48:56 (none) kernel:  [buffered_rmqueue+197/336] buffered_rmqueue+0xc5/0x150
Oct 21 14:48:56 (none) kernel:  [proc_alloc_inode+65/112] proc_alloc_inode+0x41/0x70
Oct 21 14:48:56 (none) kernel:  [filemap_nopage+461/800] filemap_nopage+0x1cd/0x320
Oct 21 14:48:56 (none) kernel:  [wake_up_inode+8/48] wake_up_inode+0x8/0x30
Oct 21 14:48:56 (none) kernel:  [do_no_page+359/672] do_no_page+0x167/0x2a0
Oct 21 14:48:56 (none) kernel:  [do_wp_page+357/704] do_wp_page+0x165/0x2c0
Oct 21 14:48:56 (none) kernel:  [handle_mm_fault+190/288] handle_mm_fault+0xbe/0x120
Oct 21 14:48:56 (none) kernel:  [dev_open+116/144] dev_open+0x74/0x90
Oct 21 14:48:56 (none) kernel:  [dev_change_flags+72/272] dev_change_flags+0x48/0x110
Oct 21 14:48:56 (none) kernel:  [devinet_ioctl+585/1600] devinet_ioctl+0x249/0x640
Oct 21 14:48:56 (none) kernel:  [inet_ioctl+103/176] inet_ioctl+0x67/0xb0
Oct 21 14:48:56 (none) kernel:  [sock_ioctl+194/576] sock_ioctl+0xc2/0x240
Oct 21 14:48:56 (none) kernel:  [sys_ioctl+191/528] sys_ioctl+0xbf/0x210
Oct 21 14:48:56 (none) kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 21 14:48:56 (none) kernel: Code:  Bad EIP value.

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config-1

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_SHMEM=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MPENTIUMII=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
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
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_REGPARM=y
CONFIG_PM=y
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_APM=m
CONFIG_APM_RTC_IS_GMT=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASKFILE_IO=y
CONFIG_IDE_GENERIC=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_OPTI621=m
CONFIG_BLK_DEV_RZ1000=m
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_AEC62XX=m
CONFIG_BLK_DEV_ALI15X3=m
CONFIG_BLK_DEV_AMD74XX=m
CONFIG_BLK_DEV_CMD64X=m
CONFIG_BLK_DEV_CY82C693=m
CONFIG_BLK_DEV_CS5530=m
CONFIG_BLK_DEV_HPT34X=m
CONFIG_BLK_DEV_HPT366=m
CONFIG_BLK_DEV_PIIX=m
CONFIG_BLK_DEV_NS87415=m
CONFIG_BLK_DEV_SVWKS=m
CONFIG_BLK_DEV_SIS5513=m
CONFIG_BLK_DEV_SLC90E66=m
CONFIG_BLK_DEV_TRM290=m
CONFIG_BLK_DEV_VIA82CXXX=m
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_QLA2XXX=y
CONFIG_NET=y
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_SYN_COOKIES=y
CONFIG_NETFILTER=y
CONFIG_LLC=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_TR=y
CONFIG_IBMTR=m
CONFIG_IBMOL=m
CONFIG_IBMLS=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
CONFIG_PRINTER=m
CONFIG_PPDEV=m
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_MWAVE=m
CONFIG_FB=y
CONFIG_FB_VGA16=m
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_SOUND=m
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_JFS_FS=m
CONFIG_MINIX_FS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVFS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_HPFS_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp850"
CONFIG_NCP_FS=m
CONFIG_NCPFS_NLS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp850"
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
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_EARLY_PRINTK=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_ZLIB_INFLATE=m
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=oops-olympic-2

Oct 21 18:15:05 (none) syslogd 1.4.1#15: restart.
Oct 21 18:15:13 (none) kernel: klogd 1.4.1#15, log source = /proc/kmsg started.
Oct 21 18:15:13 (none) kernel: Cannot find map file.
Oct 21 18:15:13 (none) kernel: No module symbols loaded - kernel modules not enabled. 
Oct 21 18:15:13 (none) kernel: Linux version 2.6.9debug (root@xf030w5c) (gcc version 3.3.4 (Debian 1:3.3.4-13)) #3 Thu Oct 21 16:54:17 CEST 2004
Oct 21 18:15:13 (none) kernel: BIOS-provided physical RAM map:
Oct 21 18:15:13 (none) kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Oct 21 18:15:13 (none) kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Oct 21 18:15:13 (none) kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Oct 21 18:15:13 (none) kernel:  BIOS-e820: 0000000000100000 - 000000000fffd8c0 (usable)
Oct 21 18:15:13 (none) kernel:  BIOS-e820: 000000000fffd8c0 - 0000000010000000 (ACPI data)
Oct 21 18:15:13 (none) kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Oct 21 18:15:13 (none) kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Oct 21 18:15:13 (none) kernel:  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
Oct 21 18:15:13 (none) kernel: 255MB LOWMEM available.
Oct 21 18:15:13 (none) kernel: On node 0 totalpages: 65533
Oct 21 18:15:13 (none) kernel:   DMA zone: 4096 pages, LIFO batch:1
Oct 21 18:15:13 (none) kernel:   Normal zone: 61437 pages, LIFO batch:14
Oct 21 18:15:13 (none) kernel:   HighMem zone: 0 pages, LIFO batch:1
Oct 21 18:15:13 (none) kernel: DMI 2.1 present.
Oct 21 18:15:13 (none) kernel: Built 1 zonelists
Oct 21 18:15:13 (none) kernel: Kernel command line: BOOT_IMAGE=Linux ro root=801 init=/bin/sh
Oct 21 18:15:13 (none) kernel: No local APIC present or hardware disabled
Oct 21 18:15:13 (none) kernel: Initializing CPU#0
Oct 21 18:15:13 (none) kernel: PID hash table entries: 1024 (order: 10, 16384 bytes)
Oct 21 18:15:13 (none) kernel: Detected 348.536 MHz processor.
Oct 21 18:15:13 (none) kernel: Using tsc for high-res timesource
Oct 21 18:15:13 (none) kernel: Console: colour VGA+ 80x25
Oct 21 18:15:13 (none) kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Oct 21 18:15:13 (none) kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Oct 21 18:15:13 (none) kernel: Memory: 256720k/262132k available (1335k kernel code, 4796k reserved, 518k data, 348k init, 0k highmem)
Oct 21 18:15:13 (none) kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Oct 21 18:15:13 (none) kernel: Calibrating delay loop... 686.08 BogoMIPS (lpj=343040)
Oct 21 18:15:13 (none) kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Oct 21 18:15:13 (none) kernel: CPU: After generic identify, caps: 0183f9ff 00000000 00000000 00000000
Oct 21 18:15:13 (none) kernel: CPU: After vendor identify, caps:  0183f9ff 00000000 00000000 00000000
Oct 21 18:15:13 (none) kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Oct 21 18:15:13 (none) kernel: CPU: L2 cache: 512K
Oct 21 18:15:13 (none) kernel: CPU: After all inits, caps:        0183f9ff 00000000 00000000 00000040
Oct 21 18:15:13 (none) kernel: Intel machine check architecture supported.
Oct 21 18:15:13 (none) kernel: Intel machine check reporting enabled on CPU#0.
Oct 21 18:15:13 (none) kernel: CPU: Intel Pentium II (Deschutes) stepping 02
Oct 21 18:15:13 (none) kernel: Enabling fast FPU save and restore... done.
Oct 21 18:15:13 (none) kernel: Checking 'hlt' instruction... OK.
Oct 21 18:15:13 (none) kernel: NET: Registered protocol family 16
Oct 21 18:15:13 (none) kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd85c, last bus=1
Oct 21 18:15:13 (none) kernel: PCI: Using configuration type 1
Oct 21 18:15:13 (none) kernel: mtrr: v2.0 (20020519)
Oct 21 18:15:13 (none) kernel: SCSI subsystem initialized
Oct 21 18:15:13 (none) kernel: PCI: Probing PCI hardware
Oct 21 18:15:13 (none) kernel: PCI: Probing PCI hardware (bus 00)
Oct 21 18:15:13 (none) kernel: PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:02.0
Oct 21 18:15:13 (none) kernel: PCI: IRQ 0 for device 0000:00:02.2 doesn't match PIRQ mask - try pci=usepirqmask
Oct 21 18:15:13 (none) kernel: devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
Oct 21 18:15:13 (none) kernel: devfs: boot_options: 0x0
Oct 21 18:15:13 (none) kernel: Limiting direct PCI/PCI transfers.
Oct 21 18:15:13 (none) kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Oct 21 18:15:13 (none) kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Oct 21 18:15:13 (none) kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Oct 21 18:15:13 (none) kernel: PCI: Found IRQ 9 for device 0000:00:12.0
Oct 21 18:15:13 (none) kernel: PCI: Sharing IRQ 9 with 0000:01:01.0
Oct 21 18:15:13 (none) kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
Oct 21 18:15:13 (none) kernel:         <Adaptec 2940 Ultra SCSI adapter>
Oct 21 18:15:14 (none) kernel:         aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs
Oct 21 18:15:14 (none) kernel: 
Oct 21 18:15:14 (none) kernel: Using anticipatory io scheduler
Oct 21 18:15:14 (none) kernel: (scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
Oct 21 18:15:14 (none) kernel:   Vendor: IBM-PSG   Model: DNES-309170W  !#  Rev: SAB0
Oct 21 18:15:14 (none) kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Oct 21 18:15:14 (none) kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 8
Oct 21 18:15:14 (none) kernel: (scsi0:A:3): 20.000MB/s transfers (20.000MHz, offset 15)
Oct 21 18:15:14 (none) kernel:   Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
Oct 21 18:15:14 (none) kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Oct 21 18:15:14 (none) kernel: SCSI device sda: 17774160 512-byte hdwr sectors (9100 MB)
Oct 21 18:15:14 (none) kernel: SCSI device sda: drive cache: write through
Oct 21 18:15:14 (none) kernel:  /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
Oct 21 18:15:14 (none) kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Oct 21 18:15:14 (none) kernel: sr0: scsi-1 drive
Oct 21 18:15:14 (none) kernel: Uniform CD-ROM driver Revision: 3.20
Oct 21 18:15:14 (none) kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
Oct 21 18:15:14 (none) kernel: mice: PS/2 mouse device common for all mice
Oct 21 18:15:14 (none) kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Oct 21 18:15:14 (none) kernel: input: PS/2 Generic Mouse on isa0060/serio1
Oct 21 18:15:14 (none) kernel: NET: Registered protocol family 2
Oct 21 18:15:14 (none) kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Oct 21 18:15:14 (none) kernel: TCP: Hash tables configured (established 16384 bind 32768)
Oct 21 18:15:14 (none) kernel: kjournald starting.  Commit interval 5 seconds
Oct 21 18:15:14 (none) kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 21 18:15:14 (none) kernel: VFS: Mounted root (ext3 filesystem) readonly.
Oct 21 18:15:14 (none) kernel: Freeing unused kernel memory: 348k freed
Oct 21 18:15:14 (none) kernel: NET: Registered protocol family 1
Oct 21 18:15:14 (none) kernel: EXT3 FS on sda1, internal journal
Oct 21 18:15:14 (none) kernel: kjournald starting.  Commit interval 5 seconds
Oct 21 18:15:14 (none) kernel: EXT3 FS on sda3, internal journal
Oct 21 18:15:14 (none) kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 21 18:15:24 (none) kernel: PCI: Found IRQ 15 for device 0000:00:10.0
Oct 21 18:15:24 (none) kernel: Olympic.c v1.0.5 6/04/02 - Peter De Schrijver & Mike Phillips 
Oct 21 18:15:24 (none) kernel: 0000:00:10.0. I/O at 7400, MMIO at d0806700, LAP at d0808800, using irq 15
Oct 21 18:15:27 (none) kernel: Olympic: 0000:00:10.0 registered as: tr0
Oct 21 18:15:32 (none) logger: Module                  Size  Used by
Oct 21 18:15:32 (none) logger: olympic                22432  0 
Oct 21 18:15:32 (none) logger: unix                   25972  4 
Oct 21 18:15:48 (none) logger: lo        Link encap:Local Loopback  
Oct 21 18:15:48 (none) logger:           LOOPBACK  MTU:16436  Metric:1
Oct 21 18:15:48 (none) logger:           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
Oct 21 18:15:48 (none) logger:           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
Oct 21 18:15:48 (none) logger:           collisions:0 txqueuelen:0 
Oct 21 18:15:48 (none) logger:           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
Oct 21 18:15:48 (none) logger: 
Oct 21 18:15:48 (none) logger: tr0       Link encap:16/4 Mbps Token Ring (New)  HWaddr 00:06:29:C2:F5:41  
Oct 21 18:15:48 (none) logger:           BROADCAST MULTICAST  MTU:4056  Metric:1
Oct 21 18:15:48 (none) logger:           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
Oct 21 18:15:48 (none) logger:           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
Oct 21 18:15:48 (none) logger:           collisions:0 txqueuelen:100 
Oct 21 18:15:48 (none) logger:           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
Oct 21 18:15:48 (none) logger:           Interrupt:15 Base address:0x7400 
Oct 21 18:15:48 (none) logger: 
Oct 21 18:16:11 (none) dhclient: Internet Software Consortium DHCP Client 2.0pl5
Oct 21 18:16:11 (none) dhclient: Copyright 1995, 1996, 1997, 1998, 1999 The Internet Software Consortium.
Oct 21 18:16:11 (none) dhclient: All rights reserved.
Oct 21 18:16:11 (none) dhclient: 
Oct 21 18:16:11 (none) dhclient: Please contribute if you find this software useful.
Oct 21 18:16:11 (none) dhclient: For info, please visit http://www.isc.org/dhcp-contrib.html
Oct 21 18:16:11 (none) dhclient: 
Oct 21 18:16:11 (none) kernel: Unable to handle kernel paging request at virtual address d08482a0
Oct 21 18:16:11 (none) kernel:  printing eip:
Oct 21 18:16:11 (none) kernel: d08482a0
Oct 21 18:16:11 (none) kernel: *pde = 01322067
Oct 21 18:16:11 (none) kernel: *pte = 00000000
Oct 21 18:16:11 (none) kernel: Oops: 0000 [#1]
Oct 21 18:16:11 (none) kernel: Modules linked in: olympic unix
Oct 21 18:16:11 (none) kernel: CPU:    0
Oct 21 18:16:11 (none) kernel: EIP:    0060:[<d08482a0>]    Not tainted VLI
Oct 21 18:16:11 (none) kernel: EFLAGS: 00010286   (2.6.9debug) 
Oct 21 18:16:11 (none) kernel: EIP is at 0xd08482a0
Oct 21 18:16:11 (none) kernel: eax: cfb1d800   ebx: cfb1d800   ecx: 00000000   edx: cfbb7020
Oct 21 18:16:11 (none) kernel: esi: cf4ce000   edi: cf4cfd94   ebp: cf4cfecc   esp: cf4cfd34
Oct 21 18:16:11 (none) kernel: ds: 007b   es: 007b   ss: 0068
Oct 21 18:16:11 (none) kernel: Process ifconfig (pid: 64, threadinfo=cf4ce000 task=cfbb7020)
Oct 21 18:16:11 (none) kernel: Stack: d0841099 cf4cfd60 c013bb22 00000001 cf4c7000 cf4c3b80 00000001 cfb884bc 
Oct 21 18:16:11 (none) kernel:        cf459b00 cf459b2c cfb884bc cf4cfe28 c0295284 c11e99a0 c0295284 00000001 
Oct 21 18:16:11 (none) kernel:        d0806700 cfb1da20 cfb1d800 00000000 cfbb7020 c01146d0 00000000 00000000 
Oct 21 18:16:11 (none) kernel: Call Trace:
Oct 21 18:16:11 (none) kernel:  [<c010696a>] show_stack+0x7a/0x90
Oct 21 18:16:11 (none) kernel:  [<c0106ae9>] show_registers+0x149/0x1b0
Oct 21 18:16:11 (none) kernel:  [<c0106cbb>] die+0xbb/0x140
Oct 21 18:16:11 (none) kernel:  [<c0112ef1>] do_page_fault+0x2d1/0x5b8
Oct 21 18:16:11 (none) kernel:  [<c0106599>] error_code+0x2d/0x38
Oct 21 18:16:11 (none) kernel:  [<c020a674>] dev_open+0x74/0x90
Oct 21 18:16:11 (none) kernel:  [<c020b972>] dev_change_flags+0x52/0x120
Oct 21 18:16:11 (none) kernel:  [<c0241eb5>] devinet_ioctl+0x245/0x660
Oct 21 18:16:11 (none) kernel:  [<c0243f23>] inet_ioctl+0x63/0xb0
Oct 21 18:16:11 (none) kernel:  [<c02026b2>] sock_ioctl+0xb2/0x230
Oct 21 18:16:11 (none) kernel:  [<c0157ad7>] sys_ioctl+0xb7/0x210
Oct 21 18:16:11 (none) kernel:  [<c0105b8f>] syscall_call+0x7/0xb
Oct 21 18:16:11 (none) kernel: Code:  Bad EIP value.

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config-2

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCALVERSION="debug"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_SHMEM=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MPENTIUMII=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
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
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_REGPARM=y
CONFIG_PM=y
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_APM=m
CONFIG_APM_RTC_IS_GMT=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASKFILE_IO=y
CONFIG_IDE_GENERIC=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_OPTI621=m
CONFIG_BLK_DEV_RZ1000=m
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_AEC62XX=m
CONFIG_BLK_DEV_ALI15X3=m
CONFIG_BLK_DEV_AMD74XX=m
CONFIG_BLK_DEV_CMD64X=m
CONFIG_BLK_DEV_CY82C693=m
CONFIG_BLK_DEV_CS5530=m
CONFIG_BLK_DEV_HPT34X=m
CONFIG_BLK_DEV_HPT366=m
CONFIG_BLK_DEV_PIIX=m
CONFIG_BLK_DEV_NS87415=m
CONFIG_BLK_DEV_SVWKS=m
CONFIG_BLK_DEV_SIS5513=m
CONFIG_BLK_DEV_SLC90E66=m
CONFIG_BLK_DEV_TRM290=m
CONFIG_BLK_DEV_VIA82CXXX=m
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_QLA2XXX=y
CONFIG_NET=y
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_SYN_COOKIES=y
CONFIG_NETFILTER=y
CONFIG_LLC=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_TR=y
CONFIG_IBMTR=m
CONFIG_IBMOL=m
CONFIG_IBMLS=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
CONFIG_PRINTER=m
CONFIG_PPDEV=m
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_MWAVE=m
CONFIG_FB=y
CONFIG_FB_VGA16=m
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_SOUND=m
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_JFS_FS=m
CONFIG_MINIX_FS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVFS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_HPFS_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp850"
CONFIG_NCP_FS=m
CONFIG_NCPFS_NLS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp850"
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
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_INFO=y
CONFIG_FRAME_POINTER=y
CONFIG_EARLY_PRINTK=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_ZLIB_INFLATE=m
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--HcAYCG3uE/tztfnV--

