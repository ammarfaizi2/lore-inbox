Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262594AbVCPNgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbVCPNgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 08:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVCPNgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 08:36:14 -0500
Received: from mail.dif.dk ([193.138.115.101]:12184 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262594AbVCPNey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 08:34:54 -0500
Date: Wed, 16 Mar 2005 14:36:18 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steven French <sfrench@us.ibm.com>
Cc: smfrench@austin.rr.com, linux-kernel@vger.kernel.org
Subject: [PATCH][6/7] cifs: file.c cleanups in incremental bits - new helper
 function, cifs_get_disposition
Message-ID: <Pine.LNX.4.62.0503161434060.3141@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1601702387-1110980178=:3141"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1601702387-1110980178=:3141
Content-Type: TEXT/PLAIN; charset=US-ASCII


This (attached) patch adds a new helper function called 
cifs_get_disposition and converts cifs_open to use it to further shorten 
that very long function.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


-- 
Jesper Juhl


--8323328-1601702387-1110980178=:3141
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=fs_cifs_file-cleanups-3-cifs_get_disposition.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.62.0503161436180.3141@dragon.hyggekrogen.localhost>
Content-Description: fs_cifs_file-cleanups-3-cifs_get_disposition.patch
Content-Disposition: attachment; filename=fs_cifs_file-cleanups-3-cifs_get_disposition.patch

ZGlmZiAtdXAgbGludXgtMi42LjExLW1tMy9mcy9jaWZzL2ZpbGUuYy53aXRo
X3BhdGNoXzYgbGludXgtMi42LjExLW1tMy9mcy9jaWZzL2ZpbGUuYw0KLS0t
IGxpbnV4LTIuNi4xMS1tbTMvZnMvY2lmcy9maWxlLmMud2l0aF9wYXRjaF82
CTIwMDUtMDMtMTYgMTM6Mzk6MDQuMDAwMDAwMDAwICswMTAwDQorKysgbGlu
dXgtMi42LjExLW1tMy9mcy9jaWZzL2ZpbGUuYwkyMDA1LTAzLTE2IDEzOjQx
OjE0LjAwMDAwMDAwMCArMDEwMA0KQEAgLTY3LDYgKzY3LDE4IEBAIHN0YXRp
YyBpbmxpbmUgaW50IGNpZnNfY29udmVydF9mbGFncyh1bnMNCiAJcmV0dXJu
IDB4MjAxOTc7DQogfQ0KIA0KK3N0YXRpYyBpbmxpbmUgaW50IGNpZnNfZ2V0
X2Rpc3Bvc2l0aW9uKHVuc2lnbmVkIGludCBmbGFncykNCit7DQorCWlmICgo
ZmxhZ3MgJiAoT19DUkVBVCB8IE9fRVhDTCkpID09IChPX0NSRUFUIHwgT19F
WENMKSkNCisJCXJldHVybiBGSUxFX0NSRUFURTsNCisJZWxzZSBpZiAoKGZs
YWdzICYgKE9fQ1JFQVQgfCBPX1RSVU5DKSkgPT0gKE9fQ1JFQVQgfCBPX1RS
VU5DKSkNCisJCXJldHVybiBGSUxFX09WRVJXUklURV9JRjsNCisJZWxzZSBp
ZiAoKGZsYWdzICYgT19DUkVBVCkgPT0gT19DUkVBVCkNCisJCXJldHVybiBG
SUxFX09QRU5fSUY7DQorCWVsc2UNCisJCXJldHVybiBGSUxFX09QRU47DQor
fQ0KKw0KIC8qIGFsbCBhcmd1bWVudHMgdG8gdGhpcyBmdW5jdGlvbiBtdXN0
IGJlIGNoZWNrZWQgZm9yIHZhbGlkaXR5IGluIGNhbGxlciAqLw0KIHN0YXRp
YyBpbmxpbmUgaW50IGNpZnNfb3Blbl9pbm9kZV9oZWxwZXIoc3RydWN0IGlu
b2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUsDQogCXN0cnVjdCBjaWZz
SW5vZGVJbmZvICpwQ2lmc0lub2RlLCBzdHJ1Y3QgY2lmc0ZpbGVJbmZvICpw
Q2lmc0ZpbGUsDQpAQCAtMjIxLDE0ICsyMzMsNyBAQCBpbnQgY2lmc19vcGVu
KHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjDQogICoJIE9fRkFTWU5DLCBP
X05PRk9MTE9XLCBPX05PTkJMT0NLIG5lZWQgZnVydGhlciBpbnZlc3RpZ2F0
aW9uDQogICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8NCiANCi0JaWYgKChm
aWxlLT5mX2ZsYWdzICYgKE9fQ1JFQVQgfCBPX0VYQ0wpKSA9PSAoT19DUkVB
VCB8IE9fRVhDTCkpDQotCQlkaXNwb3NpdGlvbiA9IEZJTEVfQ1JFQVRFOw0K
LQllbHNlIGlmICgoZmlsZS0+Zl9mbGFncyAmIChPX0NSRUFUIHwgT19UUlVO
QykpID09IChPX0NSRUFUIHwgT19UUlVOQykpDQotCQlkaXNwb3NpdGlvbiA9
IEZJTEVfT1ZFUldSSVRFX0lGOw0KLQllbHNlIGlmICgoZmlsZS0+Zl9mbGFn
cyAmIE9fQ1JFQVQpID09IE9fQ1JFQVQpDQotCQlkaXNwb3NpdGlvbiA9IEZJ
TEVfT1BFTl9JRjsNCi0JZWxzZQ0KLQkJZGlzcG9zaXRpb24gPSBGSUxFX09Q
RU47DQorCWRpc3Bvc2l0aW9uID0gY2lmc19nZXRfZGlzcG9zaXRpb24oZmls
ZS0+Zl9mbGFncyk7DQogDQogCWlmIChvcGxvY2tFbmFibGVkKQ0KIAkJb3Bs
b2NrID0gUkVRX09QTE9DSzsNCg==

--8323328-1601702387-1110980178=:3141--
