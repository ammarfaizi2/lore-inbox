Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267828AbUIBIOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267828AbUIBIOd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 04:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267859AbUIBIOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 04:14:33 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:28294 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S267828AbUIBIOa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 04:14:30 -0400
Message-ID: <1094112869.4136d66600691@imp4-q.free.fr>
Date: Thu,  2 Sep 2004 10:14:30 +0200
From: castet.matthieu@free.fr
To: linux-kernel@vger.kernel.org
Subject: [PATCH] pnpbios parser bugfix
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ1094112869e5ed2b2e701372b65086ea9363dff036"
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 213.228.31.152
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

---MOQ1094112869e5ed2b2e701372b65086ea9363dff036
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

hi,
this patch fix a pnpbios problem with independant
resource(http://bugzilla.kernel.org/show_bug.cgi?id=3295) :
the old code assume that they are given at the beggining (before any
SMALL_TAG_STARTDEP entry), but in some case there are found after
SMALL_TAG_ENDDEP entry.

tag : 6 SMALL_TAG_STARTDEP
tag : 8 SMALL_TAG_PORT
tag : 6 SMALL_TAG_STARTDEP
tag : 8 SMALL_TAG_PORT
tag : 7 SMALL_TAG_ENDDEP
tag : 4 SMALL_TAG_IRQ   <-- independant resource
tag : f SMALL_TAG_END


Matthieu
---MOQ1094112869e5ed2b2e701372b65086ea9363dff036
Content-Type: text/x-patch; name="pnp1.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pnp1.patch"

LS0tIGxpbnV4L2RyaXZlcnMvcG5wL3BucGJpb3MvcnNwYXJzZXIuYwkyMDA0LTA2LTE2IDA3OjE5
OjEzLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjkvZHJpdmVycy9wbnAvcG5wYmlvcy9y
c3BhcnNlci5jCTIwMDQtMDktMDIgMDk6NTk6NTMuMDAwMDAwMDAwICswMjAwCkBAIC0zNDYsMTIg
KzM0NiwxMiBAQAogewogCXVuc2lnbmVkIGludCBsZW4sIHRhZzsKIAlpbnQgcHJpb3JpdHkgPSAw
OwotCXN0cnVjdCBwbnBfb3B0aW9uICpvcHRpb247CisJc3RydWN0IHBucF9vcHRpb24gKm9wdGlv
biwgKm9wdGlvbl9pbmRlcGVuZGVudDsKIAogCWlmICghcCkKIAkJcmV0dXJuIE5VTEw7CiAKLQlv
cHRpb24gPSBwbnBfcmVnaXN0ZXJfaW5kZXBlbmRlbnRfb3B0aW9uKGRldik7CisJb3B0aW9uX2lu
ZGVwZW5kZW50ID0gb3B0aW9uID0gcG5wX3JlZ2lzdGVyX2luZGVwZW5kZW50X29wdGlvbihkZXYp
OwogCWlmICghb3B0aW9uKQogCQlyZXR1cm4gTlVMTDsKIApAQCAtNDI4LDkgKzQyOCwxNCBAQAog
CQljYXNlIFNNQUxMX1RBR19FTkRERVA6CiAJCQlpZiAobGVuICE9IDApCiAJCQkJZ290byBsZW5f
ZXJyOworCQkJaWYgKG9wdGlvbl9pbmRlcGVuZGVudCA9PSBvcHRpb24pCisJCQkJcHJpbnRrKEtF
Uk5fV0FSTklORyAiUG5QQklPUzogTWlzc2luZyBTTUFMTF9UQUdfU1RBUlRERVAgdGFnXG4iKTsK
KwkJCW9wdGlvbiA9IG9wdGlvbl9pbmRlcGVuZGVudDsKIAkJCWJyZWFrOwogCiAJCWNhc2UgU01B
TExfVEFHX0VORDoKKwkJCWlmIChvcHRpb25faW5kZXBlbmRlbnQgIT0gb3B0aW9uKQorCQkJCXBy
aW50ayhLRVJOX1dBUk5JTkcgIlBuUEJJT1M6IE1pc3NpbmcgU01BTExfVEFHX0VORERFUCB0YWdc
biIpOwogCQkJcCA9IHAgKyAyOwogICAgICAgICAJCXJldHVybiAodW5zaWduZWQgY2hhciAqKXA7
CiAJCQlicmVhazsK

---MOQ1094112869e5ed2b2e701372b65086ea9363dff036--
