Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbVCPNWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbVCPNWh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 08:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbVCPNWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 08:22:37 -0500
Received: from mail.dif.dk ([193.138.115.101]:24468 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262588AbVCPNT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 08:19:58 -0500
Date: Wed, 16 Mar 2005 14:21:21 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steven French <sfrench@us.ibm.com>
Cc: smfrench@austin.rr.com, linux-kernel@vger.kernel.org
Subject: [PATCH][2/7] cifs: file.c cleanups in incremental bits - kfree
 changes
Message-ID: <Pine.LNX.4.62.0503161418350.3141@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-633708402-1110979281=:3141"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-633708402-1110979281=:3141
Content-Type: TEXT/PLAIN; charset=US-ASCII


This patch (attached) removes pointless checks for NULL before kfree()'ing 
a pointer. kfree() handles NULL pointers just fine, so checking the 
pointer first is redundant.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


-- 
Jesper Juhl


--8323328-633708402-1110979281=:3141
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=fs_cifs_file-cleanups-3-kfree-changes.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.62.0503161421210.3141@dragon.hyggekrogen.localhost>
Content-Description: fs_cifs_file-cleanups-3-kfree-changes.patch
Content-Disposition: attachment; filename=fs_cifs_file-cleanups-3-kfree-changes.patch

ZGlmZiAtdXAgbGludXgtMi42LjExLW1tMy9mcy9jaWZzL2ZpbGUuYy53aXRo
X3BhdGNoXzIgbGludXgtMi42LjExLW1tMy9mcy9jaWZzL2ZpbGUuYw0KLS0t
IGxpbnV4LTIuNi4xMS1tbTMvZnMvY2lmcy9maWxlLmMud2l0aF9wYXRjaF8y
CTIwMDUtMDMtMTUgMjI6NDk6MzMuMDAwMDAwMDAwICswMTAwDQorKysgbGlu
dXgtMi42LjExLW1tMy9mcy9jaWZzL2ZpbGUuYwkyMDA1LTAzLTE1IDIyOjUx
OjAxLjAwMDAwMDAwMCArMDEwMA0KQEAgLTE0OCw4ICsxNDgsNyBAQCBpbnQg
Y2lmc19vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjDQogCWFibGUg
dG8gc2ltcGx5IGRvIGEgZmlsZW1hcF9mZGF0YXdyaXRlL2ZpbGVtYXBfZmRh
dGF3YWl0IGZpcnN0ICovDQogCWJ1ZiA9IGttYWxsb2Moc2l6ZW9mKEZJTEVf
QUxMX0lORk8pLCBHRlBfS0VSTkVMKTsNCiAJaWYgKGJ1ZiA9PSBOVUxMKSB7
DQotCQlpZiAoZnVsbF9wYXRoKQ0KLQkJCWtmcmVlKGZ1bGxfcGF0aCk7DQor
CQlrZnJlZShmdWxsX3BhdGgpOw0KIAkJRnJlZVhpZCh4aWQpOw0KIAkJcmV0
dXJuIC1FTk9NRU07DQogCX0NCkBAIC0yNDgsMTAgKzI0Nyw4IEBAIGludCBj
aWZzX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWMNCiAJCX0NCiAJ
fQ0KIA0KLQlpZiAoYnVmKQ0KLQkJa2ZyZWUoYnVmKTsNCi0JaWYgKGZ1bGxf
cGF0aCkNCi0JCWtmcmVlKGZ1bGxfcGF0aCk7DQorCWtmcmVlKGJ1Zik7DQor
CWtmcmVlKGZ1bGxfcGF0aCk7DQogCUZyZWVYaWQoeGlkKTsNCiAJcmV0dXJu
IHJjOw0KIH0NCkBAIC0zNDIsOCArMzM5LDcgQEAgc3RhdGljIGludCBjaWZz
X3Jlb3Blbl9maWxlKHN0cnVjdCBpbm9kZQ0KIC8qCWJ1ZiA9IGttYWxsb2Mo
c2l6ZW9mKEZJTEVfQUxMX0lORk8pLCBHRlBfS0VSTkVMKTsNCiAJaWYgKGJ1
ZiA9PSAwKSB7DQogCQl1cCgmcENpZnNGaWxlLT5maF9zZW0pOw0KLQkJaWYg
KGZ1bGxfcGF0aCkNCi0JCQlrZnJlZShmdWxsX3BhdGgpOw0KKwkJa2ZyZWUo
ZnVsbF9wYXRoKTsNCiAJCUZyZWVYaWQoeGlkKTsNCiAJCXJldHVybiAtRU5P
TUVNOw0KIAl9ICovDQpAQCAtMzk2LDggKzM5Miw3IEBAIHN0YXRpYyBpbnQg
Y2lmc19yZW9wZW5fZmlsZShzdHJ1Y3QgaW5vZGUNCiAJCX0NCiAJfQ0KIA0K
LQlpZiAoZnVsbF9wYXRoKQ0KLQkJa2ZyZWUoZnVsbF9wYXRoKTsNCisJa2Zy
ZWUoZnVsbF9wYXRoKTsNCiAJRnJlZVhpZCh4aWQpOw0KIAlyZXR1cm4gcmM7
DQogfQ0KQEAgLTQzMSw4ICs0MjYsNyBAQCBpbnQgY2lmc19jbG9zZShzdHJ1
Y3QgaW5vZGUgKmlub2RlLCBzdHJ1DQogCQlsaXN0X2RlbCgmcFNNQkZpbGUt
PmZsaXN0KTsNCiAJCWxpc3RfZGVsKCZwU01CRmlsZS0+dGxpc3QpOw0KIAkJ
d3JpdGVfdW5sb2NrKCZmaWxlLT5mX293bmVyLmxvY2spOw0KLQkJaWYgKHBT
TUJGaWxlLT5zZWFyY2hfcmVzdW1lX25hbWUpDQotCQkJa2ZyZWUocFNNQkZp
bGUtPnNlYXJjaF9yZXN1bWVfbmFtZSk7DQorCQlrZnJlZShwU01CRmlsZS0+
c2VhcmNoX3Jlc3VtZV9uYW1lKTsNCiAJCWtmcmVlKGZpbGUtPnByaXZhdGVf
ZGF0YSk7DQogCQlmaWxlLT5wcml2YXRlX2RhdGEgPSBOVUxMOw0KIAl9IGVs
c2UNCg==

--8323328-633708402-1110979281=:3141--
