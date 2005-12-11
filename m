Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbVLKNsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbVLKNsv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 08:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVLKNsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 08:48:51 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:2188 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751363AbVLKNst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 08:48:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=mmjQnrFMDeW6s4unjq2pKMnsRWskNIMwZw/WY1+sq7KWJ8OyzCU5eZQ3EEtNDea09ffXUiV5UkHd10v9j5IVJkjEY5+qVzS0sY2P3Jn7ba0s89gzwN4YzO83CE2Qja+4Fqpdo2EC+Eic9ciiNOIEtNDi87vWy99ys4/G7sCbXVg=
Message-ID: <9a8748490512110548h22889559ld81374f2626c3ed2@mail.gmail.com>
Date: Sun, 11 Dec 2005 14:48:48 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: LKML List <linux-kernel@vger.kernel.org>
Subject: Mouse stalls with 2.6.5-rc5-mm2
Cc: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_10660_16197143.1134308928781"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_10660_16197143.1134308928781
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

With 2.6.5-rc5-mm2 I'm getting regular mouse stalls for short periods
of time ~1sec
I'm also seeing this in dmesg :

[  117.308573] psmouse.c: resync failed, issuing reconnect request
[  157.100063] psmouse.c: resync failed, issuing reconnect request
[  167.583936] psmouse.c: resync failed, issuing reconnect request
[  278.986267] psmouse.c: resync failed, issuing reconnect request
[  328.320242] psmouse.c: resync failed, issuing reconnect request
[  358.117414] psmouse.c: resync failed, issuing reconnect request
[  472.814321] psmouse.c: resync failed, issuing reconnect request
[  492.781941] psmouse.c: resync failed, issuing reconnect request
[  525.788327] psmouse.c: resync failed, issuing reconnect request
[  542.843044] psmouse.c: resync failed, issuing reconnect request
[  552.129681] psmouse.c: resync failed, issuing reconnect request

The times correspond nicely to the mouse stalls, every time it stalls
I get a new line, so they are definately related.

2.6.5-rc5-git1 works flawlessly.
No hardware has changed.
Mouse is a Logitech MouseMan Wheel (M/N: M-BD53) connected to a
"Master View PRO" KVM switch.

Comlete dmesg output, .config, ver_linux output, lspci output, lsusb
output and cat /proc/cpuinfo output attached. Please just ask if
anything else is needed.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

------=_Part_10660_16197143.1134308928781
Content-Type: text/plain; name=dmesg.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg.txt"

[4294667.296000] Linux version 2.6.15-rc5-mm2 (juhl@dragon) (gcc version 3.3.6) #1 PREEMPT Sun Dec 11 14:15:18 CET 2005
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[4294667.296000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
[4294667.296000]  BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
[4294667.296000]  BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
[4294667.296000]  BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
[4294667.296000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
[4294667.296000] 511MB LOWMEM available.
[4294667.296000] On node 0 totalpages: 131052
[4294667.296000]   DMA zone: 4096 pages, LIFO batch:0
[4294667.296000]   DMA32 zone: 0 pages, LIFO batch:0
[4294667.296000]   Normal zone: 126956 pages, LIFO batch:31
[4294667.296000]   HighMem zone: 0 pages, LIFO batch:0
[4294667.296000] DMI 2.3 present.
[4294667.296000] ACPI: RSDP (v000 ASUS                                  ) @ 0x000f69e0
[4294667.296000] ACPI: RSDT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec000
[4294667.296000] ACPI: FADT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec080
[4294667.296000] ACPI: BOOT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec040
[4294667.296000] ACPI: DSDT (v001   ASUS A7M266   0x00001000 MSFT 0x0100000b) @ 0x00000000
[4294667.296000] Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Local APIC disabled by BIOS -- you can enable it with "lapic"
[4294667.296000] mapped APIC to ffffd000 (01402000)
[4294667.296000] Enabling fast FPU save and restore... done.
[4294667.296000] Initializing CPU#0
[4294667.296000] Kernel command line: BOOT_IMAGE=2.6.15-rc5-mm2 ro root=801 pci=usepirqmask
[4294667.296000] CPU 0 irqstacks, hard=c03fc000 soft=c03fb000
[4294667.296000] PID hash table entries: 2048 (order: 11, 32768 bytes)
[    0.000000] Detected 1400.282 MHz processor.
[   23.926053] Using tsc for high-res timesource
[   23.927637] Console: colour VGA+ 80x25
[   23.929984] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   23.932523] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   23.957079] Memory: 515512k/524208k available (1981k kernel code, 8184k reserved, 865k data, 180k init, 0k highmem)
[   23.957152] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   24.016334] Calibrating delay using timer specific routine.. 2803.71 BogoMIPS (lpj=1401858)
[   24.016486] Mount-cache hash table entries: 512
[   24.016683] CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
[   24.016694] CPU: After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
[   24.016704] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   24.016759] CPU: L2 Cache: 256K (64 bytes/line)
[   24.016808] CPU: After all inits, caps: 0183f9ff c1c7f9ff 00000000 00000020 00000000 00000000 00000000
[   24.016816] Intel machine check architecture supported.
[   24.016867] Intel machine check reporting enabled on CPU#0.
[   24.016929] mtrr: v2.0 (20020519)
[   24.016979] CPU: AMD Athlon(tm) Processor stepping 04
[   24.017094] Checking 'hlt' instruction... OK.
[   24.028337] ACPI: setting ELCR to 0200 (from 0838)
[   24.029079] NET: Registered protocol family 16
[   24.029162] ACPI: bus type pci registered
[   24.030219] PCI: PCI BIOS revision 2.10 entry at 0xf0d40, last bus=1
[   24.030281] PCI: Using configuration type 1
[   24.030950] ACPI: Subsystem revision 20050916
[   24.037076] ACPI: Interpreter enabled
[   24.037128] ACPI: Using PIC for interrupt routing
[   24.037952] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 *4 5 6 7 9 10 11 12 14 15)
[   24.038736] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[   24.039531] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[   24.040298] ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
[   24.042291] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   24.042656] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[   24.044699] PCI quirk: region e300-e37f claimed by vt82c686 HW-mon
[   24.044755] PCI quirk: region e800-e80f claimed by vt82c686 SMB
[   24.045123] Boot video device is 0000:01:05.0
[   24.045163] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   24.117301] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
[   24.123952] SCSI subsystem initialized
[   24.124009] PCI: Using ACPI for IRQ routing
[   24.124062] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   24.136629] PCI: Bridge: 0000:00:01.0
[   24.136680]   IO window: disabled.
[   24.136732]   MEM window: e5000000-e5efffff
[   24.136781]   PREFETCH window: e7f00000-f77fffff
[   24.136843] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   24.136930] Simple Boot Flag at 0x3a set to 0x1
[   24.137036] Machine check exception polling timer started.
[   24.137197] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[   24.137271] apm: overridden by ACPI.
[   24.138526] io scheduler noop registered
[   24.138618] io scheduler anticipatory registered
[   24.138701] io scheduler deadline registered
[   24.138790] io scheduler cfq registered
[   24.138877] PCI: Disabling Via external APIC routing
[   24.142464] Real Time Clock Driver v1.12
[   24.142805] serio: i8042 AUX port at 0x60,0x64 irq 12
[   24.142927] serio: i8042 KBD port at 0x60,0x64 irq 1
[   24.143035] Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
[   24.143502] mice: PS/2 mouse device common for all mice
[   24.143715] Floppy drive(s): fd0 is 1.44M
[   24.157943] FDC 0 is a post-1991 82077
[   24.158970] via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
[   24.159050] PCI: Enabling device 0000:00:09.0 (0094 -> 0097)
[   24.159537] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 3
[   24.159590] PCI: setting IRQ 3 as level-triggered
[   24.159597] ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 3 (level, low) -> IRQ 3
[   24.159745] PCI: Via IRQ fixup for 0000:00:09.0, from 255 to 3
[   24.163867] eth0: VIA Rhine II at 0xe4800000, 00:50:ba:f2:a3:1d, IRQ 3.
[   24.164811] eth0: MII PHY found at address 8, status 0x782d advertising 01e1 Link 45e1.
[   24.165352] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
[   24.165404] PCI: setting IRQ 5 as level-triggered
[   24.165410] ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
[   24.191806] input: AT Translated Set 2 keyboard as /class/input/input0
[   24.375385] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
[   24.375387]         <Adaptec 29160N Ultra160 SCSI adapter>
[   24.375390]         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
[   24.375392] 
[   24.803728] input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
[   40.396005]   Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.03
[   40.397017]   Type:   CD-ROM                             ANSI SCSI revision: 02
[   40.397169]  target0:0:4: Beginning Domain Validation
[   40.400265]  target0:0:4: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
[   40.402211]  target0:0:4: Domain Validation skipping write tests
[   40.402262]  target0:0:4: Ending Domain Validation
[   40.407342]   Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.01
[   40.408350]   Type:   CD-ROM                             ANSI SCSI revision: 02
[   40.408483]  target0:0:5: Beginning Domain Validation
[   40.410351]  target0:0:5: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
[   40.411575]  target0:0:5: Domain Validation skipping write tests
[   40.411628]  target0:0:5: Ending Domain Validation
[   40.412974]   Vendor: IBM       Model: DDYS-T36950N      Rev: S96H
[   40.413980]   Type:   Direct-Access                      ANSI SCSI revision: 03
[   40.414114] scsi0:A:6:0: Tagged Queuing enabled.  Depth 200
[   40.414200]  target0:0:6: Beginning Domain Validation
[   40.417055]  target0:0:6: wide asynchronous.
[   40.419217]  target0:0:6: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
[   40.432705]  target0:0:6: Ending Domain Validation
[   42.484356] SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
[   42.485678] SCSI device sda: drive cache: write back
[   42.486698] SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
[   42.488011] SCSI device sda: drive cache: write back
[   42.488064]  sda: sda1 sda2 sda3 sda4
[   42.501052] sd 0:0:6:0: Attached scsi disk sda
[   42.503080] sr0: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
[   42.503134] Uniform CD-ROM driver Revision: 3.20
[   42.503262] sr 0:0:4:0: Attached scsi CD-ROM sr0
[   42.508185] sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
[   42.508282] sr 0:0:5:0: Attached scsi CD-ROM sr1
[   42.508362] sr 0:0:4:0: Attached scsi generic sg0 type 5
[   42.508447] sr 0:0:5:0: Attached scsi generic sg1 type 5
[   42.508532] sd 0:0:6:0: Attached scsi generic sg2 type 0
[   42.508595] MC: drivers/edac/edac_mc.c version MC $Revision: 1.4.2.10 $
[   42.508767] MC0: Giving out device to amd76x_edac AMD761: PCI 0000:00:00.0 (0000:00:00.0)
[   42.508890] NET: Registered protocol family 2
[   42.518389] IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
[   42.518631] TCP established hash table entries: 32768 (order: 5, 131072 bytes)
[   42.519125] TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
[   42.519637] TCP: Hash tables configured (established 32768 bind 32768)
[   42.519689] TCP reno registered
[   42.519813] TCP bic registered
[   42.519876] NET: Registered protocol family 1
[   42.519932] NET: Registered protocol family 17
[   42.519986] Using IPI Shortcut mode
[   42.520181] ACPI wakeup devices: 
[   42.520234] PWRB PCI0 PCI1 USB0 USB1 
[   42.520454] ACPI: (supports S0 S1 S4 S5)
[   42.532494] EXT3-fs: mounted filesystem with ordered data mode.
[   42.532557] VFS: Mounted root (ext3 filesystem) readonly.
[   42.532969] Freeing unused kernel memory: 180k freed
[   42.533034] Write protecting the kernel read-only data: 373k
[   42.533559] kjournald starting.  Commit interval 5 seconds
[   44.202109] Adding 763076k swap on /dev/sda3.  Priority:-1 extents:1 across:763076k
[   44.286833] EXT3 FS on sda1, internal journal
[   45.189033] Linux agpgart interface v0.101 (c) Dave Jones
[   48.504736] ReiserFS: sda2: found reiserfs format "3.6" with standard journal
[   48.787778] ReiserFS: sda2: using ordered data mode
[   48.793073] ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   48.795422] ReiserFS: sda2: checking transaction log (sda2)
[   48.807748] ReiserFS: sda2: Using r5 hash to sort names
[   48.839565] ReiserFS: sda4: found reiserfs format "3.6" with standard journal
[   49.537162] ReiserFS: sda4: using ordered data mode
[   49.584241] ReiserFS: sda4: journal params: device sda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   49.586694] ReiserFS: sda4: checking transaction log (sda4)
[   49.644802] ReiserFS: sda4: Using r5 hash to sort names
[   51.591953] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[   52.259631] PCI: Enabling device 0000:00:0d.0 (0004 -> 0005)
[   52.259833] ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 3 (level, low) -> IRQ 3
[   52.663925] usbcore: registered new driver usbfs
[   52.682803] usbcore: registered new driver hub
[   52.722065] USB Universal Host Controller Interface driver v2.3
[   52.740895] ACPI: PCI Interrupt 0000:00:04.2[D] -> Link [LNKD] -> GSI 3 (level, low) -> IRQ 3
[   52.741098] uhci_hcd 0000:00:04.2: UHCI Host Controller
[   52.760474] uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
[   52.760663] uhci_hcd 0000:00:04.2: irq 3, io base 0x0000d400
[   52.779025] usb usb1: configuration #1 chosen from 1 choice
[   52.800295] hub 1-0:1.0: USB hub found
[   52.800496] hub 1-0:1.0: 2 ports detected
[   52.918723] ACPI: PCI Interrupt 0000:00:04.3[D] -> Link [LNKD] -> GSI 3 (level, low) -> IRQ 3
[   52.918924] uhci_hcd 0000:00:04.3: UHCI Host Controller
[   52.936088] uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
[   52.936277] uhci_hcd 0000:00:04.3: irq 3, io base 0x0000d000
[   52.954141] usb usb2: configuration #1 chosen from 1 choice
[   52.963533] hub 2-0:1.0: USB hub found
[   52.963744] hub 2-0:1.0: 2 ports detected
[  117.308573] psmouse.c: resync failed, issuing reconnect request
[  157.100063] psmouse.c: resync failed, issuing reconnect request
[  167.583936] psmouse.c: resync failed, issuing reconnect request
[  278.986267] psmouse.c: resync failed, issuing reconnect request
[  328.320242] psmouse.c: resync failed, issuing reconnect request
[  358.117414] psmouse.c: resync failed, issuing reconnect request
[  472.814321] psmouse.c: resync failed, issuing reconnect request
[  492.781941] psmouse.c: resync failed, issuing reconnect request
[  525.788327] psmouse.c: resync failed, issuing reconnect request
[  542.843044] psmouse.c: resync failed, issuing reconnect request
[  552.129681] psmouse.c: resync failed, issuing reconnect request
[  602.945594] psmouse.c: resync failed, issuing reconnect request
[  646.105203] psmouse.c: resync failed, issuing reconnect request
[  673.600571] psmouse.c: resync failed, issuing reconnect request
[  828.893419] psmouse.c: resync failed, issuing reconnect request
[  842.271094] psmouse.c: resync failed, issuing reconnect request
[  893.756793] psmouse.c: resync failed, issuing reconnect request

------=_Part_10660_16197143.1134308928781
Content-Type: text/plain; name=config.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="config.txt"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.15-rc5-mm2
# Sun Dec 11 14:02:13 2005
#
CONFIG_X86_32=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=y
CONFIG_SWAP_PREFETCH=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_DOUBLEFAULT=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_SLAB=y
CONFIG_SERIAL_PCI=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y

#
# Block layer
#
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_TSC=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_CS5535 is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_REGPARM=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_PHYSICAL_START=0x100000
# CONFIG_KEXEC is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_HOTKEY=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_IBM=m
CONFIG_ACPI_TOSHIBA=m
# CONFIG_ACPI_SONY is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set
# CONFIG_ACPI_CONTAINER is not set

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
CONFIG_APM_REAL_MODE_POWER_OFF=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SAS_CLASS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=200
CONFIG_AIC7XXX_RESET_DELAY_MS=15001
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA24XX is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
CONFIG_VIA_RHINE=y
CONFIG_VIA_RHINE_MMIO=y

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
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

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
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1600
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1200
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_WISTRON_BTNS is not set
CONFIG_INPUT_UINPUT=m

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

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
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=2
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=y
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# SPI support
#
CONFIG_SPI_ARCH_HAS_MASTER=y
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5535AUDIO is not set
CONFIG_SND_EMU10K1=m
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_IP is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
# CONFIG_USB_HID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
CONFIG_USB_MON=y

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_GOTEMP is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# EDAC - error detection and reporting (RAS)
#
CONFIG_EDAC=y

#
# Reporting subsystems
#
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_MM_EDAC=y
CONFIG_EDAC_AMD76X=y
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
CONFIG_EDAC_POLL=y

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set

#
# File systems
#
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
# CONFIG_REISER4_FS is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=865
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_RELAYFS_FS is not set
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ASFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
CONFIG_PRINTK_TIME=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=16
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
CONFIG_FRAME_POINTER=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_DEBUG_RODATA=y
CONFIG_4KSTACKS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
# CONFIG_KGDB is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Hardware crypto devices
#

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_KTIME_SCALAR=y

------=_Part_10660_16197143.1134308928781
Content-Type: text/plain; name=ver_linux.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ver_linux.txt"

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux dragon 2.6.15-rc5-mm2 #1 PREEMPT Sun Dec 11 14:15:18 CET 2005 i686 unknown unknown GNU/Linux
 
Gnu C                  3.3.6
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.38
reiserfsprogs          3.6.19
quota-tools            3.12.
PPP                    2.4.4b1
nfs-utils              1.0.7
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Linux C++ Library      5.0.7
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   064
Modules Loaded         snd_pcm_oss snd_mixer_oss uhci_hcd usbcore snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer snd_page_alloc snd_util_mem snd_hwdep snd agpgart

------=_Part_10660_16197143.1134308928781
Content-Type: text/plain; name=lspci.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lspci.txt"

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System Controller (rev 13)
	Flags: bus master, medium devsel, latency 32
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Memory at f7800000 (32-bit, prefetchable) [size=4K]
	I/O ports at e000 [disabled] [size=4]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP Bridge (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: e5000000-e5efffff
	Prefetchable memory behind bridge: e7f00000-f77fffff

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: ASUSTeK Computer Inc. A7M266 Mainboard
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: <available only to root>

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at d800 [size=16]
	Capabilities: <available only to root>

00:04.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 3
	I/O ports at d400 [size=32]
	Capabilities: <available only to root>

00:04.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 3
	I/O ports at d000 [size=32]
	Capabilities: <available only to root>

00:04.4 Non-VGA unclassified device: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: ASUSTeK Computer Inc. A7M266 Mainboard
	Flags: medium devsel, IRQ 9
	Capabilities: <available only to root>

00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: ASUSTeK Computer Inc. CMI8738 6ch-MX
	Flags: bus master, stepping, medium devsel, latency 32, IRQ 5
	I/O ports at a400 [size=256]
	Capabilities: <available only to root>

00:09.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 42)
	Subsystem: D-Link System Inc DFE-530TX rev B
	Flags: bus master, stepping, medium devsel, latency 32, IRQ 3
	I/O ports at a000 [size=256]
	Memory at e4800000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at 30020000 [disabled] [size=64K]
	Capabilities: <available only to root>

00:0a.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W [Millennium II] (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc.: Unknown device 0100
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at e6000000 (32-bit, prefetchable) [size=16M]
	Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
	Memory at e3800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at e5ff0000 [disabled] [size=64K]

00:0b.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
	Subsystem: Adaptec 29160N Ultra160 SCSI Controller
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 5
	BIST result: 00
	I/O ports at 9800 [disabled] [size=256]
	Memory at e3000000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at 30000000 [disabled] [size=128K]
	Capabilities: <available only to root>

00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
	Subsystem: Creative Labs SBLive! 5.1 eMicro 28028
	Flags: bus master, medium devsel, latency 32, IRQ 3
	I/O ports at 9400 [size=32]
	Capabilities: <available only to root>

00:0d.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 0a)
	Subsystem: Creative Labs Gameport Joystick
	Flags: bus master, medium devsel, latency 32
	I/O ports at 9000 [disabled] [size=8]
	Capabilities: <available only to root>

01:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA Parhelia AGP (rev 03) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Parhelia 128Mb
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 4
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Memory at e5000000 (32-bit, non-prefetchable) [size=8K]
	Expansion ROM at e7fe0000 [disabled] [size=128K]
	Capabilities: <available only to root>


------=_Part_10660_16197143.1134308928781
Content-Type: text/plain; name=lsusb.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lsusb.txt"


Bus 002 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 
  iProduct                2 
  iSerial                 1 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 twice
        bInterval             255

Bus 001 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 
  iProduct                2 
  iSerial                 1 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 twice
        bInterval             255

------=_Part_10660_16197143.1134308928781
Content-Type: text/plain; name=cpuinfo.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cpuinfo.txt"

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) Processor
stepping	: 4
cpu MHz		: 1400.282
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 2803.71


------=_Part_10660_16197143.1134308928781--
