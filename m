Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTGARV2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 13:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbTGARV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 13:21:28 -0400
Received: from [213.33.94.61] ([213.33.94.61]:6929 "EHLO
	gatekeeper.corp.liscon.com") by vger.kernel.org with ESMTP
	id S262955AbTGARVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 13:21:24 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C33FF7.33E46016"
Subject: 
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Date: Tue, 1 Jul 2003 19:35:45 +0200
Message-ID: <7B11213736BD5447864FEE894DB7CAD9016390@catilina.corp.liscon.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Index: AcM/95cB080bSZ4mSlG/oZw2CtGifQ==
From: "Gerhard Schaden" <ges@liscon.com>
To: <ges@liscon.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C33FF7.33E46016
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,=20

I've the following Setup


PC1
Linux PC kernel 2.4.21,
PCI Network card with realtek 8029=20


PC2
Windows 2k ( Terminal Server )
PCI Network card with realtek 8029=20
PCI Network card with realtek 8139

PC3
Windows 2k Terminal Server
PCI Network card with realtek 8139




Scenario 1:

PC1 and PC2 are connected via BNC and i use rdesktop to connect to the
terminal server, no problem
--------                              --------
| PC 1 |                              | PC 2 |
|------|                              |------|  =20
    |-------------BNC--------------------|



Scenario 2:

PC2 gets a second Ethernet card rtl8139, routing is activated=20
PC3 is connected to PC2 via 100BaseT

--------                              --------
| PC 1 |                              | PC 2 |-----100BaseT
|------|                              |------|        |
    |-------------BNC--------------------|            |
                                                      |
                                                  --------
                                                  | PC 3 |
                                                  |------|  =20

i connect to PC3 with rdesktop no problem



Scenario 3:

The BNC Network gets a 3Com 8 Port Hub with one BNC


--------                              --------
| PC 1 |                              | PC 2 |
|------|                              |------|
    |-------------BNC-----|--------------|   =20
                          |
                        -----                  --------     =20
                        |HUB| -----10BaseT-----| PC 3 |
                        -----                  |------|


PC1 connects to PC3 with rdesktop with collision rate around 30% with
network utilization 30KB/s (70pkts/s)

But if

PC2 connects to PC3 with mstsc I get the same network utilization but NO
collision=20


It looks like, that the Linux Networking stack is faster but produces
more collisions, I've looked at the throughput with iptraf and it was
perfect, even if i added more PCs making some traffic with tcpspray.=20
The problem is that customers don't accept the high collision rate.

I tried to change nearly all components:

Different Motherboards, different NICs (3Com), different HUB, different
Kernel (2.4.18, 2.2.20, 2.2.12), different cables :), different
T-Connectors, different Resistors

Tuning the software:
Limiting incoming traffic with iptables, limiting incoming traffic with
ingress scheduling,=20



Any Ideas ?


-GES




----------------------------------------------------------------
LISCON GmbH                               http://www.liscon.com/
Gerhard Schaden                           ges@liscon.com
Leitung Forschung u. Entwicklung
=20
Europastrasse 8                           Tel: +43 4242 214855
A-9500 Villach                            Fax: +43 4242 214855 99
AUSTRIA / EUROPE                          Mobil: +43 664 2333323
                           =20





------_=_NextPart_001_01C33FF7.33E46016
Content-Type: text/x-vcard;
	name="Gerhard Schaden (E-Mail).vcf"
Content-Transfer-Encoding: base64
Content-Description: Gerhard Schaden (E-Mail).vcf
Content-Disposition: attachment;
	filename="Gerhard Schaden (E-Mail).vcf"

QkVHSU46VkNBUkQNClZFUlNJT046Mi4xDQpOOlNjaGFkZW47R2VyaGFyZA0KRk46R2VyaGFyZCBT
Y2hhZGVuIChFLU1haWwpDQpPUkc6TGlzY29uIEdtYkgNClRJVExFOkNoaWVmIFImRA0KVEVMO1dP
Uks7Vk9JQ0U6KzQzIDQyNDIgMjE0ODU1IA0KVEVMO0NFTEw7Vk9JQ0U6KzQzIDY2NCAyMzMzMzIz
DQpURUw7V09SSztGQVg6KzQzIDQyNDIgMjE0ODU1IDk5DQpBRFI7V09SSzo7O0V1cm9wYXN0cmFz
c2UgODtWaWxsYWNoOzs5NTAwO0F1c3RyaWENCkxBQkVMO1dPUks7RU5DT0RJTkc9UVVPVEVELVBS
SU5UQUJMRTpFdXJvcGFzdHJhc3NlIDg9MEQ9MEFWaWxsYWNoIDk1MDA9MEQ9MEFBdXN0cmlhDQpF
TUFJTDtQUkVGO0lOVEVSTkVUOmdlc0BsaXNjb24uY29tDQpSRVY6MjAwMjA4MDdUMTA0NzQ5Wg0K
RU5EOlZDQVJEDQo=

------_=_NextPart_001_01C33FF7.33E46016--
