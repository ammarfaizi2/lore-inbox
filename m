Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285422AbRLNRQh>; Fri, 14 Dec 2001 12:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285423AbRLNRQ1>; Fri, 14 Dec 2001 12:16:27 -0500
Received: from mx2.elte.hu ([157.181.151.9]:49557 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S285422AbRLNRQP>;
	Fri, 14 Dec 2001 12:16:15 -0500
Date: Fri, 14 Dec 2001 20:13:49 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>
Subject: [patch] mempool-2.5.1-D2
In-Reply-To: <Pine.LNX.4.33.0112141908420.12688-200000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0112142008520.14764-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1044705119-1008357229=:14764"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1044705119-1008357229=:14764
Content-Type: TEXT/PLAIN; charset=US-ASCII


Andrew Morton noticed another bug, run_tasklist() should not be called as
TASK_UNINTERRUPTIBLE. The attached patch fixes this.

	Ingo

--8323328-1044705119-1008357229=:14764
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="mempool-2.5.1-D2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0112142013490.14764@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="mempool-2.5.1-D2"

LS0tIGxpbnV4L21tL21lbXBvb2wuYy5vcmlnCUZyaSBEZWMgMTQgMTY6NTU6
MTIgMjAwMQ0KKysrIGxpbnV4L21tL21lbXBvb2wuYwlGcmkgRGVjIDE0IDE4
OjAzOjA3IDIwMDENCkBAIC0xNzYsNyArMTc2LDggQEANCiAgKg0KICAqIHRo
aXMgZnVuY3Rpb24gb25seSBzbGVlcHMgaWYgdGhlIGFsbG9jX2ZuIGZ1bmN0
aW9uIHNsZWVwcyBvcg0KICAqIHJldHVybnMgTlVMTC4gTm90ZSB0aGF0IGR1
ZSB0byBwcmVhbGxvY2F0aW9uLCB0aGlzIGZ1bmN0aW9uDQotICogKm5ldmVy
KiBmYWlscy4NCisgKiAqbmV2ZXIqIGZhaWxzIHdoZW4gY2FsbGVkIGZyb20g
cHJvY2VzcyBjb250ZXh0cy4gKGl0IG1pZ2h0DQorICogZmFpbCBpZiBjYWxs
ZWQgZnJvbSBhbiBJUlEgY29udGV4dC4pDQogICovDQogdm9pZCAqIG1lbXBv
b2xfYWxsb2MobWVtcG9vbF90ICpwb29sLCBpbnQgZ2ZwX21hc2spDQogew0K
QEAgLTE4NSw3ICsxODYsNyBAQA0KIAlzdHJ1Y3QgbGlzdF9oZWFkICp0bXA7
DQogCWludCBjdXJyX25yOw0KIAlERUNMQVJFX1dBSVRRVUVVRSh3YWl0LCBj
dXJyZW50KTsNCi0JaW50IGdmcF9ub3dhaXQgPSBnZnBfbWFzayAmIH5fX0dG
UF9XQUlUOw0KKwlpbnQgZ2ZwX25vd2FpdCA9IGdmcF9tYXNrICYgfihfX0dG
UF9XQUlUIHwgX19HRlBfSU8pOw0KIA0KIHJlcGVhdF9hbGxvYzoNCiAJZWxl
bWVudCA9IHBvb2wtPmFsbG9jKGdmcF9ub3dhaXQsIHBvb2wtPnBvb2xfZGF0
YSk7DQpAQCAtMTk2LDE1ICsxOTcsMTEgQEANCiAJICogSWYgdGhlIHBvb2wg
aXMgbGVzcyB0aGFuIDUwJSBmdWxsIHRoZW4gdHJ5IGhhcmRlcg0KIAkgKiB0
byBhbGxvY2F0ZSBhbiBlbGVtZW50Og0KIAkgKi8NCi0JaWYgKGdmcF9tYXNr
ICE9IGdmcF9ub3dhaXQpIHsNCi0JCWlmIChwb29sLT5jdXJyX25yIDw9IHBv
b2wtPm1pbl9uci8yKSB7DQotCQkJZWxlbWVudCA9IHBvb2wtPmFsbG9jKGdm
cF9tYXNrLCBwb29sLT5wb29sX2RhdGEpOw0KLQkJCWlmIChsaWtlbHkoZWxl
bWVudCAhPSBOVUxMKSkNCi0JCQkJcmV0dXJuIGVsZW1lbnQ7DQotCQl9DQot
CX0gZWxzZQ0KLQkJLyogd2UgbXVzdCBub3Qgc2xlZXAgKi8NCi0JCXJldHVy
biBOVUxMOw0KKwlpZiAoKGdmcF9tYXNrICE9IGdmcF9ub3dhaXQpICYmIChw
b29sLT5jdXJyX25yIDw9IHBvb2wtPm1pbl9uci8yKSkgew0KKwkJZWxlbWVu
dCA9IHBvb2wtPmFsbG9jKGdmcF9tYXNrLCBwb29sLT5wb29sX2RhdGEpOw0K
KwkJaWYgKGxpa2VseShlbGVtZW50ICE9IE5VTEwpKQ0KKwkJCXJldHVybiBl
bGVtZW50Ow0KKwl9DQogDQogCS8qDQogCSAqIEtpY2sgdGhlIFZNIGF0IHRo
aXMgcG9pbnQuDQpAQCAtMjE4LDE5ICsyMTUsMjUgQEANCiAJCWVsZW1lbnQg
PSB0bXA7DQogCQlwb29sLT5jdXJyX25yLS07DQogCQlzcGluX3VubG9ja19p
cnFyZXN0b3JlKCZwb29sLT5sb2NrLCBmbGFncyk7DQotDQogCQlyZXR1cm4g
ZWxlbWVudDsNCiAJfQ0KKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZwb29s
LT5sb2NrLCBmbGFncyk7DQorDQorCS8qIFdlIG11c3Qgbm90IHNsZWVwIGlu
IHRoZSBHRlBfQVRPTUlDIGNhc2UgKi8NCisJaWYgKGdmcF9tYXNrID09IGdm
cF9ub3dhaXQpDQorCQlyZXR1cm4gTlVMTDsNCisNCisJcnVuX3Rhc2tfcXVl
dWUoJnRxX2Rpc2spOw0KKw0KIAlhZGRfd2FpdF9xdWV1ZV9leGNsdXNpdmUo
JnBvb2wtPndhaXQsICZ3YWl0KTsNCiAJc2V0X3Rhc2tfc3RhdGUoY3VycmVu
dCwgVEFTS19VTklOVEVSUlVQVElCTEUpOw0KIA0KKwlzcGluX2xvY2tfaXJx
c2F2ZSgmcG9vbC0+bG9jaywgZmxhZ3MpOw0KIAljdXJyX25yID0gcG9vbC0+
Y3Vycl9ucjsNCiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG9vbC0+bG9j
aywgZmxhZ3MpOw0KIA0KLQlpZiAoIWN1cnJfbnIpIHsNCi0JCXJ1bl90YXNr
X3F1ZXVlKCZ0cV9kaXNrKTsNCisJaWYgKCFjdXJyX25yKQ0KIAkJc2NoZWR1
bGUoKTsNCi0JfQ0KIA0KIAljdXJyZW50LT5zdGF0ZSA9IFRBU0tfUlVOTklO
RzsNCiAJcmVtb3ZlX3dhaXRfcXVldWUoJnBvb2wtPndhaXQsICZ3YWl0KTsN
Cg==
--8323328-1044705119-1008357229=:14764--
