Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262504AbSJKORL>; Fri, 11 Oct 2002 10:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262502AbSJKORK>; Fri, 11 Oct 2002 10:17:10 -0400
Received: from email.gcom.com ([206.221.230.194]:60621 "EHLO gcom.com")
	by vger.kernel.org with ESMTP id <S262501AbSJKORI>;
	Fri, 11 Oct 2002 10:17:08 -0400
Message-Id: <5.1.0.14.2.20021011091840.02695808@localhost>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 11 Oct 2002 09:22:09 -0500
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>,
       Arjan van de Ven <arjanv@fenrus.demon.nl>
From: David Grothe <dave@gcom.com>
Subject: Re: [Linux-streams] Re: [PATCH] Re: export of sys_call_tabl
Cc: hch@infradead.org, linux-kernel@vger.kernel.org,
       LiS <linux-streams@gsyc.escet.urjc.es>, Dave Miller <davem@redhat.com>,
       bidulock@openss7.org
In-Reply-To: <43B789B00E8@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_1787956465==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_1787956465==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

Here is a proposed "final" patch for the streams hooks.  I think that it 
takes into account all suggestions.  I put the prototype in linux/sys.h.

This is for stock 2.4.19, and has been tested.

-- Dave
--=====================_1787956465==_
Content-Type: text/plain; name="stock-i386-2.4.19.txt";
 x-mac-type="42494E41"; x-mac-creator="74747874"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="stock-i386-2.4.19.txt"

LS0tIGFyY2gvaTM4Ni9rZXJuZWwvZW50cnkuUy5vcmlnCTIwMDItMDgtMDIgMTk6Mzk6NDIuMDAw
MDAwMDAwIC0wNTAwCisrKyBhcmNoL2kzODYva2VybmVsL2VudHJ5LlMJMjAwMi0xMC0wOCAxNTo0
MzowOC4wMDAwMDAwMDAgLTA1MDAKQEAgLTU4NCw4ICs1ODQsOCBAQAogCS5sb25nIFNZTUJPTF9O
QU1FKHN5c19jYXBzZXQpICAgICAgICAgICAvKiAxODUgKi8KIAkubG9uZyBTWU1CT0xfTkFNRShz
eXNfc2lnYWx0c3RhY2spCiAJLmxvbmcgU1lNQk9MX05BTUUoc3lzX3NlbmRmaWxlKQotCS5sb25n
IFNZTUJPTF9OQU1FKHN5c19uaV9zeXNjYWxsKQkJLyogc3RyZWFtczEgKi8KLQkubG9uZyBTWU1C
T0xfTkFNRShzeXNfbmlfc3lzY2FsbCkJCS8qIHN0cmVhbXMyICovCisJLmxvbmcgU1lNQk9MX05B
TUUoc3lzX2dldHBtc2cpCQkvKiBzdHJlYW1zMSAqLworCS5sb25nIFNZTUJPTF9OQU1FKHN5c19w
dXRwbXNnKQkJLyogc3RyZWFtczIgKi8KIAkubG9uZyBTWU1CT0xfTkFNRShzeXNfdmZvcmspICAg
ICAgICAgICAgLyogMTkwICovCiAJLmxvbmcgU1lNQk9MX05BTUUoc3lzX2dldHJsaW1pdCkKIAku
bG9uZyBTWU1CT0xfTkFNRShzeXNfbW1hcDIpCi0tLSBrZXJuZWwvc3lzLmMub3JpZwkyMDAyLTA4
LTAyIDE5OjM5OjQ2LjAwMDAwMDAwMCAtMDUwMAorKysga2VybmVsL3N5cy5jCTIwMDItMTAtMTAg
MTU6MDA6NDUuMDAwMDAwMDAwIC0wNTAwCkBAIC0xNjcsNiArMTY3LDQ5IEBACiAJcmV0dXJuIG5v
dGlmaWVyX2NoYWluX3VucmVnaXN0ZXIoJnJlYm9vdF9ub3RpZmllcl9saXN0LCBuYik7CiB9CiAK
K3N0YXRpYyBpbnQgKCpkb19wdXRwbXNnKSAoaW50LCB2b2lkICosIHZvaWQgKiwgaW50LCBpbnQp
ID0gTlVMTDsKK3N0YXRpYyBpbnQgKCpkb19nZXRwbXNnKSAoaW50LCB2b2lkICosIHZvaWQgKiwg
aW50LCBpbnQpID0gTlVMTDsKKworc3RhdGljIERFQ0xBUkVfUldTRU0oc3RyZWFtc19jYWxsX3Nl
bSk7CisKK2xvbmcgYXNtbGlua2FnZQorc3lzX3B1dHBtc2coaW50IGZkLCB2b2lkICpjdGxwdHIs
IHZvaWQgKmRhdHB0ciwgaW50IGJhbmQsIGludCBmbGFncykKK3sKKwlpbnQgcmV0ID0gLUVOT1NZ
UzsKKwlkb3duX3JlYWQoJnN0cmVhbXNfY2FsbF9zZW0pOwkvKiBzaG91bGQgcmV0dXJuIGludCwg
YnV0IGRvZXNuJ3QgKi8KKwlpZiAoZG9fcHV0cG1zZykKKwkJcmV0ID0gKCpkb19wdXRwbXNnKSAo
ZmQsIGN0bHB0ciwgZGF0cHRyLCBiYW5kLCBmbGFncyk7CisJdXBfcmVhZCgmc3RyZWFtc19jYWxs
X3NlbSk7CisJcmV0dXJuIHJldDsKK30KKworbG9uZyBhc21saW5rYWdlCitzeXNfZ2V0cG1zZyhp
bnQgZmQsIHZvaWQgKmN0bHB0ciwgdm9pZCAqZGF0cHRyLCBpbnQgYmFuZCwgaW50IGZsYWdzKQor
eworCWludCByZXQgPSAtRU5PU1lTOworCWRvd25fcmVhZCgmc3RyZWFtc19jYWxsX3NlbSk7CS8q
IHNob3VsZCByZXR1cm4gaW50LCBidXQgZG9lc24ndCAqLworCWlmIChkb19nZXRwbXNnKQorCQly
ZXQgPSAoKmRvX2dldHBtc2cpIChmZCwgY3RscHRyLCBkYXRwdHIsIGJhbmQsIGZsYWdzKTsKKwl1
cF9yZWFkKCZzdHJlYW1zX2NhbGxfc2VtKTsKKwlyZXR1cm4gcmV0OworfQorCitpbnQKK3JlZ2lz
dGVyX3N0cmVhbXNfY2FsbHMoaW50ICgqcHV0cG1zZykgKGludCwgdm9pZCAqLCB2b2lkICosIGlu
dCwgaW50KSwKKwkJICAgICAgIGludCAoKmdldHBtc2cpIChpbnQsIHZvaWQgKiwgdm9pZCAqLCBp
bnQsIGludCkpCit7CisJaW50IHJldCA9IC1FQlVTWTsKKwlkb3duX3dyaXRlKCZzdHJlYW1zX2Nh
bGxfc2VtKTsJLyogc2hvdWxkIHJldHVybiBpbnQsIGJ1dCBkb2Vzbid0ICovCisJaWYgKCAgIChw
dXRwbXNnID09IE5VTEwgfHwgZG9fcHV0cG1zZyA9PSBOVUxMKQorCSAgICAmJiAoZ2V0cG1zZyA9
PSBOVUxMIHx8IGRvX2dldHBtc2cgPT0gTlVMTCkpIHsKKwkJZG9fcHV0cG1zZyA9IHB1dHBtc2c7
CisJCWRvX2dldHBtc2cgPSBnZXRwbXNnOworCQlyZXQgPSAwOworCX0KKwl1cF93cml0ZSgmc3Ry
ZWFtc19jYWxsX3NlbSk7CisJcmV0dXJuIHJldDsKK30KKwogYXNtbGlua2FnZSBsb25nIHN5c19u
aV9zeXNjYWxsKHZvaWQpCiB7CiAJcmV0dXJuIC1FTk9TWVM7CkBAIC0xMjg2LDMgKzEzMjksNCBA
QAogRVhQT1JUX1NZTUJPTCh1bnJlZ2lzdGVyX3JlYm9vdF9ub3RpZmllcik7CiBFWFBPUlRfU1lN
Qk9MKGluX2dyb3VwX3ApOwogRVhQT1JUX1NZTUJPTChpbl9lZ3JvdXBfcCk7CitFWFBPUlRfU1lN
Qk9MX0dQTChyZWdpc3Rlcl9zdHJlYW1zX2NhbGxzKTsKLS0tIGluY2x1ZGUvbGludXgvc3lzLmgu
b3JpZwkyMDAyLTEwLTExIDA4OjU5OjEwLjAwMDAwMDAwMCAtMDUwMAorKysgaW5jbHVkZS9saW51
eC9zeXMuaAkyMDAyLTEwLTExIDA5OjE1OjA0LjAwMDAwMDAwMCAtMDUwMApAQCAtMjcsNCArMjcs
MTYgQEAKICAqIFRoZXNlIGFyZSBzeXN0ZW0gY2FsbHMgdGhhdCBoYXZlbid0IGJlZW4gaW1wbGVt
ZW50ZWQgeWV0CiAgKiBidXQgaGF2ZSBhbiBlbnRyeSBpbiB0aGUgdGFibGUgZm9yIGZ1dHVyZSBl
eHBhbnNpb24uLgogICovCisKKy8qCisgKiBUaGVzZSBhcmUgcmVnaXN0cmF0aW9uIHJvdXRpbmVz
IGZvciBzeXN0ZW0gY2FsbHMgdGhhdCBhcmUKKyAqIGltcGxlbWVudGVkIGJ5IGxvYWRhYmxlIG1v
ZHVsZXMgb3V0c2lkZSBvZiB0aGUga2VybmVsCisgKiBzb3VyY2UgdHJlZS4KKyAqLworI2lmICFk
ZWZpbmVkKF9fQVNTRU1CTFlfXykKK2V4dGVybiBpbnQKK3JlZ2lzdGVyX3N0cmVhbXNfY2FsbHMo
aW50ICgqcHV0cG1zZykgKGludCwgdm9pZCAqLCB2b2lkICosIGludCwgaW50KSwKKwkJICAgICAg
IGludCAoKmdldHBtc2cpIChpbnQsIHZvaWQgKiwgdm9pZCAqLCBpbnQsIGludCkpIDsKKworI2Vu
ZGlmCQkJLyogX19BU1NFTUJMWV9fICovCiAjZW5kaWYK
--=====================_1787956465==_--

