Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317503AbSGOPoE>; Mon, 15 Jul 2002 11:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317505AbSGOPoD>; Mon, 15 Jul 2002 11:44:03 -0400
Received: from smtp1.wanadoo.nl ([194.134.35.136]:53670 "EHLO smtp1.wanadoo.nl")
	by vger.kernel.org with ESMTP id <S317503AbSGOPnx>;
	Mon, 15 Jul 2002 11:43:53 -0400
Message-Id: <5.1.0.14.0.20020715172232.009f9120@mail.science.uva.nl>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 15 Jul 2002 17:45:31 +0200
To: Vojtech Pavlik <vojtech@suse.cz>
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Subject: Re: kbd not functioning in 2.5.25-dj2
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just tried 2.5.25-dj2 and also found a nonresponsive keyboard.
after reading this thread I enabled ATKBD_DEBUG and I8042_DEBUG_IO, this is 
the result (output from dmesg):

Linux version 2.5.25-dj2 (root@frodo) (gcc version 2.95.3 20010315 
(release)) #5 Mon Jul 15 14:25:42 CEST 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 0000000000100000 - 0000000003000000 (usable)
  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
48MB LOWMEM available.
On node 0 totalpages: 12288
zone(0): 4096 pages.
zone(1): 8192 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=lin2.5 ro root=301 ether=0,0,eth1
Initializing CPU#0
Detected 99.730 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 195.07 BogoMIPS
Memory: 46820k/49152k available (863k kernel code, 1944k reserved, 203k 
data, 196k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
CPU:     After generic, caps: 000001bf 00000000 00000000 00000000
CPU:             Common caps: 000001bf 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 06
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd9d1, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Limiting direct PCI/PCI transfers.
pty: 256 Unix98 ptys configured
block: 160 slots per queue, batch=32
RAMDISK driver initialized: 1 RAM disks of 512K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX: IDE controller on PCI bus 00 dev 38
PIIX: chipset revision 2
PIIX: not 100% native mode: will probe irqs later
PIIX: neither IDE port enabled (BIOS)
hda: QUANTUM FIREBALL640A, ATA DISK drive
hdc: QUANTUM FIREBALL640A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 1253952 sectors (642 MB) w/83KiB Cache, CHS=622/32/63
hdc: 1253952 sectors (642 MB) w/83KiB Cache, CHS=1244/16/63
  hda: hda1 hda2
  hdc: [PTBL] [622/32/63] hdc1 hdc2
i8042.c: 20 -> i8042 (command) [0]
i8042.c: 65 <- i8042 (return) [0]
i8042.c: 60 -> i8042 (command) [1]
i8042.c: 74 -> i8042 (parameter) [1]
i8042.c: 60 -> i8042 (command) [1]
i8042.c: 65 -> i8042 (parameter) [1]
atkbd.c: Sent: f5
i8042.c: f5 -> i8042 (kbd-data) [1]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 74 -> i8042 (parameter) [2]
i8042.c: fa <- i8042 (interrupt-kbd) [3]
atkbd.c: Received fa
serio: i8042 KBD port at 0x60,0x64 irq 1
i8042.c: d3 -> i8042 (command) [3]
i8042.c: 5a -> i8042 (parameter) [3]
i8042.c: a5 <- i8042 (return) [3]
i8042.c: a9 -> i8042 (command) [3]
i8042.c: 00 <- i8042 (return) [3]
i8042.c: a7 -> i8042 (command) [4]
i8042.c: 20 -> i8042 (command) [4]
i8042.c: 74 <- i8042 (return) [4]
i8042.c: a9 -> i8042 (command) [4]
i8042.c: 00 <- i8042 (return) [4]
i8042.c: a8 -> i8042 (command) [4]
i8042.c: 20 -> i8042 (command) [4]
i8042.c: 54 <- i8042 (return) [4]
i8042.c: 60 -> i8042 (command) [5]
i8042.c: 74 -> i8042 (parameter) [5]
i8042.c: 60 -> i8042 (command) [5]
i8042.c: 56 -> i8042 (parameter) [5]
atkbd.c: Sent: f5
i8042.c: d4 -> i8042 (command) [5]
i8042.c: f5 -> i8042 (parameter) [5]
i8042.c: 60 -> i8042 (command) [5]
i8042.c: 56 -> i8042 (parameter) [5]
i8042.c: fe <- i8042 (interrupt-aux) [6]
atkbd.c: Received fe
i8042.c: 60 -> i8042 (command) [6]
i8042.c: 74 -> i8042 (parameter) [6]
serio: i8042 AUX port at 0x60,0x64 irq 12
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x300: 00 00 b4 65 19 22
eth0: NE2000 found at 0x300, using IRQ 3.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 196k freed
Adding 42328k swap on /dev/hda2.  Priority:-1 extents:1
i8042.c: 60 -> i8042 (command) [20639]
i8042.c: 56 -> i8042 (parameter) [20639]
i8042.c: d4 -> i8042 (command) [20639]
i8042.c: f6 -> i8042 (parameter) [20639]
i8042.c: 60 -> i8042 (command) [20639]
i8042.c: 56 -> i8042 (parameter) [20639]
i8042.c: fa <- i8042 (interrupt-aux) [20640]
i8042.c: d4 -> i8042 (command) [20640]
i8042.c: f2 -> i8042 (parameter) [20640]
i8042.c: 60 -> i8042 (command) [20640]
i8042.c: 56 -> i8042 (parameter) [20640]
i8042.c: fa <- i8042 (interrupt-aux) [20641]
i8042.c: 00 <- i8042 (interrupt-aux) [20643]
i8042.c: d4 -> i8042 (command) [20643]
i8042.c: e8 -> i8042 (parameter) [20643]
i8042.c: 60 -> i8042 (command) [20643]
i8042.c: 56 -> i8042 (parameter) [20643]
i8042.c: fa <- i8042 (interrupt-aux) [20644]
i8042.c: d4 -> i8042 (command) [20644]
i8042.c: 03 -> i8042 (parameter) [20644]
i8042.c: 60 -> i8042 (command) [20644]
i8042.c: 56 -> i8042 (parameter) [20644]
i8042.c: fa <- i8042 (interrupt-aux) [20645]
i8042.c: d4 -> i8042 (command) [20645]
i8042.c: e6 -> i8042 (parameter) [20645]
i8042.c: 60 -> i8042 (command) [20645]
i8042.c: 56 -> i8042 (parameter) [20645]
i8042.c: fa <- i8042 (interrupt-aux) [20646]
i8042.c: d4 -> i8042 (command) [20646]
i8042.c: e6 -> i8042 (parameter) [20646]
i8042.c: 60 -> i8042 (command) [20646]
i8042.c: 56 -> i8042 (parameter) [20646]
i8042.c: fa <- i8042 (interrupt-aux) [20647]
i8042.c: d4 -> i8042 (command) [20647]
i8042.c: e6 -> i8042 (parameter) [20647]
i8042.c: 60 -> i8042 (command) [20648]
i8042.c: 56 -> i8042 (parameter) [20648]
i8042.c: fa <- i8042 (interrupt-aux) [20649]
i8042.c: d4 -> i8042 (command) [20649]
i8042.c: e9 -> i8042 (parameter) [20649]
i8042.c: 60 -> i8042 (command) [20649]
i8042.c: 56 -> i8042 (parameter) [20649]
i8042.c: fa <- i8042 (interrupt-aux) [20651]
i8042.c: 00 <- i8042 (interrupt-aux) [20652]
i8042.c: 03 <- i8042 (interrupt-aux) [20654]
i8042.c: 64 <- i8042 (interrupt-aux) [20656]
i8042.c: d4 -> i8042 (command) [20656]
i8042.c: e8 -> i8042 (parameter) [20656]
i8042.c: 60 -> i8042 (command) [20656]
i8042.c: 56 -> i8042 (parameter) [20656]
i8042.c: fa <- i8042 (interrupt-aux) [20657]
i8042.c: d4 -> i8042 (command) [20657]
i8042.c: 00 -> i8042 (parameter) [20657]
i8042.c: 60 -> i8042 (command) [20657]
i8042.c: 56 -> i8042 (parameter) [20657]
i8042.c: fa <- i8042 (interrupt-aux) [20658]
i8042.c: d4 -> i8042 (command) [20658]
i8042.c: e6 -> i8042 (parameter) [20658]
i8042.c: 60 -> i8042 (command) [20659]
i8042.c: 56 -> i8042 (parameter) [20659]
i8042.c: fa <- i8042 (interrupt-aux) [20660]
i8042.c: d4 -> i8042 (command) [20660]
i8042.c: e6 -> i8042 (parameter) [20660]
i8042.c: 60 -> i8042 (command) [20660]
i8042.c: 56 -> i8042 (parameter) [20660]
i8042.c: fa <- i8042 (interrupt-aux) [20661]
i8042.c: d4 -> i8042 (command) [20662]
i8042.c: e6 -> i8042 (parameter) [20662]
i8042.c: 60 -> i8042 (command) [20662]
i8042.c: 56 -> i8042 (parameter) [20662]
i8042.c: fa <- i8042 (interrupt-aux) [20663]
i8042.c: d4 -> i8042 (command) [20663]
i8042.c: e9 -> i8042 (parameter) [20663]
i8042.c: 60 -> i8042 (command) [20663]
i8042.c: 56 -> i8042 (parameter) [20663]
i8042.c: fa <- i8042 (interrupt-aux) [20664]
i8042.c: 00 <- i8042 (interrupt-aux) [20666]
i8042.c: 00 <- i8042 (interrupt-aux) [20667]
i8042.c: 64 <- i8042 (interrupt-aux) [20669]
i8042.c: d4 -> i8042 (command) [20669]
i8042.c: f3 -> i8042 (parameter) [20669]
i8042.c: 60 -> i8042 (command) [20669]
i8042.c: 56 -> i8042 (parameter) [20669]
i8042.c: fa <- i8042 (interrupt-aux) [20670]
i8042.c: d4 -> i8042 (command) [20670]
i8042.c: c8 -> i8042 (parameter) [20670]
i8042.c: 60 -> i8042 (command) [20670]
i8042.c: 56 -> i8042 (parameter) [20670]
i8042.c: fa <- i8042 (interrupt-aux) [20671]
i8042.c: d4 -> i8042 (command) [20672]
i8042.c: f3 -> i8042 (parameter) [20672]
i8042.c: 60 -> i8042 (command) [20672]
i8042.c: 56 -> i8042 (parameter) [20672]
i8042.c: fa <- i8042 (interrupt-aux) [20673]
i8042.c: d4 -> i8042 (command) [20673]
i8042.c: 64 -> i8042 (parameter) [20673]
i8042.c: 60 -> i8042 (command) [20673]
i8042.c: 56 -> i8042 (parameter) [20673]
i8042.c: fa <- i8042 (interrupt-aux) [20674]
i8042.c: d4 -> i8042 (command) [20674]
i8042.c: f3 -> i8042 (parameter) [20674]
i8042.c: 60 -> i8042 (command) [20674]
i8042.c: 56 -> i8042 (parameter) [20674]
i8042.c: fa <- i8042 (interrupt-aux) [20675]
i8042.c: d4 -> i8042 (command) [20675]
i8042.c: 50 -> i8042 (parameter) [20675]
i8042.c: 60 -> i8042 (command) [20675]
i8042.c: 56 -> i8042 (parameter) [20675]
i8042.c: fa <- i8042 (interrupt-aux) [20676]
i8042.c: d4 -> i8042 (command) [20676]
i8042.c: f2 -> i8042 (parameter) [20676]
i8042.c: 60 -> i8042 (command) [20676]
i8042.c: 56 -> i8042 (parameter) [20676]
i8042.c: fa <- i8042 (interrupt-aux) [20677]
i8042.c: 03 <- i8042 (interrupt-aux) [20679]
i8042.c: d4 -> i8042 (command) [20679]
i8042.c: f3 -> i8042 (parameter) [20679]
i8042.c: 60 -> i8042 (command) [20680]
i8042.c: 56 -> i8042 (parameter) [20680]
i8042.c: fa <- i8042 (interrupt-aux) [20681]
i8042.c: d4 -> i8042 (command) [20681]
i8042.c: c8 -> i8042 (parameter) [20681]
i8042.c: 60 -> i8042 (command) [20681]
i8042.c: 56 -> i8042 (parameter) [20681]
i8042.c: fa <- i8042 (interrupt-aux) [20683]
i8042.c: d4 -> i8042 (command) [20683]
i8042.c: f3 -> i8042 (parameter) [20683]
i8042.c: 60 -> i8042 (command) [20683]
i8042.c: 56 -> i8042 (parameter) [20683]
i8042.c: fa <- i8042 (interrupt-aux) [20684]
i8042.c: d4 -> i8042 (command) [20684]
i8042.c: c8 -> i8042 (parameter) [20684]
i8042.c: 60 -> i8042 (command) [20684]
i8042.c: 56 -> i8042 (parameter) [20684]
i8042.c: fa <- i8042 (interrupt-aux) [20685]
i8042.c: d4 -> i8042 (command) [20685]
i8042.c: f3 -> i8042 (parameter) [20685]
i8042.c: 60 -> i8042 (command) [20685]
i8042.c: 56 -> i8042 (parameter) [20685]
i8042.c: fa <- i8042 (interrupt-aux) [20686]
i8042.c: d4 -> i8042 (command) [20686]
i8042.c: 50 -> i8042 (parameter) [20686]
i8042.c: 60 -> i8042 (command) [20686]
i8042.c: 56 -> i8042 (parameter) [20686]
i8042.c: fa <- i8042 (interrupt-aux) [20687]
i8042.c: d4 -> i8042 (command) [20687]
i8042.c: f2 -> i8042 (parameter) [20687]
i8042.c: 60 -> i8042 (command) [20687]
i8042.c: 56 -> i8042 (parameter) [20687]
i8042.c: fa <- i8042 (interrupt-aux) [20688]
i8042.c: 03 <- i8042 (interrupt-aux) [20690]
input: ImPS/2 Microsoft IntelliMouse on isa0060/serio1
i8042.c: d4 -> i8042 (command) [20691]
i8042.c: f3 -> i8042 (parameter) [20691]
i8042.c: 60 -> i8042 (command) [20691]
i8042.c: 56 -> i8042 (parameter) [20691]
i8042.c: fa <- i8042 (interrupt-aux) [20692]
i8042.c: d4 -> i8042 (command) [20692]
i8042.c: 64 -> i8042 (parameter) [20692]
i8042.c: 60 -> i8042 (command) [20692]
i8042.c: 56 -> i8042 (parameter) [20692]
i8042.c: fa <- i8042 (interrupt-aux) [20693]
i8042.c: d4 -> i8042 (command) [20693]
i8042.c: f3 -> i8042 (parameter) [20693]
i8042.c: 60 -> i8042 (command) [20693]
i8042.c: 56 -> i8042 (parameter) [20693]
i8042.c: fa <- i8042 (interrupt-aux) [20694]
i8042.c: d4 -> i8042 (command) [20694]
i8042.c: c8 -> i8042 (parameter) [20694]
i8042.c: 60 -> i8042 (command) [20695]
i8042.c: 56 -> i8042 (parameter) [20695]
i8042.c: fa <- i8042 (interrupt-aux) [20696]
i8042.c: d4 -> i8042 (command) [20696]
i8042.c: e8 -> i8042 (parameter) [20696]
i8042.c: 60 -> i8042 (command) [20696]
i8042.c: 56 -> i8042 (parameter) [20696]
i8042.c: fa <- i8042 (interrupt-aux) [20697]
i8042.c: d4 -> i8042 (command) [20698]
i8042.c: 03 -> i8042 (parameter) [20698]
i8042.c: 60 -> i8042 (command) [20698]
i8042.c: 56 -> i8042 (parameter) [20698]
i8042.c: fa <- i8042 (interrupt-aux) [20699]
i8042.c: d4 -> i8042 (command) [20699]
i8042.c: e6 -> i8042 (parameter) [20699]
i8042.c: 60 -> i8042 (command) [20699]
i8042.c: 56 -> i8042 (parameter) [20699]
i8042.c: fa <- i8042 (interrupt-aux) [20700]
i8042.c: d4 -> i8042 (command) [20700]
i8042.c: ea -> i8042 (parameter) [20700]
i8042.c: 60 -> i8042 (command) [20700]
i8042.c: 56 -> i8042 (parameter) [20700]
i8042.c: fa <- i8042 (interrupt-aux) [20701]
i8042.c: d4 -> i8042 (command) [20701]
i8042.c: f4 -> i8042 (parameter) [20701]
i8042.c: 60 -> i8042 (command) [20701]
i8042.c: 56 -> i8042 (parameter) [20701]
i8042.c: fa <- i8042 (interrupt-aux) [20702]
i8042.c: 60 -> i8042 (command) [20702]
i8042.c: 47 -> i8042 (parameter) [20702]
i8042.c: f6 -> i8042 (kbd-data) [20702]
i8042.c: fa <- i8042 (interrupt-kbd) [20705]
i8042.c: f2 -> i8042 (kbd-data) [20705]
i8042.c: fa <- i8042 (interrupt-kbd) [20709]
i8042.c: ab <- i8042 (interrupt-kbd) [20710]
i8042.c: 60 -> i8042 (command) [20710]
i8042.c: 56 -> i8042 (parameter) [20710]
i8042.c: 60 -> i8042 (command) [21755]
i8042.c: 74 -> i8042 (parameter) [21755]
i8042.c: 60 -> i8042 (command) [21755]
i8042.c: 56 -> i8042 (parameter) [21755]
atkbd.c: Sent: f5
i8042.c: d4 -> i8042 (command) [21756]
i8042.c: f5 -> i8042 (parameter) [21756]
i8042.c: 60 -> i8042 (command) [21756]
i8042.c: 56 -> i8042 (parameter) [21756]
i8042.c: fa <- i8042 (interrupt-aux) [21757]
atkbd.c: Received fa
atkbd.c: Sent: f2
i8042.c: d4 -> i8042 (command) [21757]
i8042.c: f2 -> i8042 (parameter) [21757]
i8042.c: 60 -> i8042 (command) [21758]
i8042.c: 56 -> i8042 (parameter) [21758]
i8042.c: fa <- i8042 (interrupt-aux) [21759]
atkbd.c: Received fa
i8042.c: 03 <- i8042 (interrupt-aux) [21761]
atkbd.c: Received 03
i8042.c: 60 -> i8042 (command) [21766]
i8042.c: 74 -> i8042 (parameter) [21766]
i8042.c: 60 -> i8042 (command) [21766]
i8042.c: 65 -> i8042 (parameter) [21766]
atkbd.c: Sent: f5
i8042.c: f5 -> i8042 (kbd-data) [21766]
i8042.c: 60 -> i8042 (command) [21767]
i8042.c: 74 -> i8042 (parameter) [21767]
i8042.c: fa <- i8042 (interrupt-kbd) [21768]
atkbd.c: Received fa

funny thing is that with 2.5.15-dj1 the keyboard is also dead on boot but 
after 'modprobe psmouse.o' followed by 'rmmod psmouse.o' it works. This 
same behaviour is in almost every -dj kernel from 15 till 24 so I put this 
loading and unloading of psmouse.o in my bootscripts but for 25-dj2 it does 
not work anymore...

on linux-2.5.15-dj1 it says after loading psmouse.o this:
Jul 15 16:04:28 frodo kernel: input: ImPS/2 Microsoft IntelliMouse on 
isa0060/serio1
Jul 15 16:04:28 frodo kernel: input: AT Set 2 keyboard on isa0060/serio0

system is a IBM PC 330 P75 (upgraded to a p100) with a IBM 101 PS/2 Keyboard

relevant part of .config:
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=800
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=600
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_I8042_REG_BASE=60
CONFIG_I8042_KBD_IRQ=1
CONFIG_I8042_AUX_IRQ=12
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m

If you need more info please ask

	Rudmer

