Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267185AbSK2X7d>; Fri, 29 Nov 2002 18:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267186AbSK2X7d>; Fri, 29 Nov 2002 18:59:33 -0500
Received: from rrcs-midsouth-24-172-39-28.biz.rr.com ([24.172.39.28]:16902
	"EHLO maunzelectronics.com") by vger.kernel.org with ESMTP
	id <S267185AbSK2X7S>; Fri, 29 Nov 2002 18:59:18 -0500
Message-ID: <3DE80101.E92BD010@justirc.net>
Date: Fri, 29 Nov 2002 19:06:25 -0500
From: Mark Rutherford <mark@justirc.net>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.20] Trouble with via 8235 [does not boot] (forgot .config 
 SORRY!)
References: <3DE7FF0F.DF8EC985@justirc.net>
Content-Type: multipart/mixed;
 boundary="------------67C436BC92AF1FE36A1CB0D0"
X-scanner: scanned by Inflex 1.0.12.3 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------67C436BC92AF1FE36A1CB0D0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



Mark Rutherford wrote:

> hey all.
> been working at 2.4.20 all day now trying to make sure ive done this
> right..
> I think I have but i will let you all be the judge.
> please find attached my .config renamed to config.txt for the sake of
> window$
> also find attached a normal bootup as of 1 hour ago using kernel 2.5.44
> I have tried the following:
> re-downloaded the kernel souces in both tar/bz2 and tar/gzip formats
> both archives were the same, natually
> reconfigured both to no avail.
> what I do not understand is that it does not detect the 2 devices i have
> on the promise controller, or hda, hdb
> it does find hdc and hdd and it does seem to detect the via 8235
> controller as well.
> what could possibly be wrong here?
>
> dmesg: (from 2.5.44 on the same machine, I cannot snatch the bootup from
> 2.4.20)
>
>  Nov 29 18:14:19 Darkstar syslogd 1.4.1: restart.
> Nov 29 18:14:20 Darkstar kernel: klogd 1.4.1, log source = /proc/kmsg
> started.
> Nov 29 18:14:20 Darkstar kernel: BIOS-provided physical RAM map:
> Nov 29 18:14:20 Darkstar kernel: 127MB HIGHMEM available.
> Nov 29 18:14:20 Darkstar kernel: 896MB LOWMEM available.
> Nov 29 18:14:20 Darkstar sshd[76]: Server listening on 0.0.0.0 port 22.
> Nov 29 18:14:20 Darkstar kernel: Initializing CPU#0
> Nov 29 18:14:20 Darkstar kernel: Memory: 1033628k/1048512k available
> (2116k kernel code, 14496k reserved, 1538k data, 104k init, 131008k
> highmem)
> Nov 29 18:14:20 Darkstar kernel: Security Scaffold v1.0.0 initialized
> Nov 29 18:14:20 Darkstar kernel: Dentry cache hash table entries: 131072
> (order: 8, 1048576 bytes)
> Nov 29 18:14:20 Darkstar kernel: CPU: L1 I Cache: 64K (64 bytes/line), D
> cache 64K (64 bytes/line)
> Nov 29 18:14:20 Darkstar kernel: CPU: L2 Cache: 256K (64 bytes/line)
> Nov 29 18:14:20 Darkstar kernel: Intel machine check architecture
> supported.
> Nov 29 18:14:20 Darkstar kernel: Intel machine check reporting enabled
> on CPU#0.
> Nov 29 18:14:20 Darkstar kernel: Machine check exception polling timer
> started.
> Nov 29 18:14:20 Darkstar kernel: Enabling fast FPU save and restore...
> done.
> Nov 29 18:14:20 Darkstar kernel: Enabling unmasked SIMD FPU exception
> support... done.
> Nov 29 18:14:20 Darkstar kernel: Checking 'hlt' instruction... OK.
> Nov 29 18:14:20 Darkstar kernel: ...changing IO-APIC physical APIC ID to
> 2 ... ok.
> Nov 29 18:14:20 Darkstar kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
> Nov 29 18:14:20 Darkstar kernel: testing the IO
> APIC.......................
> Nov 29 18:14:22 Darkstar kernel: ....................................
> done.
> Nov 29 18:14:22 Darkstar kernel: Linux NET4.0 for Linux 2.4
> Nov 29 18:14:22 Darkstar kernel: Based upon Swansea University Computer
> Society NET3.039
> Nov 29 18:14:22 Darkstar kernel: Linux Plug and Play Support v0.9 (c)
> Adam Belay
> Nov 29 18:14:22 Darkstar kernel: PCI: PCI BIOS revision 2.10 entry at
> 0xf9df0, last bus=1
> Nov 29 18:14:22 Darkstar kernel: PCI: Using configuration type 1
> Nov 29 18:14:22 Darkstar kernel: isapnp: Scanning for PnP cards...
> Nov 29 18:14:22 Darkstar kernel: isapnp: No Plug & Play device found
> Nov 29 18:14:22 Darkstar kernel: drivers/usb/core/usb.c: registered new
> driver usbfs
> Nov 29 18:14:22 Darkstar kernel: drivers/usb/core/usb.c: registered new
> driver hub
> Nov 29 18:14:23 Darkstar kernel: PCI: Using IRQ router default
> [1106/3189] at 00:00.0
> Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I11,P0) ->
> 19
> Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I15,P0) ->
> 19
> Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I16,P0) ->
> 21
> Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I16,P1) ->
> 21
> Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I16,P2) ->
> 21
> Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I16,P3) ->
> 19
> Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I17,P0) ->
> 10
> Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I17,P2) ->
> 22
> Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I19,P0) ->
> 18
> Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B0,I20,P0) ->
> 16
> Nov 29 18:14:23 Darkstar kernel: PCI->APIC IRQ transform: (B1,I0,P0) ->
> 16
> Nov 29 18:14:23 Darkstar kernel: aio_setup: sizeof(struct page) = 40
> Nov 29 18:14:23 Darkstar kernel: Journalled Block Device driver loaded
> Nov 29 18:14:23 Darkstar kernel: Installing knfsd (copyright (C) 1996
> okir@monad.swb.de).
> Nov 29 18:14:23 Darkstar kernel: udf: registering filesystem
> Nov 29 18:14:23 Darkstar kernel: Capability LSM initialized
> Nov 29 18:14:23 Darkstar kernel: PCI: Via IRQ fixup for 00:10.0, from 10
> to 5
> Nov 29 18:14:23 Darkstar kernel: PCI: Via IRQ fixup for 00:10.1, from 10
> to 5
> Nov 29 18:14:23 Darkstar kernel: PCI: Via IRQ fixup for 00:10.2, from 11
> to 5
> Nov 29 18:14:23 Darkstar kernel: Serial: 8250/16550 driver $Revision:
> 1.90 $ IRQ sharing disabled
> Nov 29 18:14:23 Darkstar kernel: Linux agpgart interface v0.99 (c) Jeff
> Hartmann
> Nov 29 18:14:23 Darkstar kernel: agpgart: Maximum main memory to use for
> agp memory: 816M
> Nov 29 18:14:24 Darkstar kernel: Floppy drive(s): fd0 is 1.44M
> Nov 29 18:14:24 Darkstar kernel: FDC 0 is a post-1991 82077
> Nov 29 18:14:24 Darkstar kernel: 8139too Fast Ethernet driver 0.9.26
> Nov 29 18:14:24 Darkstar kernel: eth0: RealTek RTL8139 Fast Ethernet at
> 0xf8800000, 00:20:ed:46:87:68, IRQ 18
> Nov 29 18:14:24 Darkstar kernel: Uniform Multi-Platform E-IDE driver
> Revision: 7.00alpha2
> Nov 29 18:14:24 Darkstar kernel: PDC20276: IDE controller at PCI slot
> 00:0f.0
> Nov 29 18:14:24 Darkstar kernel: PDC20276: chipset revision 1
> Nov 29 18:14:24 Darkstar kernel: PDC20276: not 100%% native mode: will
> probe irqs later
> Nov 29 18:14:24 Darkstar kernel: PDC20276: neither IDE port enabled
> (BIOS)
> Nov 29 18:14:24 Darkstar kernel: VP_IDE: IDE controller at PCI slot
> 00:11.1
> Nov 29 18:14:24 Darkstar kernel: VP_IDE: chipset revision 6
> Nov 29 18:14:24 Darkstar kernel: VP_IDE: not 100%% native mode: will
> probe irqs later
> Nov 29 18:14:24 Darkstar kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133
> controller on pci00:11.1
> Nov 29 18:14:24 Darkstar kernel: hda: setmax LBA 156250080, native
> 156250000
> Nov 29 18:14:24 Darkstar kernel: hda: 156250000 sectors (80000 MB)
> w/2048KiB Cache, CHS=9726/255/63, UDMA(100)
> Nov 29 18:14:24 Darkstar kernel:  hda: hda1
> Nov 29 18:14:24 Darkstar kernel: hdb: 26564832 sectors (13601 MB)
> w/2048KiB Cache, CHS=1653/255/63, UDMA(66)
> Nov 29 18:14:24 Darkstar kernel:  hdb: hdb1 hdb2
> Nov 29 18:14:24 Darkstar kernel: Uniform CD-ROM driver Revision: 3.12
> Nov 29 18:14:24 Darkstar kernel: SCSI subsystem driver Revision: 1.00
> Nov 29 18:14:25 Darkstar kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI
> SCSI HBA DRIVER, Rev 6.2.4
> Nov 29 18:14:25 Darkstar kernel:   Vendor: SONY      Model: CD-ROM
> CDU-76S    Rev: 1.1c
> Nov 29 18:14:25 Darkstar kernel:   Type:
> CD-ROM                             ANSI SCSI revision: 02
> Nov 29 18:14:25 Darkstar kernel:   Vendor: MATSHITA  Model: CD-ROM
> CR-8005    Rev: 2.0d
> Nov 29 18:14:25 Darkstar kernel:   Type:
> CD-ROM                             ANSI SCSI revision: 02
> Nov 29 18:14:25 Darkstar kernel: Linux Kernel Card Services 3.1.22
> Nov 29 18:14:25 Darkstar kernel:   options:  [pci] [cardbus]
> Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hcd-pci.c: ehci-hcd @
> 00:10.3, VIA Technologies, Inc. USB 2.0
> Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hcd-pci.c: irq 19, pci
> mem f880a000
> Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hcd.c: new USB bus
> registered, assigned bus number 1
> Nov 29 18:14:25 Darkstar kernel: drivers/usb/host/ehci-hcd.c: USB 2.0
> support enabled, EHCI rev 1.00, ehci-hcd 2002-Sep-23
> Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hub.c: USB hub found
> at 0
> Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hub.c: 6 ports
> detected
> Nov 29 18:14:25 Darkstar kernel: drivers/usb/host/uhci-hcd.c: USB
> Universal Host Controller Interface driver v2.0
> Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hcd-pci.c: uhci-hcd @
> 00:10.0, VIA Technologies, Inc. USB
> Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hcd-pci.c: irq 21, io
> base 0000a800
> Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hcd.c: new USB bus
> registered, assigned bus number 2
> Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hub.c: USB hub found
> at 0
> Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hub.c: 2 ports
> detected
> Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hcd-pci.c: uhci-hcd @
> 00:10.1, VIA Technologies, Inc. USB (#2)
> Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hcd-pci.c: irq 21, io
> base 0000ac00
> Nov 29 18:14:25 Darkstar kernel: drivers/usb/core/hcd.c: new USB bus
> registered, assigned bus number 3
> Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/hub.c: USB hub found
> at 0
> Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/hub.c: 2 ports
> detected
> Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/hcd-pci.c: uhci-hcd @
> 00:10.2, VIA Technologies, Inc. USB (#3)
> Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/hcd-pci.c: irq 21, io
> base 0000b000
> Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/hcd.c: new USB bus
> registered, assigned bus number 4
> Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/hub.c: USB hub found
> at 0
> Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/hub.c: 2 ports
> detected
> Nov 29 18:14:26 Darkstar kernel: Initializing USB Mass Storage driver...
>
> Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/usb.c: registered new
> driver usb-storage
> Nov 29 18:14:26 Darkstar kernel: USB Mass Storage support registered.
> Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/usb.c: registered new
> driver hiddev
> Nov 29 18:14:26 Darkstar kernel: drivers/usb/core/usb.c: registered new
> driver hid
> Nov 29 18:14:26 Darkstar kernel: drivers/usb/input/hid-core.c: v2.0:USB
> HID core driver
> Nov 29 18:14:26 Darkstar kernel: mice: PS/2 mouse device common for all
> mice
> Nov 29 18:14:26 Darkstar kernel: serio: i8042 AUX port at 0x60,0x64 irq
> 12
> Nov 29 18:14:26 Darkstar kernel: serio: i8042 KBD port at 0x60,0x64 irq
> 1
> Nov 29 18:14:26 Darkstar kernel: Advanced Linux Sound Architecture
> Driver Version 0.9.0rc3 (Mon Oct 14 16:41:26 2002 UTC).
> Nov 29 18:14:26 Darkstar kernel: ALSA device list:
> Nov 29 18:14:26 Darkstar kernel:   #0: VIA 8233A/C at 0xb800, irq 22
> Nov 29 18:14:26 Darkstar kernel: NET4: Linux TCP/IP 1.0 for NET4.0
> Nov 29 18:14:26 Darkstar kernel: IP: routing cache hash table of 8192
> buckets, 64Kbytes
> Nov 29 18:14:26 Darkstar kernel: TCP: Hash tables configured
> (established 262144 bind 65536)
> Nov 29 18:14:26 Darkstar kernel: NET4: Unix domain sockets 1.0/SMP for
> Linux NET4.0.
> Nov 29 18:14:26 Darkstar kernel: ds: no socket drivers loaded!
> Nov 29 18:14:26 Darkstar kernel: kjournald starting.  Commit interval 5
> seconds
> Nov 29 18:14:26 Darkstar kernel: EXT3-fs: mounted filesystem with
> ordered data mode.
> Nov 29 18:14:27 Darkstar kernel: Freeing unused kernel memory: 104k
> freed
> Nov 29 18:14:27 Darkstar kernel: drivers/usb/core/hub.c: new USB device
> 00:10.0-1, assigned address 2
> Nov 29 18:14:27 Darkstar kernel: drivers/usb/core/hub.c: USB hub found
> at 1
> Nov 29 18:14:27 Darkstar kernel: drivers/usb/core/hub.c: 4 ports
> detected
> Nov 29 18:14:27 Darkstar kernel: Adding 192772k swap on /dev/hdb2.
> Priority:-1 extents:1
> Nov 29 18:14:27 Darkstar kernel: drivers/usb/core/hub.c: new USB device
> 00:10.0-1.3, assigned address 3
> Nov 29 18:14:27 Darkstar kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on
> ide0(3,65), internal journal
> Nov 29 18:14:27 Darkstar kernel: input: USB HID v1.10 Keyboard [Logitech
> Logitech USB Keyboard] on usb-00:10.0-1.3
> Nov 29 18:14:27 Darkstar kernel: input: USB HID v1.10 Mouse [Logitech
> Logitech USB Keyboard] on usb-00:10.0-1.3
> Nov 29 18:14:27 Darkstar kernel: NTFS driver 2.1.0 [Flags: R/O MODULE].
> Nov 29 18:14:27 Darkstar kernel: NTFS volume version 3.1.
> Nov 29 18:14:27 Darkstar kernel: drivers/usb/core/hub.c: new USB device
> 00:10.0-1.4, assigned address 4
> Nov 29 18:14:27 Darkstar kernel: input: USB HID v1.10 Mouse [Logitech
> USB-PS/2 Optical Mouse] on usb-00:10.0-1.4
> Nov 29 18:14:27 Darkstar kernel: eth0: Setting 100mbps full-duplex based
> on auto-negotiated partner ability 45e1.
>
> --
> Regards,
> Mark Rutherford
> mark@justirc.net
>
> File: Mark Rutherford.ASC
> -----BEGIN PGP PUBLIC KEY BLOCK-----
> Version: PGPfreeware 7.0.3 for non-commercial use <http://www.pgp.com>
>
> mQGiBDqwRnsRBADTpKKSKAcphYdcVTvBpEFFNK1eL4dQ/pBwK4NimeoAA9ISD04L
> Mv/CqH5g9D1wzXEhRBhbFZnmfoTPFEWH4Gjr4KIPdsXkTEfoJ2j55qksHWMkE10A
> K8gZlI3Ovuf8BbIabfXmjf+XtId3F4+7+og4mc7EAkatYbbl/5pR0Niy3wCg/+I/
> LUQPYGloF829jXaOW7C+tG8D/RZt8lAL/Z1NfGsQYZlE1X+Gcqf0J6HaMosnVuah
> 1zAbgUHCIvNq+TOC+0KydEvbs7tAq6m+Q4zQZaqEsMwufTCWxzh+v3thRBLIuT5E
> jsTi4djkrdG3TTeAszymO/YEXQMg4Tq2hMiyeWlyTmH4C6enMu0zJMIu4OEef7+W
> KpYhBACYnukDVI8Vnw1J5KaiCZYvERhj4cr3BTk7oeYxIRH1x5S6NXK0+uVcpusa
> a8ZU4zcxvHh0k3iR8HIZcNh30eXbMF/J5pW9gorJuPwCC5Q7b+gUVaeec+1X+Wmt
> 2k8RAq9RtriUdrmVN5QcPBLFd4hOHQcWDcuyhmiFp68LFvxLSLQrTWFyayBSdXRo
> ZXJmb3JkIDxNYXJrMjAwMEBiZWxsYXRsYW50aWMubmV0PokAWAQQEQIAGAUCOrBG
> ewgLAwkIBwIBCgIZAQUbAwAAAAAKCRAudCWX7QO6ULcaAJwIsYHeAp6FC5OVWSOo
> qc8O87kvBgCgz1cLgVXYcSlDWEeE32PFYb6akuy5Ag0EOrBGexAIAPZCV7cIfwgX
> cqK61qlC8wXo+VMROU+28W65Szgg2gGnVqMU6Y9AVfPQB8bLQ6mUrfdMZIZJ+AyD
> vWXpF9Sh01D49Vlf3HZSTz09jdvOmeFXklnN/biudE/F/Ha8g8VHMGHOfMlm/xX5
> u/2RXscBqtNbno2gpXI61Brwv0YAWCvl9Ij9WE5J280gtJ3kkQc2azNsOA1FHQ98
> iLMcfFstjvbzySPAQ/ClWxiNjrtVjLhdONM0/XwXV0OjHRhs3jMhLLUq/zzhsSlA
> GBGNfISnCnLWhsQDGcgHKXrKlQzZlp+r0ApQmwJG0wg9ZqRdQZ+cfL2JSyIZJrqr
> ol7DVekyCzsAAgIIAO5Bt3XOgo2GPNOCuLv6A6mRxPxwwVsYEMmVAIp/c5nluBMi
> Tu4iQU5f3U9UqZMcFKyLr1Vh0bpO6RB6L/5tXWSRY2Yly9Ofg/e0Npgebkdd8GXE
> +IuEDI4lr1kbO70hlxFUPKSOQRjSmmVKNhUAiXEFQ7OtB9k5GECsHrD6qxR6r/ny
> XMBK2g2UUSh17Gx/pqH+XwXJ67DEQmF8hcnyiN9E3WQ5w3bIbKwFCaHF+tJbVnUd
> XxszxQYrsb6Feo0FVdCD+VVPQGesv34CrnKuED/mF/WoI8a3eYCMiY03IQgW514X
> JX+Jnmk9RFbTg75NdXIKDqKpB3wq39n3JmWRZG+JAEwEGBECAAwFAjqwRnsFGwwA
> AAAACgkQLnQll+0DulAfjgCfbVxiUtJbpXPn6gVJlnlIzur1yvgAnjh/9bdLsSrd
> cUaN07NL7N9NjgG1
> =hpbN
> -----END PGP PUBLIC KEY BLOCK-----
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

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


--------------67C436BC92AF1FE36A1CB0D0
Content-Type: text/plain; charset=us-ascii;
 name="config.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config.txt"

# Automatically generated make config: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_HIGHIO is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_STATS=y

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# ATA/IDE/MFM/RLL support
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
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDETAPE=y
CONFIG_BLK_DEV_IDEFLOPPY=y
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_OFFBOARD=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_PDC202XX=y
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
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

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_TC35815 is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# CONFIG_HVC_CONSOLE is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_SERIO is not set

#
# Joysticks
#
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_AMD_PM768 is not set
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_REISERFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_UMSDOS_FS=y
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
CONFIG_NTFS_FS=y
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
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
# CONFIG_NLS_ISO8859_1 is not set
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
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=y
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_FORTE is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
CONFIG_SOUND_VIA82CXXX=y
CONFIG_MIDI_VIA82CXXX=y
# CONFIG_SOUND_OSS is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEVICEFS is not set
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_LONG_TIMEOUT is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_UHCI_ALT=y
# CONFIG_USB_OHCI is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_MIDI is not set

#
#   SCSI support is needed for USB Storage
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
# CONFIG_USB_HIDINPUT is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set

#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set

#
# USB Multimedia devices
#

#
#   Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set

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
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set

#
# Library routines
#
# CONFIG_ZLIB_INFLATE is not set
# CONFIG_ZLIB_DEFLATE is not set

--------------67C436BC92AF1FE36A1CB0D0--
