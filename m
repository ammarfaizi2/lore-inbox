Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269646AbUJAArS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269646AbUJAArS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 20:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269645AbUJAArS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 20:47:18 -0400
Received: from fmr06.intel.com ([134.134.136.7]:19357 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S269646AbUJAAqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 20:46:45 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4A750.14B8CE47"
Subject: [BUG]EDID_INFO in zero-page
Date: Thu, 30 Sep 2004 17:46:25 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6002FE5A4C@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG]EDID_INFO in zero-page
Thread-Index: AcSnUBRyel7FPxMyS8+wf3GBQ1m9og==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, <torvalds@osdl.org>
Cc: <jsimmons@users.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Oct 2004 00:46:26.0594 (UTC) FILETIME=[15120020:01C4A750]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4A750.14B8CE47
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


EDID_INFO is encroaching on the space meant for E820 map in zero-page.
This will result in E820 map corruption on any system that has more=20
than 18 E820 entries and CONFIG_VIDEO_SELECT. Not sure how this bug=20
managed to hide for more than a year.

Attached patch should fixes the bug.

Thanks,
Venki


------_=_NextPart_001_01C4A750.14B8CE47
Content-Type: application/octet-stream;
	name="e820.patch"
Content-Transfer-Encoding: base64
Content-Description: e820.patch
Content-Disposition: attachment;
	filename="e820.patch"

CkJ1ZzoKRURJRF9JTkZPIGlzIGVuY3JvYWNoaW5nIG9uIHRoZSBzcGFjZSBtZWFudCBmb3IgRTgy
MCBtYXAgaW4gemVyby1wYWdlLgpUaGlzIHdpbGwgcmVzdWx0IGluIEU4MjAgbWFwIGNvcnJ1cHRp
b24gb24gYW55IHN5c3RlbSB0aGF0IGhhcyBtb3JlCnRoYW4gMTggRTgyMCBlbnRyaWVzIGFuZCBD
T05GSUdfVklERU9fU0VMRUNULgoKVGhpcyBwYXRjaCBmaXhlcyB0aGUgYnVnLgoKU2lnbmVkLW9m
Zi1ieTo6ICJWZW5rYXRlc2ggUGFsbGlwYWRpIiA8dmVua2F0ZXNoLnBhbGxpcGFkaUBpbnRlbC5j
b20+CgotLS0gbGludXgtMi42LjktcmMyL2luY2x1ZGUvYXNtLWkzODYvc2V0dXAuaC5vcmcJMjAw
NC0wOC0yOSAwMDoxNjoyMS44Mzk0MjY0MzIgLTA3MDAKKysrIGxpbnV4LTIuNi45LXJjMi9pbmNs
dWRlL2FzbS1pMzg2L3NldHVwLmgJMjAwNC0wOC0yOCAyMzo1OToyMS45MTI0Nzg4OTYgLTA3MDAK
QEAgLTU1LDcgKzU1LDcgQEAgZXh0ZXJuIHVuc2lnbmVkIGNoYXIgYm9vdF9wYXJhbXNbUEFSQU1f
UwogI2RlZmluZSBLRVJORUxfU1RBUlQgKCoodW5zaWduZWQgbG9uZyAqKSAoUEFSQU0rMHgyMTQp
KQogI2RlZmluZSBJTklUUkRfU1RBUlQgKCoodW5zaWduZWQgbG9uZyAqKSAoUEFSQU0rMHgyMTgp
KQogI2RlZmluZSBJTklUUkRfU0laRSAoKih1bnNpZ25lZCBsb25nICopIChQQVJBTSsweDIxYykp
Ci0jZGVmaW5lIEVESURfSU5GTyAgICgqKHN0cnVjdCBlZGlkX2luZm8gKikgKFBBUkFNKzB4NDQw
KSkKKyNkZWZpbmUgRURJRF9JTkZPICAgKCooc3RydWN0IGVkaWRfaW5mbyAqKSAoUEFSQU0rMHgx
NDApKQogI2RlZmluZSBFRERfTlIgICAgICgqKHVuc2lnbmVkIGNoYXIgKikgKFBBUkFNK0VERE5S
KSkKICNkZWZpbmUgRUREX01CUl9TSUdfTlIgKCoodW5zaWduZWQgY2hhciAqKSAoUEFSQU0rRURE
X01CUl9TSUdfTlJfQlVGKSkKICNkZWZpbmUgRUREX01CUl9TSUdOQVRVUkUgKCh1bnNpZ25lZCBp
bnQgKikgKFBBUkFNK0VERF9NQlJfU0lHX0JVRikpCi0tLSBsaW51eC0yLjYuOS1yYzIvYXJjaC9p
Mzg2L2Jvb3QvdmlkZW8uUy5vcmcJMjAwNC0wOC0yOSAwMDoxMzo1Ni44NTI0Njc4MDAgLTA3MDAK
KysrIGxpbnV4LTIuNi45LXJjMi9hcmNoL2kzODYvYm9vdC92aWRlby5TCTIwMDQtMDgtMjggMjM6
NTk6MDUuOTAyOTEyNzIwIC0wNzAwCkBAIC0xOTM2LDcgKzE5MzYsNyBAQCBzdG9yZV9lZGlkOgog
CiAJbW92bAkkMHgxMzEzMTMxMywgJWVheAkJIyBtZW1zZXQgYmxvY2sgd2l0aCAweDEzCiAJbW92
dyAgICAkMzIsICVjeAotCW1vdncJJDB4NDQwLCAlZGkKKwltb3Z3CSQweDE0MCwgJWRpCiAJY2xk
CiAJcmVwIAogCXN0b3NsICAKQEAgLTE5NDUsNyArMTk0NSw3IEBAIHN0b3JlX2VkaWQ6CiAJbW92
dwkkMHgwMSwgJWJ4CiAJbW92dwkkMHgwMCwgJWN4CiAJbW92dyAgICAkMHgwMSwgJWR4Ci0JbW92
dwkkMHg0NDAsICVkaQorCW1vdncJJDB4MTQwLCAlZGkKIAlpbnQJJDB4MTAJCiAKIAlwb3B3CSVk
aQkJCQkjIHJlc3RvcmUgYWxsIHJlZ2lzdGVycyAgICAgICAgCi0tLSBsaW51eC0yLjYuOS1yYzIv
RG9jdW1lbnRhdGlvbi9pMzg2L3plcm8tcGFnZS50eHQub3JnCTIwMDQtMDgtMjkgMDA6MTQ6MTEu
NjAyMjI1NDk2IC0wNzAwCisrKyBsaW51eC0yLjYuOS1yYzIvRG9jdW1lbnRhdGlvbi9pMzg2L3pl
cm8tcGFnZS50eHQJMjAwNC0wOC0yOSAwMDoxNzoxMC40NDUwMzcyNTYgLTA3MDAKQEAgLTI4LDcg
KzI4LDggQEAgT2Zmc2V0CVR5cGUJCURlc2NyaXB0aW9uCiAKICAweGEwCTE2IGJ5dGVzCVN5c3Rl
bSBkZXNjcmlwdGlvbiB0YWJsZSB0cnVuY2F0ZWQgdG8gMTYgYnl0ZXMuCiAJCQkoIHN0cnVjdCBz
eXNfZGVzY190YWJsZV9zdHJ1Y3QgKQotIDB4YjAgLSAweDFjMwkJRnJlZS4gQWRkIG1vcmUgcGFy
YW1ldGVycyBoZXJlIGlmIHlvdSByZWFsbHkgbmVlZCB0aGVtLgorIDB4YjAgLSAweDEzZgkJRnJl
ZS4gQWRkIG1vcmUgcGFyYW1ldGVycyBoZXJlIGlmIHlvdSByZWFsbHkgbmVlZCB0aGVtLgorIDB4
MTQwLSAweDFiZQkJRURJRF9JTkZPIFZpZGVvIG1vZGUgc2V0dXAKIAogMHgxYzQJdW5zaWduZWQg
bG9uZwlFRkkgc3lzdGVtIHRhYmxlIHBvaW50ZXIKIDB4MWM4CXVuc2lnbmVkIGxvbmcJRUZJIG1l
bW9yeSBkZXNjcmlwdG9yIHNpemUK

------_=_NextPart_001_01C4A750.14B8CE47--
