Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262774AbVDHJbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbVDHJbS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 05:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbVDHJbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 05:31:00 -0400
Received: from mail14.messagelabs.com ([212.125.75.19]:39027 "HELO
	mail14.messagelabs.com") by vger.kernel.org with SMTP
	id S262774AbVDHJaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 05:30:20 -0400
X-VirusChecked: Checked
X-Env-Sender: chris.elston@radstone.co.uk
X-Msg-Ref: server-11.tower-14.messagelabs.com!1112952613!46351182!1
X-StarScan-Version: 5.4.11; banners=radstone.co.uk,-,-
X-Originating-IP: [193.130.116.242]
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C53C1D.BB9C9000"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: [PATCH 2.6.12-rc2 1/2] ppc32: fix for misreported SDRAM size on Radstone PPC7D platform
Date: Fri, 8 Apr 2005 10:31:24 +0100
Message-ID: <F38DEABE0E171746B133C1ABBD142D9703691AF1@radmail.Radstone.Local>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.12-rc2 1/2] ppc32: fix for misreported SDRAM size on Radstone PPC7D platform
Thread-Index: AcU8HbvsQvcKLyUnQ+mo72UvbEpQ2Q==
From: "Chris Elston" <chris.elston@radstone.co.uk>
To: <akpm@osdl.org>
Cc: <linuxppc-embedded@ozlabs.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C53C1D.BB9C9000
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This=20patch=20fixes=20the=20SDRAM=20output=20from=20/proc/cpuinfo.
The=20previous=20code=20assumed=20that=20there=20was=20only=20one=20bank
of=20SDRAM,=20and=20that=20the=20size=20in=20the=20memory=20configuration
register=20was=20the=20total=20size.

Signed-off-by:=20Chris=20Elston=20<chris.elston@radstone.co.uk>

________________________________________________________________________
This=20e-mail=20has=20been=20scanned=20for=20all=20viruses=20by=20Star.=20=
The
service=20is=20powered=20by=20MessageLabs.=20For=20more=20information=20on=
=20a=20proactive
anti-virus=20service=20working=20around=20the=20clock,=20around=20the=20gl=
obe,=20visit:
http://www.star.net.uk
________________________________________________________________________
------_=_NextPart_001_01C53C1D.BB9C9000
Content-Type: application/octet-stream;
	name="ppc7d_sdram_size.patch"
Content-Transfer-Encoding: base64
Content-Description: ppc7d_sdram_size.patch
Content-Disposition: attachment;
	filename="ppc7d_sdram_size.patch"

LS0tIGxpbnV4LTIuNi4xMi1yYzIvYXJjaC9wcGMvcGxhdGZvcm1zL3JhZHN0b25lX3BwYzdkLmMJ
MjAwNS0wNC0wNyAxMjozMTo0My4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTIuNi4xMi1yYzIt
Y2RlL2FyY2gvcHBjL3BsYXRmb3Jtcy9yYWRzdG9uZV9wcGM3ZC5jCTIwMDUtMDQtMDcgMTI6Mjg6
NTEuMDAwMDAwMDAwICswMTAwCkBAIC0yNTMsNiArMjU5LDggQEAKIAl1OCB2YWwxLCB2YWwyOwog
CXN0YXRpYyBpbnQgZmxhc2hfc2l6ZXNbNF0gPSB7IDY0LCAzMiwgMCwgMTYgfTsKIAlzdGF0aWMg
aW50IGZsYXNoX2JhbmtzWzRdID0geyA0LCAzLCAyLCAxIH07CisJc3RhdGljIGludCBzZHJhbV9i
YW5rX3NpemVzWzRdID0geyAxMjgsIDI1NiwgNTEyLCAxIH07CisJaW50IHNkcmFtX251bV9iYW5r
cyA9IDI7CiAJc3RhdGljIGNoYXIgKnBjaV9tb2Rlc1tdID0geyAiUENJMzMiLCAiUENJNjYiLAog
CQkiVW5rbm93biIsICJVbmtub3duIiwKIAkJIlBDSVgzMyIsICJQQ0lYNjYiLApAQCAtMjc5LDEz
ICsyODcsMTcgQEAKIAkJICAgKHZhbDEgPT0gUFBDN0RfQ1BMRF9NQl9UWVBFX1BMTF8xMDApID8g
MTAwIDoKIAkJICAgKHZhbDEgPT0gUFBDN0RfQ1BMRF9NQl9UWVBFX1BMTF82NCkgPyA2NCA6IDAp
OwogCisJdmFsID0gaW5iKFBQQzdEX0NQTERfTUVNX0NPTkZJRyk7CisJaWYgKHZhbCAmIFBQQzdE
X0NQTERfU0RSQU1fQkFOS19OVU1fTUFTSykgc2RyYW1fbnVtX2JhbmtzLS07CisKIAl2YWwgPSBp
bmIoUFBDN0RfQ1BMRF9NRU1fQ09ORklHX0VYVEVORCk7Ci0JdmFsMSA9IHZhbCAmIFBQQzdEX0NQ
TERfU0RSQU1fQkFOS19TSVpFX01BU0s7Ci0Jc2VxX3ByaW50ZihtLCAiU0RSQU1cdFx0OiAlZCVj
IiwKLQkJICAgKHZhbDEgPT0gUFBDN0RfQ1BMRF9TRFJBTV9CQU5LX1NJWkVfMTI4TSkgPyAxMjgg
OgotCQkgICAodmFsMSA9PSBQUEM3RF9DUExEX1NEUkFNX0JBTktfU0laRV8yNTZNKSA/IDI1NiA6
Ci0JCSAgICh2YWwxID09IFBQQzdEX0NQTERfU0RSQU1fQkFOS19TSVpFXzUxMk0pID8gNTEyIDog
MSwKLQkJICAgKHZhbDEgPT0gUFBDN0RfQ1BMRF9TRFJBTV9CQU5LX1NJWkVfMUcpID8gJ0cnIDog
J00nKTsKKwl2YWwxID0gKHZhbCAmIFBQQzdEX0NQTERfU0RSQU1fQkFOS19TSVpFX01BU0spID4+
IDY7CisJc2VxX3ByaW50ZihtLCAiU0RSQU1cdFx0OiAlZCBiYW5rcyBvZiAlZCVjLCB0b3RhbCAl
ZCVjIiwKKwkJICAgc2RyYW1fbnVtX2JhbmtzLAorCQkgICBzZHJhbV9iYW5rX3NpemVzW3ZhbDFd
LAorCQkgICAoc2RyYW1fYmFua19zaXplc1t2YWwxXSA8IDEyOCkgPyAnRycgOiAnTScsCisJCSAg
IHNkcmFtX251bV9iYW5rcyAqIHNkcmFtX2Jhbmtfc2l6ZXNbdmFsMV0sCisJCSAgIChzZHJhbV9i
YW5rX3NpemVzW3ZhbDFdIDwgMTI4KSA/ICdHJyA6ICdNJyk7CiAJaWYgKHZhbDIgJiBQUEM3RF9D
UExEX01CX1RZUEVfRUNDX0ZJVFRFRF9NQVNLKSB7CiAJCXNlcV9wcmludGYobSwgIiBbRUNDICVz
YWJsZWRdIiwKIAkJCSAgICh2YWwyICYgUFBDN0RfQ1BMRF9NQl9UWVBFX0VDQ19FTkFCTEVfTUFT
SykgPyAiZW4iIDoKLS0tIGxpbnV4LTIuNi4xMi1yYzIvYXJjaC9wcGMvcGxhdGZvcm1zL3JhZHN0
b25lX3BwYzdkLmgJMjAwNS0wNC0wNyAxMjozMTo0My4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4
LTIuNi4xMi1yYzItY2RlL2FyY2gvcHBjL3BsYXRmb3Jtcy9yYWRzdG9uZV9wcGM3ZC5oCTIwMDUt
MDQtMDcgMTI6Mjg6NTEuMDAwMDAwMDAwICswMTAwCkBAIC0yNDAsNiArMjQwLDcgQEAKICNkZWZp
bmUgUFBDN0RfQ1BMRF9GTEFTSF9DTlRMCQkJMHgwODZFCiAKIC8qIE1FTU9SWV9DT05GSUdfRVhU
RU5EICovCisjZGVmaW5lIFBQQzdEX0NQTERfU0RSQU1fQkFOS19OVU1fTUFTSwkJMHgwMgogI2Rl
ZmluZSBQUEM3RF9DUExEX1NEUkFNX0JBTktfU0laRV9NQVNLCQkweGMwCiAjZGVmaW5lIFBQQzdE
X0NQTERfU0RSQU1fQkFOS19TSVpFXzEyOE0JCTAKICNkZWZpbmUgUFBDN0RfQ1BMRF9TRFJBTV9C
QU5LX1NJWkVfMjU2TQkJMHg0MAo=

------_=_NextPart_001_01C53C1D.BB9C9000--
