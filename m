Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUEaRk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUEaRk1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 13:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264705AbUEaRk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 13:40:27 -0400
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:9683 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S264704AbUEaRkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 13:40:19 -0400
X-OB-Received: from unknown (205.158.62.156)
  by wfilter.us4.outblaze.com; 31 May 2004 17:39:48 -0000
Content-Type: multipart/mixed; boundary="----------=_1086025210-2283-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Pokey the Penguin" <pokey@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Tue, 01 Jun 2004 01:40:10 +0800
Subject: [PATCH] psmouse/usb interaction fix
X-Originating-Ip: 129.215.32.201
X-Originating-Server: ws5-7.us4.outblaze.com
Message-Id: <20040531174012.BA07D2B2B58@ws5-7.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1086025210-2283-1
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This patch fixes the case where certain laptop touchpads (ALPS) 
are disabled if the machine boots with a usb mouse plugged in.

Without it, users have to choose between using either a usb mouse 
or the touchpad. With it, any combination is possible and the usb 
mouse can be attached/removed at runtime without breaking the 
touchpad.

The patch is ported from a SuSE kernel to 2.6.7-rc2. It's been
around for at least two minor releases. The maintainer was
contacted regarding merging but failed to respond.

Patch vital to certain laptop users. Please apply.
-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze

------------=_1086025210-2283-1
Content-Type: application/octet-stream; name="psmouse-usb-fix-2.6.7-rc2.diff"
Content-Disposition: attachment; filename="psmouse-usb-fix-2.6.7-rc2.diff"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi43LXJjMi1iYXNlL2RyaXZlcnMvcGNpL3F1aXJrcy5j
CTIwMDQtMDUtMzEgMTg6MDg6NTUuMzEwNjA2MDAwICswMTAwCisrKyBsaW51
eC0yLjYuNy1yYzIvZHJpdmVycy9wY2kvcXVpcmtzLmMJMjAwNC0wNS0zMSAx
ODoxODo0OC42NDg0MDQ5NTIgKzAxMDAKQEAgLTg3NSw2ICs4NzUsNjYgQEAg
c3RhdGljIHZvaWQgX19kZXZpbml0IHF1aXJrX3BjaWVocF9tc2kocwogCXBj
aWVocF9tc2lfcXVpcmsgPSAxOwogfQogCisKKyNkZWZpbmUgVUhDSV9VU0JM
RUdTVVAJCTB4YzAJCS8qIGxlZ2FjeSBzdXBwb3J0ICovCisjZGVmaW5lIFVI
Q0lfVVNCQ01ECQkwCQkvKiBjb21tYW5kIHJlZ2lzdGVyICovCisjZGVmaW5l
IFVIQ0lfVVNCSU5UUgkJNAkJLyogaW50ZXJydXB0IHJlZ2lzdGVyICovCisj
ZGVmaW5lIFVIQ0lfVVNCTEVHU1VQX0RFRkFVTFQJMHgyMDAwCQkvKiBvbmx5
IFBJUlEgZW5hYmxlIHNldCAqLworI2RlZmluZSBVSENJX1VTQkNNRF9HUkVT
RVQJMHgwMDA0CQkvKiBHbG9iYWwgcmVzZXQgKi8KKworI2RlZmluZSBPSENJ
X0NPTlRST0wJCTB4MDQKKyNkZWZpbmUgT0hDSV9DTURTVEFUVVMJCTB4MDgK
KyNkZWZpbmUgT0hDSV9JTlRSRU5BQkxFCQkweDEwCisjZGVmaW5lIE9IQ0lf
T0NSCQkoMSA8PCAzKQkvKiBvd25lcnNoaXAgY2hhbmdlIHJlcXVlc3QgKi8K
KyNkZWZpbmUgT0hDSV9DVFJMX0lSCQkoMSA8PCA4KQkvKiBpbnRlcnJ1cHQg
cm91dGluZyAqLworI2RlZmluZSBPSENJX0lOVFJfT0MJCSgxIDw8IDMwKQkv
KiBvd25lcnNoaXAgY2hhbmdlICovCisKK3N0YXRpYyB2b2lkIF9faW5pdCBx
dWlya191c2JfZGlzYWJsZV9zbW1fYmlvcyhzdHJ1Y3QgcGNpX2RldiAqcGRl
dikKK3sKKworCWlmIChwZGV2LT5jbGFzcyA9PSAoKFBDSV9DTEFTU19TRVJJ
QUxfVVNCIDw8IDgpIHwgMHgwMCkpIHsgLyogVUhDSSAqLworCQlpbnQgaTsK
KwkJdW5zaWduZWQgbG9uZyBiYXNlID0gMDs7CisKKwkJZm9yIChpID0gMDsg
aSA8IFBDSV9ST01fUkVTT1VSQ0U7IGkrKykgCisJCQlpZiAoKHBjaV9yZXNv
dXJjZV9mbGFncyhwZGV2LCBpKSAmIElPUkVTT1VSQ0VfSU8pKSB7CisJCQkJ
YmFzZSA9IHBjaV9yZXNvdXJjZV9zdGFydChwZGV2LCBpKTsKKwkJCQlicmVh
azsKKwkJCX0KKworCQlpZiAoIWJhc2UpCisJCQlyZXR1cm47CisKKwkJb3V0
dygwLCBiYXNlICsgVUhDSV9VU0JJTlRSKTsKKwkJb3V0dyhVSENJX1VTQkNN
RF9HUkVTRVQsIGJhc2UgKyBVSENJX1VTQkNNRCk7CisJCXNldF9jdXJyZW50
X3N0YXRlKFRBU0tfVU5JTlRFUlJVUFRJQkxFKTsKKyAgICAgICAJCXNjaGVk
dWxlX3RpbWVvdXQoKEhaKjUwKzk5OSkgLyAxMDAwKTsKKwkJb3V0dygwLCBi
YXNlICsgVUhDSV9VU0JDTUQpOworCQlzZXRfY3VycmVudF9zdGF0ZShUQVNL
X1VOSU5URVJSVVBUSUJMRSk7CisJCXNjaGVkdWxlX3RpbWVvdXQoKEhaKjEw
Kzk5OSkgLyAxMDAwKTsKKworCQlwY2lfd3JpdGVfY29uZmlnX3dvcmQocGRl
diwgVUhDSV9VU0JMRUdTVVAsIFVIQ0lfVVNCTEVHU1VQX0RFRkFVTFQpOwor
CX0KKworCWlmIChwZGV2LT5jbGFzcyA9PSAoKFBDSV9DTEFTU19TRVJJQUxf
VVNCIDw8IDgpIHwgMHgxMCkpIHsgLyogT0hDSSAqLworCQljaGFyICpiYXNl
ID0gaW9yZW1hcF9ub2NhY2hlKHBjaV9yZXNvdXJjZV9zdGFydChwZGV2LCAw
KSwKKwkJCQkJCQlwY2lfcmVzb3VyY2VfbGVuKHBkZXYsIDApKTsKKwkJaWYg
KGJhc2UgPT0gTlVMTCkgcmV0dXJuOworCisJCWlmIChyZWFkbChiYXNlICsg
T0hDSV9DT05UUk9MKSAmIE9IQ0lfQ1RSTF9JUikgeworCQkJaW50IHRlbXAg
PSA1MDA7ICAgICAvKiBhcmJpdHJhcnk6IGZpdmUgc2Vjb25kcyAqLworCQkJ
d3JpdGVsKE9IQ0lfSU5UUl9PQywgYmFzZSArIE9IQ0lfSU5UUkVOQUJMRSk7
CisJCQl3cml0ZWwoT0hDSV9PQ1IsIGJhc2UgKyBPSENJX0NNRFNUQVRVUyk7
CisJCQl3aGlsZSAodGVtcCAmJiByZWFkbChiYXNlICsgT0hDSV9DT05UUk9M
KSAmIE9IQ0lfQ1RSTF9JUikgeworCQkJCXRlbXAtLTsKKwkJCQlzZXRfY3Vy
cmVudF9zdGF0ZShUQVNLX1VOSU5URVJSVVBUSUJMRSk7CisJCQkJc2NoZWR1
bGVfdGltZW91dCggSFogLyAxMDApOworCQkJfQorCQl9CisJCWlvdW5tYXAo
YmFzZSk7CisJfQorfQorCiAvKgogICogIFRoZSBtYWluIHRhYmxlIG9mIHF1
aXJrcy4KICAqCkBAIC0xMDAyLDYgKzEwNjIsOCBAQCBzdGF0aWMgc3RydWN0
IHBjaV9maXh1cCBwY2lfZml4dXBzW10gX19kCiAJICBxdWlya19pbnRlbF9p
ZGVfY29tYmluZWQgfSwKICNlbmRpZiAvKiBDT05GSUdfU0NTSV9TQVRBICov
CiAKKwl7IFBDSV9GSVhVUF9GSU5BTCwJUENJX0FOWV9JRCwJCVBDSV9BTllf
SUQsCQkJcXVpcmtfdXNiX2Rpc2FibGVfc21tX2Jpb3MgfSwKKwogCXsgUENJ
X0ZJWFVQX0ZJTkFMLCAgICAgIFBDSV9WRU5ET1JfSURfSU5URUwsICAgIFBD
SV9ERVZJQ0VfSURfSU5URUxfU01DSCwJcXVpcmtfcGNpZWhwX21zaSB9LAog
CiAJeyAwIH0K

------------=_1086025210-2283-1--
