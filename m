Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbVJYRIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVJYRIp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 13:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVJYRIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 13:08:45 -0400
Received: from rtlab.med.cornell.edu ([140.251.128.175]:21137 "EHLO
	openlab.rtlab.org") by vger.kernel.org with ESMTP id S932213AbVJYRIp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 13:08:45 -0400
Date: Tue, 25 Oct 2005 13:08:43 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: calin@rtlab.med.cornell.edu
To: ajoshi@shell.unixbox.com, linux-kernel@vger.kernel.org
Cc: linux-nvidia@lists.surfsouth.com, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] nvidiafb: Geforce 7800 GTX support added
Message-ID: <Pine.LNX.4.64.0510251222070.15060@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-74666112-942060465-1130260123=:15060"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---74666112-942060465-1130260123=:15060
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed


Hi, this is an almost trivial patch that simply adds support for the 
Nvidia Geforce 7800 GTX card to the nvidiafb framebuffer driver.  All this 
patch does is add the PCI device id for this device into the module device 
table for this driver, so that nvidiafb.ko will actually work on this 
card.

I also added the PCI device id to linux/pci_ids.h (I hope noone minds).

I tested it on my 7800 GTX here and it works like a charm.  I now can get 
framebuffer support on this card!  Woo hoo!!  Nothing like 200x75 text 
mode to make your eyes BLEED. ;)

This patch is against 2.6.14-rc5.  It should apply against most 2.6 
kernels though -- not sure which kernel is the standard one to submit 
patches against.

Should I submit this patch for 2.4 kernel?  I don't even know if that one 
has nvidiafb since I don't run 2.4 much these days..

Thanks!

-Calin

---74666112-942060465-1130260123=:15060
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=nvidiafb_7800gtx.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0510251308430.15060@rtlab.med.cornell.edu>
Content-Description: 
Content-Disposition: attachment; filename=nvidiafb_7800gtx.patch

ZGlmZiAtdXJOIGxpbnV4LTIuNi4xNC1yYzUvZHJpdmVycy92aWRlby9udmlk
aWEvbnZpZGlhLmMgbGludXgtMi42LjE0LXJjNS5uZXcvZHJpdmVycy92aWRl
by9udmlkaWEvbnZpZGlhLmMNCi0tLSBsaW51eC0yLjYuMTQtcmM1L2RyaXZl
cnMvdmlkZW8vbnZpZGlhL252aWRpYS5jCTIwMDUtMTAtMjAgMDI6MjM6MDUu
MDAwMDAwMDAwIC0wNDAwDQorKysgbGludXgtMi42LjE0LXJjNS5uZXcvZHJp
dmVycy92aWRlby9udmlkaWEvbnZpZGlhLmMJMjAwNS0xMC0yNSAxMjozNDow
Ny4wMDAwMDAwMDAgLTA0MDANCkBAIC0zODQsNiArMzg0LDggQEANCiAJIFBD
SV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsIDB9LA0KIAl7UENJX1ZFTkRP
Ul9JRF9OVklESUEsIFBDSV9ERVZJQ0VfSURfTlZJRElBX0dFRk9SQ0VfNjgw
MEJfR1QsDQogCSBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCAwfSwN
CisJe1BDSV9WRU5ET1JfSURfTlZJRElBLCBQQ0lfREVWSUNFX0lEX05WSURJ
QV9HRUZPUkNFXzc4MDBfR1RYLA0KKwkgUENJX0FOWV9JRCwgUENJX0FOWV9J
RCwgMCwgMCwgMH0sDQogCXtQQ0lfVkVORE9SX0lEX05WSURJQSwgMHgwMjFk
LA0KIAkgUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgMCwgMCwgMH0sDQogCXtQ
Q0lfVkVORE9SX0lEX05WSURJQSwgMHgwMjFlLA0KZGlmZiAtdXJOIGxpbnV4
LTIuNi4xNC1yYzUvaW5jbHVkZS9saW51eC9wY2lfaWRzLmggbGludXgtMi42
LjE0LXJjNS5uZXcvaW5jbHVkZS9saW51eC9wY2lfaWRzLmgNCi0tLSBsaW51
eC0yLjYuMTQtcmM1L2luY2x1ZGUvbGludXgvcGNpX2lkcy5oCTIwMDUtMTAt
MjAgMDI6MjM6MDUuMDAwMDAwMDAwIC0wNDAwDQorKysgbGludXgtMi42LjE0
LXJjNS5uZXcvaW5jbHVkZS9saW51eC9wY2lfaWRzLmgJMjAwNS0xMC0yNSAx
MjozOTowNC4wMDAwMDAwMDAgLTA0MDANCkBAIC0xMTg4LDYgKzExODgsNyBA
QA0KICNkZWZpbmUgUENJX0RFVklDRV9JRF9OVklESUFfQ0s4X0FVRElPCQkw
eDAwOGENCiAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfTlZJRElBX05WRU5FVF81
CQkweDAwOGMNCiAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfTlZJRElBX05GT1JD
RTJTX1NBVEEJMHgwMDhlDQorI2RlZmluZSBQQ0lfREVWSUNFX0lEX05WSURJ
QV9HRUZPUkNFXzc4MDBfR1RYCTB4MDA5MQ0KICNkZWZpbmUgUENJX0RFVklD
RV9JRF9OVklESUFfSVROVDIJCTB4MDBBMA0KICNkZWZpbmUgUENJX0RFVklD
RV9JRF9HRUZPUkNFXzY4MDBBICAgICAgICAgICAgIDB4MDBjMQ0KICNkZWZp
bmUgUENJX0RFVklDRV9JRF9HRUZPUkNFXzY4MDBBX0xFICAgICAgICAgIDB4
MDBjMg0K

---74666112-942060465-1130260123=:15060--
