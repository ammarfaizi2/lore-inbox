Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbTFOS1t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTFOS1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:27:49 -0400
Received: from ajlill.sentex.ca ([64.7.134.25]:23236 "EHLO
	spider.ajlc.waterloo.on.ca") by vger.kernel.org with ESMTP
	id S262547AbTFOSZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:25:21 -0400
Message-Id: <200306151839.h5FIdBFL006301@spider.ajlc.waterloo.on.ca>
To: linux-kernel@vger.kernel.org
Subject: help with 2.5.70 on Dell inspiron - no display
Content-Type: text/plain; charset=US-ASCII
From: Tony Lill <ajlill@tardis.ajlc.waterloo.on.ca>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Military Intelligence)
MIME-Version: 1.0
Date: Sun, 15 Jun 2003 14:39:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been playing wiht 2.5.70 on my laptop, but I can't get any screen
output. The Inspiron uses a
VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 100).
according to /proc/pci. I started wiht a working .config from my 2.4
kernel and did make oldconfig, and I've been playing wiht the
framebuffer and console options, but the best I've been able to do is
get the cursor to appear, but no text. I know the box is booting
beacuse the cursor moves like it's writin output.

Help!

Here's the syslog output and my current .config file

Jun  3 21:20:09 tardis kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jun  3 21:20:09 tardis kernel: Linux version 2.5.70 (root@tardis.ajlc.waterloo.on.ca) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #4 Mon Jun 2 00:39:44 EDT 2003
Jun  3 21:20:09 tardis kernel: Video mode to be used for restore is ffff
Jun  3 21:20:09 tardis kernel: BIOS-provided physical RAM map:
Jun  3 21:20:09 tardis kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Jun  3 21:20:09 tardis kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Jun  3 21:20:09 tardis kernel:  BIOS-e820: 00000000000ea000 - 0000000000100000 (reserved)
Jun  3 21:20:09 tardis kernel:  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
Jun  3 21:20:09 tardis kernel:  BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI data)
Jun  3 21:20:09 tardis kernel:  BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)
Jun  3 21:20:09 tardis kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Jun  3 21:20:09 tardis kernel: 255MB LOWMEM available.
Jun  3 21:20:09 tardis kernel: On node 0 totalpages: 65520
Jun  3 21:20:09 tardis kernel:   DMA zone: 4096 pages, LIFO batch:1
Jun  3 21:20:09 tardis kernel:   Normal zone: 61424 pages, LIFO batch:14
Jun  3 21:20:09 tardis kernel:   HighMem zone: 0 pages, LIFO batch:1
Jun  3 21:20:09 tardis kernel: Dell Inspiron with broken BIOS detected. Refusing to enable the local APIC.
Jun  3 21:20:09 tardis kernel: Building zonelist for node : 0
Jun  3 21:20:09 tardis kernel: Kernel command line: auto BOOT_IMAGE=new ro root=302 BOOT_FILE=/boot/vmlinuz-2.5.70 SCHEME=home
Jun  3 21:20:09 tardis kernel: Initializing CPU#0
Jun  3 21:20:09 tardis kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Jun  3 21:20:09 tardis kernel: Detected 697.126 MHz processor.
Jun  3 21:20:09 tardis kernel: Calibrating delay loop... 1376.25 BogoMIPS
Jun  3 21:20:09 tardis kernel: Memory: 256096k/262080k available (1671k kernel code, 5252k reserved, 658k data, 132k init, 0k highmem)
Jun  3 21:20:09 tardis kernel: Security Scaffold v1.0.0 initialized
Jun  3 21:20:09 tardis kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Jun  3 21:20:09 tardis kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Jun  3 21:20:09 tardis kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Jun  3 21:20:09 tardis kernel: -> /dev
Jun  3 21:20:09 tardis kernel: -> /dev/console
Jun  3 21:20:09 tardis kernel: -> /root
Jun  3 21:20:09 tardis kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jun  3 21:20:09 tardis kernel: CPU: L2 cache: 256K
Jun  3 21:20:09 tardis kernel: CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000040
Jun  3 21:20:09 tardis kernel: Intel machine check architecture supported.
Jun  3 21:20:09 tardis kernel: Intel machine check reporting enabled on CPU#0.
Jun  3 21:20:09 tardis kernel: CPU: Intel Pentium III (Coppermine) stepping 03
Jun  3 21:20:09 tardis kernel: Enabling fast FPU save and restore... done.
Jun  3 21:20:09 tardis kernel: Enabling unmasked SIMD FPU exception support... done.
Jun  3 21:20:09 tardis kernel: Checking 'hlt' instruction... OK.
Jun  3 21:20:09 tardis kernel: POSIX conformance testing by UNIFIX
Jun  3 21:20:09 tardis kernel: mtrr: v2.0 (20020519)
Jun  3 21:20:09 tardis kernel: Initializing RT netlink socket
Jun  3 21:20:09 tardis kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd9ae, last bus=1
Jun  3 21:20:09 tardis kernel: PCI: Using configuration type 1
Jun  3 21:20:09 tardis kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Jun  3 21:20:09 tardis kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
Jun  3 21:20:09 tardis kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
Jun  3 21:20:09 tardis kernel: biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
Jun  3 21:20:09 tardis kernel: biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
Jun  3 21:20:09 tardis kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
Jun  3 21:20:09 tardis kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Jun  3 21:20:09 tardis kernel: Linux Plug and Play Support v0.96 (c) Adam Belay
Jun  3 21:20:09 tardis kernel: block request queues:
Jun  3 21:20:09 tardis kernel:  4/128 requests per read queue
Jun  3 21:20:09 tardis kernel:  4/128 requests per write queue
Jun  3 21:20:09 tardis kernel:  enter congestion at 15
Jun  3 21:20:09 tardis kernel:  exit congestion at 17
Jun  3 21:20:09 tardis kernel: PCI: Probing PCI hardware
Jun  3 21:20:09 tardis kernel: PCI: Probing PCI hardware (bus 00)
Jun  3 21:20:09 tardis kernel: PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Jun  3 21:20:09 tardis kernel: PCI: IRQ 0 for device 00:04.0 doesn't match PIRQ mask - try pci=usepirqmask
Jun  3 21:20:09 tardis kernel: PCI: Found IRQ 11 for device 00:04.0
Jun  3 21:20:09 tardis kernel: PCI: Sharing IRQ 11 with 00:04.1
Jun  3 21:20:09 tardis kernel: PCI: Sharing IRQ 11 with 01:00.0
Jun  3 21:20:09 tardis kernel: PCI: Cannot allocate resource region 4 of device 00:07.1
Jun  3 21:20:09 tardis kernel: SBF: ACPI BOOT descriptor is wrong length (39)
Jun  3 21:20:09 tardis kernel: SBF: Simple Boot Flag extension found and enabled.
Jun  3 21:20:09 tardis kernel: SBF: Setting boot flags 0x1
Jun  3 21:20:09 tardis kernel: Machine check exception polling timer started.
Jun  3 21:20:09 tardis kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Jun  3 21:20:09 tardis kernel: Enabling SEP on CPU 0
Jun  3 21:20:09 tardis kernel: Journalled Block Device driver loaded
Jun  3 21:20:09 tardis kernel: Initializing Cryptographic API
Jun  3 21:20:09 tardis kernel: Limiting direct PCI/PCI transfers.
Jun  3 21:20:09 tardis kernel: pty: 256 Unix98 ptys configured
Jun  3 21:20:09 tardis kernel: Real Time Clock Driver v1.11
Jun  3 21:20:09 tardis kernel: Floppy drive(s): fd0 is 1.44M
Jun  3 21:20:09 tardis kernel: FDC 0 is a post-1991 82077
Jun  3 21:20:09 tardis kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Jun  3 21:20:09 tardis kernel: Compaq CISS Driver (v 2.5.0)
Jun  3 21:20:09 tardis kernel: v2.3 : Micro Memory(tm) PCI memory board block driver
Jun  3 21:20:09 tardis kernel: MM: desc_per_page = 128
Jun  3 21:20:09 tardis kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jun  3 21:20:09 tardis kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jun  3 21:20:09 tardis kernel: PIIX4: IDE controller at PCI slot 00:07.1
Jun  3 21:20:09 tardis kernel: PIIX4: chipset revision 1
Jun  3 21:20:09 tardis kernel: PIIX4: not 100%% native mode: will probe irqs later
Jun  3 21:20:09 tardis kernel:     ide0: BM-DMA at 0x1080-0x1087, BIOS settings: hda:DMA, hdb:pio
Jun  3 21:20:09 tardis kernel:     ide1: BM-DMA at 0x1088-0x108f, BIOS settings: hdc:pio, hdd:pio
Jun  3 21:20:09 tardis kernel: hda: IBM-DARA-218000, ATA DISK drive
Jun  3 21:20:09 tardis kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun  3 21:20:09 tardis kernel: hda: max request size: 128KiB
Jun  3 21:20:09 tardis kernel: hda: host protected area => 1
Jun  3 21:20:09 tardis kernel: hda: 35433216 sectors (18142 MB) w/418KiB Cache, CHS=35152/16/63, UDMA(33)
Jun  3 21:20:09 tardis kernel:  hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 >
Jun  3 21:20:09 tardis kernel: ide-floppy driver 0.99.newide
Jun  3 21:20:09 tardis kernel: mice: PS/2 mouse device common for all mice
Jun  3 21:20:09 tardis kernel: input: PS/2 Synaptics TouchPad on isa0060/serio1
Jun  3 21:20:09 tardis kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jun  3 21:20:09 tardis kernel: input: AT Set 2 keyboard on isa0060/serio0
Jun  3 21:20:09 tardis kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jun  3 21:20:09 tardis kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jun  3 21:20:09 tardis kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Jun  3 21:20:09 tardis kernel: TCP: Hash tables configured (established 16384 bind 32768)
Jun  3 21:20:09 tardis kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Jun  3 21:20:09 tardis kernel: kjournald starting.  Commit interval 5 seconds
Jun  3 21:20:09 tardis kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jun  3 21:20:09 tardis kernel: VFS: Mounted root (ext3 filesystem) readonly.
Jun  3 21:20:09 tardis kernel: Freeing unused kernel memory: 132k freed
Jun  3 21:20:09 tardis kernel: Warning: unable to open an initial console.
Jun  3 21:20:09 tardis kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda2, internal journal
Jun  3 21:20:09 tardis kernel: Adding 264560k swap on /dev/hda7.  Priority:-1 extents:1
Jun  3 21:20:09 tardis kernel: kjournald starting.  Commit interval 5 seconds
Jun  3 21:20:09 tardis kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda5, internal journal
Jun  3 21:20:09 tardis kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jun  3 21:20:09 tardis kernel: kjournald starting.  Commit interval 5 seconds
Jun  3 21:20:09 tardis kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda6, internal journal
Jun  3 21:20:09 tardis kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jun  3 21:20:09 tardis kernel: kjournald starting.  Commit interval 5 seconds
Jun  3 21:20:09 tardis kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda9, internal journal
Jun  3 21:20:09 tardis kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jun  3 21:20:09 tardis kernel: kjournald starting.  Commit interval 5 seconds
Jun  3 21:20:09 tardis kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda8, internal journal
Jun  3 21:20:09 tardis kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jun  3 21:20:09 tardis syslog: klogd startup succeeded
Jun  3 21:20:09 tardis apmd[350]: Version 3.0.2 (APM BIOS 1.2, Linux driver 1.16ac)
Jun  3 21:20:09 tardis apmd: apmd startup succeeded
Jun  3 21:20:09 tardis apmd[350]: apmd_call_proxy: executing: '/etc/sysconfig/apm-scripts/apmscript' 'start'
Jun  3 21:20:09 tardis keytable: Loading keymap: 
Jun  3 21:20:09 tardis keytable: /etc/rc5.d/S17keytable: line 26: /dev/tty0: No such device
Jun  3 21:20:09 tardis keytable: [
Jun  3 21:20:09 tardis keytable: FAILED
Jun  3 21:20:09 tardis keytable: 
Jun  3 21:20:09 tardis keytable: Loading system font: 
Jun  3 21:20:09 tardis keytable: [  
Jun  3 21:20:09 tardis keytable: OK
Jun  3 21:20:09 tardis keytable: 
Jun  3 21:20:09 tardis rc: Starting keytable:  failed
Jun  3 21:20:09 tardis random: Initializing random number generator:  succeeded
Jun  3 21:20:09 tardis atd: atd startup succeeded
Jun  3 21:20:10 tardis crond[411]: (CRON) STARTUP (fork ok) 
Jun  3 21:20:10 tardis mount: mount: fs type vfat not supported by kernel
Jun  3 21:20:10 tardis netfs: Mounting other filesystems:  failed
Jun  3 21:20:10 tardis apmd[350]: apmd_call_proxy: + Starting atd: [  OK  ]^M Starting crond: 
Jun  3 21:20:10 tardis crond: crond startup succeeded
Jun  3 21:20:10 tardis irattach: 1.1 Tue Nov  9 15:30:55 1999 Dag Brattli
Jun  3 21:20:10 tardis irattach: 1.1 Tue Nov  9 15:30:55 1999 Dag Brattli
Jun  3 21:20:10 tardis irda: irattach startup succeeded
Jun  3 21:20:10 tardis irattach: Failed to open /dev/ttyS0: No such device
Jun  3 21:20:11 tardis pcmcia: Starting PCMCIA services:
Jun  3 21:19:49 tardis rc.sysinit: Mounting proc filesystem:  succeeded 
Jun  3 21:19:49 tardis sysctl: net.ipv4.ip_forward = 0 
Jun  3 21:19:49 tardis sysctl: net.ipv4.conf.default.rp_filter = 1 
Jun  3 21:19:49 tardis sysctl: kernel.core_uses_pid = 1 
Jun  3 21:19:49 tardis rc.sysinit: Configuring kernel parameters:  succeeded 
Jun  3 21:19:49 tardis date: Tue Jun  3 21:19:49 EDT 2003 
Jun  3 21:19:49 tardis rc.sysinit: Setting clock  (localtime): Tue Jun  3 21:19:49 EDT 2003 succeeded 
Jun  3 21:19:49 tardis rc.sysinit: Setting hostname tardis.ajlc.waterloo.on.ca:  succeeded 
Jun  3 21:19:49 tardis modprobe: modprobe: QM_MODULES: Function not implemented 
Jun  3 21:19:49 tardis modprobe: modprobe: QM_MODULES: Function not implemented 
Jun  3 21:19:49 tardis modprobe: modprobe: Can't locate module usb-uhci 
Jun  3 21:19:49 tardis rc.sysinit: Initializing USB controller (usb-uhci):  failed 
Jun  3 21:19:49 tardis fsck: /: clean, 25929/53040 files, 146357/211680 blocks 
Jun  3 21:19:49 tardis fsck: [/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/hda2  
Jun  3 21:19:49 tardis rc.sysinit: Checking root filesystem succeeded 
Jun  3 21:19:49 tardis rc.sysinit: Remounting root filesystem in read-write mode:  succeeded 
Jun  3 21:19:49 tardis rc.sysinit: Activating swap partitions:  succeeded 
Jun  3 21:19:50 tardis fsck: /home: clean, 82742/1219200 files, 2175164/2436202 blocks 
Jun  3 21:19:50 tardis fsck: /usr: clean, 136358/370944 files, 679773/780562 blocks 
Jun  3 21:19:50 tardis fsck: /usr/local: clean, 25283/139104 files, 212236/270262 blocks 
Jun  3 21:19:50 tardis fsck: /var: clean, 668/53040 files, 126648/211648 blocks 
Jun  3 21:19:50 tardis fsck: Checking all file systems. 
Jun  3 21:19:50 tardis fsck: [/sbin/fsck.ext3 (1) -- /home] fsck.ext3 -a /dev/hda5  
Jun  3 21:19:50 tardis fsck: [/sbin/fsck.ext3 (1) -- /usr] fsck.ext3 -a /dev/hda6  
Jun  3 21:19:50 tardis fsck: [/sbin/fsck.ext3 (1) -- /usr/local] fsck.ext3 -a /dev/hda9  
Jun  3 21:19:50 tardis fsck: [/sbin/fsck.ext3 (1) -- /var] fsck.ext3 -a /dev/hda8  
Jun  3 21:19:50 tardis rc.sysinit: Checking filesystems succeeded 
Jun  3 21:19:51 tardis mount: mount: fs type vfat not supported by kernel 
Jun  3 21:19:52 tardis rc.sysinit: Mounting local filesystems:  failed 
Jun  3 21:19:55 tardis rc.sysinit: Enabling swap space:  succeeded 
Jun  3 21:20:04 tardis init: Entering runlevel: 5 
Jun  3 21:20:07 tardis kudzu:  succeeded 
Jun  3 21:20:07 tardis kudzu: Updating /etc/fstab succeeded 
Jun  3 21:20:08 tardis sysctl: net.ipv4.ip_forward = 0 
Jun  3 21:20:08 tardis sysctl: net.ipv4.conf.default.rp_filter = 1 
Jun  3 21:20:08 tardis sysctl: kernel.core_uses_pid = 1 
Jun  3 21:20:08 tardis network: Setting network parameters:  succeeded 
Jun  3 21:20:08 tardis network: Bringing up loopback interface:  succeeded 
Jun  3 21:20:11 tardis pcmcia:  cardmgr.
Jun  3 21:20:11 tardis pcmcia: modprobe: QM_MODULES: Function not implemented
Jun  3 21:20:11 tardis pcmcia: 
Jun  3 21:20:11 tardis pcmcia: modprobe: QM_MODULES: Function not implemented
Jun  3 21:20:11 tardis pcmcia: 
Jun  3 21:20:11 tardis pcmcia: modprobe: Can't locate module pcmcia_core
Jun  3 21:20:11 tardis pcmcia: modprobe: QM_MODULES: Function not implemented
Jun  3 21:20:11 tardis pcmcia: 
Jun  3 21:20:11 tardis pcmcia: modprobe: QM_MODULES: Function not implemented
Jun  3 21:20:11 tardis pcmcia: 
Jun  3 21:20:11 tardis pcmcia: modprobe: Can't locate module i82365
Jun  3 21:20:11 tardis pcmcia: modprobe: QM_MODULES: Function not implemented
Jun  3 21:20:11 tardis pcmcia: 
Jun  3 21:20:11 tardis pcmcia: modprobe: QM_MODULES: Function not implemented
Jun  3 21:20:11 tardis pcmcia: 
Jun  3 21:20:11 tardis pcmcia: modprobe: Can't locate module ds
Jun  3 21:20:11 tardis cardmgr[460]: starting, version is 3.1.31
Jun  3 21:20:11 tardis rc: Starting pcmcia:  succeeded
Jun  3 21:20:11 tardis apmd[350]: apmd_call_proxy: + [  OK  ]^M /etc/init.d/seti: line 7: cd: /dos/SETI@home: No such file or directory 
Jun  3 21:20:11 tardis apmd[350]: Charge: * * * (3% 0:12)
Jun  3 21:20:11 tardis cardmgr[460]: no pcmcia driver in /proc/devices
Jun  3 21:20:11 tardis cardmgr[460]: exiting
Jun  3 21:20:12 tardis su(pam_unix)[433]: session opened for user ajlill by (uid=0)
Jun  3 21:20:12 tardis su(pam_unix)[433]: session closed for user ajlill
Jun  3 21:20:13 tardis sshd:  succeeded
Jun  3 21:20:13 tardis sshd[470]: Server listening on 0.0.0.0 port 22.
Jun  3 21:20:14 tardis gpm[507]: oops() invoked from gpn.c(125)
Jun  3 21:20:14 tardis gpm[507]: /dev/console: No such device
Jun  3 21:20:14 tardis gpm: gpm: oops() invoked from gpn.c(125)
Jun  3 21:20:14 tardis gpm: /dev/console: No such device
Jun  3 21:20:14 tardis gpm: gpm startup failed
Jun  3 21:20:17 tardis xfs: xfs startup succeeded
Jun  3 21:20:18 tardis anacron[577]: Anacron 2.3 started on 2003-06-03
Jun  3 21:20:18 tardis anacron: anacron startup succeeded
Jun  3 21:20:18 tardis /sbin/mingetty[589]: /dev/tty6: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[593]: /dev/tty6: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[596]: /dev/tty6: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[599]: /dev/tty6: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[602]: /dev/tty6: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[605]: /dev/tty6: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[608]: /dev/tty6: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[611]: /dev/tty6: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[614]: /dev/tty6: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[617]: /dev/tty6: cannot open tty: No such device
Jun  3 21:20:18 tardis init: Id "6" respawning too fast: disabled for 5 minutes
Jun  3 21:20:18 tardis /sbin/mingetty[588]: /dev/tty5: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[586]: /dev/tty3: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[585]: /dev/tty2: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[584]: /dev/tty1: cannot open tty: No such device
Jun  3 21:20:18 tardis kernel: warning: process `update' used the obsolete bdflush system call
Jun  3 21:20:18 tardis kernel: Fix your initscripts?
Jun  3 21:20:18 tardis /sbin/mingetty[630]: /dev/tty1: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[633]: /dev/tty2: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[636]: /dev/tty3: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[639]: /dev/tty5: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[643]: /dev/tty1: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[646]: /dev/tty2: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[649]: /dev/tty3: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[652]: /dev/tty5: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[655]: /dev/tty1: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[658]: /dev/tty2: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[661]: /dev/tty3: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[664]: /dev/tty5: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[667]: /dev/tty1: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[670]: /dev/tty2: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[673]: /dev/tty3: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[676]: /dev/tty5: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[679]: /dev/tty1: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[682]: /dev/tty2: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[685]: /dev/tty3: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[688]: /dev/tty5: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[691]: /dev/tty1: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[694]: /dev/tty2: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[697]: /dev/tty3: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[700]: /dev/tty5: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[703]: /dev/tty1: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[706]: /dev/tty2: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[709]: /dev/tty3: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[712]: /dev/tty5: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[715]: /dev/tty1: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[718]: /dev/tty2: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[721]: /dev/tty3: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[724]: /dev/tty5: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[727]: /dev/tty1: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[730]: /dev/tty2: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[733]: /dev/tty3: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[736]: /dev/tty5: cannot open tty: No such device
Jun  3 21:20:18 tardis init: Id "1" respawning too fast: disabled for 5 minutes
Jun  3 21:20:18 tardis init: Id "2" respawning too fast: disabled for 5 minutes
Jun  3 21:20:18 tardis init: Id "3" respawning too fast: disabled for 5 minutes
Jun  3 21:20:18 tardis /sbin/mingetty[587]: /dev/tty4: cannot open tty: No such device
Jun  3 21:20:18 tardis init: Id "5" respawning too fast: disabled for 5 minutes
Jun  3 21:20:18 tardis /sbin/mingetty[741]: /dev/tty4: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[744]: /dev/tty4: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[747]: /dev/tty4: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[750]: /dev/tty4: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[753]: /dev/tty4: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[756]: /dev/tty4: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[759]: /dev/tty4: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[762]: /dev/tty4: cannot open tty: No such device
Jun  3 21:20:18 tardis /sbin/mingetty[765]: /dev/tty4: cannot open tty: No such device
Jun  3 21:20:18 tardis init: Id "4" respawning too fast: disabled for 5 minutes
Jun  3 21:20:18 tardis anacron[577]: Normal exit (0 jobs run)
Jun  3 21:20:18 tardis xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/cyrillic (unreadable) 
Jun  3 21:20:18 tardis xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/local (unreadable) 
Jun  3 21:20:19 tardis xfs: ignoring font path element /usr/share/fonts/wprequired (unreadable) 
Jun  3 21:20:19 tardis xfs: ignoring font path element /dos/windows/fonts (unreadable) 
Jun  3 21:20:23 tardis kernel: warning: process `update' used the obsolete bdflush system call
Jun  3 21:20:23 tardis kernel: Fix your initscripts?
Jun  3 21:20:25 tardis gdm[799]: gdm_slave_xioerror_handler: Fatal X error - Restarting :0
Jun  3 21:20:26 tardis gdm[803]: gdm_slave_xioerror_handler: Fatal X error - Restarting :0

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_EMBEDDED is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
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
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI Support
#
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_RTC_IS_GMT is not set
CONFIG_APM_ALLOW_INTS=y
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_PROC_INTF=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_24_API=y
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP=m
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
CONFIG_I82092=m
CONFIG_I82365=m
CONFIG_TCIC=m

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL device support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_IDE_TASK_IOCTL=y

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDE_TCQ=y
CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=y
CONFIG_BLK_DEV_IDE_TCQ_DEPTH=8
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
CONFIG_BLK_DEV_CMD64X=y
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_PROC=m

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
# CONFIG_NETFILTER is not set
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=m
CONFIG_IP_SCTP=m
# CONFIG_SCTP_ADLER32 is not set
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y
# CONFIG_ATM is not set
CONFIG_VLAN_8021Q=m
# CONFIG_LLC is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
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

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
CONFIG_ETHERTAP=m
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
# CONFIG_PCMCIA_XIRCOM is not set
# CONFIG_PCMCIA_XIRTULIP is not set
# CONFIG_HP100 is not set
# CONFIG_NET_PCI is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_PCMCIA_NETWAVE is not set

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_AIRO is not set
CONFIG_HERMES=m
CONFIG_PLX_HERMES=m
CONFIG_PCI_HERMES=m

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
CONFIG_PCMCIA_HERMES=m
CONFIG_AIRO_CS=m
CONFIG_NET_WIRELESS=y

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_RCPCI is not set
CONFIG_SHAPER=m

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_PCMCIA_NMCLAN=m
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_PCMCIA_AXNET is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
CONFIG_IRDA=y

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m

#
# Dongle support
#
# CONFIG_DONGLE is not set

#
# Old SIR device drivers
#
CONFIG_IRTTY_OLD=m
CONFIG_IRPORT_SIR=m

#
# Old Serial dongle support
#
# CONFIG_DONGLE_OLD is not set

#
# FIR device drivers
#
CONFIG_USB_IRDA=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
# CONFIG_TOSHIBA_OLD is not set
CONFIG_TOSHIBA_FIR=m
CONFIG_SMC_IRCC_OLD=m
CONFIG_SMC_IRCC_FIR=m
CONFIG_ALI_FIR=m
CONFIG_VLSI_FIR=m

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_TSDEV=m
CONFIG_INPUT_TSDEV_SCREEN_X=240
CONFIG_INPUT_TSDEV_SCREEN_Y=320
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_CS=m
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set

#
# I2C support
#
CONFIG_I2C=m
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=m

#
# I2C Hardware Sensors Mainboard support
#
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIAPRO=m

#
# I2C Hardware Sensors Chip support
#
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_I2C_SENSOR=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_KCS=m
CONFIG_IPMI_WATCHDOG=m

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=m
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=m
CONFIG_HANGCHECK_TIMER=m

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
CONFIG_XFS_RT=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_MINIX_FS is not set
CONFIG_ROMFS_FS=m
# CONFIG_QUOTA is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
CONFIG_DEVPTS_FS_XATTR=y
CONFIG_DEVPTS_FS_SECURITY=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_CIFS=m
# CONFIG_NCP_FS is not set
CONFIG_CODA_FS=m
# CONFIG_INTERMEZZO_FS is not set
CONFIG_AFS_FS=m
CONFIG_RXRPC=m

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
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

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=y
CONFIG_FB_ATY128=y
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_XL_INIT=y
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=m
CONFIG_PCI_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
# CONFIG_LOGO is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

#
# PCI devices
#
CONFIG_SND_ALI5451=m
CONFIG_SND_CS46XX=m
# CONFIG_SND_CS46XX_NEW_DSP is not set
CONFIG_SND_CS4281=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_KORG1212=m
CONFIG_SND_NM256=m
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
CONFIG_SND_HDSP=m
CONFIG_SND_TRIDENT=m
CONFIG_SND_YMFPCI=m
CONFIG_SND_ALS4000=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
CONFIG_SND_ES1938=m
CONFIG_SND_ES1968=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_FM801=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_SONICVIBES=m
CONFIG_SND_VIA82XX=m

#
# ALSA USB devices
#
CONFIG_SND_USB_AUDIO=m

#
# Open Sound System
#
CONFIG_SOUND_PRIME=m
CONFIG_SOUND_BT878=m
CONFIG_SOUND_CMPCI=m
CONFIG_SOUND_CMPCI_FM=y
CONFIG_SOUND_CMPCI_FMIO=388
CONFIG_SOUND_CMPCI_MIDI=y
CONFIG_SOUND_CMPCI_MPUIO=330
CONFIG_SOUND_CMPCI_JOYSTICK=y
CONFIG_SOUND_CMPCI_CM8738=y
CONFIG_SOUND_CMPCI_SPDIFINVERSE=y
CONFIG_SOUND_CMPCI_SPDIFLOOP=y
CONFIG_SOUND_CMPCI_SPEAKERS=2
CONFIG_SOUND_EMU10K1=m
CONFIG_MIDI_EMU10K1=y
CONFIG_SOUND_FUSION=m
CONFIG_SOUND_CS4281=m
CONFIG_SOUND_ES1370=m
CONFIG_SOUND_ES1371=m
CONFIG_SOUND_ESSSOLO1=m
CONFIG_SOUND_MAESTRO=m
CONFIG_SOUND_MAESTRO3=m
CONFIG_SOUND_ICH=m
CONFIG_SOUND_RME96XX=m
CONFIG_SOUND_SONICVIBES=m
CONFIG_SOUND_TRIDENT=m
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
CONFIG_SOUND_VIA82CXXX=m
# CONFIG_MIDI_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
CONFIG_SOUND_AD1816=m
CONFIG_SOUND_SGALAXY=m
CONFIG_SOUND_ADLIB=m
CONFIG_SOUND_ACI_MIXER=m
CONFIG_SOUND_CS4232=m
CONFIG_SOUND_SSCAPE=m
CONFIG_SOUND_GUS=m
CONFIG_SOUND_GUS16=y
CONFIG_SOUND_GUSMAX=y
CONFIG_SOUND_VMIDI=m
CONFIG_SOUND_TRIX=m
CONFIG_SOUND_MSS=m
CONFIG_SOUND_MPU401=m
CONFIG_SOUND_NM256=m
CONFIG_SOUND_MAD16=m
# CONFIG_MAD16_OLDCARD is not set
CONFIG_SOUND_PAS=m
CONFIG_SOUND_PSS=m
CONFIG_PSS_MIXER=y
# CONFIG_PSS_HAVE_BOOT is not set
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
CONFIG_SOUND_WAVEFRONT=m
CONFIG_SOUND_MAUI=m
CONFIG_SOUND_YM3812=m
CONFIG_SOUND_OPL3SA1=m
CONFIG_SOUND_OPL3SA2=m
CONFIG_SOUND_YMFPCI=m
CONFIG_SOUND_YMFPCI_LEGACY=y
CONFIG_SOUND_UART6850=m
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
# CONFIG_USB_BLUETOOTH_TTY is not set
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# SCSI support is needed for USB Storage
#

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_HID_FF=y
CONFIG_HID_PID=y
CONFIG_LOGITECH_FF=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
# CONFIG_USB_MOUSE is not set
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m
CONFIG_USB_XPAD=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=m

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m

#
# USB Host-to-Host Cables
#
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_GENESYS=y
CONFIG_USB_NET1080=y
CONFIG_USB_PL2301=y

#
# Intelligent USB Devices/Gadgets
#
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_ZAURUS=y
CONFIG_USB_CDCETHER=y

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
# CONFIG_USB_SERIAL_KEYSPAN_MPR is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QW is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QI is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49WLC is not set
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI26=m
CONFIG_USB_TIGL=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
CONFIG_USB_BRLVGER=m
CONFIG_USB_LCD=m
CONFIG_USB_TEST=m
CONFIG_USB_GADGET=m
CONFIG_USB_NET2280=m
CONFIG_USB_ZERO=m
CONFIG_USB_ZERO_NET2280=y
CONFIG_USB_ETH=m
CONFIG_USB_ETH_NET2280=y

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_KALLSYMS=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=m
# CONFIG_SECURITY_ROOTPLUG is not set

#
# Cryptographic options
#
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

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y
