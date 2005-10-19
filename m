Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbVJSNtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbVJSNtK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 09:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbVJSNtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 09:49:09 -0400
Received: from mailgate.urz.uni-halle.de ([141.48.3.51]:58838 "EHLO
	mailgate.uni-halle.de") by vger.kernel.org with ESMTP
	id S1750933AbVJSNtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 09:49:08 -0400
Date: Wed, 19 Oct 2005 15:49:00 +0200 (METDST)
From: Clemens Ladisch <clemens@ladisch.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] more HPET fixes and enhancements
In-Reply-To: <Pine.HPX.4.33n.0510190910390.13768-100000@studcom.urz.uni-halle.de>
Message-ID: <Pine.HPX.4.33n.0510191546100.2146-200000@studcom.urz.uni-halle.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="2015913978-758783491-1129729740=:2146"
X-Scan-Signature: e2604e7fef3f5620405fa2497b708545
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--2015913978-758783491-1129729740=:2146
Content-Type: TEXT/PLAIN; charset=US-ASCII

I wrote:
> This means that hpet.c must initialize the interrupt routing register
> in this case.  I'll write a patch for this.

Okay, this is a quick hack, untested.  It just tries to set the first
interrupt that the timer could use.


Regards,
Clemens

--2015913978-758783491-1129729740=:2146
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="hpet-irq-route-init.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.HPX.4.33n.0510191549000.2146@studcom.urz.uni-halle.de>
Content-Description: 
Content-Disposition: attachment; filename="hpet-irq-route-init.diff"

SW5kZXg6IGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwvdGltZV9ocGV0LmMNCj09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCi0tLSBsaW51eC5vcmlnL2FyY2gvaTM4
Ni9rZXJuZWwvdGltZV9ocGV0LmMJMjAwNS0xMC0wMiAxNzoyMzoyMC4wMDAw
MDAwMDAgKzAyMDANCisrKyBsaW51eC9hcmNoL2kzODYva2VybmVsL3RpbWVf
aHBldC5jCTIwMDUtMTAtMTkgMTQ6Mzc6NTUuMDAwMDAwMDAwICswMjAwDQpA
QCAtMTk2LDYgKzE5NiwxMiBAQCBpbnQgX19pbml0IGhwZXRfZW5hYmxlKHZv
aWQpDQogDQogCQkJZm9yIChpID0gMiwgdGltZXIgPSAmaHBldC0+aHBldF90
aW1lcnNbMl07IGkgPCBudGltZXI7DQogCQkJCXRpbWVyKyssIGkrKykNCisJ
CQkJaWYgKCEodGltZXItPmhwZXRfY29uZmlnICYgVG5fSU5UX1JPVVRFX0NO
Rl9NQVNLKSAmJg0KKwkJCQkgICAgISh0aW1lci0+aHBldF9jb25maWcgJiBU
bl9GU0JfRU5fQ05GX01BU0spKSB7DQorCQkJCQlpbnQgaXJxID0gZmZzKHRp
bWVyLT5ocGV0X2NvbmZpZyA+PiBUbl9JTklfUk9VVEVfQ0FQX1NISUZUKTsN
CisJCQkJCXRpbWVyLT5ocGV0X2NvbmZpZyB8PSBpcnEgPDwgVG5fSU5UX1JP
VVRFX0NORl9TSElGVDsNCisJCQkJCXByaW50ayhLRVJOX0lORk8gIkhQRVQ6
IHRpbWVyICVkIGNvbmZpZ3VyZWQgZm9yIElSUSAlZFxuIiwgaSwgaXJxKTsN
CisJCQkJfQ0KIAkJCQloZC5oZF9pcnFbaV0gPSAodGltZXItPmhwZXRfY29u
ZmlnICYNCiAJCQkJCVRuX0lOVF9ST1VURV9DTkZfTUFTSykgPj4NCiAJCQkJ
CVRuX0lOVF9ST1VURV9DTkZfU0hJRlQ7DQpJbmRleDogbGludXgvYXJjaC94
ODZfNjQva2VybmVsL3RpbWUuYw0KPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
LS0tIGxpbnV4Lm9yaWcvYXJjaC94ODZfNjQva2VybmVsL3RpbWUuYwkyMDA1
LTEwLTAyIDE3OjIzOjIwLjAwMDAwMDAwMCArMDIwMA0KKysrIGxpbnV4L2Fy
Y2gveDg2XzY0L2tlcm5lbC90aW1lLmMJMjAwNS0xMC0xOSAxNDozNjoyMy4w
MDAwMDAwMDAgKzAyMDANCkBAIC03ODMsNiArNzgzLDEyIEBAIHN0YXRpYyBf
X2luaXQgaW50IGxhdGVfaHBldF9pbml0KHZvaWQpDQogDQogCQlmb3IgKGkg
PSAyLCB0aW1lciA9ICZocGV0LT5ocGV0X3RpbWVyc1syXTsgaSA8IG50aW1l
cjsNCiAJCSAgICAgdGltZXIrKywgaSsrKQ0KKwkJCWlmICghKHRpbWVyLT5o
cGV0X2NvbmZpZyAmIFRuX0lOVF9ST1VURV9DTkZfTUFTSykgJiYNCisJCQkg
ICAgISh0aW1lci0+aHBldF9jb25maWcgJiBUbl9GU0JfRU5fQ05GX01BU0sp
KSB7DQorCQkJCWludCBpcnEgPSBmZnModGltZXItPmhwZXRfY29uZmlnID4+
IFRuX0lOSV9ST1VURV9DQVBfU0hJRlQpOw0KKwkJCQl0aW1lci0+aHBldF9j
b25maWcgfD0gaXJxIDw8IFRuX0lOVF9ST1VURV9DTkZfU0hJRlQ7DQorCQkJ
CXByaW50ayhLRVJOX0lORk8gIkhQRVQ6IHRpbWVyICVkIGNvbmZpZ3VyZWQg
Zm9yIElSUSAlZFxuIiwgaSwgaXJxKTsNCisJCQl9DQogCQkJaGQuaGRfaXJx
W2ldID0gKHRpbWVyLT5ocGV0X2NvbmZpZyAmDQogCQkJCQlUbl9JTlRfUk9V
VEVfQ05GX01BU0spID4+DQogCQkJCVRuX0lOVF9ST1VURV9DTkZfU0hJRlQ7
DQo=
--2015913978-758783491-1129729740=:2146--
