Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266810AbUIVTps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUIVTps (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 15:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266802AbUIVTps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 15:45:48 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:13267 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S266810AbUIVTk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 15:40:26 -0400
Subject: [2.6.8 ->] Problems, hci_usb dosn't work.
From: Ian Kumlien <pomac@vapor.com>
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jTU8rHxnBpDxzT7adCMA"
Message-Id: <1095882024.3559.9.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 22 Sep 2004 21:40:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jTU8rHxnBpDxzT7adCMA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

[A, Snipped from a mail to the BlueZ ppl. B, CC:ed since the last post
 on USB was in the year 2000]

What the bluez developer gathered:
This looks really like an ohci_hcd problem with interrupt URBs.

Controllers and drivers:
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
ehci_hcd 0000:00:02.2: irq 193, pci mem f8814000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
ohci_hcd 0000:00:02.0: irq 177, pci mem f8816000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
ohci_hcd 0000:00:02.1: irq 185, pci mem f8818000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3

And the final error when inserting a USB BT dongle:
usb 1-3.4: new full speed USB device using address 12
ehci_hcd 0000:00:02.2: qh f7e54680 (#0) state 1
hci_usb_intr_rx_submit: hci0 intr rx submit failed urb f7b81274 err -28

from proc/interrupts:
177:          0   IO-APIC-level  ohci_hcd
185:          0   IO-APIC-level  ohci_hcd
193:      24812   IO-APIC-level  ehci_hcd

CC: Since i'm not subbed to either ml.

Some snipped parts from the original mail.
---
Since some kernel version i can't exactly remember which, i have been
unable to use usb, i have tested with with 2.6.8 -> 2.6.9-rc2-bk7 and i
also applied your patches for 2.6.8.

I have 2 usb dongles, one old that did work once, and one new that seems
to be working like the older but it doesn't work with linux.

Output from hciconfig:
hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0

Basically, it just stopped working and i dunno why, any clues? at all?

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-jTU8rHxnBpDxzT7adCMA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBUdUn7F3Euyc51N8RAlcOAJ9/l2aXznQJrCp54Y+zBO8KkfZdnQCdGKCc
AYS3GFgKT6Ith79UKKj4ONE=
=niE7
-----END PGP SIGNATURE-----

--=-jTU8rHxnBpDxzT7adCMA--

