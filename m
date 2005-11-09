Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVKIOCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVKIOCX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVKIOCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:02:23 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:4143
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750770AbVKIOCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:02:22 -0500
Message-Id: <43720FBA.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 09 Nov 2005 15:03:22 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/39] NLKD - rmmod notification
References: <43720DAE.76F0.0078.0@novell.com> <43720E2E.76F0.0078.0@novell.com> <43720E72.76F0.0078.0@novell.com> <43720EAF.76F0.0078.0@novell.com> <43720F5E.76F0.0078.0@novell.com> <43720F95.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartE2C0DEBA.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartE2C0DEBA.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Debugging and maintenance support code occasionally needs to know not
only of module insertions, but also module removals.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__PartE2C0DEBA.0__=
Content-Type: application/octet-stream; name="linux-2.6.14-nlkd-notify-rmmod.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-nlkd-notify-rmmod.patch"

RGVidWdnaW5nIGFuZCBtYWludGVuYW5jZSBzdXBwb3J0IGNvZGUgb2NjYXNpb25hbGx5IG5lZWRz
IHRvIGtub3cgbm90Cm9ubHkgb2YgbW9kdWxlIGluc2VydGlvbnMsIGJ1dCBhbHNvIG1vZHVsZSBy
ZW1vdmFscy4KClNpZ25lZC1PZmYtQnk6IEphbiBCZXVsaWNoIDxqYmV1bGljaEBub3ZlbGwuY29t
PgoKSW5kZXg6IDIuNi4xNC1ubGtkL2tlcm5lbC9tb2R1bGUuYwo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSAyLjYu
MTQtbmxrZC5vcmlnL2tlcm5lbC9tb2R1bGUuYwkyMDA1LTExLTA0IDE2OjE5OjM0LjAwMDAwMDAw
MCArMDEwMAorKysgMi42LjE0LW5sa2Qva2VybmVsL21vZHVsZS5jCTIwMDUtMTEtMDQgMTY6MTk6
MzQuMDAwMDAwMDAwICswMTAwCkBAIC0xMTY5LDYgKzExNjksMTAgQEAgc3RhdGljIHZvaWQgY2xl
YW51cF9rYWxsc3ltcyhzdHJ1Y3QgbW9kdQogLyogRnJlZSBhIG1vZHVsZSwgcmVtb3ZlIGZyb20g
bGlzdHMsIGV0YyAobXVzdCBob2xkIG1vZHVsZSBtdXRleCkuICovCiBzdGF0aWMgdm9pZCBmcmVl
X21vZHVsZShzdHJ1Y3QgbW9kdWxlICptb2QpCiB7CisJZG93bigmbm90aWZ5X211dGV4KTsKKwlu
b3RpZmllcl9jYWxsX2NoYWluKCZtb2R1bGVfbm90aWZ5X2xpc3QsIE1PRFVMRV9TVEFURV9HT0lO
RywgbW9kKTsKKwl1cCgmbm90aWZ5X211dGV4KTsKKwogCS8qIERlbGV0ZSBmcm9tIHZhcmlvdXMg
bGlzdHMgKi8KIAlzdG9wX21hY2hpbmVfcnVuKF9fdW5saW5rX21vZHVsZSwgbW9kLCBOUl9DUFVT
KTsKIAlyZW1vdmVfc2VjdF9hdHRycyhtb2QpOwpAQCAtMTk5OSw5ICsyMDAzLDEzIEBAIHN5c19p
bml0X21vZHVsZSh2b2lkIF9fdXNlciAqdW1vZCwKICAgICAgICAgICAgICAgICAgICBidWdneSBy
ZWZjb3VudGVycy4gKi8KIAkJbW9kLT5zdGF0ZSA9IE1PRFVMRV9TVEFURV9HT0lORzsKIAkJc3lu
Y2hyb25pemVfc2NoZWQoKTsKLQkJaWYgKG1vZC0+dW5zYWZlKQorCQlpZiAobW9kLT51bnNhZmUp
IHsKIAkJCXByaW50ayhLRVJOX0VSUiAiJXM6IG1vZHVsZSBpcyBub3cgc3R1Y2shXG4iLAogCQkJ
ICAgICAgIG1vZC0+bmFtZSk7CisJCQlkb3duKCZub3RpZnlfbXV0ZXgpOworCQkJbm90aWZpZXJf
Y2FsbF9jaGFpbigmbW9kdWxlX25vdGlmeV9saXN0LCBNT0RVTEVfU1RBVEVfR09JTkcsIG1vZCk7
CisJCQl1cCgmbm90aWZ5X211dGV4KTsKKwkJfQogCQllbHNlIHsKIAkJCW1vZHVsZV9wdXQobW9k
KTsKIAkJCWRvd24oJm1vZHVsZV9tdXRleCk7Cg==

--=__PartE2C0DEBA.0__=--
