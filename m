Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936860AbWLDNuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936860AbWLDNuL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 08:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936863AbWLDNuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 08:50:10 -0500
Received: from hqemgate01.nvidia.com ([216.228.112.170]:54282 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S936861AbWLDNuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 08:50:08 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C717AA.FA6AECBD"
Subject: RE: [PATCH 1/2] sata_nv & ahci: Move some IDs from sata_nv.c to ahci.c
Date: Mon, 4 Dec 2006 21:49:11 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B07FC61A9@hkemmail01.nvidia.com>
In-Reply-To: <456EB5A8.2060107@pobox.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/2] sata_nv & ahci: Move some IDs from sata_nv.c to ahci.c
Thread-Index: AccUbEZrL9Q9cOY6Stay2kn8fypMmADPk7YQ
From: "Peer Chen" <pchen@nvidia.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 04 Dec 2006 13:49:16.0622 (UTC) FILETIME=[FD60FEE0:01C717AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C717AA.FA6AECBD
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Resend the patch.
The content of memory map io of BAR5 have been change from MCP65 then sat=
a_nv can't work fine on the platform based on MCP65 and MCP67,so move the=
ir IDs from sata_nv.c to ahci.c.
Please check attachment for new patch,thanks.

Signed-off-by: Peer Chen <pchen@nvidia.com>


-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com]=20
Sent: Thursday, November 30, 2006 6:43 PM
To: Peer Chen
Cc: linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org; Andrew Morto=
n
Subject: Re: [PATCH 1/2] sata_nv & ahci: Move some IDs from sata_nv.c to =
ahci.c

Peer Chen wrote:
> Move the device IDs of MCP65/MCP67 from sata_nv.c to ahci.c.
> The patch will be applied to kernel 2.6.19.
> Please check attachment for the patch.
>=20
> Signed-off-by: Peer Chen <pchen@nvidia.com>

Please update as follows:

1) Provide a detailed explanation as to /why/ this is needed.  I certainl=
y encourage use of ahci over legacy mode, but the patch description tells=
=20us nothing.

2) Combine the two patches into one.  Think of a patch as an atomic opera=
tion.  If you apply your patches as submitted, then a 'git bisect'=20
may reach a state where the PCI IDs exist in _neither_ sata_nv or ahci.=20
=20 Any time you /move/ code or data, it should be in the same patch.

3) Your patches are completely unreviewable in a standard Internet mailer=
, because they were sent with your email base64-encoded.  For many mailer=
s, base64 encoding means the patch is not shown nor able to be commented =
upon.  Indeed, some mailers make it difficult to response -at
all- to data contained in a MIME attachment.

The change itself seems OK, once suitable justification is provided.

=09Jeff



-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------

------_=_NextPart_001_01C717AA.FA6AECBD
Content-Type: application/octet-stream;
	name="patch.sata_nv-ahci"
Content-Transfer-Encoding: base64
Content-Description: patch.sata_nv-ahci
Content-Disposition: attachment;
	filename="patch.sata_nv-ahci"

ZGlmZiAtdXByTiAtWCBsaW51eC0yLjYuMTktdmFuaWxsYS9Eb2N1bWVudGF0aW9uL2RvbnRkaWZm
IGxpbnV4LTIuNi4xOS12YW5pbGxhL2RyaXZlcnMvYXRhL2FoY2kuYyBsaW51eC0yLjYuMTkvZHJp
dmVycy9hdGEvYWhjaS5jCi0tLSBsaW51eC0yLjYuMTktdmFuaWxsYS9kcml2ZXJzL2F0YS9haGNp
LmMJMjAwNi0xMS0zMCAwNTo1NzozNy4wMDAwMDAwMDAgKzA4MDAKKysrIGxpbnV4LTIuNi4xOS9k
cml2ZXJzL2F0YS9haGNpLmMJMjAwNi0xMi0wNCAxNzozNDoyNi4wMDAwMDAwMDAgKzA4MDAKQEAg
LTM0NSw2ICszNDUsMTQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIGFoY2lf
cAogCXsgUENJX1ZERVZJQ0UoTlZJRElBLCAweDA0NGQpLCBib2FyZF9haGNpIH0sCQkvKiBNQ1A2
NSAqLwogCXsgUENJX1ZERVZJQ0UoTlZJRElBLCAweDA0NGUpLCBib2FyZF9haGNpIH0sCQkvKiBN
Q1A2NSAqLwogCXsgUENJX1ZERVZJQ0UoTlZJRElBLCAweDA0NGYpLCBib2FyZF9haGNpIH0sCQkv
KiBNQ1A2NSAqLworCXsgUENJX1ZERVZJQ0UoTlZJRElBLCAweDA0NWMpLCBib2FyZF9haGNpIH0s
CQkvKiBNQ1A2NSAqLworCXsgUENJX1ZERVZJQ0UoTlZJRElBLCAweDA0NWQpLCBib2FyZF9haGNp
IH0sCQkvKiBNQ1A2NSAqLworCXsgUENJX1ZERVZJQ0UoTlZJRElBLCAweDA0NWUpLCBib2FyZF9h
aGNpIH0sCQkvKiBNQ1A2NSAqLworCXsgUENJX1ZERVZJQ0UoTlZJRElBLCAweDA0NWYpLCBib2Fy
ZF9haGNpIH0sCQkvKiBNQ1A2NSAqLworCXsgUENJX1ZERVZJQ0UoTlZJRElBLCAweDA1NTApLCBi
b2FyZF9haGNpIH0sCQkvKiBNQ1A2NyAqLworCXsgUENJX1ZERVZJQ0UoTlZJRElBLCAweDA1NTEp
LCBib2FyZF9haGNpIH0sCQkvKiBNQ1A2NyAqLworCXsgUENJX1ZERVZJQ0UoTlZJRElBLCAweDA1
NTIpLCBib2FyZF9haGNpIH0sCQkvKiBNQ1A2NyAqLworCXsgUENJX1ZERVZJQ0UoTlZJRElBLCAw
eDA1NTMpLCBib2FyZF9haGNpIH0sCQkvKiBNQ1A2NyAqLwogCXsgUENJX1ZERVZJQ0UoTlZJRElB
LCAweDA1NTQpLCBib2FyZF9haGNpIH0sCQkvKiBNQ1A2NyAqLwogCXsgUENJX1ZERVZJQ0UoTlZJ
RElBLCAweDA1NTUpLCBib2FyZF9haGNpIH0sCQkvKiBNQ1A2NyAqLwogCXsgUENJX1ZERVZJQ0Uo
TlZJRElBLCAweDA1NTYpLCBib2FyZF9haGNpIH0sCQkvKiBNQ1A2NyAqLwpkaWZmIC11cHJOIC1Y
IGxpbnV4LTIuNi4xOS12YW5pbGxhL0RvY3VtZW50YXRpb24vZG9udGRpZmYgbGludXgtMi42LjE5
LXZhbmlsbGEvZHJpdmVycy9hdGEvc2F0YV9udi5jIGxpbnV4LTIuNi4xOS9kcml2ZXJzL2F0YS9z
YXRhX252LmMKLS0tIGxpbnV4LTIuNi4xOS12YW5pbGxhL2RyaXZlcnMvYXRhL3NhdGFfbnYuYwky
MDA2LTExLTMwIDA1OjU3OjM3LjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjE5L2RyaXZl
cnMvYXRhL3NhdGFfbnYuYwkyMDA2LTEyLTA0IDE3OjM0OjMyLjAwMDAwMDAwMCArMDgwMApAQCAt
MTE3LDE0ICsxMTcsNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgbnZfcGNp
CiAJeyBQQ0lfVkRFVklDRShOVklESUEsIFBDSV9ERVZJQ0VfSURfTlZJRElBX05GT1JDRV9NQ1A2
MV9TQVRBKSwgR0VORVJJQyB9LAogCXsgUENJX1ZERVZJQ0UoTlZJRElBLCBQQ0lfREVWSUNFX0lE
X05WSURJQV9ORk9SQ0VfTUNQNjFfU0FUQTIpLCBHRU5FUklDIH0sCiAJeyBQQ0lfVkRFVklDRShO
VklESUEsIFBDSV9ERVZJQ0VfSURfTlZJRElBX05GT1JDRV9NQ1A2MV9TQVRBMyksIEdFTkVSSUMg
fSwKLQl7IFBDSV9WREVWSUNFKE5WSURJQSwgMHgwNDVjKSwgR0VORVJJQyB9LCAvKiBNQ1A2NSAq
LwotCXsgUENJX1ZERVZJQ0UoTlZJRElBLCAweDA0NWQpLCBHRU5FUklDIH0sIC8qIE1DUDY1ICov
Ci0JeyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDQ1ZSksIEdFTkVSSUMgfSwgLyogTUNQNjUgKi8K
LQl7IFBDSV9WREVWSUNFKE5WSURJQSwgMHgwNDVmKSwgR0VORVJJQyB9LCAvKiBNQ1A2NSAqLwot
CXsgUENJX1ZERVZJQ0UoTlZJRElBLCAweDA1NTApLCBHRU5FUklDIH0sIC8qIE1DUDY3ICovCi0J
eyBQQ0lfVkRFVklDRShOVklESUEsIDB4MDU1MSksIEdFTkVSSUMgfSwgLyogTUNQNjcgKi8KLQl7
IFBDSV9WREVWSUNFKE5WSURJQSwgMHgwNTUyKSwgR0VORVJJQyB9LCAvKiBNQ1A2NyAqLwotCXsg
UENJX1ZERVZJQ0UoTlZJRElBLCAweDA1NTMpLCBHRU5FUklDIH0sIC8qIE1DUDY3ICovCiAJeyBQ
Q0lfVkVORE9SX0lEX05WSURJQSwgUENJX0FOWV9JRCwKIAkJUENJX0FOWV9JRCwgUENJX0FOWV9J
RCwKIAkJUENJX0NMQVNTX1NUT1JBR0VfSURFPDw4LCAweGZmZmYwMCwgR0VORVJJQyB9LAo=

------_=_NextPart_001_01C717AA.FA6AECBD--
