Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbTJYWdf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 18:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbTJYWdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 18:33:35 -0400
Received: from kde.informatik.uni-kl.de ([131.246.103.200]:52360 "EHLO
	dot.kde.org") by vger.kernel.org with ESMTP id S262721AbTJYWde
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 18:33:34 -0400
Date: Sun, 26 Oct 2003 00:31:51 +0200 (CEST)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: 2.4.23-pre8 ACPI breaks x86_64
Message-ID: <Pine.LNX.4.56.0310260018100.28163@dot.kde.org>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658386544-830883715-1067121111=:28163"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--658386544-830883715-1067121111=:28163
Content-Type: TEXT/PLAIN; charset=US-ASCII

SSIA - drivers/acpi/bus.c started using acpi_pic_set_level_irq 
unconditionally, and the function doesn't exist on x86_64.

The attached patch _might_ fix it (I don't have the x86_64 manuals and 
can't reboot my x86_64 test box to test myself ATM -- too many people 
working on it ;) )

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
--658386544-830883715-1067121111=:28163
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="pre8-acpi-x86_64.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.56.0310260031510.28163@dot.kde.org>
Content-Description: Suspected fix
Content-Disposition: attachment; filename="pre8-acpi-x86_64.patch"

LS0tIGxpbnV4LTIuNC4yMi9hcmNoL3g4Nl82NC9rZXJuZWwvYWNwaS5jLmFy
awkyMDAzLTEwLTI2IDA3OjI1OjEwLjAwMDAwMDAwMCArMDEwMA0KKysrIGxp
bnV4LTIuNC4yMi9hcmNoL3g4Nl82NC9rZXJuZWwvYWNwaS5jCTIwMDMtMTAt
MjYgMDc6MzA6MDcuMDAwMDAwMDAwICswMTAwDQpAQCAtNTY1LDQgKzU2NSwx
NyBAQA0KIA0KICNlbmRpZiAvKkNPTkZJR19BQ1BJX1NMRUVQKi8NCiANCisj
aWZkZWYgQ09ORklHX0FDUElfQlVTDQordm9pZCBhY3BpX3BpY19zZXRfbGV2
ZWxfaXJxKHVuc2lnbmVkIGludCBpcnEpDQorew0KKwl1bnNpZ25lZCBjaGFy
IG1hc2sgPSAxIDw8IChpcnEgJiA3KTsNCisJdW5zaWduZWQgaW50IHBvcnQg
PSAweDRkMCArIChpcnEgPj4gMyk7DQorCXVuc2lnbmVkIGNoYXIgdmFsID0g
aW5iKHBvcnQpOw0KIA0KKwlpZiAoISh2YWwgJiBtYXNrKSkgew0KKwkJcHJp
bnRrKEtFUk5fV0FSTklORyBQUkVGSVggIklSUSAlZCB3YXMgRWRnZSBUcmln
Z2VyZWQsICINCisJCQkic2V0dGluZyB0byBMZXZlbCBUcmlnZ2VyZWRcbiIs
IGlycSk7DQorCQlvdXRiKHZhbCB8IG1hc2ssIHBvcnQpOw0KKwl9DQorfQ0K
KyNlbmRpZiAvKiBDT05GSUdfQUNQSV9CVVMgKi8NCg==

--658386544-830883715-1067121111=:28163--
