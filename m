Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVGVWd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVGVWd0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 18:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVGVWd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 18:33:26 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:43915 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261408AbVGVWdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 18:33:25 -0400
Date: Fri, 22 Jul 2005 23:33:20 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: fix suspend/resume irq request free for yenta..
Message-ID: <Pine.LNX.4.58.0507222331580.15287@skynet>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-913833367-1424312705-1122071600=:15287"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---913833367-1424312705-1122071600=:15287
Content-Type: TEXT/PLAIN; charset=US-ASCII


Without this patch my laptop fails to resume from suspend to RAM...

It applies against a pretty recent 2.6.13-rc3 from git..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

---913833367-1424312705-1122071600=:15287
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=yenta_irq_diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0507222333200.15287@skynet>
Content-Description: 
Content-Disposition: attachment; filename=yenta_irq_diff

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNtY2lhL3llbnRhX3NvY2tldC5jIGIv
ZHJpdmVycy9wY21jaWEveWVudGFfc29ja2V0LmMNCi0tLSBhL2RyaXZlcnMv
cGNtY2lhL3llbnRhX3NvY2tldC5jDQorKysgYi9kcml2ZXJzL3BjbWNpYS95
ZW50YV9zb2NrZXQuYw0KQEAgLTg3MiwxMCArODcyLDIwIEBAIHN0YXRpYyBp
cnFyZXR1cm5fdCB5ZW50YV9wcm9iZV9oYW5kbGVyKGkNCiAJcmV0dXJuIElS
UV9OT05FOw0KIH0NCiANCitzdGF0aWMgaW50IHllbnRhX3JlcXVlc3RfaXJx
KHN0cnVjdCB5ZW50YV9zb2NrZXQgKnNvY2tldCkNCit7DQorCWlmIChyZXF1
ZXN0X2lycShzb2NrZXQtPmNiX2lycSwgeWVudGFfcHJvYmVfaGFuZGxlciwg
U0FfU0hJUlEsICJ5ZW50YSIsIHNvY2tldCkpIHsNCisJCXByaW50ayhLRVJO
X1dBUk5JTkcgIlllbnRhOiByZXF1ZXN0X2lycSgpIGluIHllbnRhX3Byb2Jl
X2NiX2lycSgpIGZhaWxlZCFcbiIpOw0KKwkJcmV0dXJuIC0xOw0KKwl9DQor
CXJldHVybiAwOw0KK30NCisNCiAvKiBwcm9iZXMgdGhlIFBDSSBpbnRlcnJ1
cHQsIHVzZSBvbmx5IG9uIG92ZXJyaWRlIGZ1bmN0aW9ucyAqLw0KIHN0YXRp
YyBpbnQgeWVudGFfcHJvYmVfY2JfaXJxKHN0cnVjdCB5ZW50YV9zb2NrZXQg
KnNvY2tldCkNCiB7DQogCXUxNiBicmlkZ2VfY3RybDsNCisJaW50IHJldDsN
CiANCiAJaWYgKCFzb2NrZXQtPmNiX2lycSkNCiAJCXJldHVybiAtMTsNCkBA
IC04ODcsMTAgKzg5Nyw5IEBAIHN0YXRpYyBpbnQgeWVudGFfcHJvYmVfY2Jf
aXJxKHN0cnVjdCB5ZW4NCiAJYnJpZGdlX2N0cmwgJj0gfkNCX0JSSURHRV9J
TlRSOw0KIAljb25maWdfd3JpdGV3KHNvY2tldCwgQ0JfQlJJREdFX0NPTlRS
T0wsIGJyaWRnZV9jdHJsKTsNCiANCi0JaWYgKHJlcXVlc3RfaXJxKHNvY2tl
dC0+Y2JfaXJxLCB5ZW50YV9wcm9iZV9oYW5kbGVyLCBTQV9TSElSUSwgInll
bnRhIiwgc29ja2V0KSkgew0KLQkJcHJpbnRrKEtFUk5fV0FSTklORyAiWWVu
dGE6IHJlcXVlc3RfaXJxKCkgaW4geWVudGFfcHJvYmVfY2JfaXJxKCkgZmFp
bGVkIVxuIik7DQotCQlyZXR1cm4gLTE7DQotCX0NCisJcmV0ID0geWVudGFf
cmVxdWVzdF9pcnEoc29ja2V0KTsNCisJaWYgKHJldD09LTEpDQorCQlyZXR1
cm4gcmV0Ow0KIA0KIAkvKiBnZW5lcmF0ZSBpbnRlcnJ1cHQsIHdhaXQgKi8N
CiAJZXhjYV93cml0ZWIoc29ja2V0LCBJMzY1X0NTQ0lOVCwgSTM2NV9DU0Nf
U1RTQ0hHKTsNCkBAIC0xMTAxLDYgKzExMTAsNyBAQCBzdGF0aWMgaW50IHll
bnRhX2Rldl9zdXNwZW5kIChzdHJ1Y3QgcGNpDQogCQlpZiAoc29ja2V0LT50
eXBlICYmIHNvY2tldC0+dHlwZS0+c2F2ZV9zdGF0ZSkNCiAJCQlzb2NrZXQt
PnR5cGUtPnNhdmVfc3RhdGUoc29ja2V0KTsNCiANCisJCWZyZWVfaXJxKGRl
di0+aXJxLCBzb2NrZXQpOw0KIAkJLyogRklYTUU6IHBjaV9zYXZlX3N0YXRl
IG5lZWRzIHRvIGhhdmUgYSBiZXR0ZXIgaW50ZXJmYWNlICovDQogCQlwY2lf
c2F2ZV9zdGF0ZShkZXYpOw0KIAkJcGNpX3JlYWRfY29uZmlnX2R3b3JkKGRl
diwgMTYqNCwgJnNvY2tldC0+c2F2ZWRfc3RhdGVbMF0pOw0KQEAgLTExMzEs
NiArMTE0MSw3IEBAIHN0YXRpYyBpbnQgeWVudGFfZGV2X3Jlc3VtZSAoc3Ry
dWN0IHBjaV8NCiAJCXBjaV93cml0ZV9jb25maWdfZHdvcmQoZGV2LCAxNyo0
LCBzb2NrZXQtPnNhdmVkX3N0YXRlWzFdKTsNCiAJCXBjaV9lbmFibGVfZGV2
aWNlKGRldik7DQogCQlwY2lfc2V0X21hc3RlcihkZXYpOw0KKwkJeWVudGFf
cmVxdWVzdF9pcnEoc29ja2V0KTsNCiANCiAJCWlmIChzb2NrZXQtPnR5cGUg
JiYgc29ja2V0LT50eXBlLT5yZXN0b3JlX3N0YXRlKQ0KIAkJCXNvY2tldC0+
dHlwZS0+cmVzdG9yZV9zdGF0ZShzb2NrZXQpOw0K

---913833367-1424312705-1122071600=:15287--
