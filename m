Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbVBKUpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVBKUpU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 15:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbVBKUpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 15:45:19 -0500
Received: from mms-nat.broadcom.com ([63.70.210.58]:57099 "EHLO
	MMS3.broadcom.com") by vger.kernel.org with ESMTP id S262339AbVBKUo2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 15:44:28 -0500
X-Server-Uuid: 35E76369-CF33-4172-911A-D1698BD5E887
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: [PATCH] tg3: capacitive coupling detection fix
Date: Fri, 11 Feb 2005 12:44:10 -0800
Message-ID: <B1508D50A0692F42B217C22C02D84972020F3D93@NT-IRVA-0741.brcm.ad.broadcom.com>
X-MS-Has-Attach: yes
Thread-Topic: [PATCH] tg3: capacitive coupling detection fix
thread-index: AcUQenBthEVwCOEDSUG7grDnD7JTOg==
From: "Michael Chan" <mchan@broadcom.com>
To: "David S. Miller" <davem@davemloft.net>
cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       "john stultz" <johnstul@us.ibm.com>
X-WSS-ID: 6E13C6902WC2342986-01-01
Content-Type: multipart/mixed;
 boundary="----_=_NextPart_001_01C5107A.707CC563"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5107A.707CC563
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

This patch fixes the problem reported in:

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D110798711911645&w=3D2


The 5700 link problem was caused by reading uninitialized values in sram =
and
causing capacitive coupling mode to be enabled by mistake. This patch =
fixes
the problem by properly validating the sram contents.


Signed-off-by: Michael Chan <mchan@broadcom.com>

------_=_NextPart_001_01C5107A.707CC563
Content-Type: application/octet-stream;
 name=tg3_cap_cpling.patch
Content-Transfer-Encoding: base64
Content-Description: tg3_cap_cpling.patch
Content-Disposition: attachment;
 filename=tg3_cap_cpling.patch

ZGlmZiAtTnJ1IDIvdGczLmMgMy90ZzMuYwotLS0gMi90ZzMuYwkyMDA1LTAyLTEwIDEwOjIyOjM5
LjAwMDAwMDAwMCAtMDgwMAorKysgMy90ZzMuYwkyMDA1LTAyLTEwIDEwOjI2OjQyLjAwMDAwMDAw
MCAtMDgwMApAQCAtNzUxNSwxMiArNzUxNSwxOCBAQAogCXRnM19yZWFkX21lbSh0cCwgTklDX1NS
QU1fREFUQV9TSUcsICZ2YWwpOwogCWlmICh2YWwgPT0gTklDX1NSQU1fREFUQV9TSUdfTUFHSUMp
IHsKIAkJdTMyIG5pY19jZmcsIGxlZF9jZmc7Ci0JCXUzMiBuaWNfcGh5X2lkLCBjZmcyOworCQl1
MzIgbmljX3BoeV9pZCwgdmVyLCBjZmcyID0gMDsKIAogCQl0ZzNfcmVhZF9tZW0odHAsIE5JQ19T
UkFNX0RBVEFfQ0ZHLCAmbmljX2NmZyk7CiAJCXRwLT5uaWNfc3JhbV9kYXRhX2NmZyA9IG5pY19j
Zmc7CiAKLQkJdGczX3JlYWRfbWVtKHRwLCBOSUNfU1JBTV9EQVRBX0NGR18yLCAmY2ZnMik7CisJ
CXRnM19yZWFkX21lbSh0cCwgTklDX1NSQU1fREFUQV9WRVIsICZ2ZXIpOworCQl2ZXIgPj49IE5J
Q19TUkFNX0RBVEFfVkVSX1NISUZUOworCQlpZiAoKEdFVF9BU0lDX1JFVih0cC0+cGNpX2NoaXBf
cmV2X2lkKSAhPSBBU0lDX1JFVl81NzAwKSAmJgorCQkgICAgKEdFVF9BU0lDX1JFVih0cC0+cGNp
X2NoaXBfcmV2X2lkKSAhPSBBU0lDX1JFVl81NzAxKSAmJgorCQkgICAgKEdFVF9BU0lDX1JFVih0
cC0+cGNpX2NoaXBfcmV2X2lkKSAhPSBBU0lDX1JFVl81NzAzKSAmJgorCQkgICAgKHZlciA+IDAp
ICYmICh2ZXIgPCAweDEwMCkpCisJCQl0ZzNfcmVhZF9tZW0odHAsIE5JQ19TUkFNX0RBVEFfQ0ZH
XzIsICZjZmcyKTsKIAogCQllZXByb21fc2lnbmF0dXJlX2ZvdW5kID0gMTsKIApkaWZmIC1OcnUg
Mi90ZzMuaCAzL3RnMy5oCi0tLSAyL3RnMy5oCTIwMDUtMDItMTAgMTA6MjI6NDMuMDAwMDAwMDAw
IC0wODAwCisrKyAzL3RnMy5oCTIwMDUtMDItMTAgMTA6MjY6NDQuMDAwMDAwMDAwIC0wODAwCkBA
IC0xNDUyLDYgKzE0NTIsOSBAQAogI2RlZmluZSAgTklDX1NSQU1fREFUQV9DRkdfRklCRVJfV09M
CQkgMHgwMDAwNDAwMAogI2RlZmluZSAgTklDX1NSQU1fREFUQV9DRkdfTk9fR1BJTzIJCSAweDAw
MTAwMDAwCiAKKyNkZWZpbmUgTklDX1NSQU1fREFUQV9WRVIJCQkweDAwMDAwYjVjCisjZGVmaW5l
ICBOSUNfU1JBTV9EQVRBX1ZFUl9TSElGVAkJIDE2CisKICNkZWZpbmUgTklDX1NSQU1fREFUQV9Q
SFlfSUQJCTB4MDAwMDBiNzQKICNkZWZpbmUgIE5JQ19TUkFNX0RBVEFfUEhZX0lEMV9NQVNLCSAw
eGZmZmYwMDAwCiAjZGVmaW5lICBOSUNfU1JBTV9EQVRBX1BIWV9JRDJfTUFTSwkgMHgwMDAwZmZm
Zgo=

------_=_NextPart_001_01C5107A.707CC563--

