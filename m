Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbUAOS4b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 13:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbUAOS4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 13:56:31 -0500
Received: from absinthe.ifi.unizh.ch ([130.60.75.58]:61077 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP id S261506AbUAOS41
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 13:56:27 -0500
Date: Thu, 15 Jan 2004 19:56:26 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] additional HID_QUIRKS
Message-ID: <20040115185626.GA1352@piper.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.1-diamond i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I don't know about the procedure, but could you please add the
attached patch to the 2.6 (and possibly to the 2.4) tree? It
defines a set of HID_QUIRKS to blacklist a number of devices from
hiddev.

If this is not the right way, then please advise me!

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
"those who are faithful know only the trivial side of love:
 it is the faithless who know love's tragedies."
                                                        -- oscar wilde

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="hid-ignore.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.1/drivers/usb/input/hid-core.c.orig	2004-01-15 19:44:00.00000=
0000 +0100
+++ linux-2.6.1/drivers/usb/input/hid-core.c	2004-01-15 19:52:23.000000000 =
+0100
@@ -1357,6 +1357,22 @@
 #define USB_VENDOR_ID_BERKSHIRE		0x0c98
 #define USB_DEVICE_ID_BERKSHIRE_PCWD	0x1140
=20
+#define USB_VENDOR_ID_PHIDGETS		0x06c2
+#define USB_DEVICE_ID_PHIDGETS_RFID	0x0030
+#define USB_DEVICE_ID_PHIDGETS_4SERVO	0x0038
+#define USB_DEVICE_ID_PHIDGETS_1SERVO	0x0039
+#define USB_DEVICE_ID_PHIDGETS_8SERVO	0x003b
+#define USB_DEVICE_ID_PHIDGETS_IFACE884	0x0040
+#define USB_DEVICE_ID_PHIDGETS_IFACE088	0x0041
+#define USB_DEVICE_ID_PHIDGETS_IFACE_32_32_0	0x0042
+#define USB_DEVICE_ID_PHIDGETS_IFACE_0_256_0	0x0043
+#define USB_DEVICE_ID_PHIDGETS_RECEIVER	0x0048
+#define USB_DEVICE_ID_PHIDGETS_LED	0x0049
+#define USB_DEVICE_ID_PHIDGETS_ENCODER	0x004b
+#define USB_DEVICE_ID_PHIDGETS_POWER	0x004e
+#define USB_DEVICE_ID_PHIDGETS_TEXTLCD	0x0050
+#define USB_DEVICE_ID_PHIDGETS_GRAPHLCD	0x0058
+
 struct hid_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -1407,6 +1423,20 @@
 	{ USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5, HI=
D_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU, HID_QUIRK_2WHEEL_MO=
USE_HACK },
 	{ USB_VENDOR_ID_BERKSHIRE, USB_DEVICE_ID_BERKSHIRE_PCWD, HID_QUIRK_IGNORE=
 },
+	{ USB_VENDOR_ID_PHIDGETS, USB_DEVICE_ID_PHIDGETS_RFID, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_PHIDGETS, USB_DEVICE_ID_PHIDGETS_4SERVO, HID_QUIRK_IGNORE=
 },
+	{ USB_VENDOR_ID_PHIDGETS, USB_DEVICE_ID_PHIDGETS_1SERVO, HID_QUIRK_IGNORE=
 },
+	{ USB_VENDOR_ID_PHIDGETS, USB_DEVICE_ID_PHIDGETS_8SERVO, HID_QUIRK_IGNORE=
 },
+	{ USB_VENDOR_ID_PHIDGETS, USB_DEVICE_ID_PHIDGETS_IFACE884, HID_QUIRK_IGNO=
RE },
+	{ USB_VENDOR_ID_PHIDGETS, USB_DEVICE_ID_PHIDGETS_IFACE088, HID_QUIRK_IGNO=
RE },
+	{ USB_VENDOR_ID_PHIDGETS, USB_DEVICE_ID_PHIDGETS_IFACE_32_32_0, HID_QUIRK=
_IGNORE },
+	{ USB_VENDOR_ID_PHIDGETS, USB_DEVICE_ID_PHIDGETS_IFACE_0_256_0, HID_QUIRK=
_IGNORE },
+	{ USB_VENDOR_ID_PHIDGETS, USB_DEVICE_ID_PHIDGETS_RECEIVER, HID_QUIRK_IGNO=
RE },
+	{ USB_VENDOR_ID_PHIDGETS, USB_DEVICE_ID_PHIDGETS_LED, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_PHIDGETS, USB_DEVICE_ID_PHIDGETS_ENCODER, HID_QUIRK_IGNOR=
E },
+	{ USB_VENDOR_ID_PHIDGETS, USB_DEVICE_ID_PHIDGETS_POWER, HID_QUIRK_IGNORE =
},
+	{ USB_VENDOR_ID_PHIDGETS, USB_DEVICE_ID_PHIDGETS_TEXTLCD, HID_QUIRK_IGNOR=
E },
+	{ USB_VENDOR_ID_PHIDGETS, USB_DEVICE_ID_PHIDGETS_GRAPHLCD, HID_QUIRK_IGNO=
RE },
 	{ 0, 0 }
 };
=20

--UlVJffcvxoiEqYs2--

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFABuJaIgvIgzMMSnURAtbxAKDnMx/NTeec+s/O8cORcmqEaYSRzgCgxm2c
V/2OQ247MHZVVK6lUCK3jKw=
=zWtr
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
