Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbVKEBiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbVKEBiK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 20:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbVKEBiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 20:38:09 -0500
Received: from rtlab.med.cornell.edu ([140.251.128.175]:33408 "EHLO
	openlab.rtlab.org") by vger.kernel.org with ESMTP id S1751436AbVKEBiI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 20:38:08 -0500
Date: Fri, 4 Nov 2005 20:38:04 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: calin@rtlab.med.cornell.edu
To: ajoshi@shell.unixbox.com, akpm@osdl.org, adaplas@pol.net,
       linux-kernel@vger.kernel.org
Cc: linux-nvidia@lists.surfsouth.com, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] nvidiafb: Geforce 7800 series support added 
Message-ID: <Pine.LNX.4.64.0511042031470.9781@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-74666112-942060465-1130260123=:15060"
Content-ID: <Pine.LNX.4.64.0511042031471.9781@rtlab.med.cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---74666112-942060465-1130260123=:15060
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.64.0511042031472.9781@rtlab.med.cornell.edu>


Hi, this patch replaces a patch I prevously submitted.  The previous patch 
was named:

  nvidiafb-geforce-7800-gtx-support-added.patch

Which was added to the -mm tree on Oct. 25.

Can you replace the above mentioned patch with this one, since it is more 
updated?

This patch replaces the above patch, and is simply a better version of 
that patch with more support for more cards.

Altogether this is an almost trivial patch that simply adds support for 
the Nvidia Geforce 7800 series of cards to the nvidiafb framebuffer 
driver.  All this patch does is add the PCI device id for the 7800, 7800 
GTX, 7800 GO, and 7800 GTX GO cards to the module device table for the 
nvidiafb.ko driver, so that nvidiafb.ko will actually work on these cards.

I also added the relevant PCI device ids to linux/pci_ids.h (I hope noone 
minds).

I tested it on my 7800 GTX here and it works like a charm.  I now can get 
framebuffer support on this card!  Woo hoo!!  Nothing like 200x75 text mode to 
make your eyes BLEED. ;)

This patch is against 2.6.14-rc5.  It should apply against most 2.6 kernels 
though -- not sure which kernel is the standard one to submit patches against.

Should I submit this patch for 2.4 kernel?  I don't even know if that one has 
nvidiafb since I don't run 2.4 much these days..

Thanks!

-Calin
---74666112-942060465-1130260123=:15060
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=nvidiafb_7800_series.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0511042034350.9781@rtlab.med.cornell.edu>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=nvidiafb_7800_series.patch

ZGlmZiAtdXJOIGxpbnV4LTIuNi4xNC1yYzUvZHJpdmVycy92aWRlby9udmlk
aWEvbnZpZGlhLmMgbGludXgtMi42LjE0LXJjNS5uZXcvZHJpdmVycy92aWRl
by9udmlkaWEvbnZpZGlhLmMNCi0tLSBsaW51eC0yLjYuMTQtcmM1L2RyaXZl
cnMvdmlkZW8vbnZpZGlhL252aWRpYS5jCTIwMDUtMTAtMjAgMDI6MjM6MDUu
MDAwMDAwMDAwIC0wNDAwDQorKysgbGludXgtMi42LjE0LXJjNS5uZXcvZHJp
dmVycy92aWRlby9udmlkaWEvbnZpZGlhLmMJMjAwNS0xMC0yNSAxMjozNDow
Ny4wMDAwMDAwMDAgLTA0MDANCkBAIC0zODQsNiArMzg0LDE0IEBADQogCSBQ
Q0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCAwfSwNCiAJe1BDSV9WRU5E
T1JfSURfTlZJRElBLCBQQ0lfREVWSUNFX0lEX05WSURJQV9HRUZPUkNFXzY4
MDBCX0dULA0KIAkgUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgMCwgMCwgMH0s
DQorCXtQQ0lfVkVORE9SX0lEX05WSURJQSwgUENJX0RFVklDRV9JRF9OVklE
SUFfR0VGT1JDRV83ODAwX0dULA0KKwkgUENJX0FOWV9JRCwgUENJX0FOWV9J
RCwgMCwgMCwgMH0sDQorCXtQQ0lfVkVORE9SX0lEX05WSURJQSwgUENJX0RF
VklDRV9JRF9OVklESUFfR0VGT1JDRV83ODAwX0dUWCwNCisJIFBDSV9BTllf
SUQsIFBDSV9BTllfSUQsIDAsIDAsIDB9LA0KKwl7UENJX1ZFTkRPUl9JRF9O
VklESUEsIFBDSV9ERVZJQ0VfSURfTlZJRElBX0dFRk9SQ0VfR09fNzgwMCwN
CisJIFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsIDB9LA0KKwl7UENJ
X1ZFTkRPUl9JRF9OVklESUEsIFBDSV9ERVZJQ0VfSURfTlZJRElBX0dFRk9S
Q0VfR09fNzgwMF9HVFgsDQorCSBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAw
LCAwLCAwfSwNCiAJe1BDSV9WRU5ET1JfSURfTlZJRElBLCAweDAyMWQsDQog
CSBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCAwfSwNCiAJe1BDSV9W
RU5ET1JfSURfTlZJRElBLCAweDAyMWUsDQpkaWZmIC11ck4gbGludXgtMi42
LjE0LXJjNS9pbmNsdWRlL2xpbnV4L3BjaV9pZHMuaCBsaW51eC0yLjYuMTQt
cmM1Lm5ldy9pbmNsdWRlL2xpbnV4L3BjaV9pZHMuaA0KLS0tIGxpbnV4LTIu
Ni4xNC1yYzUvaW5jbHVkZS9saW51eC9wY2lfaWRzLmgJMjAwNS0xMC0yMCAw
MjoyMzowNS4wMDAwMDAwMDAgLTA0MDANCisrKyBsaW51eC0yLjYuMTQtcmM1
Lm5ldy9pbmNsdWRlL2xpbnV4L3BjaV9pZHMuaAkyMDA1LTEwLTI1IDEyOjM5
OjA0LjAwMDAwMDAwMCAtMDQwMA0KQEAgLTExODgsNiArMTE4OCwxMCBAQA0K
ICNkZWZpbmUgUENJX0RFVklDRV9JRF9OVklESUFfQ0s4X0FVRElPCQkweDAw
OGENCiAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfTlZJRElBX05WRU5FVF81CQkw
eDAwOGMNCiAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfTlZJRElBX05GT1JDRTJT
X1NBVEEJMHgwMDhlDQorI2RlZmluZSBQQ0lfREVWSUNFX0lEX05WSURJQV9H
RUZPUkNFXzc4MDBfR1QgICAweDAwOTANCisjZGVmaW5lIFBDSV9ERVZJQ0Vf
SURfTlZJRElBX0dFRk9SQ0VfNzgwMF9HVFgJMHgwMDkxDQorI2RlZmluZSBQ
Q0lfREVWSUNFX0lEX05WSURJQV9HRUZPUkNFX0dPXzc4MDAgICAweDAwOTgN
CisjZGVmaW5lIFBDSV9ERVZJQ0VfSURfTlZJRElBX0dFRk9SQ0VfR09fNzgw
MF9HVFggMHgwMDk5DQogI2RlZmluZSBQQ0lfREVWSUNFX0lEX05WSURJQV9J
VE5UMgkJMHgwMEEwDQogI2RlZmluZSBQQ0lfREVWSUNFX0lEX0dFRk9SQ0Vf
NjgwMEEgICAgICAgICAgICAgMHgwMGMxDQogI2RlZmluZSBQQ0lfREVWSUNF
X0lEX0dFRk9SQ0VfNjgwMEFfTEUgICAgICAgICAgMHgwMGMyDQo=

---74666112-942060465-1130260123=:15060--
