Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUEGBni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUEGBni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 21:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUEGBnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 21:43:37 -0400
Received: from fmr01.intel.com ([192.55.52.18]:52626 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262382AbUEGBnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 21:43:32 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C433D4.3F01F916"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] mxcsr patch for i386 & x86-64
Date: Thu, 6 May 2004 18:40:15 -0700
Message-ID: <E305A4AFB7947540BC487567B5449BA802D798AB@scsmsx402.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mxcsr patch for i386 & x86-64
Thread-Index: AcQyqryVXyOSXEOaSWqYGJq/Dy/7SwA7uw+AAAnlHVA=
From: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
To: "Kamble, Nitin A" <nitin.a.kamble@intel.com>,
       "Pavel Machek" <pavel@ucw.cz>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
X-OriginalArrivalTime: 07 May 2004 01:40:16.0261 (UTC) FILETIME=[3F60D350:01C433D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C433D4.3F01F916
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Pavel,
  The test for suspend & resume has passed.=20

One more patch to be applied on top of the previous patch is attached.
It cleans up the duplicate code, as per Jeff's suggestion.

Thanks & Regards,
Nitin
------------------------------------------------------------------------
-

>-----Original Message-----
>From: Kamble, Nitin A
>Sent: Thursday, May 06, 2004 2:01 PM
>To: 'Pavel Machek'; Linus Torvalds
>Cc: Andrew Morton; linux-kernel@vger.kernel.org; Nakajima, Jun;
Mallick,
>Asit K; Saxena, Sunil
>Subject: RE: [PATCH] mxcsr patch for i386 & x86-64
>
>>i386/kernel/power/cpu.c now probably wants fpu_init, too...
>
>Hi Pavel,
>   I have updated the mxcsr patch to also enable it at the time of
resume.
>Please find the patch attached.
>  fpu_init() is needed in the resume path, only if the user want to
change
>the cpu between suspend and resume. Otherwise the mxcsr_features_mask
>calculated earlier will still be valid.
>	Also for changing the cpu, the user will need to shutdown the
system,
>so it is useful for S4 (suspend to disk) state.
>  I am testing the patch. Meanwhile please let me know if these changes
are
>ok for you?
>
>Thanks & Regards,
>Nitin

------_=_NextPart_001_01C433D4.3F01F916
Content-Type: application/octet-stream;
	name="mxcsr_shared.patch"
Content-Transfer-Encoding: base64
Content-Description: mxcsr_shared.patch
Content-Disposition: attachment;
	filename="mxcsr_shared.patch"

LS0tIDIuNi42LXJjMy9hcmNoL2kzODYva2VybmVsL01ha2VmaWxlLm9yaWcJMjAwNC0wNS0wNiAx
Nzo1NzoxMC4wMDAwMDAwMDAgLTA3MDAKKysrIDIuNi42LXJjMy9hcmNoL2kzODYva2VybmVsL01h
a2VmaWxlCTIwMDQtMDUtMDYgMTg6MDY6MzAuMDAwMDAwMDAwIC0wNzAwCkBAIC02LDggKzYsOCBA
QAogCiBvYmoteQk6PSBwcm9jZXNzLm8gc2VtYXBob3JlLm8gc2lnbmFsLm8gZW50cnkubyB0cmFw
cy5vIGlycS5vIHZtODYubyBcCiAJCXB0cmFjZS5vIGk4MjU5Lm8gaW9wb3J0Lm8gbGR0Lm8gc2V0
dXAubyB0aW1lLm8gc3lzX2kzODYubyBcCi0JCXBjaS1kbWEubyBpMzg2X2tzeW1zLm8gaTM4Ny5v
IGRtaV9zY2FuLm8gYm9vdGZsYWcubyBcCi0JCWRvdWJsZWZhdWx0Lm8KKwkJcGNpLWRtYS5vIGkz
ODZfa3N5bXMubyBpMzg3Lm8gaTM4N19zaGFyZWQubyBkbWlfc2Nhbi5vIFwKKwkJYm9vdGZsYWcu
byBkb3VibGVmYXVsdC5vCiAKIG9iai15CQkJCSs9IGNwdS8KIG9iai15CQkJCSs9IHRpbWVycy8K
LS0tIC9kZXYvbnVsbAkyMDAzLTA5LTIzIDE1OjE5OjMyLjAwMDAwMDAwMCAtMDcwMAorKysgMi42
LjYtcmMzL2FyY2gvaTM4Ni9rZXJuZWwvaTM4N19zaGFyZWQuYwkyMDA0LTA1LTA2IDE4OjEyOjA5
LjAwMDAwMDAwMCAtMDcwMApAQCAtMCwwICsxLDI5IEBACisvKgorICogbGludXgvYXJjaC9pMzg2
L2tlcm5lbC9pMzg3X3NoYXJlZC5jCisgKgorICogVGFraW5nIHRoZSBhcmNoaWN0dXJlIHNoYXJl
ZCBteGNzciBmdW5jdGlvbmFsaXR5IG91dCBmcm9tIGkzODcuYyAKKyAqIHRvIHRoaXMgaTM4N19z
aGFyZWQuYy4oNnRoIE1heSAyMDA0KQorICogIE5pdGluIEthbWJsZSA8bml0aW4uYS5rYW1ibGVA
aW50ZWwuY29tPiAKKyAqLworCisjaW5jbHVkZSA8YXNtL3R5cGVzLmg+CisjaW5jbHVkZSA8YXNt
L3N5c3RlbS5oPgorI2luY2x1ZGUgPGFzbS9wcm9jZXNzb3IuaD4KKyNpbmNsdWRlIDxhc20vc3Ry
aW5nLmg+CisjaW5jbHVkZSA8bGludXgvc2NoZWQuaD4KKwordTMyIG14Y3NyX2ZlYXR1cmVfbWFz
ayA9IDB4ZmZmZmZmZmY7CisKK3ZvaWQgbXhjc3JfZmVhdHVyZV9tYXNrX2luaXQodm9pZCkKK3sK
Kwl1MzIgbWFzayA9IDA7CisJY2x0cygpOworCWlmIChjcHVfaGFzX2Z4c3IpIHsKKwkJbWVtc2V0
KCZjdXJyZW50LT50aHJlYWQuaTM4Ny5meHNhdmUsIDAsIHNpemVvZihzdHJ1Y3QgaTM4N19meHNh
dmVfc3RydWN0KSk7CisJCWFzbSB2b2xhdGlsZSgiZnhzYXZlICUwIiA6IDogIm0iIChjdXJyZW50
LT50aHJlYWQuaTM4Ny5meHNhdmUpKTsgCisJCW1hc2sgPSBjdXJyZW50LT50aHJlYWQuaTM4Ny5m
eHNhdmUubXhjc3JfbWFzazsKKwkJaWYgKG1hc2sgPT0gMCkgbWFzayA9IDB4MDAwMGZmYmY7CisJ
fSAKKwlteGNzcl9mZWF0dXJlX21hc2sgJj0gbWFzazsKKwlzdHRzKCk7Cit9Ci0tLSAyLjYuNi1y
YzMvYXJjaC9pMzg2L2tlcm5lbC9pMzg3LmMub3JpZwkyMDA0LTA1LTA2IDE3OjU3OjE2LjAwMDAw
MDAwMCAtMDcwMAorKysgMi42LjYtcmMzL2FyY2gvaTM4Ni9rZXJuZWwvaTM4Ny5jCTIwMDQtMDUt
MDYgMTg6MDY6MzAuMDAwMDAwMDAwIC0wNzAwCkBAIC0yNCwyMiArMjQsNiBAQAogI2RlZmluZSBI
QVZFX0hXRlAgMQogI2VuZGlmCiAKLXVuc2lnbmVkIGxvbmcgbXhjc3JfZmVhdHVyZV9tYXNrID0g
MHhmZmZmZmZmZjsKLQotdm9pZCBteGNzcl9mZWF0dXJlX21hc2tfaW5pdCh2b2lkKQotewotCXVu
c2lnbmVkIGxvbmcgbWFzayA9IDA7Ci0JY2x0cygpOwotCWlmIChjcHVfaGFzX2Z4c3IpIHsKLQkJ
bWVtc2V0KCZjdXJyZW50LT50aHJlYWQuaTM4Ny5meHNhdmUsIDAsIHNpemVvZihzdHJ1Y3QgaTM4
N19meHNhdmVfc3RydWN0KSk7Ci0JCWFzbSB2b2xhdGlsZSgiZnhzYXZlICUwIiA6IDogIm0iIChj
dXJyZW50LT50aHJlYWQuaTM4Ny5meHNhdmUpKTsgCi0JCW1hc2sgPSBjdXJyZW50LT50aHJlYWQu
aTM4Ny5meHNhdmUubXhjc3JfbWFzazsKLQkJaWYgKG1hc2sgPT0gMCkgbWFzayA9IDB4MDAwMGZm
YmY7Ci0JfSAKLQlteGNzcl9mZWF0dXJlX21hc2sgJj0gbWFzazsKLQlzdHRzKCk7Ci19Ci0KIC8q
CiAgKiBUaGUgX2N1cnJlbnRfIHRhc2sgaXMgdXNpbmcgdGhlIEZQVSBmb3IgdGhlIGZpcnN0IHRp
bWUKICAqIHNvIGluaXRpYWxpemUgaXQgYW5kIHNldCB0aGUgbXhjc3IgdG8gaXRzIGRlZmF1bHQK
LS0tIDIuNi42LXJjMy9hcmNoL3g4Nl82NC9rZXJuZWwvTWFrZWZpbGUub3JpZwkyMDA0LTA1LTA2
IDE3OjU3OjE4LjAwMDAwMDAwMCAtMDcwMAorKysgMi42LjYtcmMzL2FyY2gveDg2XzY0L2tlcm5l
bC9NYWtlZmlsZQkyMDA0LTA1LTA2IDE4OjA2OjMwLjAwMDAwMDAwMCAtMDcwMApAQCAtNiw3ICs2
LDcgQEAKIEVYVFJBX0FGTEFHUwk6PSAtdHJhZGl0aW9uYWwKIG9iai15CTo9IHByb2Nlc3MubyBz
ZW1hcGhvcmUubyBzaWduYWwubyBlbnRyeS5vIHRyYXBzLm8gaXJxLm8gXAogCQlwdHJhY2UubyBp
ODI1OS5vIGlvcG9ydC5vIGxkdC5vIHNldHVwLm8gdGltZS5vIHN5c194ODZfNjQubyBcCi0JCXg4
NjY0X2tzeW1zLm8gaTM4Ny5vIHN5c2NhbGwubyB2c3lzY2FsbC5vIFwKKwkJeDg2NjRfa3N5bXMu
byBpMzg3Lm8gaTM4N19zaGFyZWQubyBzeXNjYWxsLm8gdnN5c2NhbGwubyBcCiAJCXNldHVwNjQu
byBib290ZmxhZy5vIGU4MjAubyByZWJvb3QubyB3YXJtcmVib290Lm8KIG9iai15ICs9IG1jZS5v
IGFjcGkvCiAKQEAgLTM1LDMgKzM1LDQgQEAKIHRvcG9sb2d5LXkgICAgICAgICAgICAgICAgICAg
ICArPSAuLi8uLi9pMzg2L21hY2gtZGVmYXVsdC90b3BvbG9neS5vCiBzd2lvdGxiLSQoQ09ORklH
X1NXSU9UTEIpICAgICAgKz0gLi4vLi4vaWE2NC9saWIvc3dpb3RsYi5vCiBtaWNyb2NvZGUtJChz
dWJzdCBtLHksJChDT05GSUdfTUlDUk9DT0RFKSkgICs9IC4uLy4uL2kzODYva2VybmVsL21pY3Jv
Y29kZS5vCitpMzg3X3NoYXJlZC15ICAgICAgICAgICAgICAgICAgKz0gLi4vLi4vaTM4Ni9rZXJu
ZWwvaTM4N19zaGFyZWQubwotLS0gMi42LjYtcmMzL2FyY2gveDg2XzY0L2tlcm5lbC9pMzg3LmMu
b3JpZwkyMDA0LTA1LTA2IDE3OjU3OjE5LjAwMDAwMDAwMCAtMDcwMAorKysgMi42LjYtcmMzL2Fy
Y2gveDg2XzY0L2tlcm5lbC9pMzg3LmMJMjAwNC0wNS0wNiAxODowNjozMC4wMDAwMDAwMDAgLTA3
MDAKQEAgLTI0LDIwICsyNCw2IEBACiAjaW5jbHVkZSA8YXNtL3B0cmFjZS5oPgogI2luY2x1ZGUg
PGFzbS91YWNjZXNzLmg+CiAKLXVuc2lnbmVkIGludCBteGNzcl9mZWF0dXJlX21hc2sgPSAweGZm
ZmZmZmZmOwotCi12b2lkIG14Y3NyX2ZlYXR1cmVfbWFza19pbml0KHZvaWQpCi17Ci0JdW5zaWdu
ZWQgaW50IG1hc2s7Ci0JY2x0cygpOwotCW1lbXNldCgmY3VycmVudC0+dGhyZWFkLmkzODcuZnhz
YXZlLCAwLCBzaXplb2Yoc3RydWN0IGkzODdfZnhzYXZlX3N0cnVjdCkpOwotCWFzbSB2b2xhdGls
ZSgiZnhzYXZlICUwIiA6IDogIm0iIChjdXJyZW50LT50aHJlYWQuaTM4Ny5meHNhdmUpKTsKLQlt
YXNrID0gY3VycmVudC0+dGhyZWFkLmkzODcuZnhzYXZlLm14Y3NyX21hc2s7Ci0JaWYgKG1hc2sg
PT0gMCkgbWFzayA9IDB4MDAwMGZmYmY7Ci0JbXhjc3JfZmVhdHVyZV9tYXNrICY9IG1hc2s7Ci0J
c3R0cygpOwotfQotCiAvKgogICogQ2FsbGVkIGF0IGJvb3R1cCB0byBzZXQgdXAgdGhlIGluaXRp
YWwgRlBVIHN0YXRlIHRoYXQgaXMgbGF0ZXIgY2xvbmVkCiAgKiBpbnRvIGFsbCBwcm9jZXNzZXMu
Cg==

------_=_NextPart_001_01C433D4.3F01F916--
