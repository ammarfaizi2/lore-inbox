Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265799AbUAKIT7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 03:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265796AbUAKIT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 03:19:59 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:51415 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265809AbUAKISX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 03:18:23 -0500
Date: Sun, 11 Jan 2004 09:11:01 +0100 (CET)
From: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter@peterpall.de>
Reply-To: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter.koenigsmann@gmx.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter@peterpall.de>,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/2] Psmouse log and discard timed out bytes - addition
In-Reply-To: <200401102357.03434.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.53.0401110903350.1210@calcula.uni-erlangen.de>
References: <Pine.LNX.4.53.0401091101170.1050@calcula.uni-erlangen.de>
 <200401100345.17211.dtor_core@ameritech.net> <200401100346.04660.dtor_core@ameritech.net>
 <200401102357.03434.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:6f0b4d165b4faec4675b8267e0f72da4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm... This patch did something: I think, I get less warnings and no
warning at all at startup...

But defining DEBUG didn't produce any message, that seems to be of interest
to me...

Appended an complete dmesg from switching on to the first error messages...

And: Another strange observation: klling gpm (X is not running) results in 
odd numbers of warnings contrary to even ones when gpm runs.

Inspecting /boot/System.map
Loaded 31043 symbols from /boot/System.map.
Symbols match kernel version 2.6.1.
No module symbols loaded - kernel modules not enabled.

klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.6.1 (gunter@labtop) (gcc version 3.3 20030226 (prerelease) (SuSE Linux)) #21 Sun Jan 11 08:55:09 CET 2004
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
<4> BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
<4> BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000001f6e0000 (usable)
<4> BIOS-e820: 000000001f6e0000 - 000000001f6eb000 (ACPI data)
<4> BIOS-e820: 000000001f6eb000 - 000000001f700000 (ACPI NVS)
<4> BIOS-e820: 000000001f700000 - 0000000020000000 (reserved)
<4> BIOS-e820: 00000000fec10000 - 00000000fec20000 (reserved)
<4> BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
<4> BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
<5>502MB LOWMEM available.
<4>On node 0 totalpages: 128736
<4>  DMA zone: 4096 pages, LIFO batch:1
<4>  Normal zone: 124640 pages, LIFO batch:16
<4>  HighMem zone: 0 pages, LIFO batch:1
<6>DMI present.
<6>ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f60d0
<6>ACPI: RSDT (v001 PTLTD  Montara  0x06040000  LTP 0x00000000) @ 0x1f6e65a2
<6>ACPI: FADT (v001 INTEL  MONTARAG 0x06040000 PTL  0x00000050) @ 0x1f6eaed2
<6>ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1f6eafd8
<6>ACPI: SSDT (v001 INTEL    GV3Ref 0x00001001 MSFT 0x0100000e) @ 0x1f6e65d2
<6>ACPI: DSDT (v001 WISTRO FB2I     0x06040000 MSFT 0x0100000e) @ 0x00000000
<4>Building zonelist for node : 0
<4>Kernel command line: auto BOOT_IMAGE=Plain root=302 video=i810fb,xres:1024,yres:768 resume=/dev/hda3
<6>Initializing CPU#0
<4>PID hash table entries: 2048 (order 11: 16384 bytes)
<4>Detected 1400.073 MHz processor.
<6>Using tsc for high-res timesource
<4>Console: colour VGA+ 80x34
<6>Memory: 504052k/514944k available (3187k kernel code, 10116k reserved, 1322k data, 148k init, 0k highmem)
<4>Checking if this processor honours the WP bit even in supervisor mode... Ok.
<4>Calibrating delay loop... 2768.89 BogoMIPS
<6>Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
<4>Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
<4>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
<7>CPU:     After generic identify, caps: a7e9f9bf 00000000 00000000 00000000
<7>CPU:     After vendor identify, caps: a7e9f9bf 00000000 00000000 00000000
<6>CPU: L1 I cache: 32K, L1 D cache: 32K
<6>CPU: L2 cache: 1024K
<7>CPU:     After all inits, caps: a7e9f9bf 00000000 00000000 00000040
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<4>CPU: Intel(R) Pentium(R) M processor 1400MHz stepping 05
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<6>NET: Registered protocol family 16
<6>PCI: PCI BIOS revision 2.10 entry at 0xfd6c4, last bus=3
<6>PCI: Using configuration type 1
<6>mtrr: v2.0 (20020519)
<6>ACPI: Subsystem revision 20031002
<4>ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
<6>ACPI: Interpreter enabled
<6>ACPI: Using PIC for interrupt routing
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<6>PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
<4>Transparent bridge - 0000:00:1e.0
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 10 *11)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs *10 11)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 10 *11)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
<4>ACPI: PCI Interrupt Link [LNKE] (IRQs *10 11)
<4>ACPI: PCI Interrupt Link [LNKF] (IRQs *10 11)
<4>ACPI: PCI Interrupt Link [LNKG] (IRQs *10 11)
<4>ACPI: PCI Interrupt Link [LNKH] (IRQs 10 *11)
<6>ACPI: Embedded Controller [EC] (gpe 28)
<6>Linux Plug and Play Support v0.97 (c) Adam Belay
<5>SCSI subsystem initialized
<6>Linux Kernel Card Services
<6>  options:  [pci] [cardbus] [pm]
<6>drivers/usb/core/usb.c: registered new driver usbfs
<6>drivers/usb/core/usb.c: registered new driver hub
<4>ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
<4>ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
<4>ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
<4>ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
<4>ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
<4>ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
<4>ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
<4>ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
<6>PCI: Using ACPI for IRQ routing
<6>PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
<6>NET: Registered protocol family 23
<6>agpgart: Detected an Intel 855 Chipset.
<6>agpgart: Maximum main memory to use for agp memory: 430M
<6>agpgart: Detected 8060K stolen memory.
<6>agpgart: AGP aperture is 128M @ 0xe8000000
<6>SBF: Simple Boot Flag extension found and enabled.
<6>SBF: Setting boot flags 0x1
<6>Machine check exception polling timer started.
<6>speedstep-centrino: found "Intel(R) Pentium(R) M processor 1400MHz": max frequency: 1400000kHz
<6>IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
<4>Total HugeTLB memory allocated, 0
<6>ikconfig 0.7 with /proc/config*
<6>Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
<6>NTFS driver 2.1.5 [Flags: R/W].
<5>udf: registering filesystem
<6>Initializing Cryptographic API
<4>
<4>testing md5
<4>test 1:
<4>d41d8cd98f00b204e9800998ecf8427e
<4>pass
<4>test 2:
<4>0cc175b9c0f1b6a831c399e269772661
<4>pass
<4>test 3:
<4>900150983cd24fb0d6963f7d28e17f72
<4>pass
<4>test 4:
<4>f96b697d7cb7938d525a2f31aaf161d0
<4>pass
<4>test 5:
<4>c3fcd3d76192e4007dfb496cca67e13b
<4>pass
<4>test 6:
<4>d174ab98d277d9f5a5611c2c9f419d9f
<4>pass
<4>test 7:
<4>57edf4a22be3c955ac49da2e2107b67a
<4>pass
<4>testing md5 across pages
<4>test 1:
<4>c3fcd3d76192e4007dfb496cca67e13b
<4>pass
<4>
<4>testing sha1
<4>test 1:
<4>a9993e364706816aba3e25717850c26c9cd0d89d
<4>pass
<4>test 2:
<4>84983e441c3bd26ebaae4aa1f95129e5e54670f1
<4>pass
<4>testing sha1 across pages
<4>test 1:
<4>84983e441c3bd26ebaae4aa1f95129e5e54670f1
<4>pass
<4>
<4>testing des ECB encryption 
<4>test 1 (64 bit key):
<4>c95744256a5ed31d
<4>pass
<4>test 2 (64 bit key):
<4>f79c892a338f4a8b
<4>pass
<4>test 3 (64 bit key):
<4>690f5b0d9a26939b
<4>pass
<4>test 4 (64 bit key):
<4>c95744256a5ed31df79c892a338f4a8bb49926f71fe1d490
<4>pass
<4>test 5 (64 bit key):
<4>setkey() failed flags=100100
<4>c95744256a5ed31d
<4>pass
<4>
<4>testing des ECB encryption across pages (chunking) 
<4>test 1 (64 bit key):
<4>page 0
<4>c95744256a5ed31d
<4>pass
<4>page 1
<4>f79c892a338f4a8b
<4>pass
<4>test 2 (64 bit key):
<4>page 0
<4>c95744256a5ed31df79c892a338f
<4>pass
<4>page 1
<4>4a8bb49926f71fe1d490
<4>pass
<4>page 2
<4>f79c892a338f4a8b
<4>pass
<4>test 3 (64 bit key):
<4>page 0
<4>c957
<4>pass
<4>page 1
<4>44
<4>pass
<4>page 2
<4>256a5e
<4>pass
<4>page 3
<4>d31df79c892a338f4a8bb49926f71fe1d490
<4>pass
<4>test 4 (64 bit key):
<4>page 0
<4>c957
<4>pass
<4>page 1
<4>4425
<4>pass
<4>page 2
<4>6a5e
<4>pass
<4>page 3
<4>d31d
<4>pass
<4>page 4
<4>f79c892a338f4a8b
<4>pass
<4>test 5 (64 bit key):
<4>page 0
<4>c9
<4>pass
<4>page 1
<4>57
<4>pass
<4>page 2
<4>44
<4>pass
<4>page 3
<4>25
<4>pass
<4>page 4
<4>6a
<4>pass
<4>page 5
<4>5e
<4>pass
<4>page 6
<4>d3
<4>pass
<4>page 7
<4>1d
<4>pass
<4>
<4>testing des ECB decryption 
<4>test 1 (64 bit key):
<4>0123456789abcde7
<4>pass
<4>test 2 (64 bit key):
<4>01a1d6d039776742
<4>pass
<4>
<4>testing des ECB decryption across pages (chunking) 
<4>test 1 (64 bit key):
<4>page 0
<4>0123456789abcde7
<4>pass
<4>page 1
<4>a3997bcaaf69a0f5
<4>pass
<4>test 2 (64 bit key):
<4>page 0
<4>012345
<4>pass
<4>page 1
<4>6789abcde7a3997bcaaf69a0
<4>pass
<4>page 2
<4>f5
<4>pass
<4>
<4>testing des CBC encryption 
<4>test 1 (64 bit key):
<4>ccd173ffab2039f4acd8aefddfd8a1eb468e91157888ba68
<4>pass
<4>test 2 (64 bit key):
<4>e5c7cdde872bf27c
<4>pass
<4>test 3 (64 bit key):
<4>43e934008c389c0f
<4>pass
<4>test 4 (64 bit key):
<4>683788499a7c05f6
<4>pass
<4>
<4>testing des CBC encryption across pages (chunking) 
<4>test 1 (64 bit key):
<4>page 0
<4>ccd173ffab2039f4acd8aefddf
<4>pass
<4>page 1
<4>d8a1eb468e91157888ba68
<4>pass
<4>
<4>testing des CBC decryption 
<4>test 1 (64 bit key):
<4>4e6f772069732074
<4>pass
<4>test 2 (64 bit key):
<4>68652074696d6520
<4>pass
<4>test 3 (64 bit key):
<4>666f7220616c6c20
<4>pass
<4>
<4>testing des CBC decryption across pages (chunking) 
<4>test 1 (64 bit key):
<4>page 0
<4>666f7220
<4>pass
<4>page 1
<4>616c6c20
<4>pass
<4>
<4>testing des3_ede ECB encryption 
<4>test 1 (192 bit key):
<4>18d748e563620572
<4>pass
<4>test 2 (192 bit key):
<4>c07d2a0fa566fa30
<4>pass
<4>test 3 (192 bit key):
<4>e1ef62c332fe825b
<4>pass
<4>
<4>testing des3_ede ECB encryption across pages (chunking) 
<4>
<4>testing des3_ede ECB decryption 
<4>test 1 (192 bit key):
<4>736f6d6564617461
<4>pass
<4>test 2 (192 bit key):
<4>7371756967676c65
<4>pass
<4>test 3 (192 bit key):
<4>0000000000000000
<4>pass
<4>
<4>testing des3_ede ECB decryption across pages (chunking) 
<4>
<4>testing md4
<4>test 1:
<4>31d6cfe0d16ae931b73c59d7e0c089c0
<4>pass
<4>test 2:
<4>bde52cb31de33e46245e05fbdbd6fb24
<4>pass
<4>test 3:
<4>a448017aaf21d8525fc10ae87aa6729d
<4>pass
<4>test 4:
<4>d9130a8164549fe818874806e1c7014b
<4>pass
<4>test 5:
<4>d79e1c308aa5bbcdeea8ed63df412da9
<4>pass
<4>test 6:
<4>043f8582f241db351ce627e153e7f0e4
<4>pass
<4>test 7:
<4>e33b4ddc9c38f2199c3e7b164fcc0536
<4>pass
<4>testing md4 across pages
<4>test 1:
<4>d79e1c308aa5bbcdeea8ed63df412da9
<4>pass
<4>
<4>testing sha256
<4>test 1:
<4>4bdc38c481dc38711bb54ce4f858f5c0b68e896d853598358e438a9c5bac2e97
<4>fail
<4>test 2:
<4>33f031667b47fb810a22cfa42b5c23712e0c2b75ba7e13e28c635fda3c8c3f7e
<4>fail
<4>testing sha256 across pages
<4>test 1:
<4>33f031667b47fb810a22cfa42b5c23712e0c2b75ba7e13e28c635fda3c8c3f7e
<4>fail
<4>
<4>testing blowfish ECB encryption 
<4>test 1 (64 bit key):
<4>4ef997456198dd78
<4>pass
<4>test 2 (64 bit key):
<4>a790795108ea3cae
<4>pass
<4>test 3 (64 bit key):
<4>e87a244e2cc85e82
<4>pass
<4>test 4 (128 bit key):
<4>93142887ee3be15c
<4>pass
<4>test 5 (168 bit key):
<4>e6f51ed79b9db21f
<4>pass
<4>test 6 (448 bit key):
<4>c04504012e4e1f53
<4>pass
<4>
<4>testing blowfish ECB encryption across pages (chunking) 
<4>
<4>testing blowfish ECB decryption 
<4>test 1 (64 bit key):
<4>0000000000000000
<4>pass
<4>test 2 (64 bit key):
<4>0123456789abcdef
<4>pass
<4>test 3 (64 bit key):
<4>fedcba9876543210
<4>pass
<4>test 4 (128 bit key):
<4>fedcba9876543210
<4>pass
<4>test 5 (168 bit key):
<4>fedcba9876543210
<4>pass
<4>test 6 (448 bit key):
<4>fedcba9876543210
<4>pass
<4>
<4>testing blowfish ECB decryption across pages (chunking) 
<4>
<4>testing blowfish CBC encryption 
<4>test 1 (128 bit key):
<4>6b77b4d63006dee605b156e27403979358deb9e7154616d959f1652bd5ff92cc
<4>pass
<4>
<4>testing blowfish CBC encryption across pages (chunking) 
<4>
<4>testing blowfish CBC decryption 
<4>test 1 (128 bit key):
<4>37363534333231204e6f77206973207468652074696d6520666f722000000000
<4>pass
<4>
<4>testing blowfish CBC decryption across pages (chunking) 
<4>
<4>testing twofish ECB encryption 
<4>test 1 (128 bit key):
<4>9f589f5cf6122c32b6bfec2f2ae8c35a
<4>pass
<4>test 2 (192 bit key):
<4>cfd1d2e5a9be9cdf501f13b892bd2248
<4>pass
<4>test 3 (256 bit key):
<4>37527be0052334b89f0cfccae87cfa20
<4>pass
<4>
<4>testing twofish ECB encryption across pages (chunking) 
<4>
<4>testing twofish ECB decryption 
<4>test 1 (128 bit key):
<4>00000000000000000000000000000000
<4>pass
<4>test 2 (192 bit key):
<4>00000000000000000000000000000000
<4>pass
<4>test 3 (256 bit key):
<4>00000000000000000000000000000000
<4>pass
<4>
<4>testing twofish ECB decryption across pages (chunking) 
<4>
<4>testing twofish CBC encryption 
<4>test 1 (128 bit key):
<4>9f589f5cf6122c32b6bfec2f2ae8c35a
<4>pass
<4>test 2 (128 bit key):
<4>d491db16e7b1c39e86cb086b789f5419
<4>pass
<4>test 3 (128 bit key):
<4>05ef8c61a811582634ba5cb7106aa641
<4>pass
<4>test 4 (128 bit key):
<4>9f589f5cf6122c32b6bfec2f2ae8c35ad491db16e7b1c39e86cb086b789f541905ef8c61a811582634ba5cb7106aa641
<4>pass
<4>
<4>testing twofish CBC encryption across pages (chunking) 
<4>
<4>testing twofish CBC decryption 
<4>test 1 (128 bit key):
<4>00000000000000000000000000000000
<4>pass
<4>test 2 (128 bit key):
<4>00000000000000000000000000000000
<4>pass
<4>test 3 (128 bit key):
<4>00000000000000000000000000000000
<4>pass
<4>test 4 (128 bit key):
<4>000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
<4>pass
<4>
<4>testing twofish CBC decryption across pages (chunking) 
<4>
<4>testing serpent ECB encryption 
<4>test 1 (0 bit key):
<4>1207fcce9bd0d6476ae98fbed143a0e2
<4>pass
<4>test 2 (128 bit key):
<4>4c7d8a328072a22c823e4a1f3acda16d
<4>pass
<4>test 3 (256 bit key):
<4>de269ff833e432b85b2e88d2701ce75c
<4>pass
<4>test 4 (128 bit key):
<4>ddd26b98a5ffd82c05345a9dadbfaf49
<4>pass
<4>
<4>testing serpent ECB encryption across pages (chunking) 
<4>
<4>testing serpent ECB decryption 
<4>test 1 (0 bit key):
<4>000102030405060708090a0b0c0d0e0f
<4>pass
<4>test 2 (128 bit key):
<4>000102030405060708090a0b0c0d0e0f
<4>pass
<4>test 3 (256 bit key):
<4>000102030405060708090a0b0c0d0e0f
<4>pass
<4>test 4 (128 bit key):
<4>00000000000000000000000000000000
<4>pass
<4>
<4>testing serpent ECB decryption across pages (chunking) 
<4>
<4>testing aes ECB encryption 
<4>test 1 (128 bit key):
<4>69c4e0d86a7b0430d8cdb78070b4c55a
<4>pass
<4>test 2 (192 bit key):
<4>dda97ca4864cdfe06eaf70a0ec0d7191
<4>pass
<4>test 3 (256 bit key):
<4>8ea2b7ca516745bfeafc49904b496089
<4>pass
<4>
<4>testing aes ECB encryption across pages (chunking) 
<4>
<4>testing aes ECB decryption 
<4>test 1 (128 bit key):
<4>00112233445566778899aabbccddeeff
<4>pass
<4>test 2 (192 bit key):
<4>00112233445566778899aabbccddeeff
<4>pass
<4>test 3 (256 bit key):
<4>00112233445566778899aabbccddeeff
<4>pass
<4>
<4>testing aes ECB decryption across pages (chunking) 
<4>
<4>testing cast5 ECB encryption 
<4>test 1 (128 bit key):
<4>238b4fe5847e44b2
<4>pass
<4>test 2 (80 bit key):
<4>eb6a711a2c02271b
<4>pass
<4>test 3 (40 bit key):
<4>7ac816d16e9b302e
<4>pass
<4>
<4>testing cast5 ECB encryption across pages (chunking) 
<4>
<4>testing cast5 ECB decryption 
<4>test 1 (128 bit key):
<4>0123456789abcdef
<4>pass
<4>test 2 (80 bit key):
<4>0123456789abcdef
<4>pass
<4>test 3 (40 bit key):
<4>0123456789abcdef
<4>pass
<4>
<4>testing cast5 ECB decryption across pages (chunking) 
<4>
<4>testing cast6 ECB encryption 
<4>test 1 (128 bit key):
<4>c842a08972b43d20836c91d1b7530f6b
<4>pass
<4>test 2 (192 bit key):
<4>1b386c0210dcadcbdd0e41aa08a7a7e8
<4>pass
<4>test 3 (256 bit key):
<4>4f6a2038286897b9c9870136553317fa
<4>pass
<4>
<4>testing cast6 ECB encryption across pages (chunking) 
<4>
<4>testing cast6 ECB decryption 
<4>test 1 (128 bit key):
<4>00000000000000000000000000000000
<4>pass
<4>test 2 (192 bit key):
<4>00000000000000000000000000000000
<4>pass
<4>test 3 (256 bit key):
<4>00000000000000000000000000000000
<4>pass
<4>
<4>testing cast6 ECB decryption across pages (chunking) 
<4>
<4>testing sha384
<4>test 1:
<4>cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7
<4>pass
<4>test 2:
<4>3391fdddfc8dc7393707a65b1b4709397cf8b1d162af05abfe8f450de5f36bc6b0455a8520bc4e6f5fe95b1fe3c8452b
<4>pass
<4>test 3:
<4>09330c33f71147e83d192fc782cd1b4753111b173b3b05d22fa08086e3b0f712fcc7c71a557e2db966c3e9fa91746039
<4>pass
<4>test 4:
<4>3d208973ab3508dbbd7e2c2862ba290ad3010e4978c198dc4d8fd014e582823a89e16f9b2a7bbc1ac938e2d199e8bea4
<4>pass
<4>testing sha384 across pages
<4>test 1:
<4>3d208973ab3508dbbd7e2c2862ba290ad3010e4978c198dc4d8fd014e582823a89e16f9b2a7bbc1ac938e2d199e8bea4
<4>pass
<4>
<4>testing sha512
<4>test 1:
<4>ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f
<4>pass
<4>test 2:
<4>204a8fc6dda82f0a0ced7beb8e08a41657c16ef468b228a8279be331a703c33596fd15c13b1b07f9aa1d3bea57789ca031ad85c7a71dd70354ec631238ca3445
<4>pass
<4>test 3:
<4>8e959b75dae313da8cf4f72814fc143f8f7779c6eb9f7fa17299aeadb6889018501d289e4900f7e4331b99dec4b5433ac7d329eeb6dd26545e96e55b874be909
<4>pass
<4>test 4:
<4>930d0cefcb30ff1133b6898121f1cf3d27578afcafe8677c5257cf069911f75d8f5831b56ebfda67b278e66dff8b84fe2b2870f742a580d8edb41987232850c9
<4>pass
<4>testing sha512 across pages
<4>test 1:
<4>930d0cefcb30ff1133b6898121f1cf3d27578afcafe8677c5257cf069911f75d8f5831b56ebfda67b278e66dff8b84fe2b2870f742a580d8edb41987232850c9
<4>pass
<4>
<4>testing deflate compression
<4>test 1:
<4>f3cacfcc53282d56c8cb2f5748cc4b5128ce482c4a5528c9485528ce4f2b290771bc082b0100
<4>pass (ratio 70:38)
<4>test 2:
<4>5d8d310ec2301004bfb22fc81f10040989c2853f70b12ff824db67d947c1ef49681251ae7667d62719881ade85ab21f2085d161e20042dadf318a215852d69c4428323b66c89719befcf8b9fcf33ca2fed62a94c80ff13af5237ed0e526b5902d94ee87a761d0298fe8a8783a34f568ab89e8e5c57d3a079fa02
<4>pass (ratio 191:122)
<4>
<4>testing deflate decompression
<4>test 1:
<4>5468697320646f63756d656e7420646573637269626573206120636f6d7072657373696f6e206d6574686f64206261736564206f6e20746865204445464c415445636f6d7072657373696f6e20616c676f726974686d2e20205468697320646f63756d656e7420646566696e657320746865206170706c69636174696f6e206f6620746865204445464c41544520616c676f726974686d20746f20746865204950205061796c6f616420436f6d7072657373696f6e2050726f746f636f6c2e
<4>pass (ratio 122:191)
<4>test 2:
<4>4a6f696e207573206e6f7720616e642073686172652074686520736f667477617265204a6f696e207573206e6f7720616e642073686172652074686520736f66747761726520
<4>pass (ratio 38:70)
<4>
<4>testing hmac_md5
<4>test 1:
<4>9294727a3638bb1c13f48ef8158bfc9d
<4>pass
<4>test 2:
<4>750c783e6ab0b503eaa86e310a5db738
<4>pass
<4>test 3:
<4>56be34521d144c88dbb8c733f0e8b3f6
<4>pass
<4>test 4:
<4>697eaf0aca3a3aea3a75164746ffaa79
<4>pass
<4>test 5:
<4>56461ef2342edc00f9bab995690efd4c
<4>pass
<4>test 6:
<4>6b1ab7fe4bd7bf8f0b62e6ce61b9d0cd
<4>pass
<4>test 7:
<4>6f630fad67cda0ee1fb1f562db3aa53e
<4>pass
<4>
<4>testing hmac_md5 across pages
<4>test 1:
<4>750c783e6ab0b503eaa86e310a5db738
<4>pass
<4>
<4>testing hmac_sha1
<4>test 1:
<4>b617318655057264e28bc0b6fb378c8ef146be00
<4>pass
<4>test 2:
<4>effcdf6ae5eb2fa2d27416d5f184df9c259a7c79
<4>pass
<4>test 3:
<4>125d7342b9ac11cd91a39af48aa17b4f63f175d3
<4>pass
<4>test 4:
<4>4c9007f4026250c6bc8414f9bf50c86c2d7235da
<4>pass
<4>test 5:
<4>4c1a03424b55e07fe7f27be1d58bb9324a9a5a04
<4>pass
<4>test 6:
<4>aa4ae5e15272d00e95705637ce8a3b55ed402112
<4>pass
<4>test 7:
<4>e8e99d0f45237d786d6bbaa7965c7808bbff1a91
<4>pass
<4>
<4>testing hmac_sha1 across pages
<4>test 1:
<4>effcdf6ae5eb2fa2d27416d5f184df9c259a7c79
<4>pass
<4>
<4>testing hmac_sha256
<4>test 1:
<4>21d1844619eb36470e81df73392a8df1f24c687557ebea5a8a58164512dbee96
<4>fail
<4>test 2:
<4>00331d3e0761fd86f6a9917406cc716d3e02df6b6a755eaa5b5195bb027f1cab
<4>fail
<4>test 3:
<4>5164eee0e1aa9e76c7e7c87f91276991f30e2fc652c16943198002fa21edb0a3
<4>fail
<4>test 4:
<4>91cec30b0cb21abf319d0da1b9924521b090b32c038fed4fe9e51f5d5071d44e
<4>fail
<4>test 5:
<4>e38342ccad9d5f75b8e0e99862201650fe9b5372596a4e90e85e3278bed9c9a4
<4>fail
<4>test 6:
<4>471479d3bd9d18c47ebe810c9ed807a2db1a37f6ae4031c902c7d1c0777929a1
<4>fail
<4>test 7:
<4>e38775424caf0d8bb2c009a824104514138177f751ac790c2f4c66dbd7703f70
<4>fail
<4>test 8:
<4>35404b92be68c96319b2ab17ef71fde3a7127414793d376b8b1ed15f6f27c474
<4>fail
<4>test 9:
<4>eb937c3e57fd605b63a35ffc4ecdedc796e44c1d986f03b3a3d788ae759662bc
<4>fail
<4>test 10:
<4>b32e156d6fff4611c6c36ba68ab3dbb02a2f8057a8d3732d9ebcf950b6883158
<4>fail
<4>
<4>testing hmac_sha256 across pages
<4>test 1:
<4>e38342ccad9d5f75b8e0e99862201650fe9b5372596a4e90e85e3278bed9c9a4
<4>fail
<6>ACPI: AC Adapter [AC] (on-line)
<6>ACPI: Battery Slot [BAT0] (battery present)
<6>ACPI: Power Button (FF) [PWRF]
<6>ACPI: Lid Switch [LID]
<6>ACPI: Sleep Button (CM) [SLP2]
<6>ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
<6>ACPI: Thermal Zone [THRS] (39 C)
<6>ACPI: Thermal Zone [THRC] (38 C)
<4>pty: 256 Unix98 ptys configured
<7>request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
<6>lp: driver loaded but no devices found
<6>Real Time Clock Driver v1.12
<3>hw_random: RNG not detected
<6>ppdev: user-space parallel port driver
<6>Linux agpgart interface v0.100 (c) Dave Jones
<6>[drm] Initialized i830 1.3.2 20021108 on minor 0
<6>parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
<7>parport0: cpp_daisy: aa5500ff(38)
<7>parport0: assign_addrs: aa5500ff(38)
<7>parport0: cpp_daisy: aa5500ff(38)
<7>parport0: assign_addrs: aa5500ff(38)
<6>lp0: using parport0 (polling).
<6>loop: loaded (max 8 devices)
<4>Using anticipatory io scheduler
<6>nbd: registered device at major 43
<6>b44.c:v0.92 (Nov 4, 2003)
<6>eth0: Broadcom 4400 10/100BaseT Ethernet 00:0a:e4:20:dc:c7
<6>PPP generic driver version 2.4.2
<6>Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
<6>nsc-ircc, Found chip at base=0x02e
<6>nsc-ircc, driver loaded (Dag Brattli)
<6>IrDA: Registered device irda0
<6>nsc-ircc, Found dongle: Sharp RY5HD01
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<6>ICH4: IDE controller at PCI slot 0000:00:1f.1
<4>PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
<6>ICH4: chipset revision 3
<6>ICH4: not 100%% native mode: will probe irqs later
<6>    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
<6>    ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:DMA, hdd:pio
<4>hda: FUJITSU MHT2040AT, ATA DISK drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>hdc: QSI CD-RW/DVD-ROM SBW242U, ATAPI CD/DVD-ROM drive
<4>ide1 at 0x170-0x177,0x376 on irq 15
<4>hda: max request size: 128KiB
<6>hda: 78140160 sectors (40007 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
<6> hda: hda1 hda2 hda3
<4>hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
<6>Uniform CD-ROM driver Revision: 3.12
<6>ohci1394: $Rev: 1087 $ Ben Collins <bcollins@debian.org>
<4>ohci1394: fw-host0: Unexpected PCI resource length of 1000!
<6>ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[e0202000-e02027ff]  Max Packet=[2048]
<6>Yenta: CardBus bridge found at 0000:02:09.0 [1734:1033]
<6>Yenta: ISA IRQ mask 0x0090, PCI irq 10
<6>Socket status: 30000007
<7>ehci_hcd: block sizes: qh 128 qtd 96 itd 128 sitd 64
<6>ehci_hcd 0000:00:1d.7: EHCI Host Controller
<7>ehci_hcd 0000:00:1d.7: reset hcs_params 0x103206 dbg=1 cc=3 pcc=2 ordered !ppc ports=6
<7>ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 bit addr
<7>ehci_hcd 0000:00:1d.7: capability 0001 at 68
<7>PCI: Setting latency timer of device 0000:00:1d.7 to 64
<6>ehci_hcd 0000:00:1d.7: irq 11, pci mem e0099000
<6>ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
<7>ehci_hcd 0000:00:1d.7: reset command 080022 (park)=0 ithresh=8 Async period=1024 Reset HALT
<4>PCI: cache line size of 32 is not supported by device 0000:00:1d.7
<7>ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1024 RUN
<6>ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
<7>ehci_hcd 0000:00:1d.7: root hub device address 1
<7>usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
<7>drivers/usb/core/message.c: USB device number 1 default language ID 0x409
<6>usb usb1: Product: EHCI Host Controller
<6>usb usb1: Manufacturer: Linux 2.6.1 ehci_hcd
<6>usb usb1: SerialNumber: 0000:00:1d.7
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb usb1: registering 1-0:1.0 (config #1, interface 0)
<7>drivers/usb/core/usb.c: usb_hotplug
<7>hub 1-0:1.0: usb_probe_interface
<7>hub 1-0:1.0: usb_probe_interface - got id
<6>hub 1-0:1.0: USB hub found
<6>hub 1-0:1.0: 6 ports detected
<7>hub 1-0:1.0: standalone hub
<7>hub 1-0:1.0: ganged power switching
<7>hub 1-0:1.0: individual port over-current protection
<7>hub 1-0:1.0: Single TT
<7>hub 1-0:1.0: TT requires at most 8 FS bit times
<7>hub 1-0:1.0: Port indicators are not supported
<7>hub 1-0:1.0: power on to power good time: 0ms
<7>hub 1-0:1.0: hub controller current requirement: 0mA
<7>hub 1-0:1.0: local power source is good
<7>hub 1-0:1.0: no over-current condition exists
<7>hub 1-0:1.0: enabling power on all ports
<6>drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
<6>uhci_hcd 0000:00:1d.0: UHCI Host Controller
<7>PCI: Setting latency timer of device 0000:00:1d.0 to 64
<6>uhci_hcd 0000:00:1d.0: irq 11, io base 00001820
<6>uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
<6>drivers/usb/host/uhci-hcd.c: detected 2 ports
<7>uhci_hcd 0000:00:1d.0: root hub device address 1
<7>usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
<7>drivers/usb/core/message.c: USB device number 1 default language ID 0x409
<6>usb usb2: Product: UHCI Host Controller
<6>usb usb2: Manufacturer: Linux 2.6.1 uhci_hcd
<6>usb usb2: SerialNumber: 0000:00:1d.0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb usb2: registering 2-0:1.0 (config #1, interface 0)
<7>drivers/usb/core/usb.c: usb_hotplug
<7>hub 2-0:1.0: usb_probe_interface
<7>hub 2-0:1.0: usb_probe_interface - got id
<6>hub 2-0:1.0: USB hub found
<6>hub 2-0:1.0: 2 ports detected
<7>hub 2-0:1.0: standalone hub
<7>hub 2-0:1.0: ganged power switching
<7>hub 2-0:1.0: global over-current protection
<7>hub 2-0:1.0: Port indicators are not supported
<7>hub 2-0:1.0: power on to power good time: 2ms
<7>hub 2-0:1.0: hub controller current requirement: 0mA
<7>hub 2-0:1.0: local power source is good
<7>hub 2-0:1.0: no over-current condition exists
<7>hub 2-0:1.0: enabling power on all ports
<6>uhci_hcd 0000:00:1d.1: UHCI Host Controller
<7>PCI: Setting latency timer of device 0000:00:1d.1 to 64
<6>uhci_hcd 0000:00:1d.1: irq 11, io base 00001840
<6>uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
<6>drivers/usb/host/uhci-hcd.c: detected 2 ports
<7>uhci_hcd 0000:00:1d.1: root hub device address 1
<7>usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
<7>drivers/usb/core/message.c: USB device number 1 default language ID 0x409
<6>usb usb3: Product: UHCI Host Controller
<6>usb usb3: Manufacturer: Linux 2.6.1 uhci_hcd
<6>usb usb3: SerialNumber: 0000:00:1d.1
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb usb3: registering 3-0:1.0 (config #1, interface 0)
<7>drivers/usb/core/usb.c: usb_hotplug
<7>hub 3-0:1.0: usb_probe_interface
<7>hub 3-0:1.0: usb_probe_interface - got id
<6>hub 3-0:1.0: USB hub found
<6>hub 3-0:1.0: 2 ports detected
<7>hub 3-0:1.0: standalone hub
<7>hub 3-0:1.0: ganged power switching
<7>hub 3-0:1.0: global over-current protection
<7>hub 3-0:1.0: Port indicators are not supported
<7>hub 3-0:1.0: power on to power good time: 2ms
<7>hub 3-0:1.0: hub controller current requirement: 0mA
<7>hub 3-0:1.0: local power source is good
<7>hub 3-0:1.0: no over-current condition exists
<7>hub 3-0:1.0: enabling power on all ports
<6>uhci_hcd 0000:00:1d.2: UHCI Host Controller
<7>PCI: Setting latency timer of device 0000:00:1d.2 to 64
<6>uhci_hcd 0000:00:1d.2: irq 11, io base 00001860
<6>uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
<6>drivers/usb/host/uhci-hcd.c: detected 2 ports
<7>uhci_hcd 0000:00:1d.2: root hub device address 1
<7>usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
<7>drivers/usb/core/message.c: USB device number 1 default language ID 0x409
<6>usb usb4: Product: UHCI Host Controller
<6>usb usb4: Manufacturer: Linux 2.6.1 uhci_hcd
<6>usb usb4: SerialNumber: 0000:00:1d.2
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb usb4: registering 4-0:1.0 (config #1, interface 0)
<7>drivers/usb/core/usb.c: usb_hotplug
<7>hub 4-0:1.0: usb_probe_interface
<7>hub 4-0:1.0: usb_probe_interface - got id
<6>hub 4-0:1.0: USB hub found
<6>hub 4-0:1.0: 2 ports detected
<7>hub 4-0:1.0: standalone hub
<7>hub 4-0:1.0: ganged power switching
<7>hub 4-0:1.0: global over-current protection
<7>hub 4-0:1.0: Port indicators are not supported
<7>hub 4-0:1.0: power on to power good time: 2ms
<7>hub 4-0:1.0: hub controller current requirement: 0mA
<7>hub 4-0:1.0: local power source is good
<7>hub 4-0:1.0: no over-current condition exists
<7>hub 4-0:1.0: enabling power on all ports
<6>drivers/usb/core/usb.c: registered new driver usblp
<6>drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
<6>Initializing USB Mass Storage driver...
<6>drivers/usb/core/usb.c: registered new driver usb-storage
<6>USB Mass Storage support registered.
<6>drivers/usb/core/usb.c: registered new driver hiddev
<6>drivers/usb/core/usb.c: registered new driver hid
<6>drivers/usb/input/hid-core.c: v2.0:USB HID core driver
<6>drivers/usb/core/usb.c: registered new driver mdc800
<6>drivers/usb/image/mdc800.c: v0.7.5 (30/10/2000):USB Driver for Mustek MDC800 Digital Camera
<6>drivers/usb/core/usb.c: registered new driver hpusbscsi
<6>drivers/usb/core/usb.c: registered new driver microtekX6
<6>drivers/usb/core/usb.c: registered new driver usbscanner
<6>drivers/usb/image/scanner.c: 0.4.16:USB Scanner Driver
<6>mice: PS/2 mouse device common for all mice
<6>input: PC Speaker
<6>i8042.c: Detected active multiplexing controller, rev 1.1.
<6>serio: i8042 AUX0 port at 0x60,0x64 irq 12
<6>serio: i8042 AUX1 port at 0x60,0x64 irq 12
<6>serio: i8042 AUX2 port at 0x60,0x64 irq 12
<6>serio: i8042 AUX3 port at 0x60,0x64 irq 12
<6>Synaptics Touchpad, model: 1
<6> Firmware: 5.8
<6> 180 degree mounted touchpad
<6> Sensor: 18
<6> new absolute packet format
<6> Touchpad has extended capability bits
<6> -> 4 multi-buttons, i.e. besides standard buttons
<6> -> multifinger detection
<6> -> palm detection
<6>input: SynPS/2 Synaptics TouchPad on isa0060/serio4
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>input: AT Translated Set 2 keyboard on isa0060/serio0
<6>Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
<7>PCI: Setting latency timer of device 0000:00:1f.5 to 64
<7>ieee1394: Host added: ID:BUS[0-00:1023]  GUID[03e40a0097072036]
<7>drivers/usb/host/uhci-hcd.c: 1820: suspend_hc
<7>drivers/usb/host/uhci-hcd.c: 1840: suspend_hc
<7>drivers/usb/host/uhci-hcd.c: 1860: suspend_hc
<6>intel8x0: clocking to 48000
<6>ALSA device list:
<6>  #0: Intel 82801DB-ICH4 at 0xe0100c00, irq 10
<6>NET: Registered protocol family 2
<6>IP: routing cache hash table of 4096 buckets, 32Kbytes
<6>TCP: Hash tables configured (established 32768 bind 65536)
<6>NET: Registered protocol family 1
<6>NET: Registered protocol family 17
<6>IrCOMM protocol (Dag Brattli)
<6>cpufreq: No CPUs supporting ACPI performance management found.
<6>BIOS EDD facility v0.10 2003-Oct-11, 1 devices found
<6>Please report your BIOS at http://domsch.com/linux/edd30/results.html
<4>Resume Machine: resuming from /dev/hda3
<4>Resuming from device hda3
<4>Resume Machine: Signature found, resuming
<3>Resume Machine: Incorrect version
<4>Resume Machine: Error -1 resuming
Resume Machine: Signature found, resuming
Resume Machine: Incorrect version
Resume Machine: Error -1 resuming
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda2) for (hda2)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 148k freed
request_module: failed /sbin/modprobe -- char-major-4-64. error = 256
Unable to find swap-space signature
NTFS volume version 3.1.
Unable to find swap-space signature
b44: eth0: Link is down.
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is on for TX and on for RX.
raw1394: /dev/raw1394 device initialized
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver resynced.
Synaptics driver lost sync at byte 4
Synaptics driver lost sync at byte 1
Synaptics driver resynced.
request_module: failed /sbin/modprobe -- net-pf-10. error = 256
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver resynced.
request_module: failed /sbin/modprobe -- char-major-4-64. error = 256
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver resynced.
Synaptics driver lost sync at byte 4
Synaptics driver lost sync at byte 4
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 4
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver resynced.
Synaptics driver lost sync at byte 4
Synaptics driver lost sync at byte 1
Synaptics driver resynced.



On Yesterday, Dmitry Torokhov wrote:

>From: Dmitry Torokhov <dtor_core@ameritech.net>
>Date: Sat, 10 Jan 2004 23:57:00 -0500
>To: Gunter Königsmann <gunter.koenigsmann@gmx.de>,
>     Gunter Königsmann <gunter@peterpall.de>
>Delivered-To: GMX delivery to gunter.koenigsmann@gmx.de
>Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
>     Andrew Morton <akpm@osdl.org>
>Subject: Re: [PATCH 3/2] Psmouse log and discard timed out bytes - addition
>
>Hi Gunter,
>
>I have some additions to the last patch and I'd like you to give it a spin.
>Also, could you please define DEBUG symbol in drivers/input/serio/i8042.c
>and send me your dmesg with boot data and also when the touchpad loses
>sync. I'd like to see it in all gory details :)
>
>Thank you,
>
>Dmitry
>
>
>===================================================================
>
>
>ChangeSet@1.1514, 2004-01-10 23:50:51-05:00, dtor_core@ameritech.net
>  Input: Change the way timeouts/parity errors are handled:
>         - Only complain about errors from keyboard controller if mouse
>           is activated
>         - Reset packet count to 0 as the next received byte will most
>           likely be the first byte of a new packet
>         - If expecting an ACK from the mouse set NACK condition
>
>
> psmouse-base.c |   12 +++++++++---
> 1 files changed, 9 insertions(+), 3 deletions(-)
>
>
>===================================================================
>
>
>
>diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
>--- a/drivers/input/mouse/psmouse-base.c	Sat Jan 10 23:55:28 2004
>+++ b/drivers/input/mouse/psmouse-base.c	Sat Jan 10 23:55:28 2004
>@@ -122,9 +122,15 @@
> 		goto out;
>
> 	if (flags & (SERIO_PARITY|SERIO_TIMEOUT)) {
>-		printk(KERN_WARNING "psmouse.c: bad data from KBC -%s%s\n",
>-			flags & SERIO_TIMEOUT ? " timeout" : "",
>-			flags & SERIO_PARITY ? " bad parity" : "");
>+		if (psmouse->state == PSMOUSE_ACTIVATED)
>+			printk(KERN_WARNING "psmouse.c: bad data from KBC -%s%s\n",
>+				flags & SERIO_TIMEOUT ? " timeout" : "",
>+				flags & SERIO_PARITY ? " bad parity" : "");
>+		if (psmouse->acking) {
>+			psmouse->ack = -1;
>+			psmouse->acking = 0;
>+		}
>+		psmouse->pktcnt = 0;
> 		goto out;
> 	}
>
>

-- 
THE MX IS GOOD FOR THE ECONOMY.  One important reason we have a Defense
Department is that when we give it money, it spends it, which creates
jobs, whereas if we left the money in the hands of civilians, we don't
know what they'd do with it.  Probably put it in open trenches and set
it on fire.  The MX will create an especially large number of jobs
because of the number of warheads it carries.  It carries a total of 10
warheads.  This creates a great deal of employment, because you have
your Warhead Makers, your Warhead Lifters, your Persons Who Tap the
Warheads Gently with Rubber Mallets to Wedge Them All Snugly Into the
Nose Cone, your Persons Who Just Walk Around Playing Soothing Cassettes
by Recording Artists such as Perry Como So We Don't Have Any More
Episodes Where a Worker Who is Experiencing Some Strain Sticks a
Warhead in the Employee Cafeteria Microwave and Sets It On Roast, etc.
We are talking about a lot of jobs.
                -- Dave Barry, "At Last, the Ultimate Deterrent Against
                   Political Fallout
