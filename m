Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263817AbUFNTjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263817AbUFNTjU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 15:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbUFNTjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 15:39:19 -0400
Received: from mh57.com ([217.160.185.21]:64216 "EHLO mithrin.mh57.de")
	by vger.kernel.org with ESMTP id S263817AbUFNTiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 15:38:23 -0400
Date: Mon, 14 Jun 2004 21:38:18 +0200
From: Martin Hermanowski <lkml@martin.mh57.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6.7-rc3-mm1] usb memorystick: device not accepting address 2, error -71
Message-ID: <20040614193818.GD32226@mh57.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Broken-Reverse-DNS: no host name found for IP address 2001:8d8:81:4d0:8000::1
X-Spam-Score: 0.0 (/)
X-Authenticated-ID: martin
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I am running 2.6.7-rc3-mm1, and I just inserted my memory stick, which
only produced the following error message:

,----
| Jun 14 20:38:43 localhost kernel: usb 3-2: new full speed USB device using address 2
| Jun 14 20:38:43 localhost kernel: usb 3-2: device not accepting address 2, error -71
| Jun 14 20:38:43 localhost kernel: usb 3-2: new full speed USB device using address 3
| Jun 14 20:38:43 localhost kernel: usb 3-2: device not accepting address 3, error -71
`----

Replugging the device made it work:

,----
| Jun 14 20:39:01 localhost kernel: usb 3-2: new full speed USB device using address 4
| Jun 14 20:39:02 localhost kernel: SCSI subsystem initialized
| Jun 14 20:39:02 localhost kernel: Initializing USB Mass Storage driver...
| Jun 14 20:39:02 localhost kernel: scsi0 : SCSI emulation for USB Mass Storage devices
| Jun 14 20:39:02 localhost kernel:   Vendor: IBM       Model: Memory Key        Rev: 3.52
| Jun 14 20:39:02 localhost kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
| Jun 14 20:39:02 localhost kernel: USB Mass Storage device found at 4
| Jun 14 20:39:02 localhost kernel: usbcore: registered new driver usb-storage
| Jun 14 20:39:02 localhost kernel: USB Mass Storage support registered.
| Jun 14 20:39:02 localhost usb.agent[26758]:      usb-storage: loaded sucessfully
| Jun 14 20:39:02 localhost scsi.agent[26797]: disk at /devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/host0/0:0:0:0
| Jun 14 20:39:02 localhost kernel: SCSI device sda: 499712 512-byte hdwr sectors (256 MB)
| Jun 14 20:39:02 localhost kernel: sda: assuming Write Enabled
| Jun 14 20:39:02 localhost kernel: sda: assuming drive cache: write through
| Jun 14 20:39:02 localhost kernel:  sda: sda1
| Jun 14 20:39:02 localhost kernel: Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
| Jun 14 20:39:02 localhost usb-storage-hotplug: add 8ec/11/200
`----

The machine had been suspended via swsusp before this happened, I didn't
see anything similar before.

The following lines are issued if the usb modules get loaded:

,----
| ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
| PCI: Setting latency timer of device 0000:00:1d.7 to 64
| ehci_hcd 0000:00:1d.7: irq 11, pci mem e09dc000
| ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
| PCI: cache line size of 32 is not supported by device 0000:00:1d.7
| ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
| hub 1-0:1.0: USB hub found
| hub 1-0:1.0: 6 ports detected
| ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
| ohci_hcd: block sizes: ed 64 td 64
| USB Universal Host Controller Interface driver v2.2
| ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
| uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB (ICH4) USB UHCI #1
| PCI: Setting latency timer of device 0000:00:1d.0 to 64
| uhci_hcd 0000:00:1d.0: irq 11, io base 00001800
| uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
| hub 2-0:1.0: USB hub found
| hub 2-0:1.0: 2 ports detected
| ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
| uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB (ICH4) USB UHCI #2
| PCI: Setting latency timer of device 0000:00:1d.1 to 64
| uhci_hcd 0000:00:1d.1: irq 11, io base 00001820
| uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
| hub 3-0:1.0: USB hub found
| hub 3-0:1.0: 2 ports detected
| ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
| uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB (ICH4) USB UHCI #3
| PCI: Setting latency timer of device 0000:00:1d.2 to 64
| uhci_hcd 0000:00:1d.2: irq 11, io base 00001840
| uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
| hub 4-0:1.0: USB hub found
| hub 4-0:1.0: 2 ports detected
`----

My kernel config can be found at mh57.de/~martin/config-2.6.7-rc3-mm1
The dmesg from the kernel boot is at w3m mh57.de/~martin/dmesg

LLAP, Martin

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAzf6qmGb6Npij0ewRAnaEAJ9sR48Srux+FE1mG0swPhK1Z055ZwCggEL4
X4vNR1bygswu8bnD9zbY9Ec=
=VMmq
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
