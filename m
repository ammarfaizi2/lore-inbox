Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311288AbSCSOif>; Tue, 19 Mar 2002 09:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311289AbSCSOiQ>; Tue, 19 Mar 2002 09:38:16 -0500
Received: from [67.105.233.135] ([67.105.233.135]:6684 "EHLO
	EXCHANGE.themunicenter.com") by vger.kernel.org with ESMTP
	id <S311287AbSCSOh7>; Tue, 19 Mar 2002 09:37:59 -0500
Subject: [PATCH] Support for Belkin Wireless PCI Adapter (PLX PCI9502 Based)
	in Kernel >= 2.4.18
From: "Brendan W. McAdams" <b.mcadams@themunicenter.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-taaVdSylONtndatGyWqU"
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 19 Mar 2002 09:32:47 -0500
Message-Id: <1016548367.10236.25.camel@mycroft.themunicenter.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-taaVdSylONtndatGyWqU
Content-Type: multipart/mixed; boundary="=-c7Bm9YdPB9C1SC3t2eCq"


--=-c7Bm9YdPB9C1SC3t2eCq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

[I apologize if this sent twice, my kernel list subscription was inactive w=
hen i sent
initially so I'm not sure it was sent properly]
I'm not sure who the current "keeper of the flame" is on drivers/net/wirele=
ss/
orinoco_plx.c so I'm submitting this patch to any conceivably appropriate
places.

This patch adds support to the Linux kernel (tested on 2.4.18, 2.4.19-pre3 =
and
2.4.19-pre3-ac1) for the Belkin F5D6000 "Wireless Desktop PCI Network Adapt=
er".
This is a PLX PCI9502 based PCMCIA adapter that allows 802.11b wireless net=
work
cards (mainly Prism2 based, like the Belkin F5D6020) to work on desktop box=
en.

This patch would be a great addition to the appropriate packages, including=
 the
Linux kernel as Belkins components tend to be low cost and high quality, as
well as widely available.

The patch contents are basically an addition to orinoco_plx.c so that it
recognizes the IO Addresses of the Belkin F5D6000 and configures it
appropriately.  It is a small patch but it does the trick; I have tested it
extensively on my Linux box in both Managed and Ad-Hoc modes with a Belkin
F5D6020 card.

It has been applied and tested (as aformentioned) against 2.4.18, 2.4.19-pr=
e3
and 2.4.19-pre3-ac1.

I am posting a page at http://www.jacked-in.org/linux/belkin_wireless.php w=
ith
more details on this patch and using Belkin's Wireless components with Linu=
x
for those interested.

Patch follows inline & attached:

--- linux/drivers/net/wireless/orinoco_plx.c	Mon Feb 25 14:38:03 2002
+++ linux.bmcadams-patched/drivers/net/wireless/orinoco_plx.c	Mon Mar 18 10=
:42:
48 2002
@@ -385,6 +385,10 @@
 	{0x16ab, 0x1101, PCI_ANY_ID, PCI_ANY_ID,},	/* Reported working, but unkno=
wn
*/
 	{0x16ab, 0x1102, PCI_ANY_ID, PCI_ANY_ID,},	/* Linksys WDT11 */
 	{0x16ec, 0x3685, PCI_ANY_ID, PCI_ANY_ID,},	/* USR 2415 */
+	{0xec80, 0xec00, PCI_ANY_ID, PCI_ANY_ID,}, 	/* Belkin F5D6000
+							   Tested & Working with
+							   Belkin's F5D6020 Prism2 based PCMCIA NIC
+							   - Brendan W. McAdams <rit@jacked-in.org> */
 	{0,},
 };

-----
Brendan W. McAdams
rit@jacked-in.org

"I cannot make my days longer, so I strive to make them better."
- Henry David Thoreau

--=-c7Bm9YdPB9C1SC3t2eCq
Content-Disposition: attachment; filename=orinoco_plx-belkin-bmcadams.patch
Content-Type: text/plain; name=orinoco_plx-belkin-bmcadams.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- linux/drivers/net/wireless/orinoco_plx.c	Mon Feb 25 14:38:03 2002
+++ linux.bmcadams-patched/drivers/net/wireless/orinoco_plx.c	Mon Mar 18 10=
:42:48 2002
@@ -385,6 +385,10 @@
 	{0x16ab, 0x1101, PCI_ANY_ID, PCI_ANY_ID,},	/* Reported working, but unkno=
wn */
 	{0x16ab, 0x1102, PCI_ANY_ID, PCI_ANY_ID,},	/* Linksys WDT11 */
 	{0x16ec, 0x3685, PCI_ANY_ID, PCI_ANY_ID,},	/* USR 2415 */
+	{0xec80, 0xec00, PCI_ANY_ID, PCI_ANY_ID,}, 	/* Belkin F5D6000
+							   Tested & Working with
+							   Belkin's F5D6020 Prism2 based PCMCIA NIC=20
+							   - Brendan W. McAdams <rit@jacked-in.org> */
 	{0,},
 };
=20

--=-c7Bm9YdPB9C1SC3t2eCq--

--=-taaVdSylONtndatGyWqU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8l0wP0YD3roIwZxARAlFcAKDFBCiyLntfGoLo74bvQllP0bhB9ACglH5S
UfEv/oU3MH6zg7ifxijtGNU=
=JvIE
-----END PGP SIGNATURE-----

--=-taaVdSylONtndatGyWqU--
