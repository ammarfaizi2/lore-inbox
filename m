Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264033AbTIILek (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 07:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbTIILek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 07:34:40 -0400
Received: from kde.informatik.uni-kl.de ([131.246.103.200]:24726 "EHLO
	dot.kde.org") by vger.kernel.org with ESMTP id S264033AbTIILei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 07:34:38 -0400
Date: Tue, 9 Sep 2003 13:19:13 +0200 (CEST)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH 2.6.0-test5-mm1] Fix build with debug disabled
Message-ID: <Pine.LNX.4.56.0309091317320.9188@dot.kde.org>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658386544-1685210824-1063106353=:9188"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--658386544-1685210824-1063106353=:9188
Content-Type: TEXT/PLAIN; charset=US-ASCII

2.6.0-test5-mm1 mm/slab.c defines dbg_redzone1 and friends in #if DEBUG, 
but uses them unconditionally.

Patch attached.

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
--658386544-1685210824-1063106353=:9188
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="2.6.0-test5-mm1-compile.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.56.0309091319130.9188@dot.kde.org>
Content-Description: Fix compile
Content-Disposition: attachment; filename="2.6.0-test5-mm1-compile.patch"

LS0tIGxpbnV4LTIuNi4wLXRlc3Q1L21tL3NsYWIuYy5hcmsJMjAwMy0wOS0w
OSAxMzozMjowOC4wMDAwMDAwMDAgKzAyMDANCisrKyBsaW51eC0yLjYuMC10
ZXN0NS9tbS9zbGFiLmMJMjAwMy0wOS0wOSAxMzozMzozMC4wMDAwMDAwMDAg
KzAyMDANCkBAIC05NDgsNiArOTQ4LDcgQEANCiAJCQljaGVja19wb2lzb25f
b2JqKGNhY2hlcCwgb2JqcCk7DQogI2VuZGlmDQogCQl9DQorI2lmIERFQlVH
DQogCQlpZiAoY2FjaGVwLT5mbGFncyAmIFNMQUJfUkVEX1pPTkUpIHsNCiAJ
CQlpZiAoKmRiZ19yZWR6b25lMShjYWNoZXAsIG9ianApICE9IFJFRF9JTkFD
VElWRSkNCiAJCQkJc2xhYl9lcnJvcihjYWNoZXAsICJzdGFydCBvZiBhIGZy
ZWVkIG9iamVjdCAiDQpAQCAtOTU2LDYgKzk1Nyw3IEBADQogCQkJCXNsYWJf
ZXJyb3IoY2FjaGVwLCAiZW5kIG9mIGEgZnJlZWQgb2JqZWN0ICINCiAJCQkJ
CQkJIndhcyBvdmVyd3JpdHRlbiIpOw0KIAkJfQ0KKyNlbmRpZg0KIAkJaWYg
KGNhY2hlcC0+ZHRvciAmJiAhKGNhY2hlcC0+ZmxhZ3MgJiBTTEFCX1BPSVNP
TikpDQogCQkJKGNhY2hlcC0+ZHRvcikob2JqcCtvYmpfZGJnaGVhZChjYWNo
ZXApLCBjYWNoZXAsIDApOw0KIAl9DQpAQCAtMjc5NCwxMSArMjc5NiwxMyBA
QA0KIAkJfSBlbHNlIHsNCiAJCQlrZXJuZWxfbWFwX3BhZ2VzKHZpcnRfdG9f
cGFnZShvYmpwKSwgYy0+b2Jqc2l6ZS9QQUdFX1NJWkUsIDEpOw0KIA0KKyNp
ZiBERUJVRw0KIAkJCWlmIChjLT5mbGFncyAmIFNMQUJfUkVEX1pPTkUpDQog
CQkJCXByaW50aygicmVkem9uZTogMHglbHgvMHglbHguXG4iLCAqZGJnX3Jl
ZHpvbmUxKGMsIG9ianApLCAqZGJnX3JlZHpvbmUyKGMsIG9ianApKTsNCiAN
CiAJCQlpZiAoYy0+ZmxhZ3MgJiBTTEFCX1NUT1JFX1VTRVIpDQogCQkJCXBy
aW50aygiTGFzdCB1c2VyOiAlcC5cbiIsICpkYmdfdXNlcndvcmQoYywgb2Jq
cCkpOw0KKyNlbmRpZg0KIAkJfQ0KIAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmYy0+c3BpbmxvY2ssIGZsYWdzKTsNCiANCg==

--658386544-1685210824-1063106353=:9188--
