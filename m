Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272471AbTGZMeS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 08:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272473AbTGZMeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 08:34:18 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:34777 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S272471AbTGZMeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 08:34:04 -0400
Date: Sat, 26 Jul 2003 14:49:07 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: neofb problems with 2.6.0-test1-ac3 etc. -- kernel-2.6.x ignoramus
Message-ID: <20030726124907.GB22804@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Basically, 2.6.x works, but there are still issues where I need
enlightenment:

Jul 26 14:21:46 hummus kernel: Linux version 2.6.0-test1-ac3 (root@hummus) (gcc version 3.3.1 20030722 (Debian prerelease)) #1 Thu Jul 24 08:17:38 CEST 2003
Jul 26 14:21:46 hummus kernel: Video mode to be used for restore is 317
Jul 26 14:21:46 hummus kernel: BIOS-provided physical RAM map:
Jul 26 14:21:46 hummus kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jul 26 14:21:46 hummus kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jul 26 14:21:46 hummus kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jul 26 14:21:46 hummus kernel:  BIOS-e820: 0000000000100000 - 000000000bff0000 (usable)
Jul 26 14:21:46 hummus kernel:  BIOS-e820: 000000000bff0000 - 000000000c000000 (ACPI data)
Jul 26 14:21:46 hummus kernel:  BIOS-e820: 00000000100a0000 - 00000000100b6e00 (reserved)
Jul 26 14:21:46 hummus kernel:  BIOS-e820: 00000000100b6e00 - 00000000100b7000 (ACPI NVS)
Jul 26 14:21:46 hummus kernel:  BIOS-e820: 00000000100b7000 - 0000000010100000 (reserved)
Jul 26 14:21:46 hummus kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Jul 26 14:21:46 hummus kernel: 191MB LOWMEM available.
Jul 26 14:21:46 hummus kernel: On node 0 totalpages: 49136
Jul 26 14:21:46 hummus kernel:   DMA zone: 4096 pages, LIFO batch:1
Jul 26 14:21:46 hummus kernel:   Normal zone: 45040 pages, LIFO batch:10
Jul 26 14:21:46 hummus kernel:   HighMem zone: 0 pages, LIFO batch:1
Jul 26 14:21:46 hummus kernel: Building zonelist for node : 0
Jul 26 14:21:46 hummus kernel: Kernel command line: BOOT_IMAGE=Linux.exp ro root=302 video=neofb:ywrap,depth:16

This is my framebuffer. It works, but switching back and forth between
X11 and the fbconsole totally trashes the framebuffer. 

fbset -depth 16

fixes things again. To see what I see, look at:
http://sbserv.stahl.bau.tu-bs.de/~hildeb/fbfubar/

Jul 26 14:21:46 hummus kernel: Initializing CPU#0
Jul 26 14:21:46 hummus kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Jul 26 14:21:46 hummus kernel: Detected 300.025 MHz processor.
Jul 26 14:21:46 hummus kernel: Console: colour dummy device 80x25
Jul 26 14:21:46 hummus kernel: Calibrating delay loop... 591.87 BogoMIPS
Jul 26 14:21:46 hummus kernel: Memory: 191328k/196544k available (1617k kernel code, 4580k reserved, 703k data, 128k init, 0k highmem)
Jul 26 14:21:46 hummus kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Jul 26 14:21:46 hummus kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Jul 26 14:21:46 hummus kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Jul 26 14:21:46 hummus kernel: -> /dev
Jul 26 14:21:46 hummus kernel: -> /dev/console
Jul 26 14:21:46 hummus kernel: -> /root
Jul 26 14:21:46 hummus kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jul 26 14:21:46 hummus kernel: CPU: L2 cache: 512K
Jul 26 14:21:46 hummus kernel: CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000040
Jul 26 14:21:46 hummus kernel: CPU: Intel Pentium II (Deschutes) stepping 02
Jul 26 14:21:46 hummus kernel: Enabling fast FPU save and restore... done.
Jul 26 14:21:46 hummus kernel: Checking 'hlt' instruction... OK.
Jul 26 14:21:46 hummus kernel: POSIX conformance testing by UNIFIX
Jul 26 14:21:46 hummus kernel: Initializing RT netlink socket
Jul 26 14:21:46 hummus kernel: PCI: Using configuration type 1
Jul 26 14:21:46 hummus kernel: mtrr: v2.0 (20020519)
Jul 26 14:21:46 hummus kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Jul 26 14:21:46 hummus kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
Jul 26 14:21:46 hummus kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
Jul 26 14:21:46 hummus kernel: biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
Jul 26 14:21:46 hummus kernel: biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
Jul 26 14:21:46 hummus kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
Jul 26 14:21:46 hummus kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Jul 26 14:21:46 hummus kernel: Linux Plug and Play Support v0.96 (c) Adam Belay
Jul 26 14:21:46 hummus kernel: PnPBIOS: Scanning system for PnP BIOS support...
Jul 26 14:21:46 hummus kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00fed00
Jul 26 14:21:46 hummus kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x92c6, dseg 0x0
Jul 26 14:21:46 hummus kernel: PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
Jul 26 14:21:46 hummus kernel: SCSI subsystem initialized
Jul 26 14:21:46 hummus kernel: drivers/usb/core/usb.c: registered new driver usbfs
Jul 26 14:21:46 hummus kernel: drivers/usb/core/usb.c: registered new driver hub
Jul 26 14:21:46 hummus kernel: PCI: Probing PCI hardware
Jul 26 14:21:46 hummus kernel: PCI: Probing PCI hardware (bus 00)
Jul 26 14:21:46 hummus kernel: PCI: Using IRQ router PIIX [8086/7110] at 0000:00:05.0
Jul 26 14:21:46 hummus kernel: PCI: Cannot allocate resource region 4 of device 0000:00:05.1
Jul 26 14:21:46 hummus kernel: PCI: Found IRQ 11 for device 0000:00:04.0
Jul 26 14:21:46 hummus kernel: PCI: Sharing IRQ 11 with 0000:00:09.0
Jul 26 14:21:46 hummus kernel: neofb: mapped io at cc800000
Jul 26 14:21:46 hummus kernel: Autodetected internal display
Jul 26 14:21:46 hummus kernel: Panel is a 1024x768 color TFT display
Jul 26 14:21:46 hummus kernel: neofb: mapped framebuffer at cca01000
Jul 26 14:21:46 hummus kernel: neofb v0.4.1: 2560kB VRAM, using 1024x768, 48.361kHz, 60Hz
Jul 26 14:21:46 hummus kernel: fb0: MagicGraph 256AV frame buffer device
Jul 26 14:21:46 hummus kernel: Console: switching to colour frame buffer device 128x48
Jul 26 14:21:46 hummus kernel: pty: 256 Unix98 ptys configured
Jul 26 14:21:46 hummus kernel: Enabling SEP on CPU 0
Jul 26 14:21:46 hummus kernel: ikconfig 0.5 with /proc/ikconfig
Jul 26 14:21:46 hummus kernel: Journalled Block Device driver loaded
Jul 26 14:21:46 hummus kernel: devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
Jul 26 14:21:46 hummus kernel: devfs: boot_options: 0x1
Jul 26 14:21:46 hummus kernel: Initializing Cryptographic API
Jul 26 14:21:46 hummus kernel: Limiting direct PCI/PCI transfers.
Jul 26 14:21:46 hummus kernel: isapnp: Scanning for PnP cards...
Jul 26 14:21:46 hummus kernel: isapnp: No Plug & Play device found
Jul 26 14:21:46 hummus kernel: klogd 1.4.1#11, log source = /proc/kmsg started.
Jul 26 14:21:46 hummus kernel: Inspecting /boot/System.map-2.6.0-test1-ac3
Jul 26 14:21:46 hummus kernel: Loaded 21223 symbols from /boot/System.map-2.6.0-test1-ac3.
Jul 26 14:21:46 hummus kernel: Symbols match kernel version 2.6.0.
Jul 26 14:21:46 hummus kernel: No module symbols loaded - kernel modules not enabled.

Huh? I DO USE modules. What is the deeper meaning of this warning?

Jul 26 14:21:48 hummus cardmgr[575]: watching 2 sockets
Jul 26 14:21:48 hummus cardmgr[576]: starting, version is 3.2.2
Jul 26 14:21:48 hummus cardmgr[576]: socket 0: Xircom CEM56 Ethernet/Modem
Jul 26 14:21:48 hummus cardmgr[576]: executing: 'modprobe xirc2ps_cs'
Jul 26 14:21:48 hummus cardmgr[576]: executing: 'modprobe serial_cs'
Jul 26 14:21:48 hummus cardmgr[576]: + FATAL: Module serial_cs not found.
Jul 26 14:21:48 hummus cardmgr[576]: modprobe exited with status 1
Jul 26 14:21:48 hummus cardmgr[576]: module /lib/modules/2.6.0-test1-ac3/pcmcia/serial_cs.o not available

Is this a module for the "modem" on the Xircom Ethernet/Modem card?

Jul 26 14:21:48 hummus kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Jul 26 14:21:48 hummus kernel: cs: IO port probe 0x0800-0x08ff: clean.
Jul 26 14:21:48 hummus kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x330-0x337 0x378-0x37f 0x388-0x38f 0x3c0-0x3df 0x4d0-0x4d7
Jul 26 14:21:48 hummus kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Jul 26 14:21:48 hummus kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Jul 26 14:21:48 hummus kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Jul 26 14:21:48 hummus kernel: cs: IO port probe 0x0800-0x08ff: clean.
Jul 26 14:21:48 hummus kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x330-0x337 0x378-0x37f 0x388-0x38f 0x3c0-0x3df 0x4d0-0x4d7
Jul 26 14:21:48 hummus kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Jul 26 14:21:48 hummus kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Jul 26 14:21:49 hummus modprobe: FATAL: Module /dev/apm_bios not found. 

How can I fix this?

Jul 26 14:21:49 hummus kernel: Yamaha OPL3-SA soundcard not found or device busy

This baffles me totally. ALSO works paco on 2.4.22-pre8 -- but not
under kernel-2.5.x or 2.6.x -- no even a insmod with the SAME
paramaters works.


And what is this all about?

Jul 26 14:21:50 hummus modprobe: FATAL: Module /dev/ttyS4 not found. 
Jul 26 14:21:50 hummus modprobe: FATAL: Module /dev/ttyS5 not found. 
Jul 26 14:21:50 hummus modprobe: FATAL: Module /dev/ttyS6 not found. 
Jul 26 14:21:50 hummus modprobe: FATAL: Module /dev/ttyS7 not found. 
Jul 26 14:21:50 hummus modprobe: FATAL: Module /dev/ttyS8 not found. 
Jul 26 14:21:50 hummus modprobe: FATAL: Module /dev/ttyS9 not found. 
Jul 26 14:21:50 hummus modprobe: FATAL: Module /dev/ttyS10 not found. 
Jul 26 14:21:50 hummus modprobe: FATAL: Module /dev/ttyS11 not found. 
Jul 26 14:21:50 hummus modprobe: FATAL: Module /dev/ttyS12 not found. 
Jul 26 14:21:50 hummus modprobe: FATAL: Module /dev/ttyS13 not found. 
Jul 26 14:21:50 hummus modprobe: FATAL: Module /dev/ttyS14 not found. 
Jul 26 14:21:50 hummus modprobe: FATAL: Module /dev/ttyS15 not found. 
Jul 26 14:21:50 hummus modprobe: FATAL: Module /dev/ttyS16 not found. 
Jul 26 14:21:50 hummus kernel: ttyS3: LSR safety check engaged!
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS17 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS18 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS19 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS20 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS21 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS22 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS23 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS24 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS25 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS26 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS27 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS28 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS29 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS30 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS31 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS32 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS33 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS34 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS35 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS36 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS37 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS38 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS39 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS40 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS41 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS42 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS43 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS44 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS45 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS46 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS47 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS48 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS49 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS50 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS51 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS52 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS53 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS54 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS55 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS56 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS57 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS58 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS59 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS60 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS61 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS62 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS63 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS64 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS65 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS66 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS67 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS68 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS69 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS70 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS71 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS72 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS73 not found. 
Jul 26 14:21:51 hummus modprobe: FATAL: Module /dev/ttyS74 not found. 
Jul 26 14:21:51 hummus kernel: eth0: MII link partner: 0021
Jul 26 14:21:51 hummus kernel: eth0: MII selected
Jul 26 14:21:51 hummus kernel: eth0: media 10BaseT, silicon revision 5
Jul 26 14:21:51 hummus kernel: eth0: Xircom: port 0x300, irq 3, hwaddr 00:10:A4:B9:AB:74
Jul 26 14:21:51 hummus kernel: eth0: MII link partner: 0021
Jul 26 14:21:51 hummus kernel: eth0: MII selected
Jul 26 14:21:51 hummus kernel: eth0: media 10BaseT, silicon revision 5
Jul 26 14:21:51 hummus kernel: eth0: Xircom: port 0x300, irq 3, hwaddr 00:10:A4:B9:AB:74
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS75 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS76 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS77 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS78 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS79 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS80 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS81 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS82 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS83 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS84 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS85 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS86 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS87 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS88 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS89 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS90 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS91 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS92 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS93 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS94 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS95 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS96 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS97 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS98 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/ttyS99 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usb/ttyUSB0 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usb/ttyUSB1 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usb/ttyUSB2 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usb/ttyUSB3 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usb/ttyUSB4 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usb/ttyUSB5 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usb/ttyUSB6 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usb/ttyUSB7 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usb/ttyUSB8 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usb/ttyUSB9 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usb/ttyUSB10 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usb/ttyUSB11 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usb/ttyUSB12 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usb/ttyUSB13 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usb/ttyUSB14 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usb/ttyUSB15 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usb/lp0 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usb/usblp0 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usblp0 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usblp1 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usblp2 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usblp3 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usblp4 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usblp5 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usblp6 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usblp7 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usblp8 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usblp9 not found. 
Jul 26 14:21:52 hummus modprobe: FATAL: Module /dev/usblp10 not found. 
Jul 26 14:21:53 hummus modprobe: FATAL: Module /dev/usblp11 not found. 
Jul 26 14:21:53 hummus modprobe: FATAL: Module /dev/usblp12 not found. 
Jul 26 14:21:53 hummus modprobe: FATAL: Module /dev/usblp13 not found. 
Jul 26 14:21:53 hummus modprobe: FATAL: Module /dev/usblp14 not found. 
Jul 26 14:21:53 hummus modprobe: FATAL: Module /dev/usblp15 not found. 
Jul 26 14:21:54 hummus modprobe: FATAL: Module /dev/parallel not found. 
Jul 26 14:21:54 hummus modprobe: FATAL: Module /dev/lp0 not found. 
Jul 26 14:21:54 hummus modprobe: FATAL: Module /dev/par0 not found. 
Jul 26 14:21:54 hummus modprobe: FATAL: Module /dev/printers not found. 
Jul 26 14:21:54 hummus modprobe: FATAL: Module /dev/parallel not found. 
Jul 26 14:21:54 hummus modprobe: FATAL: Module /dev/lp1 not found. 
Jul 26 14:21:54 hummus modprobe: FATAL: Module /dev/par1 not found. 
Jul 26 14:21:54 hummus modprobe: FATAL: Module /dev/printers not found. 
Jul 26 14:21:54 hummus modprobe: FATAL: Module /dev/parallel not found. 
Jul 26 14:21:54 hummus modprobe: FATAL: Module /dev/lp2 not found. 
Jul 26 14:21:54 hummus modprobe: FATAL: Module /dev/par2 not found. 
Jul 26 14:21:54 hummus modprobe: FATAL: Module /dev/printers not found. 
Jul 26 14:21:54 hummus modprobe: FATAL: Module /dev/parallel not found. 
Jul 26 14:21:54 hummus modprobe: FATAL: Module /dev/lp3 not found. 
Jul 26 14:21:54 hummus modprobe: FATAL: Module /dev/par3 not found. 
Jul 26 14:21:54 hummus modprobe: FATAL: Module /dev/printers not found. 
Jul 26 14:21:55 hummus modprobe: FATAL: Module /dev/gpmdata not found. 
Jul 26 14:21:55 hummus modprobe: FATAL: Module /dev/gpmctl not found. 
Jul 26 14:21:55 hummus modprobe: FATAL: Module /dev/MAKEDEV not found. 

That's quite a bit of stuff not found. Can this clobbering of the log
be prevented?

Jul 26 14:21:59 hummus postfix/postfix-script: starting the Postfix mail system
Jul 26 14:21:59 hummus postfix/master[883]: daemon started -- version 2.0.13
Jul 26 14:22:03 hummus xfs: ignoring font path element /usr/lib/X11/fonts/CID/ (unreadable) 
Jul 26 14:22:06 hummus ntpd[937]: ntpd 4.1.1b@1.829 Sun Dec 29 22:42:05 UTC 2002 (2)
Jul 26 14:22:06 hummus modprobe: FATAL: Module /dev/apm_bios not found. 
Jul 26 14:22:06 hummus ntpd[937]: signal_no_reset: signal 13 had flags 4000000
Jul 26 14:22:06 hummus ntpd[937]: precision = 16 usec
Jul 26 14:22:06 hummus ntpd[937]: kernel time discipline status 0040
Jul 26 14:22:06 hummus ntpd[937]: frequency initialized 45.950 from /var/lib/ntp/ntp.drift
Jul 26 14:22:06 hummus ntpd[937]: signal_no_reset: signal 13 had flags 4000000
Jul 26 14:22:06 hummus anacron[944]: Anacron 2.3 started on 2003-07-26
Jul 26 14:22:06 hummus anacron[944]: Normal exit (0 jobs run)
Jul 26 14:22:08 hummus modprobe: FATAL: Module /dev/dri not found. 
Jul 26 14:22:10 hummus modprobe: FATAL: Module /dev/apm_bios not found. 
Jul 26 14:22:11 hummus pppd[991]: pppd 2.4.1 started by root, uid 0
Jul 26 14:22:11 hummus pppd[991]: Serial connection established.
Jul 26 14:22:11 hummus pppd[991]: pppd 2.4.1 started by root, uid 0
Jul 26 14:22:11 hummus pppd[991]: Serial connection established.
Jul 26 14:22:14 hummus pppoe[1014]: Changed pty line discipline to N_HDLC for synchronous mode
Jul 26 14:22:14 hummus pppoe[1014]: PADS: Service-Name: ''
Jul 26 14:22:14 hummus pppoe[1014]: PPP session is 25251
Jul 26 14:22:14 hummus ntpd[937]: sendto(192.53.103.103): Network is unreachable
Jul 26 14:22:14 hummus pppoe[1014]: PADS: Service-Name: ''
Jul 26 14:22:14 hummus kernel: eth0: MII link partner: 0021
Jul 26 14:22:14 hummus kernel: eth0: MII selected
Jul 26 14:22:14 hummus kernel: eth0: media 10BaseT, silicon revision 5
Jul 26 14:22:14 hummus kernel: HDLC line discipline: version $Revision: 4.8 $, maxframe=4096
Jul 26 14:22:14 hummus kernel: N_HDLC line discipline registered.
Jul 26 14:22:14 hummus kernel: eth0: MII link partner: 0021
Jul 26 14:22:14 hummus kernel: eth0: MII selected
Jul 26 14:22:14 hummus kernel: eth0: media 10BaseT, silicon revision 5
Jul 26 14:22:14 hummus pppd[991]: Using interface ppp0
Jul 26 14:22:14 hummus pppd[991]: Connect: ppp0 <--> /dev/pts/0
Jul 26 14:22:14 hummus kernel: HDLC line discipline: version $Revision: 4.8 $, maxframe=4096
Jul 26 14:22:14 hummus kernel: N_HDLC line discipline registered.
Jul 26 14:22:14 hummus pppd[991]: Using interface ppp0
Jul 26 14:22:14 hummus pppd[991]: Connect: ppp0 <--> /dev/pts/0
Jul 26 14:22:16 hummus modprobe: FATAL: Module /dev/cpu not found. 
Jul 26 14:22:16 hummus pppd[991]: kernel does not support PPP filtering
Jul 26 14:22:17 hummus kernel: PPP BSD Compression module registered
Jul 26 14:22:17 hummus kernel: PPP Deflate Compression module registered
Jul 26 14:22:17 hummus kernel: PPP BSD Compression module registered
Jul 26 14:22:17 hummus kernel: PPP Deflate Compression module registered
Jul 26 14:22:17 hummus pppd[991]: local  IP address 212.202.37.115
Jul 26 14:22:17 hummus pppd[991]: remote IP address 213.148.128.50
Jul 26 14:22:17 hummus pppd[991]: local  IP address 212.202.37.115
Jul 26 14:22:17 hummus pppd[991]: remote IP address 213.148.128.50

As you see, the rest works.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
