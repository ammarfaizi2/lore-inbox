Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132530AbRDKIPb>; Wed, 11 Apr 2001 04:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132521AbRDKIPR>; Wed, 11 Apr 2001 04:15:17 -0400
Received: from [194.8.76.131] ([194.8.76.131]:23311 "HELO imap.camline.com")
	by vger.kernel.org with SMTP id <S132529AbRDKIOW>;
	Wed, 11 Apr 2001 04:14:22 -0400
Date: Wed, 11 Apr 2001 10:16:02 +0200 (CEST)
From: Matthias Hanisch <matze@camline.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] some new __init functions in general modules
Message-ID: <Pine.LNX.4.10.10104111013340.21412-200000@homer.camline.com>
Organization: camLine Datensysteme fuer die Mikroelektronik
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463781119-1986626035-986976962=:21412"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463781119-1986626035-986976962=:21412
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi!

The attached patch puts the following functions into the .text.init
section.

mcheck_init
        called by init_intel (initfunc)

init_irq_proc
        called by sysctl_init (initfunc)
        (already done for ARM, should be done for other archs, too)

start_context_thread
        called by do_basic_setup (initfunc)

init_timervecs
        called by sched_init (initfunc)


Patch is against 2.4.4pre1, to be included in the ac-series and in the
standard kernel.


Regards,
	Matze

-- 
Matthias Hanisch    mailto:matze@camline.com    phone: +49 8137 935-219

---1463781119-1986626035-986976962=:21412
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=init-kernel
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10104111016020.21412@homer.camline.com>
Content-Description: 
Content-Disposition: attachment; filename=init-kernel

ZGlmZiAtcnUgbGludXgtdmFuaWxsYS9hcmNoL2kzODYva2VybmVsL2JsdWVz
bW9rZS5jIGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwvYmx1ZXNtb2tlLmMNCi0t
LSBsaW51eC12YW5pbGxhL2FyY2gvaTM4Ni9rZXJuZWwvYmx1ZXNtb2tlLmMJ
U3VuIE1hciAyNSAxMToxMDozOSAyMDAxDQorKysgbGludXgvYXJjaC9pMzg2
L2tlcm5lbC9ibHVlc21va2UuYwlNb24gQXByICA5IDIyOjIyOjIwIDIwMDEN
CkBAIC01LDYgKzUsNyBAQA0KICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0K
ICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCiAjaW5jbHVkZSA8bGludXgv
c2NoZWQuaD4NCisjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KICNpbmNsdWRl
IDxhc20vcHJvY2Vzc29yLmg+IA0KICNpbmNsdWRlIDxhc20vbXNyLmg+DQog
DQpAQCAtNjYsNyArNjcsNyBAQA0KICAqCVRoaXMgaGFzIHRvIGJlIHJ1biBm
b3IgZWFjaCBwcm9jZXNzb3INCiAgKi8NCiAgDQotdm9pZCBtY2hlY2tfaW5p
dChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpDQordm9pZCBfX2luaXQgbWNoZWNr
X2luaXQoc3RydWN0IGNwdWluZm9feDg2ICpjKQ0KIHsNCiAJdTMyIGwsIGg7
DQogCWludCBpOw0KZGlmZiAtcnUgbGludXgtdmFuaWxsYS9hcmNoL2kzODYv
a2VybmVsL2lycS5jIGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwvaXJxLmMNCi0t
LSBsaW51eC12YW5pbGxhL2FyY2gvaTM4Ni9rZXJuZWwvaXJxLmMJU3VuIE1h
ciAyNSAxMToyMDo1NyAyMDAxDQorKysgbGludXgvYXJjaC9pMzg2L2tlcm5l
bC9pcnEuYwlTdW4gQXByICA4IDA5OjQzOjQ5IDIwMDENCkBAIC0xMTQ3LDcg
KzExNDcsNyBAQA0KIA0KIHVuc2lnbmVkIGxvbmcgcHJvZl9jcHVfbWFzayA9
IC0xOw0KIA0KLXZvaWQgaW5pdF9pcnFfcHJvYyAodm9pZCkNCit2b2lkIF9f
aW5pdCBpbml0X2lycV9wcm9jICh2b2lkKQ0KIHsNCiAJc3RydWN0IHByb2Nf
ZGlyX2VudHJ5ICplbnRyeTsNCiAJaW50IGk7DQpkaWZmIC1ydSBsaW51eC12
YW5pbGxhL2tlcm5lbC9jb250ZXh0LmMgbGludXgva2VybmVsL2NvbnRleHQu
Yw0KLS0tIGxpbnV4LXZhbmlsbGEva2VybmVsL2NvbnRleHQuYwlTdW4gTWFy
IDI1IDExOjE5OjAxIDIwMDENCisrKyBsaW51eC9rZXJuZWwvY29udGV4dC5j
CU1vbiBBcHIgIDkgMDg6MTc6MzMgMjAwMQ0KQEAgLTE0Niw3ICsxNDYsNyBA
QA0KIAlyZW1vdmVfd2FpdF9xdWV1ZSgmY29udGV4dF90YXNrX2RvbmUsICZ3
YWl0KTsNCiB9DQogCQ0KLWludCBzdGFydF9jb250ZXh0X3RocmVhZCh2b2lk
KQ0KK2ludCBfX2luaXQgc3RhcnRfY29udGV4dF90aHJlYWQodm9pZCkNCiB7
DQogCWtlcm5lbF90aHJlYWQoY29udGV4dF90aHJlYWQsIE5VTEwsIENMT05F
X0ZTIHwgQ0xPTkVfRklMRVMpOw0KIAlyZXR1cm4gMDsNCmRpZmYgLXJ1IGxp
bnV4LXZhbmlsbGEva2VybmVsL3RpbWVyLmMgbGludXgva2VybmVsL3RpbWVy
LmMNCi0tLSBsaW51eC12YW5pbGxhL2tlcm5lbC90aW1lci5jCVRodSBEZWMg
MjggMjE6Mzk6NTEgMjAwMA0KKysrIGxpbnV4L2tlcm5lbC90aW1lci5jCU1v
biBBcHIgIDkgMjI6MjI6MjEgMjAwMQ0KQEAgLTIyLDYgKzIyLDcgQEANCiAj
aW5jbHVkZSA8bGludXgvc21wX2xvY2suaD4NCiAjaW5jbHVkZSA8bGludXgv
aW50ZXJydXB0Lmg+DQogI2luY2x1ZGUgPGxpbnV4L2tlcm5lbF9zdGF0Lmg+
DQorI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4NCiANCiAjaW5jbHVkZSA8YXNt
L3VhY2Nlc3MuaD4NCiANCkBAIC0xMDMsNyArMTA0LDcgQEANCiANCiAjZGVm
aW5lIE5PT0ZfVFZFQ1MgKHNpemVvZih0dmVjcykgLyBzaXplb2YodHZlY3Nb
MF0pKQ0KIA0KLXZvaWQgaW5pdF90aW1lcnZlY3MgKHZvaWQpDQordm9pZCBf
X2luaXQgaW5pdF90aW1lcnZlY3MgKHZvaWQpDQogew0KIAlpbnQgaTsNCiAN
Cg==
---1463781119-1986626035-986976962=:21412--
