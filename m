Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265432AbTFVShg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 14:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265453AbTFVShg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 14:37:36 -0400
Received: from RJ088138.user.veloxzone.com.br ([200.141.88.138]:19072 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id S265432AbTFVSh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 14:37:29 -0400
Date: Sun, 22 Jun 2003 15:51:22 -0300 (BRT)
From: =?UTF-8?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.21 released
Message-ID: <Pine.LNX.4.56.0306221509150.181@pervalidus.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://marc.theaimsgroup.com/?l=linux-kernel&m=105572386027023&w=2

Nobody replied but let me do my last report.

> I just tested with 2.4.21. With IO-APIC everything worked
> except the ethernet.

My ECS K7VTA3 5.0C is useless with Linux since I can't get
ethernet to work with IO-APIC, and without it modprobe usb-uhci
just freezes everything. It may be a broken motherboard. I
can't believe all 5.0 have so many problems, but...

...I wonder what's so different in Windows XP. As I reported
ethernet and USB work together there.

My last try was ACPI, but while the ethernet worked, the USB
and onboard sound didn't:

# modprobe usbcore
...

# modprobe usb-uhci
...

Sorry, I couldn't copy all lines, but you get the idea.

usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: No IRQ known for interrupt pin C of device 00:10.2
usb-uhci.c: USB UHCI at I/O 0xdc00, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: new USB device 00:10.0-1, assigned address 2
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: new USB device 00:10.0-1, assigned address 3
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3 (error=-110)

# modprobe ehci-hcd
PCI: No IRQ known for interrupt pin D of device 00:10.3
ehci-hcd 00:10.3: VIA Technologies, Inc. USB 2.0
ehci-hcd 00:10.3: irq 11, pci mem e286f000
usb.c: new USB bus registered, assigned bus number 4
PCI: 00:10.3 PCI cache line size set incorrectly (32 bytes) by BIOS/FW.
PCI: 00:10.3 PCI cache line size corrected to 64.
ehci-hcd 00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hub.c: USB hub found
hub.c: 6 ports detected
hub.c: new USB device 00:10.0-1, assigned address 4
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=4 (error=-110)
hub.c: new USB device 00:10.0-1, assigned address 5
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=5 (error=-110)

# modprobe sound
Via 686a/8233/8235 audio driver 1.9.1-ac2
PCI: No IRQ known for interrupt pin C of device 00:11.5
via82cxxx: Six channel audio available
ac97_codec: AC97 Audio codec, id: VIA97 (Unknown)
via82cxxx: board #1 at 0xE400, IRQ 10

Any sound loops at the start and the kernel reports

via_audio: ignoring drain playback error -512

I also tried ACPI with noapic, but things got worse. The
ethernet and sound worked, but everything reported an awful
amount of APIC error on CPU0: 40(40). 'shutdown -r now' did the
same and I finally rebooted with SysRq.

My last ECS, really. The BIOS is even worse. If you disable
RAID and 1394 the menus just disappear and you can't reenable
them.
