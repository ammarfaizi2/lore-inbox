Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVAXWTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVAXWTb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVAXWSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:18:34 -0500
Received: from mail.smartlink.ee ([213.180.16.242]:61575 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261682AbVAXWMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:12:37 -0500
Subject: Re: Trying to fix radeonfb suspending on IBM Thinkpad T41
From: Antti Andreimann <Antti.Andreimann@mail.ee>
To: Volker Braun <vbraun@physics.upenn.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1106600491.14176.21.camel@carrot.hep.upenn.edu>
References: <1106450704.10594.52.camel@localhost.localdomain>
	 <1106517245.10964.3.camel@carrot.hep.upenn.edu>
	 <1106528040.17621.7.camel@localhost.localdomain>
	 <1106537779.5069.2.camel@localhost.localdomain>
	 <1106552017.17621.13.camel@localhost.localdomain>
	 <1106600491.14176.21.camel@carrot.hep.upenn.edu>
Content-Type: multipart/mixed; boundary="=-5TzKF3pA3umCs619ObAb"
Date: Tue, 25 Jan 2005 00:12:32 +0200
Message-Id: <1106604752.17621.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5TzKF3pA3umCs619ObAb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=C3=9Chel kenal p=C3=A4eval (esmasp=C3=A4ev, 24. jaanuar 2005, 16:01-0500),=
 kirjutas
Volker Braun:
> Hi,
>=20
> This does the trick. In fact, i only need to get rid of the second
> OUTREG() call. No idea what that is good for. I'll update the bugzilla
> kernel entry with your patch and some additional information.

Ok, Great!

I have made another patch that disables this call altogether.
As far as I can understand it programs some registers that are related
to AGP clocking and according to some guys inside ATI, it is North
Bridge and Radeon chip dependent, but I don't know jack about ATI HW
programming so I might be seriously off here.
My laptop seems to do well without reprogramming this register and it
manages to crash Yours (and crashed mine with old driver) so I think it
should be left untouched until we get more information on how to do it
properly.

Can You please upload this patch to bugzilla instead?

If anyone tests the patch on some other thinkpad model please post it to
bugzilla so I we can get an impression how well it performs as well as
update the whitelist.

--=20
 Antti Andreimann - Security Expert
      Using Linux since 1993
  Member of ELUG since 29.01.2000

--=-5TzKF3pA3umCs619ObAb
Content-Disposition: attachment; filename=radeonfb-thinkpad-pm2.patch
Content-Type: text/x-patch; name=radeonfb-thinkpad-pm2.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi4xMS1yYzItdGFuay9kcml2ZXJzL3ZpZGVvL2F0eS9yYWRlb25fcG0uYy5v
cmlnCTIwMDUtMDEtMjQgMjM6NTI6MTcuMDAwMDAwMDAwICswMjAwDQorKysgbGludXgtMi42LjEx
LXJjMi10YW5rL2RyaXZlcnMvdmlkZW8vYXR5L3JhZGVvbl9wbS5jCTIwMDUtMDEtMjUgMDA6MDA6
MjQuMDAwMDAwMDAwICswMjAwDQpAQCAtMjUsOCArMjUsMzkgQEANCiAjaW5jbHVkZSA8YXNtL3Bt
YWNfZmVhdHVyZS5oPg0KICNlbmRpZg0KIA0KKy8qIEZvciBkZXRlY3Rpbmcgc3VwcG9ydGVkIFBD
IGxhcHRvcHMgKi8NCisjaWZkZWYgQ09ORklHX1g4Ng0KKyNpbmNsdWRlIDxsaW51eC9kbWkuaD4N
CisjZW5kaWYNCisNCiAjaW5jbHVkZSAiYXRpX2lkcy5oIg0KIA0KKyNpZmRlZiBDT05GSUdfWDg2
DQorLyogVGhpcyBhcnJheSBob2xkcyBhIGxpc3Qgb2Ygc3VwcG9ydGVkIFBDIGxhcHRvcHMuDQor
ICogQ3VycmVudGx5IG9ubHkgZmV3IElCTSBtb2RlbHMgYXJlIHRlc3RlZC4NCisgKiBJZiB5b3Ug
d2FudCB0byBleHBlcmltZW50LCB1c2UgZG1pZGVjb2RlIHRvIGZpbmQgb3V0DQorICogdmVuZG9y
IGFuZCBwcm9kdWN0IGNvZGVzIGZvciBZb3VyIGxhcHRvcC4NCisgKi8NCitzdGF0aWMgc3RydWN0
IGRtaV9zeXN0ZW1faWQgX19kZXZpbml0ZGF0YSByYWRlb25mYl9kbWlfdGFibGVbXSA9IHsNCisJ
ew0KKwkJLmlkZW50ID0gIklCTSBUaGlua1BhZCBUNDEgKDIzNzMtMkZHKSIsDQorCQkubWF0Y2hl
cyA9IHsNCisJCQlETUlfTUFUQ0goRE1JX1NZU19WRU5ET1IsICJJQk0iKSwNCisJCQlETUlfTUFU
Q0goRE1JX1BST0RVQ1RfTkFNRSwgIjIzNzMyRkciKSwNCisJCX0sDQorCX0sDQorCXsNCisJCS8q
IFJlcG9ydGVkIGJ5IFZvbGtlciBCcmF1biA8dmJyYXVuQHBoeXNpY3MudXBlbm4uZWR1PiAqLw0K
KwkJLmlkZW50ID0gIklCTSBUaGlua1BhZCBUNDEgKDIzNzktREpVKSIsDQorCQkubWF0Y2hlcyA9
IHsNCisJCQlETUlfTUFUQ0goRE1JX1NZU19WRU5ET1IsICJJQk0iKSwNCisJCQlETUlfTUFUQ0go
RE1JX1BST0RVQ1RfTkFNRSwgIjIzNzlESlUiKSwNCisJCX0sDQorCX0sDQorCXsgfSwNCit9Ow0K
KyNlbmRpZg0KKw0KIHZvaWQgcmFkZW9uX3BtX2Rpc2FibGVfZHluYW1pY19tb2RlKHN0cnVjdCBy
YWRlb25mYl9pbmZvICpyaW5mbykNCiB7DQogCXUzMiB0bXA7DQpAQCAtODUzLDYgKzg4NCwxMyBA
QA0KIAl0bXAgPSBJTlBMTCggcGxsTUNMS19NSVNDKSB8IE1DTEtfTUlTQ19fRU5fTUNMS19UUklT
VEFURV9JTl9TVVNQRU5EOw0KIAlPVVRQTEwoIHBsbE1DTEtfTUlTQywgdG1wKTsNCiANCisJLyog
QlVTX0NOVEwxX19NT0JJTEVfUExBVE9STV9TRUwgc2V0dGluZyBpcyBub3J0aGJyaWRnZSBjaGlw
c2V0DQorCSAqIGFuZCByYWRlb24gY2hpcCBkZXBlbmRlbnQuIFRodXMgd2Ugb25seSBlbmFibGUg
aXQgb24gTWFjIGZvcg0KKwkgKiBub3cgKHVudGlsIHdlIGdldCBtb3JlIGluZm8gb24gaG93IHRv
IGNvbXB1dGUgdGhlIGNvcnJlY3QgDQorCSAqIHZhbHVlIGZvciB2YXJpb3VzIFg4NiBicmlkZ2Vz
KS4NCisJICovDQorDQorI2lmZGVmIENPTkZJR19QUENfUE1BQw0KIAkvKiBBR1AgUExMIGNvbnRy
b2wgKi8NCiAJaWYgKHJpbmZvLT5mYW1pbHkgPD0gQ0hJUF9GQU1JTFlfUlYyODApIHsNCiAJCU9V
VFJFRyhCVVNfQ05UTDEsIElOUkVHKEJVU19DTlRMMSkgfCAgQlVTX0NOVEwxX19BR1BDTEtfVkFM
SUQpOw0KQEAgLTg2NCw2ICs5MDIsNyBAQA0KIAkJT1VUUkVHKEJVU19DTlRMMSwgSU5SRUcoQlVT
X0NOVEwxKSk7DQogCQlPVVRSRUcoQlVTX0NOVEwxLCAoSU5SRUcoQlVTX0NOVEwxKSAmIH4weDQw
MDApIHwgMHg4MDAwKTsNCiAJfQ0KKyNlbmRpZg0KIA0KIAlPVVRSRUcoQ1JUQ19PRkZTRVRfQ05U
TCwgKElOUkVHKENSVENfT0ZGU0VUX0NOVEwpDQogCQkJCSAgJiB+Q1JUQ19PRkZTRVRfQ05UTF9f
Q1JUQ19TVEVSRU9fU1lOQ19PVVRfRU4pKTsNCkBAIC0yNzQ4LDYgKzI3ODcsMjQgQEANCiAJCU9V
VFJFRyhUVl9EQUNfQ05UTCwgSU5SRUcoVFZfREFDX0NOVEwpIHwgMHgwNzAwMDAwMCk7DQogCX0N
CiAjZW5kaWYgLyogZGVmaW5lZChDT05GSUdfUE0pICYmIGRlZmluZWQoQ09ORklHX1BQQ19PRikg
Ki8NCisNCisvKiBUaGUgUE0gY29kZSBhbHNvIHdvcmtzIG9uIHNvbWUgUEMgbGFwdG9wcy4NCisg
KiBPbmx5IGEgZmV3IG1vZGVscyBhcmUgYWN0dWFsbHkgdGVzdGVkIHNvIFlvdXIgbWlsZWFnZSBt
YXkgdmFyeS4NCisgKiBXZSBjYW4gZG8gRDIgb24gYXQgbGVhc3QgTTcgYW5kIE05IG9uIHNvbWUg
SUJNIFRoaW5rUGFkIFQ0MSBtb2RlbHMuDQorICovDQorI2lmIGRlZmluZWQoQ09ORklHX1BNKSAm
JiBkZWZpbmVkKENPTkZJR19YODYpDQorCWlmIChkbWlfY2hlY2tfc3lzdGVtKHJhZGVvbmZiX2Rt
aV90YWJsZSkpIHsNCisJCWlmIChyaW5mby0+aXNfbW9iaWxpdHkgJiYgcmluZm8tPnBtX3JlZyAm
Jg0KKwkJICAgIHJpbmZvLT5mYW1pbHkgPD0gQ0hJUF9GQU1JTFlfUlYyNTApDQorCQkJcmluZm8t
PnBtX21vZGUgfD0gcmFkZW9uX3BtX2QyOw0KKw0KKwkJLyogUG93ZXIgZG93biBUViBEQUMsIHRo
YXQgc2F2ZXMgYSBzaWduaWZpY2FudCBhbW91bnQgb2YgcG93ZXIsDQorCQkgKiB3ZSdsbCBoYXZl
IHNvbWV0aGluZyBiZXR0ZXIgb25jZSB3ZSBhY3R1YWxseSBoYXZlIHNvbWUgVFZPdXQNCisJCSAq
IHN1cHBvcnQNCisJCSAqLw0KKwkJT1VUUkVHKFRWX0RBQ19DTlRMLCBJTlJFRyhUVl9EQUNfQ05U
TCkgfCAweDA3MDAwMDAwKTsNCisJfQ0KKyNlbmRpZiAvKiBkZWZpbmVkKENPTkZJR19QTSkgJiYg
ZGVmaW5lZChDT05GSUdfWDg2KSAqLw0KIH0NCiANCiB2b2lkIHJhZGVvbmZiX3BtX2V4aXQoc3Ry
dWN0IHJhZGVvbmZiX2luZm8gKnJpbmZvKQ0K


--=-5TzKF3pA3umCs619ObAb--
