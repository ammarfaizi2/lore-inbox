Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129132AbQKPLxU>; Thu, 16 Nov 2000 06:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129449AbQKPLxK>; Thu, 16 Nov 2000 06:53:10 -0500
Received: from topaz.cns.mpg.de ([194.95.183.253]:55352 "EHLO topaz.cns.mpg.de")
	by vger.kernel.org with ESMTP id <S129132AbQKPLxA>;
	Thu, 16 Nov 2000 06:53:00 -0500
Message-ID: <3A13C331.2348889C@cns.mpg.de>
Date: Thu, 16 Nov 2000 12:21:21 +0100
From: Gert Wollny <wollny@cns.mpg.de>
Organization: http://www.cns.mpg.de
X-Mailer: Mozilla 4.61C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Parport/IMM/Zip LOCKUP Oops Revisited [patch included]
In-Reply-To: <Pine.LNX.4.10.10011150012390.684-100000@bolide.beigert.de> <3A11F441.327F14B4@windeath.2y.net>
Content-Type: multipart/mixed;
 boundary="------------F9D869C1459B1120D8B8F17F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F9D869C1459B1120D8B8F17F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

(patch resent with new subject)

This patch trys to fix the lockup when doing a "modprobe imm" and the
parport_pc module is not loaded yet. 

If you have a SMP Box and a parport ZIP drive, please check it. 

There are already two success stories (James and me).

Have a nice day.

Gert
--------------F9D869C1459B1120D8B8F17F
Content-Type: text/plain; charset=us-ascii;
 name="imm-lockup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="imm-lockup.patch"

>From - Thu Nov 16 12:10:09 2000
>From wollny  Thu Nov 16 11:32:26 2000
Received: from mout1.freenet.de (exim@mout1.freenet.de [194.97.50.132])
	by topaz.cns.mpg.de (8.9.3/8.9.3/Debian/GNU) with ESMTP id LAA31905
	for <wollny@cns.mpg.de>; Thu, 16 Nov 2000 11:32:26 +0100
Received: from [194.97.50.138] (helo=mx0.freenet.de)
	by mout1.freenet.de with esmtp (Exim 3.16 #20)
	id 13wMLC-0008Vt-00
	for wollny@cns.mpg.de; Thu, 16 Nov 2000 11:32:26 +0100
Received: from afccb.pppool.de ([213.6.252.203] helo=bolide.beigert.de)
	by mx0.freenet.de with esmtp (Exim 3.16 #20)
	id 13wMLB-0003qe-00
	for wollny@cns.mpg.de; Thu, 16 Nov 2000 11:32:25 +0100
Received: from localhost (wollny@localhost)
	by bolide.beigert.de (8.9.3/8.8.7) with ESMTP id LAA01472
	for <wollny@cns.mpg.de>; Thu, 16 Nov 2000 11:40:28 +0100
Date: Thu, 16 Nov 2000 11:40:28 +0100 (CET)
From: Gert Wollny <wollny@cns.mpg.de>
To: wollny@cns.mpg.de
Subject: my patch
Message-ID: <Pine.LNX.4.10.10011161140001.1389-200000@bolide.beigert.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811830-1847483163-974371228=:1389"
X-Mozilla-Status: 8001
X-Mozilla-Status2: 00000000
X-UIDL: b5956dbe5236d1632c2f0f87bfe57e35

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811830-1847483163-974371228=:1389
Content-Type: TEXT/PLAIN; charset=US-ASCII


---1463811830-1847483163-974371228=:1389
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="imm-lockup.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10011161140280.1389@bolide.beigert.de>
Content-Description: no
Content-Disposition: attachment; filename="imm-lockup.patch"

ZGlmZiAtcnUgMi40LjAtdGVzdDExLXByZTQvZHJpdmVycy9zY3NpL2ltbS5j
IDIuNC4wLXRlc3QxMS1wcmU0LW15L2RyaXZlcnMvc2NzaS9pbW0uYw0KLS0t
IDIuNC4wLXRlc3QxMS1wcmU0L2RyaXZlcnMvc2NzaS9pbW0uYwlXZWQgTm92
IDE1IDE5OjM5OjQxIDIwMDANCisrKyAyLjQuMC10ZXN0MTEtcHJlNC1teS9k
cml2ZXJzL3Njc2kvaW1tLmMJV2VkIE5vdiAxNSAxOTo0NDo1NiAyMDAwDQpA
QCAtMjEyLDggKzIxMiwxMSBAQA0KIAkgICAgcmV0dXJuIDA7DQogCXRyeV9h
Z2FpbiA9IDE7DQogCWdvdG8gcmV0cnlfZW50cnk7DQotICAgIH0gZWxzZQ0K
LQlyZXR1cm4gMTsJCS8qIHJldHVybiBudW1iZXIgb2YgaG9zdHMgZGV0ZWN0
ZWQgKi8NCisgICAgfSBlbHNlIHsNCisJIC8qIG5vdyBlbmFibGUgdGhlIG5l
dyBjb2RlICovDQorCSBob3N0LT51c2VfbmV3X2VoX2NvZGUgPSAxOw0KKwkg
cmV0dXJuIDE7CQkvKiByZXR1cm4gbnVtYmVyIG9mIGhvc3RzIGRldGVjdGVk
ICovDQorICAgIH0JIA0KIH0NCiANCiAvKiBUaGlzIGlzIHRvIGdpdmUgdGhl
IGltbSBkcml2ZXIgYSB3YXkgdG8gbW9kaWZ5IHRoZSB0aW1pbmdzIChhbmQg
b3RoZXINCmRpZmYgLXJ1IDIuNC4wLXRlc3QxMS1wcmU0L2RyaXZlcnMvc2Nz
aS9pbW0uaCAyLjQuMC10ZXN0MTEtcHJlNC1teS9kcml2ZXJzL3Njc2kvaW1t
LmgNCi0tLSAyLjQuMC10ZXN0MTEtcHJlNC9kcml2ZXJzL3Njc2kvaW1tLmgJ
V2VkIE5vdiAxNSAxOTo0MDo0NCAyMDAwDQorKysgMi40LjAtdGVzdDExLXBy
ZTQtbXkvZHJpdmVycy9zY3NpL2ltbS5oCVdlZCBOb3YgMTUgMjA6MDE6MTEg
MjAwMA0KQEAgLTEwLDcgKzEwLDcgQEANCiAjaWZuZGVmIF9JTU1fSA0KICNk
ZWZpbmUgX0lNTV9IDQogDQotI2RlZmluZSAgIElNTV9WRVJTSU9OICAgIjIu
MDQgKGZvciBMaW51eCAyLjQuMCkiDQorI2RlZmluZSAgIElNTV9WRVJTSU9O
ICAgIjIuMDUgKGZvciBMaW51eCAyLjQuMCkiDQogDQogLyogDQogICogMTAg
QXByIDE5OTggKEdvb2QgRnJpZGF5KSAtIFJlY2VpdmVkIEVOMTQ0MzAyIGJ5
IGVtYWlsIGZyb20gSW9tZWdhLg0KQEAgLTYwLDYgKzYwLDkgQEANCiAgKiAg
ICBhZGRlZCBDT05GSUdfU0NTSV9JWklQX1NMT1dfQ1RSIG9wdGlvbg0KICAq
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgWzIuMDNdDQogICogIEZpeCBrZXJuZWwgcGFuaWMgb24gc2Nz
aSB0aW1lb3V0LgkJMjBBdWcwMCBbMi4wNF0NCisgKg0KKyAqICBGaXggYSBs
b2NrdXAgZHVyaW5nIGRldGVjdGlvbiBvZiBkcml2ZSAgICAgIDE0Tm92MDAg
WzIuMDVdDQorICogIEdlcnQgV29sbG55IDx3b2xsbnlAY25zLm1wZy5kZT4N
CiAgKi8NCiAvKiAtLS0tLS0gRU5EIE9GIFVTRVIgQ09ORklHVVJBQkxFIFBB
UkFNRVRFUlMgLS0tLS0gKi8NCiANCkBAIC0xNzIsNyArMTc1LDcgQEANCiAg
ICAgICAgICAgICAgICAgZWhfZGV2aWNlX3Jlc2V0X2hhbmRsZXI6ICAgICAg
ICBOVUxMLCAgICAgICAgICAgICAgICAgICBcDQogICAgICAgICAgICAgICAg
IGVoX2J1c19yZXNldF9oYW5kbGVyOiAgICAgICAgICAgaW1tX3Jlc2V0LCAg
ICAgICAgICAgICAgXA0KICAgICAgICAgICAgICAgICBlaF9ob3N0X3Jlc2V0
X2hhbmRsZXI6ICAgICAgICAgIGltbV9yZXNldCwgICAgICAgICAgICAgIFwN
Ci0JCXVzZV9uZXdfZWhfY29kZToJCTEsCQkJXA0KKwkJdXNlX25ld19laF9j
b2RlOgkJMCwJCQlcDQogCQliaW9zX3BhcmFtOgkJICAgICAgICBpbW1fYmlv
c3BhcmFtLAkJXA0KIAkJdGhpc19pZDoJCQk3LAkJCVwNCiAJCXNnX3RhYmxl
c2l6ZToJCQlTR19BTEwsCQkJXA0K
---1463811830-1847483163-974371228=:1389--


--------------F9D869C1459B1120D8B8F17F--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
