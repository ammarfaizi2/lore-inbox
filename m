Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbTAAU7Y>; Wed, 1 Jan 2003 15:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbTAAU7X>; Wed, 1 Jan 2003 15:59:23 -0500
Received: from stinky.trash.net ([195.134.144.50]:49581 "EHLO stinky.trash.net")
	by vger.kernel.org with ESMTP id <S265051AbTAAU7V>;
	Wed, 1 Jan 2003 15:59:21 -0500
Date: Wed, 1 Jan 2003 22:07:46 +0100 (MET)
From: Patrick McHardy <kaber@stinky.trash.net>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] workaround for i810_audio troubles on Samsung VM7000 notebooks
Message-ID: <Pine.GSO.4.42.0301012143460.16792-200000@stinky.trash.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-959030623-1041455266=:16792"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-959030623-1041455266=:16792
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Alan,

this patch works around i810_audio/ac97_codec (falsely?) identifying my
codec as softmodem. I also swapped the order of AC97 1.0/2.0 softmodem
detection in i810_audio because (at least in my case) reading both
AC97_EXTENDED_MODEM_ID and AC97_RESET identified it as softmodem, so
AC97_EXTENDED_MODEM_ID check should go first for correct message to
appear.

Regards,
Patrick

---559023410-959030623-1041455266=:16792
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="i810_workaround.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.42.0301012207461.16792@stinky.trash.net>
Content-Description: 
Content-Disposition: attachment; filename="i810_workaround.diff"

ZGlmZiAtdXJOIC1YIC4uL3NyYy9kb250ZGlmZiBsaW51eC0yLjQuMjEtcHJl
Mi1jbGVhbi9kcml2ZXJzL3NvdW5kL2FjOTdfY29kZWMuYyBsaW51eC0yLjQu
MjEtcHJlMi9kcml2ZXJzL3NvdW5kL2FjOTdfY29kZWMuYw0KLS0tIGxpbnV4
LTIuNC4yMS1wcmUyLWNsZWFuL2RyaXZlcnMvc291bmQvYWM5N19jb2RlYy5j
CTIwMDMtMDEtMDEgMjE6MzI6MDguMDAwMDAwMDAwICswMTAwDQorKysgbGlu
dXgtMi40LjIxLXByZTIvZHJpdmVycy9zb3VuZC9hYzk3X2NvZGVjLmMJMjAw
My0wMS0wMSAyMTozOToyNi4wMDAwMDAwMDAgKzAxMDANCkBAIC0xNTcsNiAr
MTU3LDcgQEANCiAJezB4ODM4NDc2NjYsICJTaWdtYVRlbCBTVEFDOTc1MFQi
LAkmc2lnbWF0ZWxfOTc0NF9vcHN9LA0KIAl7MHg4Mzg0NzY4NCwgIlNpZ21h
VGVsIFNUQUM5NzgzLzg0PyIsCSZudWxsX29wc30sDQogCXsweDU3NDU0MzAx
LCAiV2luYm9uZCA4Mzk3MUQiLAkJJm51bGxfb3BzfSwNCisJezB4NDM1ODU0
NDIsICJTYW1zdW5nID8/Pz8iLAkJJm51bGxfb3BzfSwNCiB9Ow0KIA0KIHN0
YXRpYyBjb25zdCBjaGFyICphYzk3X3N0ZXJlb19lbmhhbmNlbWVudHNbXSA9
DQpkaWZmIC11ck4gLVggLi4vc3JjL2RvbnRkaWZmIGxpbnV4LTIuNC4yMS1w
cmUyLWNsZWFuL2RyaXZlcnMvc291bmQvaTgxMF9hdWRpby5jIGxpbnV4LTIu
NC4yMS1wcmUyL2RyaXZlcnMvc291bmQvaTgxMF9hdWRpby5jDQotLS0gbGlu
dXgtMi40LjIxLXByZTItY2xlYW4vZHJpdmVycy9zb3VuZC9pODEwX2F1ZGlv
LmMJMjAwMy0wMS0wMSAyMTozMjowOS4wMDAwMDAwMDAgKzAxMDANCisrKyBs
aW51eC0yLjQuMjEtcHJlMi9kcml2ZXJzL3NvdW5kL2k4MTBfYXVkaW8uYwky
MDAzLTAxLTAxIDIxOjQxOjUyLjAwMDAwMDAwMCArMDEwMA0KQEAgLTI5MTYs
MTUgKzI5MTYsMTYgQEANCiAJCQlrZnJlZShjb2RlYyk7DQogCQkJYnJlYWs7
DQogCQl9DQorDQorCQkvKiBTYW1zdW5nIGNvZGVjIGJ1aWx0IGluIFZNNzAw
MCBzZXJpZXMgTm90ZWJvb2tzIGlzIGZhbHNlbHkgKD8pDQorCQkgKiBpZGVu
dGlmaWVkIGFzIHNvZnRtb2RlbSAqLw0KIAkJDQotCQkvKiBDaGVjayBmb3Ig
YW4gQUM5NyAxLjAgc29mdCBtb2RlbSAoSUQxKSAqLw0KLQkJDQotCQlpZihj
b2RlYy0+Y29kZWNfcmVhZChjb2RlYywgQUM5N19SRVNFVCkgJiAyKQ0KKwkJ
aWYgKGNvZGVjLT50eXBlID09IDB4NDM1ODU0NDIpDQogCQl7DQotCQkJcHJp
bnRrKEtFUk5fV0FSTklORyAiaTgxMF9hdWRpbzogY29kZWMgJWQgaXMgYW4g
QUM5NyAxLjAgc29mdG1vZGVtIC0gc2tpcHBpbmcuXG4iLCBhYzk3X2lkKTsN
Ci0JCQlrZnJlZShjb2RlYyk7DQotCQkJY29udGludWU7DQorCQkJcHJpbnRr
KEtFUk5fV0FSTklORyAiaTgxMF9hdWRpbzogY29kZWMgJWQgaXMgYSBicm9r
ZW4oPykgU2Ftc3VuZyBjb2RlYywgc2tpcHBpbmcgc29mdG1vZGVtIGNoZWNr
LlxuIiwgYWM5N19pZCk7DQorCQkJZ290byBza2lwX21vZGVtX2NoZWNrOw0K
IAkJfQ0KKwkJCQ0KIAkJDQogCQkvKiBDaGVjayBmb3IgYW4gQUM5NyAyLngg
c29mdCBtb2RlbSAqLw0KIAkJDQpAQCAtMjkzNSw3ICsyOTM2LDE3IEBADQog
CQkJa2ZyZWUoY29kZWMpOw0KIAkJCWNvbnRpbnVlOw0KIAkJfQ0KLQkNCisN
CisJCS8qIENoZWNrIGZvciBhbiBBQzk3IDEuMCBzb2Z0IG1vZGVtIChJRDEp
ICovDQorCQkNCisJCWlmKGNvZGVjLT5jb2RlY19yZWFkKGNvZGVjLCBBQzk3
X1JFU0VUKSAmIDIpDQorCQl7DQorCQkJcHJpbnRrKEtFUk5fV0FSTklORyAi
aTgxMF9hdWRpbzogY29kZWMgJWQgaXMgYW4gQUM5NyAxLjAgc29mdG1vZGVt
IC0gc2tpcHBpbmcuXG4iLCBhYzk3X2lkKTsNCisJCQlrZnJlZShjb2RlYyk7
DQorCQkJY29udGludWU7DQorCQl9DQorDQorc2tpcF9tb2RlbV9jaGVjazoN
CiAJCWNhcmQtPmFjOTdfZmVhdHVyZXMgPSBlaWQ7DQogDQogCQkvKiBOb3cg
Y2hlY2sgdGhlIGNvZGVjIGZvciB1c2VmdWwgZmVhdHVyZXMgdG8gbWFrZSB1
cCBmb3INCg==
---559023410-959030623-1041455266=:16792--
