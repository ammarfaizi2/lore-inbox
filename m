Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267182AbSK2XvB>; Fri, 29 Nov 2002 18:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267183AbSK2XvB>; Fri, 29 Nov 2002 18:51:01 -0500
Received: from rrcs-midsouth-24-172-39-28.biz.rr.com ([24.172.39.28]:15366
	"EHLO maunzelectronics.com") by vger.kernel.org with ESMTP
	id <S267182AbSK2Xu5>; Fri, 29 Nov 2002 18:50:57 -0500
Message-ID: <3DE7FF0F.DF8EC985@justirc.net>
Date: Fri, 29 Nov 2002 18:58:07 -0500
From: Mark Rutherford <mark@justirc.net>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [2.4.20] Trouble with via 8235 [does not boot]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 1.0.12.3 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey all.
been working at 2.4.20 all day now trying to make sure ive done this
right..
I think I have but i will let you all be the judge.
please find attached my .config renamed to config.txt for the sake of
window$
also find attached a normal bootup as of 1 hour ago using kernel 2.5.44
I have tried the following:
re-downloaded the kernel souces in both tar/bz2 and tar/gzip formats
both archives were the same, natually
reconfigured both to no avail.
what I do not understand is that it does not detect the 2 devices i have
on the promise controller, or hda, hdb
it does find hdc and hdd and it does seem to detect the via 8235
controller as well.
what could possibly be wrong here?

dmesg: (from 2.5.44 on the same machine, I cannot snatch the bootup from
2.4.20)

 Nov 29 18:14:19 Darkstar syslogd 1.4.1: restart.
Nov 29 18:14:20 Darkstar kernel: klogd 1.4.1, log source = /proc/kmsg
started.
Nov 29 18:14:20 Darkstar kernel: BIOS-provided physical RAM map:
Nov 29 18:14:20 Darkstar kernel: 127MB HIGHMEM available.
Nov 29 18:14:20 Darkstar kernel: 896MB LOWMEM available.
Nov 29 18:14:20 Darkstar sshd[76]: Server listening on 0.0.0.0 port 22.
Nov 29 18:14:20 Darkstar kernel: Initializing CPU#0
Nov 29 18:14:20 Darkstar kernel: Memory: 1033628k/1048512k available
(2116k kernel code, 14496k reserved, 1538k data, 104k init, 131008k
highmem)
Nov 29 18:14:20 Darkstar kernel: Security Scaffold v1.0.0 initialized
Nov 29 18:14:20 Darkstar kernel: Dentry cache hash table entries: 131072
(order: 8, 1048576 bytes)
Nov 29 18:14:20 Darkstar kernel: CPU: L1 I Cache: 64K (64 bytes/line), D
cache 64K (64 bytes/line)
Nov 29 18:14:20 Darkstar kernel: CPU: L2 Cache: 256K (64 bytes/line)
Nov 29 18:14:20 Darkstar kernel: Intel machine check architecture
supported.
Nov 29 18:14:20 Darkstar kernel: Intel machine check reporting enabled
on CPU#0.
Nov 29 18:14:20 Darkstar kernel: Machine check exception polling timer
started.
Nov 29 18:14:20 Darkstar kernel: Enabling fast FPU save and restore...
done.
Nov 29 18:14:20 Darkstar kernel: Enabling unmasked SIMD FPU exception
support... done.
Nov 29 18:14:20 Darkstar kernel: Checking 'hlt' instruction... OK.
Nov 29 18:14:20 Darkstar kernel: ...changing IO-APIC physical APIC ID to
2 ... ok.
Nov 29 18:14:20 Darkstar kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Nov 29 18:14:20 Darkstar kernel: testing the IO
APIC.......................
Nov 29 18:14:22 Darkstar kernel: ....................................
done.
Nov 29 18:14:22 Darkstar kernel: Linux NET4.0 for Linux 2.4
Nov 29 18:14:22 Darkstar kernel: Based upon Swansea University Computer
Society NET3.039
Nov 29 18:14:22 Darkstar kernel: Linux Plug and Play Support v0.9 (c)
Adam Belay
Nov 29 18:14:22 Darkstar kernel: PCI: PCI BIOS revision 2.10 entry at
0xf9df0, last bus=1
Nov 29 18:14:22 Darkstar kernel: PCI: Using configuration type 1
Nov 29 18:14:22 Darkstar kernel: isapnp: Scanning for PnP cards...
Nov 29 18:14:22 Darkstar kernel: isapnp: No Plug & Play device found
Nov 29 18:14:22 Darkstar kernel: drivers/usb/core/usb.c: registered new
driver usbfs
Nov 29 18:14:22 Darkstar kernel: drivers/usb/core/usb.c: registered new
driver hub
Nov 29 18:14:23 Darkstar kernel: PCI: Using IRQ router default
[1106/3189] at 00:00.0
Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I11,P0) ->
19
Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I15,P0) ->
19
Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I16,P0) ->
21
Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I16,P1) ->
21
Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I16,P2) ->
21
Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I16,P3) ->
19
Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I17,P0) ->
10
Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I17,P2) ->
22
Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I19,P0) ->
18
Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I20,P0) ->
16
Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B1,I0,P0) ->
16
Nov 29 18:14:23 Darkstar kernel: aio_setup: sizeof(struct page) = 40
Nov 29 18:14:23 Darkstar kernel: Journalled Block Device driver loaded
Nov 29 18:14:23 Darkstar kernel: Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
Nov 29 18:14:23 Darkstar kernel: udf: registering filesystem
Nov 29 18:14:23 Darkstar kernel: Capability LSM initialized
Nov 29 18:14:23 Darkstar kernel: PCI: Via IRQ fixup for 00:10.0, from 10
to 5
Nov 29 18:14:23 Darkstar kernel: PCI: Via IRQ fixup for 00:10.1, from 10
to 5
Nov 29 18:14:23 Darkstar kernel: PCI: Via IRQ fixup for 00:10.2, from 11
to 5
Nov 29 18:14:23 Darkstar kernel: Serial: 8250/16550 driver $Revision:
1.90 $ IRQ sharing disabled
Nov 29 18:14:23 Darkstar kernel: Linux agpgart interface v0.99 (c) Jeff
Hartmann
Nov 29 18:14:23 Darkstar kernel: agpgart: Maximum main memory to use for
agp memory: 816M
Nov 29 18:14:24 Darkstar kernel: Floppy drive(s): fd0 is 1.44M
Nov 29 18:14:24 Darkstar kernel: FDC 0 is a post-1991 82077
Nov 29 18:14:24 Darkstar kernel: 8139too Fast Ethernet driver 0.9.26
Nov 29 18:14:24 Darkstar kernel: eth0: RealTek RTL8139 Fast Ethernet at
0xf8800000, 00:20:ed:46:87:68, IRQ 18
Nov 29 18:14:24 Darkstar kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00alpha2
Nov 29 18:14:24 Darkstar kernel: PDC20276: IDE controller at PCI slot
00:0f.0
Nov 29 18:14:24 Darkstar kernel: PDC20276: chipset revision 1
Nov 29 18:14:24 Darkstar kernel: PDC20276: not 100%% native mode: will
probe irqs later
Nov 29 18:14:24 Darkstar kernel: PDC20276: neither IDE port enabled
(BIOS)
Nov 29 18:14:24 Darkstar kernel: VP_IDE: IDE controller at PCI slot
00:11.1
Nov 29 18:14:24 Darkstar kernel: VP_IDE: chipset revision 6
Nov 29 18:14:24 Darkstar kernel: VP_IDE: not 100%% native mode: will
probe irqs later
Nov 29 18:14:24 Darkstar kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133
controller on pci00:11.1
Nov 29 18:14:24 Darkstar kernel: hda: setmax LBA 156250080, native
156250000
Nov 29 18:14:24 Darkstar kernel: hda: 156250000 sectors (80000 MB)
w/2048KiB Cache, CHS=9726/255/63, UDMA(100)
Nov 29 18:14:24 Darkstar kernel:  hda: hda1
Nov 29 18:14:24 Darkstar kernel: hdb: 26564832 sectors (13601 MB)
w/2048KiB Cache, CHS=1653/255/63, UDMA(66)
Nov 29 18:14:24 Darkstar kernel:  hdb: hdb1 hdb2
Nov 29 18:14:24 Darkstar kernel: Uniform CD-ROM driver Revision: 3.12
Nov 29 18:14:24 Darkstar kernel: SCSI subsystem driver Revision: 1.00
Nov 29 18:14:25 Darkstar kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI
SCSI HBA DRIVER, Rev 6.2.4
Nov 29 18:14:25 Darkstar kernel:   Vendor: SONY      Model: CD-ROM
CDU-76S    Rev: 1.1c
Nov 29 18:14:25 Darkstar kernel:   Type:
CD-ROM                             ANSI SCSI revision: 02
Nov 29 18:14:25 Darkstar kernel:   Vendor: MATSHITA  Model: CD-ROM
CR-8005    Rev: 2.0d
Nov 29 18:14:25 Darkstar kernel:   Type:
CD-ROM                             ANSI SCSI revision: 02
Nov 29 18:14:25 Darkstar kernel: Linux Kernel Card Services 3.1.22
Nov 29 18:14:25 Darkstar kernel:   options:  [pci] [cardbus]
Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hcd-pci.c: ehci-hcd @
00:10.3, VIA Technologies, Inc. USB 2.0
Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hcd-pci.c: irq 19, pci
mem f880a000
Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hcd.c: new USB bus
registered, assigned bus number 1
Nov 29 18:14:25 Darkstar kernel: drivers/usb/host/ehci-hcd.c: USB 2.0
support enabled, EHCI rev 1.00, ehci-hcd 2002-Sep-23
Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hub.c: USB hub found
at 0
Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hub.c: 6 ports
detected
Nov 29 18:14:25 Darkstar kernel: drivers/usb/host/uhci-hcd.c: USB
Universal Host Controller Interface driver v2.0
Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hcd-pci.c: uhci-hcd @
00:10.0, VIA Technologies, Inc. USB
Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hcd-pci.c: irq 21, io
base 0000a800
Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hcd.c: new USB bus
registered, assigned bus number 2
Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hub.c: USB hub found
at 0
Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hub.c: 2 ports
detected
Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hcd-pci.c: uhci-hcd @
00:10.1, VIA Technologies, Inc. USB (#2)
Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hcd-pci.c: irq 21, io
base 0000ac00
Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hcd.c: new USB bus
registered, assigned bus number 3
Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/hub.c: USB hub found
at 0
Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/hub.c: 2 ports
detected
Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/hcd-pci.c: uhci-hcd @
00:10.2, VIA Technologies, Inc. USB (#3)
Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/hcd-pci.c: irq 21, io
base 0000b000
Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/hcd.c: new USB bus
registered, assigned bus number 4
Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/hub.c: USB hub found
at 0
Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/hub.c: 2 ports
detected
Nov 29 18:14:26 Darkstar kernel: Initializing USB Mass Storage driver...

Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/usb.c: registered new
driver usb-storage
Nov 29 18:14:26 Darkstar kernel: USB Mass Storage support registered.
Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/usb.c: registered new
driver hiddev
Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/usb.c: registered new
driver hid
Nov 29 18:14:26 Darkstar kernel: drivers/usb/input/hid-core.c: v2.0:USB
HID core driver
Nov 29 18:14:26 Darkstar kernel: mice: PS/2 mouse device common for all
mice
Nov 29 18:14:26 Darkstar kernel: serio: i8042 AUX port at 0x60,0x64 irq
12
Nov 29 18:14:26 Darkstar kernel: serio: i8042 KBD port at 0x60,0x64 irq
1
Nov 29 18:14:26 Darkstar kernel: Advanced Linux Sound Architecture
Driver Version 0.9.0rc3 (Mon Oct 14 16:41:26 2002 UTC).
Nov 29 18:14:26 Darkstar kernel: ALSA device list:
Nov 29 18:14:26 Darkstar kernel:   #0: VIA 8233A/C at 0xb800, irq 22
Nov 29 18:14:26 Darkstar kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Nov 29 18:14:26 Darkstar kernel: IP: routing cache hash table of 8192
buckets, 64Kbytes
Nov 29 18:14:26 Darkstar kernel: TCP: Hash tables configured
(established 262144 bind 65536)
Nov 29 18:14:26 Darkstar kernel: NET4: Unix domain sockets 1.0/SMP for
Linux NET4.0.
Nov 29 18:14:26 Darkstar kernel: ds: no socket drivers loaded!
Nov 29 18:14:26 Darkstar kernel: kjournald starting.  Commit interval 5
seconds
Nov 29 18:14:26 Darkstar kernel: EXT3-fs: mounted filesystem with
ordered data mode.
Nov 29 18:14:27 Darkstar kernel: Freeing unused kernel memory: 104k
freed
Nov 29 18:14:27 Darkstar kernel: drivers/usb/core/hub.c: new USB device
00:10.0-1, assigned address 2
Nov 29 18:14:27 Darkstar kernel: drivers/usb/core/hub.c: USB hub found
at 1
Nov 29 18:14:27 Darkstar kernel: drivers/usb/core/hub.c: 4 ports
detected
Nov 29 18:14:27 Darkstar kernel: Adding 192772k swap on /dev/hdb2.
Priority:-1 extents:1
Nov 29 18:14:27 Darkstar kernel: drivers/usb/core/hub.c: new USB device
00:10.0-1.3, assigned address 3
Nov 29 18:14:27 Darkstar kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on
ide0(3,65), internal journal
Nov 29 18:14:27 Darkstar kernel: input: USB HID v1.10 Keyboard [Logitech
Logitech USB Keyboard] on usb-00:10.0-1.3
Nov 29 18:14:27 Darkstar kernel: input: USB HID v1.10 Mouse [Logitech
Logitech USB Keyboard] on usb-00:10.0-1.3
Nov 29 18:14:27 Darkstar kernel: NTFS driver 2.1.0 [Flags: R/O MODULE].
Nov 29 18:14:27 Darkstar kernel: NTFS volume version 3.1.
Nov 29 18:14:27 Darkstar kernel: drivers/usb/core/hub.c: new USB device
00:10.0-1.4, assigned address 4
Nov 29 18:14:27 Darkstar kernel: input: USB HID v1.10 Mouse [Logitech
USB-PS/2 Optical Mouse] on usb-00:10.0-1.4
Nov 29 18:14:27 Darkstar kernel: eth0: Setting 100mbps full-duplex based
on auto-negotiated partner ability 45e1.





--
Regards,
Mark Rutherford
mark@justirc.net


File: Mark Rutherford.ASC
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: PGPfreeware 7.0.3 for non-commercial use <http://www.pgp.com>

mQGiBDqwRnsRBADTpKKSKAcphYdcVTvBpEFFNK1eL4dQ/pBwK4NimeoAA9ISD04L
Mv/CqH5g9D1wzXEhRBhbFZnmfoTPFEWH4Gjr4KIPdsXkTEfoJ2j55qksHWMkE10A
K8gZlI3Ovuf8BbIabfXmjf+XtId3F4+7+og4mc7EAkatYbbl/5pR0Niy3wCg/+I/
LUQPYGloF829jXaOW7C+tG8D/RZt8lAL/Z1NfGsQYZlE1X+Gcqf0J6HaMosnVuah
1zAbgUHCIvNq+TOC+0KydEvbs7tAq6m+Q4zQZaqEsMwufTCWxzh+v3thRBLIuT5E
jsTi4djkrdG3TTeAszymO/YEXQMg4Tq2hMiyeWlyTmH4C6enMu0zJMIu4OEef7+W
KpYhBACYnukDVI8Vnw1J5KaiCZYvERhj4cr3BTk7oeYxIRH1x5S6NXK0+uVcpusa
a8ZU4zcxvHh0k3iR8HIZcNh30eXbMF/J5pW9gorJuPwCC5Q7b+gUVaeec+1X+Wmt
2k8RAq9RtriUdrmVN5QcPBLFd4hOHQcWDcuyhmiFp68LFvxLSLQrTWFyayBSdXRo
ZXJmb3JkIDxNYXJrMjAwMEBiZWxsYXRsYW50aWMubmV0PokAWAQQEQIAGAUCOrBG
ewgLAwkIBwIBCgIZAQUbAwAAAAAKCRAudCWX7QO6ULcaAJwIsYHeAp6FC5OVWSOo
qc8O87kvBgCgz1cLgVXYcSlDWEeE32PFYb6akuy5Ag0EOrBGexAIAPZCV7cIfwgX
cqK61qlC8wXo+VMROU+28W65Szgg2gGnVqMU6Y9AVfPQB8bLQ6mUrfdMZIZJ+AyD
vWXpF9Sh01D49Vlf3HZSTz09jdvOmeFXklnN/biudE/F/Ha8g8VHMGHOfMlm/xX5
u/2RXscBqtNbno2gpXI61Brwv0YAWCvl9Ij9WE5J280gtJ3kkQc2azNsOA1FHQ98
iLMcfFstjvbzySPAQ/ClWxiNjrtVjLhdONM0/XwXV0OjHRhs3jMhLLUq/zzhsSlA
GBGNfISnCnLWhsQDGcgHKXrKlQzZlp+r0ApQmwJG0wg9ZqRdQZ+cfL2JSyIZJrqr
ol7DVekyCzsAAgIIAO5Bt3XOgo2GPNOCuLv6A6mRxPxwwVsYEMmVAIp/c5nluBMi
Tu4iQU5f3U9UqZMcFKyLr1Vh0bpO6RB6L/5tXWSRY2Yly9Ofg/e0Npgebkdd8GXE
+IuEDI4lr1kbO70hlxFUPKSOQRjSmmVKNhUAiXEFQ7OtB9k5GECsHrD6qxR6r/ny
XMBK2g2UUSh17Gx/pqH+XwXJ67DEQmF8hcnyiN9E3WQ5w3bIbKwFCaHF+tJbVnUd
XxszxQYrsb6Feo0FVdCD+VVPQGesv34CrnKuED/mF/WoI8a3eYCMiY03IQgW514X
JX+Jnmk9RFbTg75NdXIKDqKpB3wq39n3JmWRZG+JAEwEGBECAAwFAjqwRnsFGwwA
AAAACgkQLnQll+0DulAfjgCfbVxiUtJbpXPn6gVJlnlIzur1yvgAnjh/9bdLsSrd
cUaN07NL7N9NjgG1
=hpbN
-----END PGP PUBLIC KEY BLOCK-----

