Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbULFJNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbULFJNG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 04:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbULFJNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 04:13:06 -0500
Received: from hamlet.e18.physik.tu-muenchen.de ([129.187.154.223]:27577 "EHLO
	hamlet.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S261419AbULFJMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 04:12:52 -0500
In-Reply-To: <200412051846.45496.quanten.sprung@gmx.net>
References: <200412051846.45496.quanten.sprung@gmx.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1--537968551"
Message-Id: <7898B13E-4764-11D9-960E-000A9567DDDE@e18.physik.tu-muenchen.de>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Subject: Re: [usb] device not accepting address / timeout
Date: Mon, 6 Dec 2004 09:54:42 +0100
To: Alexander Dressler <quanten.sprung@gmx.net>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-1--537968551
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Alexander!

I have the same problem with Debian unstable, kernel 2.6.10-rc2-mm3 and 
uhci-hcd (usb1). It affects my keyboard and mouse :-(

pci=noacpi solved the problem for me. Else the interrupt count on 
IRQ#10 stayed at zero and nothing worked. pci=routeirq did not help.

On Dec 5, 2004, at 6:46 PM, Alexander Dressler wrote:

> hi,
>
> I encountered some problems connecting a usb-scanner (usb2). Since I 
> found
> only postings in newgroups that report similar problems but no 
> solution, I
> hope someone here can help.
>
> OS: Debian Sarge
> Tested Kernels:  2.6.9, 2.6.10-rc1, 2.6.10-rc3
>
> Usb output of dmesg:
>
> ehci_hcd 0000:00:10.3: VIA Technologies, Inc. USB 2.0
> ehci_hcd 0000:00:10.3: reset hcs_params 0x2204 dbg=0 cc=2 pcc=2 
> ordered !ppc
> ports=4
> ehci_hcd 0000:00:10.3: reset hcc_params 6872 thresh 7 uframes 
> 256/512/1024
> ehci_hcd 0000:00:10.3: capability 0001 at 68
> ehci_hcd 0000:00:10.3: irq 21, pci mem 0xdfffff00
> ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:00:10.3: reset command 080002 (park)=0 ithresh=8 
> period=1024
> Reset HALT
> ehci_hcd 0000:00:10.3: init command 010009 (park)=0 ithresh=1 
> period=256 RUN
> ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
> ehci_hcd 0000:00:10.3: supports USB remote wakeup
> usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: default language 0x0409
> usb usb1: Product: VIA Technologies, Inc. USB 2.0
> usb usb1: Manufacturer: Linux 2.6.10-rc1 ehci_hcd
> usb usb1: SerialNumber: 0000:00:10.3
> usb usb1: hotplug
> usb usb1: adding 1-0:1.0 (config #1, interface 0)
> usb 1-0:1.0: hotplug
> hub 1-0:1.0: usb_probe_interface
> hub 1-0:1.0: usb_probe_interface - got id
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 4 ports detected
> hub 1-0:1.0: standalone hub
> hub 1-0:1.0: ganged power switching
> hub 1-0:1.0: individual port over-current protection
> hub 1-0:1.0: Single TT
> hub 1-0:1.0: TT requires at most 8 FS bit times
> hub 1-0:1.0: power on to power good time: 20ms
> hub 1-0:1.0: local power source is good
> hub 1-0:1.0: enabling power on all ports
> ehci_hcd 0000:00:10.3: GetStatus port 4 status 001803 POWER sig=j  CSC 
> CONNECT
> hub 1-0:1.0: port 4, status 0501, change 0001, 480 Mb/s
> hub 1-0:1.0: debounce: port 4: total 100ms stable 100ms status 0x501
> ehci_hcd 0000:00:10.3: port 4 high speed
> ehci_hcd 0000:00:10.3: GetStatus port 4 status 001005 POWER sig=se0  PE
> CONNECT
> usb 1-4: new high speed USB device using address 2
> USB Universal Host Controller Interface driver v2.2
> ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
> PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 5
> uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller
> uhci_hcd 0000:00:10.0: irq 21, io base 0xe800
> uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
> uhci_hcd 0000:00:10.0: detected 2 ports
> [....]
> usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb3: default language 0x0409
> usb usb3: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
> Controller
> (#2)
> usb usb3: Manufacturer: Linux 2.6.10-rc1 uhci_hcd
> usb usb3: SerialNumber: 0000:00:10.1
> usb usb3: hotplug
> usb usb3: adding 3-0:1.0 (config #1, interface 0)
> usb 3-0:1.0: hotplug
> hub 3-0:1.0: usb_probe_interface
> hub 3-0:1.0: usb_probe_interface - got id
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> hub 3-0:1.0: standalone hub
> hub 3-0:1.0: no power switching (usb 1.0)
> hub 3-0:1.0: individual port over-current protection
> hub 3-0:1.0: power on to power good time: 2ms
> hub 3-0:1.0: local power source is good
> uhci_hcd 0000:00:10.0: suspend_hc
> uhci_hcd 0000:00:10.1: suspend_hc
> usb 1-4: control timeout on ep0in
> ehci_hcd 0000:00:10.3: devpath 4 ep0out 3strikes
> ehci_hcd 0000:00:10.3: devpath 4 ep0out 3strikes
> usb 1-4: device not accepting address 2, error -71
> hub 1-0:1.0: port 4 not reset yet, waiting 50ms
> ehci_hcd 0000:00:10.3: port 4 high speed
> ehci_hcd 0000:00:10.3: GetStatus port 4 status 001005 POWER sig=se0  PE
> CONNECT
> usb 1-4: new high speed USB device using address 3
> usb 1-4: control timeout on ep0in       <------------------------
> ehci_hcd 0000:00:10.3: devpath 4 ep0out 3strikes
> ehci_hcd 0000:00:10.3: devpath 4 ep0out 3strikes
> usb 1-4: device not accepting address 3, error -71     <--------
> uhci_hcd 0000:00:10.0: port 1 portsc 008a,00
> hub 2-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
> hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
> uhci_hcd 0000:00:10.0: port 2 portsc 008a,00
> hub 2-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
> hub 2-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
> uhci_hcd 0000:00:10.1: port 1 portsc 008a,00
> hub 3-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
> hub 3-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
> uhci_hcd 0000:00:10.1: port 2 portsc 009a,00
> hub 3-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
> hub 3-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
> ehci_hcd 0000:00:10.3: GetStatus port 4 status 001803 POWER sig=j  CSC 
> CONNECT
> hub 1-0:1.0: port 4, status 0501, change 0001, 480 Mb/s
> hub 1-0:1.0: debounce: port 4: total 100ms stable 100ms status 0x501
> hub 1-0:1.0: port 4 not reset yet, waiting 50ms
> ehci_hcd 0000:00:10.3: port 4 high speed
> ehci_hcd 0000:00:10.3: GetStatus port 4 status 001005 POWER sig=se0  PE
> CONNECT
> usb 1-4: new high speed USB device using address 4
> [.....]
>
>
>
> lsusb reports:
> Bus 003 Device 001: ID 0000:0000
> Bus 002 Device 001: ID 0000:0000
> Bus 001 Device 001: ID 0000:0000
> although the scanner is connected.
>
> Other usb-devices such as memory sticks work normaly. I tried to 
> disable ehci
> but this didn't improve the situation. And the scanner already worked
> successfully with a 2.4 kernel a year ago.
>
>
> Hope someone can clear up.
>
> TIA.
>
> Alex
>
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Ciao,
					Roland

--
TU Muenchen, Physik-Department E18, James-Franck-Str. 85747 Garching
Telefon 089/289-12592; Telefax 089/289-12570
--
A mouse is a device used to point at
the xterm you want to type in.
Kim Alm on a.s.r.

--Apple-Mail-1--537968551
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFBtB5XI4MWO8QIRP0RArHnAJ0fkTiZtVXN9WPrJ2V5VvOP1AZJhwCgh6jm
rb2RQ7ZGQT1cEgfJGaFWOmo=
=xih9
-----END PGP SIGNATURE-----

--Apple-Mail-1--537968551--

