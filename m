Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266566AbUFWQzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266566AbUFWQzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 12:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266571AbUFWQzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 12:55:19 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:44932 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S266566AbUFWQy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 12:54:58 -0400
Subject: [PATCH] Fix up broken POSIX locks...
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-+5LHltF4dFlh9fHKlZ0Y"
Message-Id: <1088009697.5806.38.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 23 Jun 2004 12:54:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+5LHltF4dFlh9fHKlZ0Y
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following patch fixes up two nasty inconsistencies in the POSIX
byte-range locking code. The lockowner alone is NOT sufficient to
determine ownership of a lock.

Cheers,
  Trond

--=-+5LHltF4dFlh9fHKlZ0Y
Content-Disposition: inline; filename=linux-2.6.7-01-fix_locks.dif
Content-Type: text/plain; name=linux-2.6.7-01-fix_locks.dif; charset=ISO-8859-1
Content-Transfer-Encoding: base64

IGxvY2tzLmMgfCAgICA1ICsrKystDQogMSBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtdSAtLXJlY3Vyc2l2ZSAtLW5ldy1maWxlIC0tc2hvdy1j
LWZ1bmN0aW9uIGxpbnV4LTIuNi43L2ZzL2xvY2tzLmMgbGludXgtMi42LjctMDAtZml4X2xvY2tz
L2ZzL2xvY2tzLmMNCi0tLSBsaW51eC0yLjYuNy9mcy9sb2Nrcy5jCTIwMDQtMDYtMTYgMTQ6NTg6
MjcuMDAwMDAwMDAwIC0wNDAwDQorKysgbGludXgtMi42LjctMDAtZml4X2xvY2tzL2ZzL2xvY2tz
LmMJMjAwNC0wNi0yMyAxMjo0NjoyOS4wMDAwMDAwMDAgLTA0MDANCkBAIC05MjEsNiArOTIxLDcg
QEAgaW50IHBvc2l4X2xvY2tfZmlsZShzdHJ1Y3QgZmlsZSAqZmlscCwgcw0KIGludCBsb2Nrc19t
YW5kYXRvcnlfbG9ja2VkKHN0cnVjdCBpbm9kZSAqaW5vZGUpDQogew0KIAlmbF9vd25lcl90IG93
bmVyID0gY3VycmVudC0+ZmlsZXM7DQorCXVuc2lnbmVkIGludCBwaWQgPSBjdXJyZW50LT50Z2lk
Ow0KIAlzdHJ1Y3QgZmlsZV9sb2NrICpmbDsNCiANCiAJLyoNCkBAIC05MzIsNiArOTMzLDggQEAg
aW50IGxvY2tzX21hbmRhdG9yeV9sb2NrZWQoc3RydWN0IGlub2RlIA0KIAkJCWNvbnRpbnVlOw0K
IAkJaWYgKGZsLT5mbF9vd25lciAhPSBvd25lcikNCiAJCQlicmVhazsNCisJCWlmIChmbC0+Zmxf
cGlkICE9IHBpZCkNCisJCQlicmVhazsNCiAJfQ0KIAl1bmxvY2tfa2VybmVsKCk7DQogCXJldHVy
biBmbCA/IC1FQUdBSU4gOiAwOw0KQEAgLTE2ODQsNyArMTY4Nyw3IEBAIHZvaWQgbG9ja3NfcmVt
b3ZlX3Bvc2l4KHN0cnVjdCBmaWxlICpmaWwNCiAJbG9ja19rZXJuZWwoKTsNCiAJd2hpbGUgKCpi
ZWZvcmUgIT0gTlVMTCkgew0KIAkJc3RydWN0IGZpbGVfbG9jayAqZmwgPSAqYmVmb3JlOw0KLQkJ
aWYgKElTX1BPU0lYKGZsKSAmJiAoZmwtPmZsX293bmVyID09IG93bmVyKSkgew0KKwkJaWYgKElT
X1BPU0lYKGZsKSAmJiBwb3NpeF9zYW1lX293bmVyKGZsLCAmbG9jaykpIHsNCiAJCQlsb2Nrc19k
ZWxldGVfbG9jayhiZWZvcmUpOw0KIAkJCWNvbnRpbnVlOw0KIAkJfQ0K

--=-+5LHltF4dFlh9fHKlZ0Y--
