Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265256AbUGGR5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUGGR5F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 13:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265257AbUGGR5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 13:57:05 -0400
Received: from warsl404pip7.highway.telekom.at ([195.3.96.91]:27953 "HELO
	email08.aon.at") by vger.kernel.org with SMTP id S265256AbUGGRzw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 13:55:52 -0400
Message-ID: <40EC3921.6010609@yahoo.de>
Date: Wed, 07 Jul 2004 19:55:45 +0200
From: Wiesner Thomas <w15mail@yahoo.de>
Reply-To: w15mail@yahoo.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-DE; rv:1.4) Gecko/20030619 Netscape/7.1 (ax)
X-Accept-Language: de-de, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /proc/acpi/battery/BAT1/state shows wrong battery state (correct
 after some 'cat's)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/acpi/battery/BAT1/state shows wrong battery state (correct after 
some 'cat's)
--------------------------------

I´ve got a problem with ACPI on a Gericom SilverSeraph Per4mance.
When doing a
   cat /proc/acpi/battery/BAT1/state
It shows a wong remaining battery capacity of 2040mAh
(which is wrong, because the battery is full = 400mAh).
The wrong display occurs every time (no matter wether the AC adaptor is
plugged in or not.)

After 'cat'ting the file 5 times, it is correct beginning from the fifth 
time.

I Use kernel 2.6.7 and upgraded from 2.6.4 which didn´t have the problem.

It is running debain Woody 3.0

I´ve just made a BIOS update to the latest version, but it
didn´t change it.

BTW: I know that ACPI tells me, that the AML interpreter is not correct,
but hey - it worked in 2.6.4. I have Windows XP Home installed too, and 
it seems to have the same problem, as on bootup, for some seconds the 
battery icon (which I can only see when running from bat) is half full 
and jumps to full after about 8 seconds.

   Thank you in Advance

   Wiesner Thomas




Here are the results from the 'cat's:

gericom:~# cat /proc/acpi/battery/BAT1/state
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mA
remaining capacity:      2040 mAh
present voltage:         14800 mV
gericom:~# cat /proc/acpi/battery/BAT1/state
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mA
remaining capacity:      2040 mAh
present voltage:         14800 mV
gericom:~# cat /proc/acpi/battery/BAT1/state
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mA
remaining capacity:      2040 mAh
present voltage:         14800 mV
gericom:~# cat /proc/acpi/battery/BAT1/state
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mA
remaining capacity:      2040 mAh
present voltage:         14800 mV
gericom:~# cat /proc/acpi/battery/BAT1/state
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            0 mA
remaining capacity:      3720 mAh
present voltage:         14800 mV


/var/log/messages:

Jul  7 19:39:15 gericom syslogd 1.4.1#10: restart.
Jul  7 19:39:15 gericom kernel: klogd 1.4.1#10, log source = /proc/kmsg 
started.
Jul  7 19:39:16 gericom kernel: Inspecting /boot/System.map-2.6.4
Jul  7 19:39:16 gericom kernel: Loaded 22373 symbols from 
/boot/System.map-2.6.4.
Jul  7 19:39:16 gericom kernel: Symbols match kernel version 2.6.4.
Jul  7 19:39:16 gericom kernel: No module symbols loaded - kernel 
modules not enabled.
Jul  7 19:39:16 gericom kernel: Linux version 2.6.4 (thomas@gericom) 
(gcc version 2.95.4 20011002 (Debian prerelease)) #1 Fri Mar 26 20:13:13 
CET 2004
Jul  7 19:39:16 gericom kernel: BIOS-provided physical RAM map:
Jul  7 19:39:16 gericom kernel:  BIOS-e820: 0000000000000000 - 
000000000009f800 (usable)
Jul  7 19:39:16 gericom kernel:  BIOS-e820: 000000000009f800 - 
00000000000a0000 (reserved)
Jul  7 19:39:16 gericom kernel:  BIOS-e820: 00000000000dc000 - 
0000000000100000 (reserved)
Jul  7 19:39:16 gericom kernel:  BIOS-e820: 0000000000100000 - 
000000001fef0000 (usable)
Jul  7 19:39:16 gericom kernel:  BIOS-e820: 000000001fef0000 - 
000000001fefc000 (ACPI data)
Jul  7 19:39:16 gericom kernel:  BIOS-e820: 000000001fefc000 - 
000000001ff00000 (ACPI NVS)
Jul  7 19:39:16 gericom kernel:  BIOS-e820: 000000001ff00000 - 
000000001ff80000 (usable)
Jul  7 19:39:16 gericom kernel:  BIOS-e820: 000000001ff80000 - 
0000000020000000 (reserved)
Jul  7 19:39:16 gericom kernel:  BIOS-e820: 00000000ffb80000 - 
00000000ffc00000 (reserved)
Jul  7 19:39:16 gericom kernel:  BIOS-e820: 00000000fff00000 - 
0000000100000000 (reserved)
Jul  7 19:39:16 gericom kernel: 511MB LOWMEM available.
Jul  7 19:39:16 gericom kernel: On node 0 totalpages: 130944
Jul  7 19:39:16 gericom kernel:   DMA zone: 4096 pages, LIFO batch:1
Jul  7 19:39:16 gericom kernel:   Normal zone: 126848 pages, LIFO batch:16
Jul  7 19:39:16 gericom kernel:   HighMem zone: 0 pages, LIFO batch:1
Jul  7 19:39:16 gericom kernel: DMI present.
Jul  7 19:39:16 gericom kernel: ACPI: RSDP (v000 PTLTD 
                    ) @ 0x000f7290
Jul  7 19:39:16 gericom kernel: ACPI: RSDT (v001 PTLTD    RSDT 
0x06040000  LTP 0x00000000) @ 0x1fef59b9
Jul  7 19:39:16 gericom kernel: ACPI: FADT (v001 INTEL  845M 
0x06040000 PTL  0x0000004b) @ 0x1fefbf8c
Jul  7 19:39:16 gericom kernel: ACPI: DSDT (v001 COMPAL 845M 
0x06040000 MSFT 0x0100000d) @ 0x00000000
Jul  7 19:39:16 gericom kernel: Built 1 zonelists
Jul  7 19:39:16 gericom kernel: Kernel command line: 
BOOT_IMAGE=Linux-2.6.4 ro root=305
Jul  7 19:39:16 gericom kernel: Initializing CPU#0
Jul  7 19:39:16 gericom kernel: PID hash table entries: 2048 (order 11: 
16384 bytes)
Jul  7 19:39:16 gericom kernel: Detected 1196.565 MHz processor.
Jul  7 19:39:16 gericom kernel: Using tsc for high-res timesource
Jul  7 19:39:16 gericom kernel: Console: colour VGA+ 80x25
Jul  7 19:39:16 gericom kernel: Memory: 515096k/523776k available (1584k 
kernel code, 7848k reserved, 809k data, 108k init, 0k highmem)
Jul  7 19:39:16 gericom kernel: Checking if this processor honours the 
WP bit even in supervisor mode... Ok.
Jul  7 19:39:16 gericom kernel: Calibrating delay loop... 2351.10 BogoMIPS
Jul  7 19:39:16 gericom kernel: Dentry cache hash table entries: 65536 
(order: 6, 262144 bytes)
Jul  7 19:39:16 gericom kernel: Inode-cache hash table entries: 32768 
(order: 5, 131072 bytes)
Jul  7 19:39:16 gericom kernel: Mount-cache hash table entries: 512 
(order: 0, 4096 bytes)
Jul  7 19:39:16 gericom kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jul  7 19:39:16 gericom kernel: CPU: L2 cache: 512K
Jul  7 19:39:16 gericom kernel: Intel machine check architecture supported.
Jul  7 19:39:16 gericom kernel: Intel machine check reporting enabled on 
CPU#0.
Jul  7 19:39:16 gericom kernel: CPU#0: Intel P4/Xeon Extended MCE MSRs 
(12) available
Jul  7 19:39:16 gericom kernel: CPU: Intel(R) Pentium(R) 4 Mobile CPU 
1.60GHz stepping 04
Jul  7 19:39:16 gericom kernel: Enabling fast FPU save and restore... done.
Jul  7 19:39:16 gericom kernel: Enabling unmasked SIMD FPU exception 
support... done.
Jul  7 19:39:16 gericom kernel: Checking 'hlt' instruction... OK.
Jul  7 19:39:16 gericom kernel: POSIX conformance testing by UNIFIX
Jul  7 19:39:16 gericom kernel: NET: Registered protocol family 16
Jul  7 19:39:16 gericom kernel: PCI: PCI BIOS revision 2.10 entry at 
0xfd984, last bus=2
Jul  7 19:39:16 gericom kernel: PCI: Using configuration type 1
Jul  7 19:39:16 gericom kernel: mtrr: v2.0 (20020519)
Jul  7 19:39:16 gericom kernel: ACPI: Subsystem revision 20040220
Jul  7 19:39:16 gericom kernel: ACPI: IRQ9 SCI: Edge set to Level Trigger.
Jul  7 19:39:16 gericom kernel: ACPI: Interpreter enabled
Jul  7 19:39:16 gericom kernel: ACPI: Using PIC for interrupt routing
Jul  7 19:39:16 gericom kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jul  7 19:39:16 gericom kernel: PCI: Probing PCI hardware (bus 00)
Jul  7 19:39:16 gericom kernel: Transparent bridge - 0000:00:1e.0
Jul  7 19:39:16 gericom kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
Jul  7 19:39:16 gericom kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
Jul  7 19:39:16 gericom kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 9)
Jul  7 19:39:16 gericom kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 9)
Jul  7 19:39:16 gericom kernel: ACPI: Embedded Controller [EC0] (gpe 28)
Jul  7 19:39:16 gericom kernel: Linux Plug and Play Support v0.97 (c) 
Adam Belay
Jul  7 19:39:16 gericom kernel: SCSI subsystem initialized
Jul  7 19:39:16 gericom kernel: ACPI: PCI Interrupt Link [LNKA] enabled 
at IRQ 10
Jul  7 19:39:16 gericom kernel: ACPI: PCI Interrupt Link [LNKD] enabled 
at IRQ 11
Jul  7 19:39:16 gericom kernel: ACPI: PCI Interrupt Link [LNKC] enabled 
at IRQ 9
Jul  7 19:39:16 gericom kernel: ACPI: PCI Interrupt Link [LNKB] enabled 
at IRQ 10
Jul  7 19:39:16 gericom kernel: PCI: Using ACPI for IRQ routing
Jul  7 19:39:16 gericom kernel: PCI: if you experience problems, try 
using option 'pci=noacpi' or even 'acpi=off'
Jul  7 19:39:16 gericom kernel: Machine check exception polling timer 
started.
Jul  7 19:39:16 gericom kernel: udf: registering filesystem
Jul  7 19:39:16 gericom kernel:     ACPI-0179: *** Warning: The ACPI AML 
in your computer contains errors, please nag the manufacturer to correct it.
Jul  7 19:39:16 gericom kernel:     ACPI-0182: *** Warning: Allowing 
relaxed access to fields; turn on CONFIG_ACPI_DEBUG for details.
Jul  7 19:39:16 gericom kernel: ACPI: AC Adapter [ACAD] (off-line)
Jul  7 19:39:16 gericom kernel: ACPI: Battery Slot [BAT1] (battery present)
Jul  7 19:39:16 gericom kernel: ACPI: Power Button (FF) [PWRF]
Jul  7 19:39:16 gericom kernel: ACPI: Lid Switch [LID]
Jul  7 19:39:16 gericom kernel: ACPI: Sleep Button (CM) [SLPB]
Jul  7 19:39:16 gericom kernel: ACPI: Processor [CPU0] (supports C1 C2, 
8 throttling states)
Jul  7 19:39:16 gericom kernel: ACPI: Thermal Zone [THRM] (49 C)
Jul  7 19:39:16 gericom kernel: Using anticipatory io scheduler
Jul  7 19:39:16 gericom kernel: FDC 0 is a post-1991 82077
Jul  7 19:39:16 gericom kernel: RAMDISK driver initialized: 16 RAM disks 
of 4096K size 1024 blocksize
Jul  7 19:39:16 gericom kernel: Uniform Multi-Platform E-IDE driver 
Revision: 7.00alpha2
Jul  7 19:39:16 gericom kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
Jul  7 19:39:16 gericom kernel: ICH3M: IDE controller at PCI slot 
0000:00:1f.1
Jul  7 19:39:16 gericom kernel: PCI: Enabling device 0000:00:1f.1 (0005 
-> 0007)
Jul  7 19:39:16 gericom kernel: ICH3M: chipset revision 2
Jul  7 19:39:16 gericom kernel: ICH3M: not 100%% native mode: will probe 
irqs later
Jul  7 19:39:16 gericom kernel:     ide0: BM-DMA at 0x1800-0x1807, BIOS 
settings: hda:DMA, hdb:pio
Jul  7 19:39:16 gericom kernel:     ide1: BM-DMA at 0x1808-0x180f, BIOS 
settings: hdc:DMA, hdd:pio
Jul  7 19:39:16 gericom kernel: hda: HITACHI_DK23DA-30, ATA DISK drive
Jul  7 19:39:16 gericom kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul  7 19:39:16 gericom kernel: hdc: UJDA710, ATAPI CD/DVD-ROM drive
Jul  7 19:39:16 gericom kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul  7 19:39:16 gericom kernel: hda: max request size: 128KiB
Jul  7 19:39:16 gericom kernel: hda: 58605120 sectors (30005 MB) 
w/2048KiB Cache, CHS=58140/16/63, UDMA(100)
Jul  7 19:39:16 gericom kernel:  hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
Jul  7 19:39:16 gericom kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 
2048kB Cache, UDMA(33)
Jul  7 19:39:16 gericom kernel: Uniform CD-ROM driver Revision: 3.20
Jul  7 19:39:16 gericom kernel: mice: PS/2 mouse device common for all mice
Jul  7 19:39:16 gericom kernel: i8042.c: Detected active multiplexing 
controller, rev 1.1.
Jul  7 19:39:16 gericom kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Jul  7 19:39:16 gericom kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
Jul  7 19:39:16 gericom kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
Jul  7 19:39:16 gericom kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
Jul  7 19:39:16 gericom kernel: input: PS/2 Generic Mouse on isa0060/serio4
Jul  7 19:39:16 gericom kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul  7 19:39:16 gericom kernel: input: AT Translated Set 2 keyboard on 
isa0060/serio0
Jul  7 19:39:16 gericom kernel: NET: Registered protocol family 2
Jul  7 19:39:16 gericom kernel: IP: routing cache hash table of 4096 
buckets, 32Kbytes
Jul  7 19:39:16 gericom kernel: TCP: Hash tables configured (established 
32768 bind 32768)
Jul  7 19:39:16 gericom kernel: NET: Registered protocol family 1
Jul  7 19:39:16 gericom kernel: NET: Registered protocol family 17
Jul  7 19:39:16 gericom kernel: VFS: Mounted root (ext2 filesystem) 
readonly.
Jul  7 19:39:16 gericom kernel: Freeing unused kernel memory: 108k freed
Jul  7 19:39:16 gericom kernel: Adding 192740k swap on /dev/hda7. 
Priority:-1 extents:1
Jul  7 19:39:16 gericom kernel: 8139too Fast Ethernet driver 0.9.27
Jul  7 19:39:16 gericom kernel: eth0: RealTek RTL8139 at 0x3400, 
00:02:3f:ad:b2:ec, IRQ 10
Jul  7 19:39:16 gericom kernel: intel8x0_measure_ac97_clock: measured 
49114 usecs
Jul  7 19:39:16 gericom kernel: intel8x0: clocking to 48000
Jul  7 19:39:16 gericom kernel: drivers/usb/core/usb.c: registered new 
driver usbfs
Jul  7 19:39:16 gericom kernel: drivers/usb/core/usb.c: registered new 
driver hub
Jul  7 19:39:16 gericom kernel: USB Universal Host Controller Interface 
driver v2.2
Jul  7 19:39:16 gericom kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Jul  7 19:39:16 gericom kernel: uhci_hcd 0000:00:1d.0: irq 10, io base 
00002400
Jul  7 19:39:16 gericom kernel: uhci_hcd 0000:00:1d.0: new USB bus 
registered, assigned bus number 1
Jul  7 19:39:16 gericom kernel: hub 1-0:1.0: USB hub found
Jul  7 19:39:16 gericom kernel: hub 1-0:1.0: 2 ports detected
Jul  7 19:39:16 gericom kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Jul  7 19:39:16 gericom kernel: uhci_hcd 0000:00:1d.1: irq 11, io base 
00002420
Jul  7 19:39:16 gericom kernel: uhci_hcd 0000:00:1d.1: new USB bus 
registered, assigned bus number 2
Jul  7 19:39:16 gericom kernel: hub 2-0:1.0: USB hub found
Jul  7 19:39:16 gericom kernel: hub 2-0:1.0: 2 ports detected
Jul  7 19:39:16 gericom kernel: Initializing USB Mass Storage driver...
Jul  7 19:39:16 gericom kernel: drivers/usb/core/usb.c: registered new 
driver usb-storage
Jul  7 19:39:16 gericom kernel: USB Mass Storage support registered.
Jul  7 19:39:16 gericom kernel: eth0: link down
Jul  7 19:40:53 gericom kernel: Kernel logging (proc) stopped.
Jul  7 19:40:53 gericom kernel: Kernel log daemon terminating.
Jul  7 19:40:53 gericom exiting on signal 15
Jul  7 19:47:22 gericom syslogd 1.4.1#10: restart.
Jul  7 19:47:22 gericom kernel: klogd 1.4.1#10, log source = /proc/kmsg 
started.
Jul  7 19:47:23 gericom kernel: Inspecting /boot/System.map-2.6.7
Jul  7 19:47:23 gericom kernel: Loaded 23398 symbols from 
/boot/System.map-2.6.7.
Jul  7 19:47:23 gericom kernel: Symbols match kernel version 2.6.7.
Jul  7 19:47:23 gericom kernel: No module symbols loaded - kernel 
modules not enabled.
Jul  7 19:47:23 gericom kernel: Linux version 2.6.7 (thomas@gericom) 
(gcc version 2.95.4 20011002 (Debian prerelease)) #1 Tue Jul 6 12:35:35 
CEST 2004
Jul  7 19:47:23 gericom kernel: BIOS-provided physical RAM map:
Jul  7 19:47:23 gericom kernel:  BIOS-e820: 0000000000000000 - 
000000000009f800 (usable)
Jul  7 19:47:23 gericom kernel:  BIOS-e820: 000000000009f800 - 
00000000000a0000 (reserved)
Jul  7 19:47:23 gericom kernel:  BIOS-e820: 00000000000dc000 - 
0000000000100000 (reserved)
Jul  7 19:47:23 gericom kernel:  BIOS-e820: 0000000000100000 - 
000000001fef0000 (usable)
Jul  7 19:47:23 gericom kernel:  BIOS-e820: 000000001fef0000 - 
000000001fefc000 (ACPI data)
Jul  7 19:47:23 gericom kernel:  BIOS-e820: 000000001fefc000 - 
000000001ff00000 (ACPI NVS)
Jul  7 19:47:23 gericom kernel:  BIOS-e820: 000000001ff00000 - 
000000001ff80000 (usable)
Jul  7 19:47:23 gericom kernel:  BIOS-e820: 000000001ff80000 - 
0000000020000000 (reserved)
Jul  7 19:47:23 gericom kernel:  BIOS-e820: 00000000ffb80000 - 
00000000ffc00000 (reserved)
Jul  7 19:47:23 gericom kernel:  BIOS-e820: 00000000fff00000 - 
0000000100000000 (reserved)
Jul  7 19:47:23 gericom kernel: 511MB LOWMEM available.
Jul  7 19:47:23 gericom kernel: On node 0 totalpages: 130944
Jul  7 19:47:23 gericom kernel:   DMA zone: 4096 pages, LIFO batch:1
Jul  7 19:47:23 gericom kernel:   Normal zone: 126848 pages, LIFO batch:16
Jul  7 19:47:23 gericom kernel:   HighMem zone: 0 pages, LIFO batch:1
Jul  7 19:47:23 gericom kernel: DMI present.
Jul  7 19:47:23 gericom kernel: ACPI: RSDP (v000 PTLTD 
                    ) @ 0x000f7290
Jul  7 19:47:23 gericom kernel: ACPI: RSDT (v001 PTLTD    RSDT 
0x06040000  LTP 0x00000000) @ 0x1fef59b9
Jul  7 19:47:23 gericom kernel: ACPI: FADT (v001 INTEL  845M 
0x06040000 PTL  0x0000004b) @ 0x1fefbf8c
Jul  7 19:47:23 gericom kernel: ACPI: DSDT (v001 COMPAL 845M 
0x06040000 MSFT 0x0100000d) @ 0x00000000
Jul  7 19:47:23 gericom kernel: Built 1 zonelists
Jul  7 19:47:23 gericom kernel: Kernel command line: 
BOOT_IMAGE=Linux-2.6.7 ro root=305
Jul  7 19:47:23 gericom kernel: Initializing CPU#0
Jul  7 19:47:23 gericom kernel: PID hash table entries: 2048 (order 11: 
16384 bytes)
Jul  7 19:47:23 gericom kernel: Detected 1196.586 MHz processor.
Jul  7 19:47:23 gericom kernel: Using tsc for high-res timesource
Jul  7 19:47:23 gericom kernel: Console: colour VGA+ 80x25
Jul  7 19:47:23 gericom kernel: Memory: 516100k/523776k available (1557k 
kernel code, 6848k reserved, 840k data, 108k init, 0k highmem)
Jul  7 19:47:23 gericom kernel: Checking if this processor honours the 
WP bit even in supervisor mode... Ok.
Jul  7 19:47:23 gericom kernel: Calibrating delay loop... 2351.10 BogoMIPS
Jul  7 19:47:23 gericom kernel: Dentry cache hash table entries: 65536 
(order: 6, 262144 bytes)
Jul  7 19:47:23 gericom kernel: Inode-cache hash table entries: 32768 
(order: 5, 131072 bytes)
Jul  7 19:47:23 gericom kernel: Mount-cache hash table entries: 512 
(order: 0, 4096 bytes)
Jul  7 19:47:23 gericom kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jul  7 19:47:23 gericom kernel: CPU: L2 cache: 512K
Jul  7 19:47:23 gericom kernel: Intel machine check architecture supported.
Jul  7 19:47:23 gericom kernel: Intel machine check reporting enabled on 
CPU#0.
Jul  7 19:47:23 gericom kernel: CPU0: Intel P4/Xeon Extended MCE MSRs 
(12) available
Jul  7 19:47:23 gericom kernel: CPU: Intel(R) Pentium(R) 4 Mobile CPU 
1.60GHz stepping 04
Jul  7 19:47:23 gericom kernel: Enabling fast FPU save and restore... done.
Jul  7 19:47:23 gericom kernel: Enabling unmasked SIMD FPU exception 
support... done.
Jul  7 19:47:23 gericom kernel: Checking 'hlt' instruction... OK.
Jul  7 19:47:23 gericom kernel: NET: Registered protocol family 16
Jul  7 19:47:23 gericom kernel: PCI: PCI BIOS revision 2.10 entry at 
0xfd984, last bus=2
Jul  7 19:47:23 gericom kernel: PCI: Using configuration type 1
Jul  7 19:47:23 gericom kernel: mtrr: v2.0 (20020519)
Jul  7 19:47:23 gericom kernel: ACPI: Subsystem revision 20040326
Jul  7 19:47:23 gericom kernel: ACPI: IRQ9 SCI: Edge set to Level Trigger.
Jul  7 19:47:23 gericom kernel: ACPI: Interpreter enabled
Jul  7 19:47:23 gericom kernel: ACPI: Using PIC for interrupt routing
Jul  7 19:47:23 gericom kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jul  7 19:47:23 gericom kernel: PCI: Probing PCI hardware (bus 00)
Jul  7 19:47:23 gericom kernel: PCI: Transparent bridge - 0000:00:1e.0
Jul  7 19:47:23 gericom kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
Jul  7 19:47:23 gericom kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
Jul  7 19:47:23 gericom kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 9) 
*0, disabled.
Jul  7 19:47:23 gericom kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 9) *11
Jul  7 19:47:23 gericom kernel: ACPI: Device [FDDA] status [00000008]: 
functional but not present; setting present
Jul  7 19:47:23 gericom kernel: ACPI: Embedded Controller [EC0] (gpe 28)
Jul  7 19:47:23 gericom kernel: Linux Plug and Play Support v0.97 (c) 
Adam Belay
Jul  7 19:47:23 gericom kernel: SCSI subsystem initialized
Jul  7 19:47:23 gericom kernel: ACPI: PCI Interrupt Link [LNKA] enabled 
at IRQ 10
Jul  7 19:47:23 gericom kernel: ACPI: PCI Interrupt Link [LNKD] enabled 
at IRQ 9
Jul  7 19:47:23 gericom kernel: ACPI: PCI Interrupt Link [LNKC] enabled 
at IRQ 9
Jul  7 19:47:23 gericom kernel: ACPI: PCI Interrupt Link [LNKB] enabled 
at IRQ 10
Jul  7 19:47:23 gericom kernel: PCI: Using ACPI for IRQ routing
Jul  7 19:47:23 gericom kernel: Machine check exception polling timer 
started.
Jul  7 19:47:23 gericom kernel: udf: registering filesystem
Jul  7 19:47:23 gericom kernel:     ACPI-0179: *** Warning: The ACPI AML 
in your computer contains errors, please nag the manufacturer to correct it.
Jul  7 19:47:23 gericom kernel:     ACPI-0182: *** Warning: Allowing 
relaxed access to fields; turn on CONFIG_ACPI_DEBUG for details.
Jul  7 19:47:23 gericom kernel: ACPI: AC Adapter [ACAD] (off-line)
Jul  7 19:47:23 gericom kernel: ACPI: Battery Slot [BAT1] (battery present)
Jul  7 19:47:23 gericom kernel: ACPI: Power Button (FF) [PWRF]
Jul  7 19:47:23 gericom kernel: ACPI: Lid Switch [LID]
Jul  7 19:47:23 gericom kernel: ACPI: Sleep Button (CM) [SLPB]
Jul  7 19:47:23 gericom kernel: ACPI: Processor [CPU0] (supports C1 C2, 
8 throttling states)
Jul  7 19:47:23 gericom kernel: ACPI: Thermal Zone [THRM] (45 C)
Jul  7 19:47:23 gericom kernel: Using anticipatory io scheduler
Jul  7 19:47:23 gericom kernel: FDC 0 is a post-1991 82077
Jul  7 19:47:23 gericom kernel: RAMDISK driver initialized: 16 RAM disks 
of 4096K size 1024 blocksize
Jul  7 19:47:23 gericom kernel: Uniform Multi-Platform E-IDE driver 
Revision: 7.00alpha2
Jul  7 19:47:23 gericom kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
Jul  7 19:47:23 gericom kernel: ICH3M: IDE controller at PCI slot 
0000:00:1f.1
Jul  7 19:47:23 gericom kernel: PCI: Enabling device 0000:00:1f.1 (0005 
-> 0007)
Jul  7 19:47:23 gericom kernel: ICH3M: chipset revision 2
Jul  7 19:47:23 gericom kernel: ICH3M: not 100%% native mode: will probe 
irqs later
Jul  7 19:47:23 gericom kernel:     ide0: BM-DMA at 0x1800-0x1807, BIOS 
settings: hda:DMA, hdb:pio
Jul  7 19:47:23 gericom kernel:     ide1: BM-DMA at 0x1808-0x180f, BIOS 
settings: hdc:DMA, hdd:pio
Jul  7 19:47:23 gericom kernel: hda: HITACHI_DK23DA-30, ATA DISK drive
Jul  7 19:47:23 gericom kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul  7 19:47:23 gericom kernel: hdc: UJDA710, ATAPI CD/DVD-ROM drive
Jul  7 19:47:23 gericom kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul  7 19:47:23 gericom kernel: hda: max request size: 128KiB
Jul  7 19:47:23 gericom kernel: hda: 58605120 sectors (30005 MB) 
w/2048KiB Cache, CHS=58140/16/63, UDMA(100)
Jul  7 19:47:23 gericom kernel:  hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
Jul  7 19:47:23 gericom kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 
2048kB Cache, UDMA(33)
Jul  7 19:47:23 gericom kernel: Uniform CD-ROM driver Revision: 3.20
Jul  7 19:47:23 gericom kernel: mice: PS/2 mouse device common for all mice
Jul  7 19:47:23 gericom kernel: i8042.c: Detected active multiplexing 
controller, rev 1.1.
Jul  7 19:47:23 gericom kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Jul  7 19:47:23 gericom kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
Jul  7 19:47:23 gericom kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
Jul  7 19:47:23 gericom kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
Jul  7 19:47:23 gericom kernel: input: PS/2 Generic Mouse on isa0060/serio4
Jul  7 19:47:23 gericom kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul  7 19:47:23 gericom kernel: input: AT Translated Set 2 keyboard on 
isa0060/serio0
Jul  7 19:47:23 gericom kernel: NET: Registered protocol family 2
Jul  7 19:47:23 gericom kernel: IP: routing cache hash table of 4096 
buckets, 32Kbytes
Jul  7 19:47:23 gericom kernel: TCP: Hash tables configured (established 
32768 bind 32768)
Jul  7 19:47:23 gericom kernel: NET: Registered protocol family 1
Jul  7 19:47:23 gericom kernel: NET: Registered protocol family 17
Jul  7 19:47:23 gericom kernel: VFS: Mounted root (ext2 filesystem) 
readonly.
Jul  7 19:47:23 gericom kernel: Freeing unused kernel memory: 108k freed
Jul  7 19:47:23 gericom kernel: Adding 192740k swap on /dev/hda7. 
Priority:-1 extents:1
Jul  7 19:47:23 gericom kernel: 8139too Fast Ethernet driver 0.9.27
Jul  7 19:47:23 gericom kernel: eth0: RealTek RTL8139 at 0x3400, 
00:02:3f:ad:b2:ec, IRQ 10
Jul  7 19:47:23 gericom kernel: intel8x0_measure_ac97_clock: measured 
49123 usecs
Jul  7 19:47:23 gericom kernel: intel8x0: clocking to 48000
Jul  7 19:47:23 gericom kernel: usbcore: registered new driver usbfs
Jul  7 19:47:23 gericom kernel: usbcore: registered new driver hub
Jul  7 19:47:23 gericom kernel: USB Universal Host Controller Interface 
driver v2.2
Jul  7 19:47:23 gericom kernel: uhci_hcd 0000:00:1d.0: Intel Corp. 
82801CA/CAM USB (Hub #1)
Jul  7 19:47:23 gericom kernel: uhci_hcd 0000:00:1d.0: irq 10, io base 
00002400
Jul  7 19:47:23 gericom kernel: uhci_hcd 0000:00:1d.0: new USB bus 
registered, assigned bus number 1
Jul  7 19:47:23 gericom kernel: hub 1-0:1.0: USB hub found
Jul  7 19:47:23 gericom kernel: hub 1-0:1.0: 2 ports detected
Jul  7 19:47:23 gericom kernel: uhci_hcd 0000:00:1d.1: Intel Corp. 
82801CA/CAM USB (Hub #2)
Jul  7 19:47:23 gericom kernel: uhci_hcd 0000:00:1d.1: irq 9, io base 
00002420
Jul  7 19:47:23 gericom kernel: uhci_hcd 0000:00:1d.1: new USB bus 
registered, assigned bus number 2
Jul  7 19:47:23 gericom kernel: hub 2-0:1.0: USB hub found
Jul  7 19:47:23 gericom kernel: hub 2-0:1.0: 2 ports detected
Jul  7 19:47:23 gericom kernel: Initializing USB Mass Storage driver...
Jul  7 19:47:23 gericom kernel: usbcore: registered new driver usb-storage
Jul  7 19:47:23 gericom kernel: USB Mass Storage support registered.
Jul  7 19:47:23 gericom kernel: eth0: link down
---------------------------------------------------------------

Linux 2.6.7 config (2.6.4 was the same, did a make oldconfig for 2.6.7):

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
# CONFIG_EXPERIMENTAL is not set
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_KMOD is not set

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
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
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
# CONFIG_HPET_TIMER is not set
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DISK is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_PROC_INTF is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_TABLE=m

#
# CPUFreq processor drivers
#
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_SPEEDSTEP_ICH=m
# CONFIG_X86_P4_CLOCKMOD is not set
CONFIG_X86_SPEEDSTEP_LIB=m
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

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
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_FW_LOADER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_CARMEL is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_LBD=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_NETFILTER is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
CONFIG_8139TOO=m
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
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
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set

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
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

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
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
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
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Misc devices
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
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

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
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set

#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETSERVO is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVPTS_FS_XATTR is not set
# CONFIG_TMPFS is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_HFSPLUS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFSD is not set
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
# CONFIG_EXPORTFS is not set
CONFIG_SUNRPC=y
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
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
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_FRAME_POINTER is not set
# CONFIG_4KSTACKS is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_STD_RESOURCES=y
CONFIG_PC=y

