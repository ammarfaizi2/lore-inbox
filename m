Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280997AbRKLVRL>; Mon, 12 Nov 2001 16:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281007AbRKLVRA>; Mon, 12 Nov 2001 16:17:00 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:4968 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S280997AbRKLVQ2>; Mon, 12 Nov 2001 16:16:28 -0500
Date: Tue, 13 Nov 2001 08:27:00 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Jeronimo Pellegrini <pellegrini@mpcnet.com.br>
cc: Nils Philippsen <nils@wombat.dialup.fht-esslingen.de>, vojtech@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VIA timer fix was removed?
In-Reply-To: <20011112170026.A7310@socrates>
Message-ID: <Pine.LNX.4.05.10111130821580.3768-200000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="449546482-696495751-1005600420=:3768"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--449546482-696495751-1005600420=:3768
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 12 Nov 2001, Jeronimo Pellegrini wrote:

> > I have seen IBM machines (Netfinity 6000R) where this code got triggered
> > even though they didn't have VIA chipsets/timers. Seems to have caused
> > some problems there and I removed the code (in the custom kernel running
> > on those machines).
> 
> #ifdefs and a question in config, maybe?

Or a boot-time option to disable this fix?

Attached (untested) patch against 21.2.20 (which still has the $SUBJECT
code) should implement timer=no-via686a option to disable this.  Hopefully
I'll get it tested in the next day or two.

Regards,
Neale.

--449546482-696495751-1005600420=:3768
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="2.2.20-time.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.05.10111130827000.3768@marina.lowendale.com.au>
Content-Description: 
Content-Disposition: attachment; filename="2.2.20-time.diff"

LS0tIGxpbnV4LTIuMi4yMC1vcmlnL2FyY2gvaTM4Ni9rZXJuZWwvdGltZS5j
CU1vbiBNYXIgMjYgMDI6Mzc6MzAgMjAwMQ0KKysrIGxpbnV4LTIuMi4yMC1u
dGIvYXJjaC9pMzg2L2tlcm5lbC90aW1lLmMJU3VuIE5vdiAxMSAxOTozMzow
MiAyMDAxDQpAQCAtODEsNiArODEsOCBAQA0KIA0KIHNwaW5sb2NrX3QgcnRj
X2xvY2sgPSBTUElOX0xPQ0tfVU5MT0NLRUQ7DQogDQorc3RhdGljIGludAkJ
dmlhNjg2YV9oYWNrcyA9IDE7IC8qIGRlZmF1bHQgdG8gZW5hYmxlZCAqLw0K
Kw0KIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBkb19mYXN0X2dldHRp
bWVvZmZzZXQodm9pZCkNCiB7DQogCXJlZ2lzdGVyIHVuc2lnbmVkIGxvbmcg
ZWF4IGFzbSgiYXgiKTsNCkBAIC0xNzcsNyArMTc5LDcgQEANCiAJY291bnQg
fD0gaW5iX3AoMHg0MCkgPDwgODsNCiANCiAJLyogVklBNjg2YSB0ZXN0IGNv
ZGUuLi4gcmVzZXQgdGhlIGxhdGNoIGlmIGNvdW50ID4gbWF4ICovDQotIAlp
ZiAoY291bnQgPiBMQVRDSC0xKSB7DQorIAlpZiAoKHZpYTY4NmFfaGFja3Mp
ICYmIChjb3VudCA+IExBVENILTEpKSB7DQogCQlvdXRiX3AoMHgzNCwgMHg0
Myk7DQogCQlvdXRiX3AoTEFUQ0ggJiAweGZmLCAweDQwKTsNCiAJCW91dGIo
TEFUQ0ggPj4gOCwgMHg0MCk7DQpAQCAtNDgwLDE2ICs0ODIsMjEgQEANCiAJ
CS8qIFZJQTY4NmEgdGVzdCBjb2RlLi4uIHJlc2V0IHRoZSBsYXRjaCBpZiBj
b3VudCA+IG1heCAqLw0KIAkJaWYgKGNvdW50ID4gTEFUQ0gtMSkgew0KIAkJ
CXN0YXRpYyBpbnQgbGFzdF93aGluZTsNCi0JCQlvdXRiX3AoMHgzNCwgMHg0
Myk7DQotCQkJb3V0Yl9wKExBVENIICYgMHhmZiwgMHg0MCk7DQotCQkJb3V0
YihMQVRDSCA+PiA4LCAweDQwKTsNCi0JCQljb3VudCA9IExBVENIIC0gMTsN
Ci0JCQlpZih0aW1lX2FmdGVyKGppZmZpZXMsIGxhc3Rfd2hpbmUpKQ0KLQkJ
CXsNCisJCQlpZih0aW1lX2FmdGVyKGppZmZpZXMsIGxhc3Rfd2hpbmUpKSB7
DQogCQkJCXByaW50ayhLRVJOX1dBUk5JTkcgInByb2JhYmxlIGhhcmR3YXJl
IGJ1ZzogY2xvY2sgdGltZXIgY29uZmlndXJhdGlvbiBsb3N0IC0gcHJvYmFi
bHkgYSBWSUE2ODZhLlxuIik7DQotCQkJCXByaW50ayhLRVJOX1dBUk5JTkcg
InByb2JhYmxlIGhhcmR3YXJlIGJ1ZzogcmVzdG9yaW5nIGNoaXAgY29uZmln
dXJhdGlvbi5cbiIpOw0KKwkJCQlpZiAodmlhNjg2YV9oYWNrcykgew0KKwkJ
CQkJcHJpbnRrKEtFUk5fV0FSTklORyAicHJvYmFibGUgaGFyZHdhcmUgYnVn
OiByZXN0b3JpbmcgY2hpcCBjb25maWd1cmF0aW9uLlxuIik7DQorCQkJCX0g
ZWxzZSB7DQorCQkJCQlwcmludGsoS0VSTl9XQVJOSU5HICJwcm9iYWJsZSBo
YXJkd2FyZSBidWc6IGJ1dCBWSUE2ODZhIHdvcmthcm91bmQgZGlzYWJsZWQg
YXQgYm9vdC5cbiIpOw0KKwkJCQl9DQogCQkJCWxhc3Rfd2hpbmUgPSBqaWZm
aWVzICsgSFo7DQotCQkJfQkJCQ0KKwkJCX0NCisJCQlpZiAodmlhNjg2YV9o
YWNrcykgew0KKwkJCQlvdXRiX3AoMHgzNCwgMHg0Myk7DQorCQkJCW91dGJf
cChMQVRDSCAmIDB4ZmYsIDB4NDApOw0KKwkJCQlvdXRiKExBVENIID4+IDgs
IDB4NDApOw0KKwkJCQljb3VudCA9IExBVENIIC0gMTsNCisJCQl9DQogCQl9
CQ0KIA0KICNpZiAwDQpAQCAtNzM3LDMgKzc0NCwyNSBAQA0KIAlzZXR1cF94
ODZfaXJxKDAsICZpcnEwKTsNCiAjZW5kaWYNCiB9DQorDQorc3RhdGljIGlu
dCBfX2luaXQgdGltZXJfc2V0dXAoY2hhciAqc3RyKQ0KK3sNCisJaW50CWlu
dmVydDsNCisNCisJd2hpbGUgKChzdHIgIT0gTlVMTCkgJiYgKCpzdHIgIT0g
J1wwJykpIHsNCisJCWludmVydCA9IChzdHJuY21wKHN0ciwgIm5vLSIsIDMp
ID09IDApOw0KKwkJaWYgKGludmVydCkNCisJCQlzdHIgKz0gMzsNCisJCWlm
IChzdHJuY21wKHN0ciwgInZpYTY4NmEiLCA3KSA9PSAwKSB7DQorCQkJdmlh
Njg2YV9oYWNrcyA9ICFpbnZlcnQ7DQorCQkJaWYgKGludmVydCkNCisJCQkJ
cHJpbnRrKEtFUk5fSU5GTyAidGltZXI6IFZJQTY4NmEgd29ya2Fyb3VuZCBk
aXNhYmxlZC5cbiIpOw0KKwkJfQ0KKwkJc3RyID0gc3RyY2hyKHN0ciwgJywn
KTsNCisJCWlmIChzdHIgIT0gTlVMTCkNCisJCQlzdHIgKz0gc3Ryc3BuKHN0
ciwgIiwgXHQiKTsNCisJfQ0KKwlyZXR1cm4gMTsNCit9DQorDQorX19zZXR1
cCgidGltZXI9IiwgdGltZXJfc2V0dXApOw0K
--449546482-696495751-1005600420=:3768--
