Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130180AbQKQJhi>; Fri, 17 Nov 2000 04:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131368AbQKQJhO>; Fri, 17 Nov 2000 04:37:14 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:58635 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S130113AbQKQJhL>;
	Fri, 17 Nov 2000 04:37:11 -0500
Date: Fri, 17 Nov 2000 11:06:55 +0200 (EET)
From: <jani@virtualro.ic.ro>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH-2.4.0-10] vgacon.c
In-Reply-To: <Pine.LNX.4.10.10011161832460.803-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10011171102220.3637-200000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1724025422-2090548157-974452015=:3637"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1724025422-2090548157-974452015=:3637
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi ,
 here are some cleanings in drivers/char/vgacon.c
1) I suppose that static initialisers are 0 inited so no need for "= 0"
2) there is a line in vgacon_scroll which I think is unnecesarily
duplicated

Could anyone comment on this?

Jani


--1724025422-2090548157-974452015=:3637
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="vgacon.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10011171106550.3637@virtualro.ic.ro>
Content-Description: 
Content-Disposition: attachment; filename="vgacon.diff"

LS0tIC91c3Ivc3JjL2xpbnV4LTIuNC4wL2RyaXZlcnMvdmlkZW8vdmdhY29u
LmMJVGh1IE5vdiAxNiAyMDowNDo1MiAyMDAwDQorKysgdmdhY29uLmMJRnJp
IE5vdiAxNyAxMDo0MjoyOSAyMDAwDQpAQCAtMTA0LDcgKzEwNCw3IEBADQog
c3RhdGljIHUxNiAgICAgICAgICAgICB2Z2FfdmlkZW9fcG9ydF92YWw7CS8q
IFZpZGVvIHJlZ2lzdGVyIHZhbHVlIHBvcnQgKi8NCiBzdGF0aWMgdW5zaWdu
ZWQgaW50ICAgIHZnYV92aWRlb19udW1fY29sdW1uczsJLyogTnVtYmVyIG9m
IHRleHQgY29sdW1ucyAqLw0KIHN0YXRpYyB1bnNpZ25lZCBpbnQgICAgdmdh
X3ZpZGVvX251bV9saW5lczsJLyogTnVtYmVyIG9mIHRleHQgbGluZXMgKi8N
Ci1zdGF0aWMgaW50CSAgICAgICB2Z2FfY2FuX2RvX2NvbG9yID0gMDsJLyog
RG8gd2Ugc3VwcG9ydCBjb2xvcnM/ICovDQorc3RhdGljIGludAkgICAgICAg
dmdhX2Nhbl9kb19jb2xvcjsJLyogRG8gd2Ugc3VwcG9ydCBjb2xvcnM/ICov
DQogc3RhdGljIHVuc2lnbmVkIGludCAgICB2Z2FfZGVmYXVsdF9mb250X2hl
aWdodDsJLyogSGVpZ2h0IG9mIGRlZmF1bHQgc2NyZWVuIGZvbnQgKi8NCiBz
dGF0aWMgdW5zaWduZWQgY2hhciAgIHZnYV92aWRlb190eXBlOwkJLyogQ2Fy
ZCB0eXBlICovDQogc3RhdGljIHVuc2lnbmVkIGNoYXIgICB2Z2FfaGFyZHNj
cm9sbF9lbmFibGVkOw0KQEAgLTExMiw3ICsxMTIsNyBAQA0KIC8qDQogICog
U29mdFNEViBkb2Vzbid0IGhhdmUgaGFyZHdhcmUgYXNzaXN0IFZHQSBzY3Jv
bGxpbmcgDQogICovDQotc3RhdGljIHVuc2lnbmVkIGNoYXIgICB2Z2FfaGFy
ZHNjcm9sbF91c2VyX2VuYWJsZSA9IDA7DQorc3RhdGljIHVuc2lnbmVkIGNo
YXIgICB2Z2FfaGFyZHNjcm9sbF91c2VyX2VuYWJsZTsNCiAjZWxzZQ0KIHN0
YXRpYyB1bnNpZ25lZCBjaGFyICAgdmdhX2hhcmRzY3JvbGxfdXNlcl9lbmFi
bGUgPSAxOw0KICNlbmRpZg0KQEAgLTEyMiw3ICsxMjIsNyBAQA0KIHN0YXRp
YyBpbnQJICAgICAgIHZnYV9pc19nZng7DQogc3RhdGljIGludAkgICAgICAg
dmdhXzUxMl9jaGFyczsNCiBzdGF0aWMgaW50CSAgICAgICB2Z2FfdmlkZW9f
Zm9udF9oZWlnaHQ7DQotc3RhdGljIHVuc2lnbmVkIGludCAgICB2Z2Ffcm9s
bGVkX292ZXIgPSAwOw0KK3N0YXRpYyB1bnNpZ25lZCBpbnQgICAgdmdhX3Jv
bGxlZF9vdmVyOw0KIA0KIA0KIHN0YXRpYyBpbnQgX19pbml0IG5vX3Njcm9s
bChjaGFyICpzdHIpDQpAQCAtOTY1LDcgKzk2NSw3IEBADQogDQogc3RhdGlj
IHZvaWQgdmdhY29uX3NhdmVfc2NyZWVuKHN0cnVjdCB2Y19kYXRhICpjKQ0K
IHsNCi0Jc3RhdGljIGludCB2Z2FfYm9vdHVwX2NvbnNvbGUgPSAwOw0KKwlz
dGF0aWMgaW50IHZnYV9ib290dXBfY29uc29sZTsNCiANCiAJaWYgKCF2Z2Ff
Ym9vdHVwX2NvbnNvbGUpIHsNCiAJCS8qIFRoaXMgaXMgYSBncm9zcyBoYWNr
LCBidXQgaGVyZSBpcyB0aGUgb25seSBwbGFjZSB3ZSBjYW4NCkBAIC0xMDE1
LDcgKzEwMTUsNiBAQA0KIAkJCXZnYV9yb2xsZWRfb3ZlciA9IDA7DQogCQl9
IGVsc2UNCiAJCQljLT52Y19vcmlnaW4gLT0gZGVsdGE7DQotCQljLT52Y19z
Y3JfZW5kID0gYy0+dmNfb3JpZ2luICsgYy0+dmNfc2NyZWVuYnVmX3NpemU7
DQogCQlzY3JfbWVtc2V0dygodTE2ICopKGMtPnZjX29yaWdpbiksIGMtPnZj
X3ZpZGVvX2VyYXNlX2NoYXIsIGRlbHRhKTsNCiAJfQ0KIAljLT52Y19zY3Jf
ZW5kID0gYy0+dmNfb3JpZ2luICsgYy0+dmNfc2NyZWVuYnVmX3NpemU7DQo=
--1724025422-2090548157-974452015=:3637--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
