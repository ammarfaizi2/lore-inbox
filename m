Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264276AbUFXLnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbUFXLnq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 07:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUFXLnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 07:43:45 -0400
Received: from [193.70.192.33] ([193.70.192.33]:26558 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S264276AbUFXLnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 07:43:37 -0400
Date: Thu, 24 Jun 2004 13:43:37 +0200
From: "Angelo Dell'Aera" <buffer@antifork.org>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm2
Message-Id: <20040624134337.54156610.buffer@antifork.org>
In-Reply-To: <20040624033321.7366ac67.akpm@osdl.org>
References: <20040624014655.5d2a4bfb.akpm@osdl.org>
	<20040624033321.7366ac67.akpm@osdl.org>
Organization: Antifork Research, Inc.
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-PGP-Program: GNU Privacy Guard (http://www.gnupg.org)
X-PGP-PublicKey: http://buffer.antifork.org/privacy/buffer-gpg.asc
X-PGP-Fingerprint: 48CC B0D8 C394 CD30 355F E36D A4E3 48CF 19C1 5CA2
X-Operating-System: GNU-Linux
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, 24 Jun 2004 03:33:21 -0700
Andrew Morton <akpm@osdl.org> wrote:

>OK, ACPI seems to have progressed in a non-forward direction here.
>
>If anyone has weird problems, please do a `patch -p1 -R' of
>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm2/broken-out/bk-acpi.patch
>
>USB doesn't come up:
>
>usb 2-1: control timeout on ep0out
>uhci_hcd 0000:00:1d.0: Unlink after no-IRQ?  Different ACPI or APIC settings may help.
>usb 2-1: control timeout on ep0out
>usb 2-1: device not accepting address 2, error -110
>usb 2-1: new low speed USB device using address 3
>usb 2-1: control timeout on ep0out
>usb 2-1: control timeout on ep0out
>usb 2-1: device not accepting address 3, error -110
>usb 2-2: new full speed USB device using address 4
>usb 2-2: control timeout on ep0out
>usb 2-2: control timeout on ep0out
>usb 2-2: device not accepting address 4, error -110
>usb 2-2: new full speed USB device using address 5
>usb 2-2: control timeout on ep0out
>usb 2-2: control timeout on ep0out
>usb 2-2: device not accepting address 5, error -110


Here no problems at all. ACPI works quite good and I did few tests 
for USB which show no particular problem.

buffer@mintaka:~$ cat /proc/cpuinfo | grep "model name"
model name      : mobile AMD Athlon(tm) XP 2000+

At boot time...

usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:02.0: ALi Corporation USB 1.1 Controller
ohci_hcd 0000:00:02.0: irq 10, pci mem dfc1c000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected


While playing with a 4 port HUB and a digital camera...


ohci_hcd 0000:00:02.0: remote wakeup
usb 1-2: new full speed USB device using address 2
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
Vendor: Fujifilm  Model: FinePix 1400Zoom  Rev: 1000
Jun 24 13:21:08 mintaka kernel:   
Type:   Direct-Access                      ANSI SCSI revision: 02
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
scsi.agent[1690]: disk at /devices/pci0000:00/0000:00:02.0/usb1/1-2/1-2:1.0/host0/0:0:0:0
SCSI device sda: 16000 512-byte hdwr sectors (8 MB)
sda: assuming Write Enabled
sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
usb 1-2: USB disconnect, address 2
ohci_hcd 0000:00:02.0: remote wakeup
usb 1-2: new full speed USB device using address 3
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
usb 1-2.2: new full speed USB device using address 4
scsi1 : SCSI emulation for USB Mass Storage devices
Vendor: Fujifilm  Model: FinePix 1400Zoom  Rev: 1000
Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 16000 512-byte hdwr sectors (8 MB)
sda: assuming Write Enabled
sda: sda1
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
scsi.agent[1908]: disk at /devices/pci0000:00/0000:00:02.0/usb1/1-2/1-2.2/1-2.2:1.0/host1/1:0:0:0
usb 1-2.2: USB disconnect, address 4
usb 1-2: USB disconnect, address 3

Regards.

- --

Angelo Dell'Aera 'buffer' 
Antifork Research, Inc.	  	http://buffer.antifork.org

PGP information in e-mail header


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA2r5opONIzxnBXKIRAvHWAKCbyh6g2BhcStWNSSP01IjKbGskKQCeOYc+
n/njVG7fSWhY6BeuaCxBIOw=
=mX3F
-----END PGP SIGNATURE-----
