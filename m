Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVAaDK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVAaDK1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 22:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVAaDK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 22:10:27 -0500
Received: from [216.79.129.202] ([216.79.129.202]:56843 "EHLO
	se-1.us.steyla.com") by vger.kernel.org with ESMTP id S261902AbVAaDJ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 22:09:58 -0500
Message-ID: <32801.216.79.129.219.1107144596.squirrel@www.steyla.com>
Date: Sun, 30 Jan 2005 23:09:56 -0500 (EST)
Subject: USB / PCMCIA not working/panic on AVERATEC 3500
From: "Michaela Merz" <misch@steyla.com>
To: linux-kernel@vger.kernel.org
Reply-To: misch@steyla.com
User-Agent: SquirrelMail/1.4.0 RC2a
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey :)

Linux dhcp219.us.steyla.com 2.6.9 #2 Sat Jan 29 17:26:47 EST 2005 i686
athlon i386 GNU/Linux

Gnu C                  3.4.2
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12a
mount                  2.12a
module-init-tools      3.1-pre5
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   039
Modules Loaded         parport_pc lp parport autofs4 sunrpc ds dm_mod
button battery ac md5 ipv6 yenta_socket pcmcia_core ohci_hcd ehci_hcd
snd_intel8x0m snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss
snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi
snd_seq_device snd soundcore rt2500 sis900 ext3 jbd

Tried 2.6.9, 2.6.10 and 2.6.11-rc2

dmesg output:

ACPI: PCI interrupt 0000:00:02.6[C] -> GSI 11 (level, low) -> IRQ 11
PCI: Enabling device 0000:00:03.2 (0000 -> 0002)
ACPI: PCI interrupt 0000:00:03.2[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:03.2: EHCI Host Controller
ehci_hcd 0000:00:03.2: illegal capability!
ehci_hcd 0000:00:03.2: can't reset
ehci_hcd 0000:00:03.2: init 0000:00:03.2 fail, -110
ehci_hcd: probe of 0000:00:03.2 failed with error -110
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: Enabling device 0000:00:03.0 (0000 -> 0002)
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: USB HC reset timed out!
ohci_hcd 0000:00:03.0: can't reset
ohci_hcd 0000:00:03.0: init 0000:00:03.0 fail, -1
ohci_hcd: probe of 0000:00:03.0 failed with error -1
PCI: Enabling device 0000:00:03.1 (0000 -> 0002)
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:03.1: OHCI Host Controller
PCI: Setting latency timer of device 0000:00:03.1 to 64
ohci_hcd 0000:00:03.1: irq 11, pci mem de8c8000
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:03.1: init err
ohci_hcd 0000:00:03.1: can't start
ohci_hcd 0000:00:03.1: init error -16
ohci_hcd 0000:00:03.1: remove, state 0
ohci_hcd 0000:00:03.1: USB bus 1 deregistered
ohci_hcd: probe of 0000:00:03.1 failed with error -16
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 7 (level, low) -> IRQ 7
Yenta: CardBus bridge found at 0000:00:0c.0 [1524:1410]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0c.0, mfunc 0x01021002, devctl 0x44
Yenta TI: socket 0000:00:0c.0 probing PCI interrupt failed, trying to fix
Yenta TI: socket 0000:00:0c.0 no PCI interrupts. Fish. Please report.
Yenta: ISA IRQ mask 0x0000, PCI irq 0
Socket status: 00000720

I tried pci=routeirq and noacpi to no avail. Modules or compiled
into kernel does not change anything.

2.6.11-rc2 actually panics while initializing.

cat /proc/modules

parport_pc 27328 1 - Live 0xdea6d000
lp 12652 0 - Live 0xde931000
parport 46920 2 parport_pc,lp, Live 0xdea36000
autofs4 28292 0 - Live 0xde929000
sunrpc 184420 1 - Live 0xde94e000
ds 19204 2 - Live 0xde91f000
dm_mod 62484 0 - Live 0xde90e000
button 6928 0 - Live 0xde926000
battery 9220 0 - Live 0xde8f6000
ac 5124 0 - Live 0xde874000
md5 4608 1 - Live 0xde8ed000
ipv6 272320 8 - Live 0xde992000
yenta_socket 20864 0 - Live 0xde8e6000
pcmcia_core 67396 2 ds,yenta_socket, Live 0xde8d4000
ohci_hcd 25732 0 - Live 0xde8fb000
ehci_hcd 37380 0 - Live 0xde903000
snd_intel8x0m 20168 2 - Live 0xde87b000
snd_intel8x0 38348 2 - Live 0xde8bd000
snd_ac97_codec 72528 2 snd_intel8x0m,snd_intel8x0, Live 0xde93b000
snd_pcm_oss 55464 0 - Live 0xde983000
snd_mixer_oss 19840 3 snd_pcm_oss, Live 0xde86e000
snd_pcm 114568 3 snd_intel8x0m,snd_intel8x0,snd_pcm_oss, Live 0xde8a0000
snd_timer 34820 1 snd_pcm, Live 0xde8ca000
snd_page_alloc 10504 3 snd_intel8x0m,snd_intel8x0,snd_pcm, Live 0xde86a000
gameport 5376 1 snd_intel8x0, Live 0xde843000
snd_mpu401_uart 10368 1 snd_intel8x0, Live 0xde866000
snd_rawmidi 30116 1 snd_mpu401_uart, Live 0xde85d000
snd_seq_device 8840 1 snd_rawmidi, Live 0xde877000
snd 60260 14
snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device,
Live 0xde833000
soundcore 11360 3 snd, Live 0xde804000
rt2500 185156 1 - Live 0xdea7d000
sis900 21124 0 - Live 0xde829000
ext3 120680 1 - Live 0xde881000
jbd 89880 1 ext3, Live 0xde846000

cat /proc/devices

 1 mem
  4 /dev/vc/0
  4 tty
  4 ttyS
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
  6 lp
  7 vcs
 10 misc
 13 input
 14 sound
 29 fb
 36 netlink
116 alsa
128 ptm
136 pts
180 usb
254 pcmcia

Block devices:
  1 ramdisk
  3 ide0
  9 md
 22 ide1
253 device-mapper
254 mdp

/cat/proc/bus/pci

[root@dhcp219 log]# cat /proc/bus/pci/devices
0000    10390741        0       f0000000        00000000        00000000  
    00000000 00000000        00000000        00000000        02000000     
  000000000000000 00000000        00000000        00000000        00000000
       agpgart-sis
0008    10390003        0       00000000        00000000        00000000  
    00000000 00000000        00000000        00000000        00000000     
  000000000000000 00000000        00000000        00000000        00000000
0010    10390963        0       00000000        00000000        00000000  
    00000000 00000000        00000000        00000000        00000000     
  000000000000000 00000000        00000000        00000000        00000000
0011    10390016        b       00000000        00000000        00000000  
    00000000 00001401        00000000        00000000        00000000     
  000000000000000 00000000        00000020        00000000        00000000
0015    10395513        0       00000000        00000000        00000000  
    00000000 00001101        00000000        00000000        00000000     
  000000000000000 00000000        00000010        00000000        00000000
       SIS_IDE
0016    10397013        b       0000e001        0000e101        00000000  
    00000000 00000000        00000000        00000000        00000100     
  000000800000000 00000000        00000000        00000000        00000000
       Intel ICH Modem
0017    10397012        b       0000e201        0000e301        00000000  
    00000000 00000000        00000000        00000000        00000100     
  000000800000000 00000000        00000000        00000000        00000000
       Intel ICH
0018    10397001        b       1e000000        00000000        00000000  
    00000000 00000000        00000000        00000000        00001000     
  000000000000000 00000000        00000000        00000000        00000000
0019    10397001        b       1e001000        00000000        00000000  
    00000000 00000000        00000000        00000000        00001000     
  000000000000000 00000000        00000000        00000000        00000000
001a    10397002        b       1e002000        00000000        00000000  
    00000000 00000000        00000000        00000000        00001000     
  000000000000000 00000000        00000000        00000000        00000000
0020    10390900        7       0000e401        f2000000        00000000  
    00000000 00000000        00000000        00000000        00000100     
  000010000000000 00000000        00000000        00000000        00020000
       sis900
0038    18140201        b       f2002000        00000000        00000000  
    00000000 00000000        00000000        00000000        00002000     
  000000000000000 00000000        00000000        00000000        00000000
       rt2500
0060    15241410        7       1e003000        00000000        00000000  
    00000000 00000000        00000000        00000000        00001000     
  000000000000000 00000000        00000000        00000000        00000000
       yenta_cardbus
0100    10396330        a       a0000008        e0000000        0000c001  
    00000000 00000000        00000000        00000000        08000000     
  000200000000080 00000000        00000000        00000000        00000000

/proc/bus/usb is empty
/proc/bus/pccard/drivers is empty

Any help is appreciated.

Michaela





-- 
Steyla Technologies, Inc.
www.radiogermany.us
POT: +386-439-2286
FAX: +386-439-8521
FWD: 525452 (www.freeworlddialup.com)

