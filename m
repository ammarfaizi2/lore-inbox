Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVKEPhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVKEPhx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 10:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbVKEPhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 10:37:52 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:57312 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932084AbVKEPhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 10:37:52 -0500
Message-ID: <436CD1BC.8020102@t-online.de>
Date: Sat, 05 Nov 2005 16:37:32 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.14, udev: unknown symbols for ehci_hcd
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC8C6C59F1543CF8D7386A367"
X-ID: Zq3MPqZ-wes-mh39BgA0Fmjb4P02rVUeFwnwYK51RP-3wivauh3M00
X-TOI-MSGID: 0c2f921e-b542-4bdf-99a8-9f2e752b26d3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC8C6C59F1543CF8D7386A367
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi folks,

I can't say since when this problem is in, but currently
I get error messages about unknown symbols at boot time
(after mounting the root disk, as it seems):

:
:
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
scsi1 : sata_sil
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
ReiserFS: sda1: found reiserfs format "3.6" with standard journal
ReiserFS: sda1: using ordered data mode
ReiserFS: sda1: journal params: device sda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda1: checking transaction log (sda1)
ReiserFS: sda1: Using r5 hash to sort names
NET: Registered protocol family 1
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ehci_hcd: Unknown symbol usb_hcd_pci_suspend
ehci_hcd: Unknown symbol usb_free_urb
ehci_hcd: Unknown symbol usb_hub_tt_clear_buffer
ehci_hcd: Unknown symbol usb_hcd_pci_probe
ehci_hcd: Unknown symbol usb_disabled
ehci_hcd: Unknown symbol usb_unlock_device
ehci_hcd: Unknown symbol usb_put_dev
ehci_hcd: Unknown symbol usb_get_dev
:

If I modprobe ehci_hcd later, then there is no error message.
It is loaded as expected.

uname -a:
Linux pluto 2.6.14 #1 PREEMPT Sat Nov 5 08:47:20 CET 2005 x86_64 GNU/Linux
udev is version 0.071-1.


???

Regards

Harri


--------------enigC8C6C59F1543CF8D7386A367
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDbNHCUTlbRTxpHjcRAvtqAJ4vmmJ49kVdNIKgRZwmkvy3vwnqNwCfX4Le
WBKAF8q6fJcEP6Ab8LxfFaU=
=mVeq
-----END PGP SIGNATURE-----

--------------enigC8C6C59F1543CF8D7386A367--
