Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUCRG4p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 01:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUCRG4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 01:56:45 -0500
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:37277 "HELO
	trinity-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S262431AbUCRG4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 01:56:40 -0500
X-qfilter-stat: ok
X-Analyze: Velop Mail Shield v0.0.4
X-Velop-Vscan: no virus detected
X-Inova-Extscan: attachments authorized
Date: Thu, 18 Mar 2004 03:56:35 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: Peter Williams <peterw@aurema.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: XFree86 seems to be being wrongly accused of doing the wrong
 thing
In-Reply-To: <40593015.9090507@aurema.com>
Message-ID: <Pine.LNX.4.58.0403180346000.1276@pervalidus.dyndns.org>
References: <40593015.9090507@aurema.com>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1523601490-1079592995=:1276"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-1523601490-1079592995=:1276
Content-Type: TEXT/PLAIN; charset=US-ASCII

Wrongly ? I don't think so, as it has presumably been fixed in
XFree86 after 4.4.0.

http://www.xfree86.org/cvs/changes.html:

6. Do the Linux KDKBDREP ioctl on the correct fd.  This
prevents the fallback that tries to directly program the
keyboard repeat rate, and the related warning messages that
recent Linux kernels generate (David Dawes).

I'm attaching the patch I extracted from CVS.

Vojtech, what about adding such information to your HOWTO ? And
better, adding the URL to atkbd.c, so people stop reporting it.

On Thu, 18 Mar 2004, Peter Williams wrote:

> With 2.6.4 I'm getting the following messages very early in the boot
> long before XFree86 is started:
>
> Mar 18 16:05:31 mudlark kernel: atkbd.c: Unknown key released
> (translated set 2, code 0x7a on isa0060/serio0).
> Mar 18 16:05:31 mudlark kernel: atkbd.c: This is an XFree86 bug. It
> shouldn't access hardware directly.
>
> They are repeated 6 times and are NOT the result of any keys being
> pressed or released.

-- 
http://www.pervalidus.net/contact.html
--0-1523601490-1079592995=:1276
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="KDKBDREP-xc.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0403180356350.1276@pervalidus.dyndns.org>
Content-Description: 
Content-Disposition: attachment; filename="KDKBDREP-xc.diff"

SW5kZXg6IHhjL3Byb2dyYW1zL1hzZXJ2ZXIvaHcveGZyZWU4Ni9vcy1zdXBw
b3J0L2xpbnV4L2xueF9pby5jDQpkaWZmIC11IHhjL3Byb2dyYW1zL1hzZXJ2
ZXIvaHcveGZyZWU4Ni9vcy1zdXBwb3J0L2xpbnV4L2xueF9pby5jOjMuMjYg
eGMvcHJvZ3JhbXMvWHNlcnZlci9ody94ZnJlZTg2L29zLXN1cHBvcnQvbGlu
dXgvbG54X2lvLmM6My4yNw0KLS0tIHhjL3Byb2dyYW1zL1hzZXJ2ZXIvaHcv
eGZyZWU4Ni9vcy1zdXBwb3J0L2xpbnV4L2xueF9pby5jOjMuMjYJTW9uIE5v
diAxNyAyMjoyMDo0MSAyMDAzDQorKysgeGMvcHJvZ3JhbXMvWHNlcnZlci9o
dy94ZnJlZTg2L29zLXN1cHBvcnQvbGludXgvbG54X2lvLmMJV2VkIE1hciAg
MyAxODo1Mzo0MSAyMDA0DQpAQCAtMSw0ICsxLDQgQEANCi0vKiAkWEZyZWU4
NjogeGMvcHJvZ3JhbXMvWHNlcnZlci9ody94ZnJlZTg2L29zLXN1cHBvcnQv
bGludXgvbG54X2lvLmMsdiAzLjI2IDIwMDMvMTEvMTcgMjI6MjA6NDEgZGF3
ZXMgRXhwICQgKi8NCisvKiAkWEZyZWU4NjogeGMvcHJvZ3JhbXMvWHNlcnZl
ci9ody94ZnJlZTg2L29zLXN1cHBvcnQvbGludXgvbG54X2lvLmMsdiAzLjI3
IDIwMDQvMDMvMDMgMTg6NTM6NDEgZGF3ZXMgRXhwICQgKi8NCiAvKg0KICAq
IENvcHlyaWdodCAxOTkyIGJ5IE9yZXN0IFpib3Jvd3NraSA8b2J6QEtvZGFr
LmNvbT4NCiAgKiBDb3B5cmlnaHQgMTk5MyBieSBEYXZpZCBEYXdlcyA8ZGF3
ZXNAeGZyZWU4Ni5vcmc+DQpAQCAtODEsNyArODEsNyBAQA0KICNlbmRpZg0K
IA0KIHN0YXRpYyBpbnQNCi1LREtCRFJFUF9pb2N0bF9vayhpbnQgcmF0ZSwg
aW50IGRlbGF5KSB7DQorS0RLQkRSRVBfaW9jdGxfb2soaW50IGZkLCBpbnQg
cmF0ZSwgaW50IGRlbGF5KSB7DQogI2lmIGRlZmluZWQoS0RLQkRSRVApICYm
ICFkZWZpbmVkKF9fc3BhcmNfXykNCiAgICAgIC8qIFRoaXMgaW9jdGwgaXMg
ZGVmaW5lZCBpbiA8bGludXgva2QuaD4gYnV0IGlzIG5vdA0KIAlpbXBsZW1l
bnRlZCBhbnl3aGVyZSAtIG11c3QgYmUgaW4gc29tZSBtNjhrIHBhdGNoZXMu
ICovDQpAQCAtOTAsNyArOTAsNyBAQA0KICAgIC8qIGRvbid0IGNoYW5nZSwg
anVzdCB0ZXN0ICovDQogICAga2JkcmVwX3MucmF0ZSA9IC0xOw0KICAgIGti
ZHJlcF9zLmRlbGF5ID0gLTE7DQotICAgaWYgKGlvY3RsKCAwLCBLREtCRFJF
UCwgJmtiZHJlcF9zICkpIHsNCisgICBpZiAoaW9jdGwoIGZkLCBLREtCRFJF
UCwgJmtiZHJlcF9zICkpIHsNCiAgICAgICAgcmV0dXJuIDA7DQogICAgfQ0K
IA0KQEAgLTEwNSw3ICsxMDUsNyBAQA0KICAgIGlmIChrYmRyZXBfcy5kZWxh
eSA8IDEpDQogICAgICBrYmRyZXBfcy5kZWxheSA9IDE7DQogICAgDQotICAg
aWYgKGlvY3RsKCAwLCBLREtCRFJFUCwgJmtiZHJlcF9zICkpIHsNCisgICBp
ZiAoaW9jdGwoIGZkLCBLREtCRFJFUCwgJmtiZHJlcF9zICkpIHsNCiAgICAg
IHJldHVybiAwOw0KICAgIH0NCiANCkBAIC0xNzQsNyArMTc0LDcgQEANCiAg
ICAgZGVsYXkgPSB4Zjg2SW5mby5rYmREZWxheTsNCiANCiANCi0gIGlmKEtE
S0JEUkVQX2lvY3RsX29rKHJhdGUsIGRlbGF5KSkgCS8qIG02OGs/ICovDQor
ICBpZihLREtCRFJFUF9pb2N0bF9vayh4Zjg2SW5mby5jb25zb2xlRmQsIHJh
dGUsIGRlbGF5KSkgCS8qIG02OGs/ICovDQogICAgIHJldHVybjsNCiANCiAg
IGlmKEtJT0NTUkFURV9pb2N0bF9vayhyYXRlLCBkZWxheSkpCS8qIHNwYXJj
PyAqLw0KSW5kZXg6IHhjL3Byb2dyYW1zL1hzZXJ2ZXIvaHcveGZyZWU4Ni9v
cy1zdXBwb3J0L2xpbnV4L2xueF9rYmQuYw0KZGlmZiAtdSB4Yy9wcm9ncmFt
cy9Yc2VydmVyL2h3L3hmcmVlODYvb3Mtc3VwcG9ydC9saW51eC9sbnhfa2Jk
LmM6MS41IHhjL3Byb2dyYW1zL1hzZXJ2ZXIvaHcveGZyZWU4Ni9vcy1zdXBw
b3J0L2xpbnV4L2xueF9rYmQuYzoxLjYNCi0tLSB4Yy9wcm9ncmFtcy9Yc2Vy
dmVyL2h3L3hmcmVlODYvb3Mtc3VwcG9ydC9saW51eC9sbnhfa2JkLmM6MS41
CVR1ZSBOb3YgIDQgMDM6MTQ6MzkgMjAwMw0KKysrIHhjL3Byb2dyYW1zL1hz
ZXJ2ZXIvaHcveGZyZWU4Ni9vcy1zdXBwb3J0L2xpbnV4L2xueF9rYmQuYwlX
ZWQgTWFyICAzIDE4OjUzOjQxIDIwMDQNCkBAIC0xLDQgKzEsNCBAQA0KLS8q
ICRYRnJlZTg2OiB4Yy9wcm9ncmFtcy9Yc2VydmVyL2h3L3hmcmVlODYvb3Mt
c3VwcG9ydC9saW51eC9sbnhfa2JkLmMsdiAxLjUgMjAwMy8xMS8wNCAwMzox
NDozOSB0c2kgRXhwICQgKi8NCisvKiAkWEZyZWU4NjogeGMvcHJvZ3JhbXMv
WHNlcnZlci9ody94ZnJlZTg2L29zLXN1cHBvcnQvbGludXgvbG54X2tiZC5j
LHYgMS42IDIwMDQvMDMvMDMgMTg6NTM6NDEgZGF3ZXMgRXhwICQgKi8NCiAN
CiAvKg0KICAqIENvcHlyaWdodCAoYykgMjAwMiBieSBUaGUgWEZyZWU4NiBQ
cm9qZWN0LCBJbmMuDQpAQCAtMTA4LDcgKzEwOCw3IEBADQogI2VuZGlmDQog
DQogc3RhdGljIGludA0KLUtES0JEUkVQX2lvY3RsX29rKGludCByYXRlLCBp
bnQgZGVsYXkpIHsNCitLREtCRFJFUF9pb2N0bF9vayhpbnQgZmQsIGludCBy
YXRlLCBpbnQgZGVsYXkpIHsNCiAjaWYgZGVmaW5lZChLREtCRFJFUCkgJiYg
IWRlZmluZWQoX19zcGFyY19fKQ0KICAgICAgLyogVGhpcyBpb2N0bCBpcyBk
ZWZpbmVkIGluIDxsaW51eC9rZC5oPiBidXQgaXMgbm90DQogCWltcGxlbWVu
dGVkIGFueXdoZXJlIC0gbXVzdCBiZSBpbiBzb21lIG02OGsgcGF0Y2hlcy4g
Ki8NCkBAIC0xMTcsNyArMTE3LDcgQEANCiAgICAvKiBkb24ndCBjaGFuZ2Us
IGp1c3QgdGVzdCAqLw0KICAgIGtiZHJlcF9zLnJhdGUgPSAtMTsNCiAgICBr
YmRyZXBfcy5kZWxheSA9IC0xOw0KLSAgIGlmIChpb2N0bCggMCwgS0RLQkRS
RVAsICZrYmRyZXBfcyApKSB7DQorICAgaWYgKGlvY3RsKCBmZCwgS0RLQkRS
RVAsICZrYmRyZXBfcyApKSB7DQogICAgICAgIHJldHVybiAwOw0KICAgIH0N
CiANCkBAIC0xMzIsNyArMTMyLDcgQEANCiAgICBpZiAoa2JkcmVwX3MuZGVs
YXkgPCAxKQ0KICAgICAga2JkcmVwX3MuZGVsYXkgPSAxOw0KICAgIA0KLSAg
IGlmIChpb2N0bCggMCwgS0RLQkRSRVAsICZrYmRyZXBfcyApKSB7DQorICAg
aWYgKGlvY3RsKCBmZCwgS0RLQkRSRVAsICZrYmRyZXBfcyApKSB7DQogICAg
ICByZXR1cm4gMDsNCiAgICB9DQogDQpAQCAtMjAwLDcgKzIwMCw3IEBADQog
ICBpZiAocEtiZC0+ZGVsYXkgPj0gMCkNCiAgICAgZGVsYXkgPSBwS2JkLT5k
ZWxheTsNCiANCi0gIGlmKEtES0JEUkVQX2lvY3RsX29rKHJhdGUsIGRlbGF5
KSkgCS8qIG02OGs/ICovDQorICBpZihLREtCRFJFUF9pb2N0bF9vayhwSW5m
by0+ZmQsIHJhdGUsIGRlbGF5KSkgCS8qIG02OGs/ICovDQogICAgIHJldHVy
bjsNCiANCiAgIGlmKEtJT0NTUkFURV9pb2N0bF9vayhyYXRlLCBkZWxheSkp
CS8qIHNwYXJjPyAqLw0K

--0-1523601490-1079592995=:1276--
