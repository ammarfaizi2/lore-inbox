Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVBADcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVBADcf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 22:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVBADa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 22:30:59 -0500
Received: from [195.23.16.24] ([195.23.16.24]:25227 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261521AbVBADaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 22:30:22 -0500
Message-ID: <1107228508.41fef75c95dad@webmail.grupopie.com>
Date: Tue,  1 Feb 2005 03:28:28 +0000
From: "" <pmarques@grupopie.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "" <linux-kernel@vger.kernel.org>, "" <linux-parport@lists.infradead.org>
Subject: [PATCH 2.6] 3/7 use kstrdup library function in parport/probe.c
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ11072285087a7c05db6d586fc7cf7cff19c4c9aa4c"
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 82.154.143.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

---MOQ11072285087a7c05db6d586fc7cf7cff19c4c9aa4c
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


This patch removes a private strdup in parport/probe.c, and updates it to=
 use
the kstrdup library function.

Signed-off-by: Paulo Marques <pmarques@grupopie.com>

--
Paulo Marques - www.grupopie.com
=20
All that is necessary for the triumph of evil is that good men do nothing=
.
Edmund Burke (1729 - 1797)

---MOQ11072285087a7c05db6d586fc7cf7cff19c4c9aa4c
Content-Type: text/x-diff; name="patch3"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch3"

LS0tIGxpbnV4LTIuNi4xMC9kcml2ZXJzL3BhcnBvcnQvcHJvYmUuYy5vcmlnCTIwMDUtMDEtMzEg
MTk6MzU6MDYuNDYwNzM0OTcyICswMDAwCisrKyBsaW51eC0yLjYuMTAvZHJpdmVycy9wYXJwb3J0
L3Byb2JlLmMJMjAwNS0wMS0zMSAxOTozNjowNC40NTA2ODI1MDEgKzAwMDAKQEAgLTQ4LDE0ICs0
OCw2IEBAIHN0YXRpYyB2b2lkIHByZXR0eV9wcmludChzdHJ1Y3QgcGFycG9ydCAKIAlwcmludGso
IlxuIik7CiB9CiAKLXN0YXRpYyBjaGFyICpzdHJkdXAoY2hhciAqc3RyKQotewotCWludCBuID0g
c3RybGVuKHN0cikrMTsKLQljaGFyICpzID0ga21hbGxvYyhuLCBHRlBfS0VSTkVMKTsKLQlpZiAo
IXMpIHJldHVybiBOVUxMOwotCXJldHVybiBzdHJjcHkocywgc3RyKTsKLX0KLQogc3RhdGljIHZv
aWQgcGFyc2VfZGF0YShzdHJ1Y3QgcGFycG9ydCAqcG9ydCwgaW50IGRldmljZSwgY2hhciAqc3Ry
KQogewogCWNoYXIgKnR4dCA9IGttYWxsb2Moc3RybGVuKHN0cikrMSwgR0ZQX0tFUk5FTCk7CkBA
IC04OCwxNiArODAsMTYgQEAgc3RhdGljIHZvaWQgcGFyc2VfZGF0YShzdHJ1Y3QgcGFycG9ydCAq
cAogCQkJaWYgKCFzdHJjbXAocCwgIk1GRyIpIHx8ICFzdHJjbXAocCwgIk1BTlVGQUNUVVJFUiIp
KSB7CiAJCQkJaWYgKGluZm8tPm1mcikKIAkJCQkJa2ZyZWUgKGluZm8tPm1mcik7Ci0JCQkJaW5m
by0+bWZyID0gc3RyZHVwKHNlcCk7CisJCQkJaW5mby0+bWZyID0ga3N0cmR1cChzZXAsIEdGUF9L
RVJORUwpOwogCQkJfSBlbHNlIGlmICghc3RyY21wKHAsICJNREwiKSB8fCAhc3RyY21wKHAsICJN
T0RFTCIpKSB7CiAJCQkJaWYgKGluZm8tPm1vZGVsKQogCQkJCQlrZnJlZSAoaW5mby0+bW9kZWwp
OwotCQkJCWluZm8tPm1vZGVsID0gc3RyZHVwKHNlcCk7CisJCQkJaW5mby0+bW9kZWwgPSBrc3Ry
ZHVwKHNlcCwgR0ZQX0tFUk5FTCk7CiAJCQl9IGVsc2UgaWYgKCFzdHJjbXAocCwgIkNMUyIpIHx8
ICFzdHJjbXAocCwgIkNMQVNTIikpIHsKIAkJCQlpbnQgaTsKIAkJCQlpZiAoaW5mby0+Y2xhc3Nf
bmFtZSkKIAkJCQkJa2ZyZWUgKGluZm8tPmNsYXNzX25hbWUpOwotCQkJCWluZm8tPmNsYXNzX25h
bWUgPSBzdHJkdXAoc2VwKTsKKwkJCQlpbmZvLT5jbGFzc19uYW1lID0ga3N0cmR1cChzZXAsIEdG
UF9LRVJORUwpOwogCQkJCWZvciAodSA9IHNlcDsgKnU7IHUrKykKIAkJCQkJKnUgPSB0b3VwcGVy
KCp1KTsKIAkJCQlmb3IgKGkgPSAwOyBjbGFzc2VzW2ldLnRva2VuOyBpKyspIHsKQEAgLTExMiw3
ICsxMDQsNyBAQCBzdGF0aWMgdm9pZCBwYXJzZV9kYXRhKHN0cnVjdCBwYXJwb3J0ICpwCiAJCQkJ
ICAgIXN0cmNtcChwLCAiQ09NTUFORCBTRVQiKSkgewogCQkJCWlmIChpbmZvLT5jbWRzZXQpCiAJ
CQkJCWtmcmVlIChpbmZvLT5jbWRzZXQpOwotCQkJCWluZm8tPmNtZHNldCA9IHN0cmR1cChzZXAp
OworCQkJCWluZm8tPmNtZHNldCA9IGtzdHJkdXAoc2VwLCBHRlBfS0VSTkVMKTsKIAkJCQkvKiBp
ZiBpdCBzcGVha3MgcHJpbnRlciBsYW5ndWFnZSwgaXQncwogCQkJCSAgIHByb2JhYmx5IGEgcHJp
bnRlciAqLwogCQkJCWlmIChzdHJzdHIoc2VwLCAiUEpMIikgfHwgc3Ryc3RyKHNlcCwgIlBDTCIp
KQpAQCAtMTIwLDcgKzExMiw3IEBAIHN0YXRpYyB2b2lkIHBhcnNlX2RhdGEoc3RydWN0IHBhcnBv
cnQgKnAKIAkJCX0gZWxzZSBpZiAoIXN0cmNtcChwLCAiREVTIikgfHwgIXN0cmNtcChwLCAiREVT
Q1JJUFRJT04iKSkgewogCQkJCWlmIChpbmZvLT5kZXNjcmlwdGlvbikKIAkJCQkJa2ZyZWUgKGlu
Zm8tPmRlc2NyaXB0aW9uKTsKLQkJCQlpbmZvLT5kZXNjcmlwdGlvbiA9IHN0cmR1cChzZXApOwor
CQkJCWluZm8tPmRlc2NyaXB0aW9uID0ga3N0cmR1cChzZXAsIEdGUF9LRVJORUwpOwogCQkJfQog
CQl9CiAJcm9ja19vbjoK

---MOQ11072285087a7c05db6d586fc7cf7cff19c4c9aa4c--
