Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVHWNoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVHWNoQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 09:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbVHWNoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 09:44:16 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:42920 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932171AbVHWNoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 09:44:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=kCh3H34jo+SMOhqZdPYi76h4xsLi3O0dt7Ly2xXrw05IR9zSSrAbmly4QrHT8jAAtuVcxb9sZ/1v+SIpDY55KqSSy0vLF0u7+PF7gdjJexdwrBoSvmIW8cymxBsyMO3ppd+BN8F7TWzGYHom8sGjNFuXSoGKsKUNnKLCifKWr9g=
Message-ID: <9e473391050823064469eb78a2@mail.gmail.com>
Date: Tue, 23 Aug 2005 09:44:12 -0400
From: Jon Smirl <jonsmirl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix whitespace handling on sysfs attributes
Cc: lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3491_13642074.1124804652353"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3491_13642074.1124804652353
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The first version of this patch didn't allow for the request firmware
case which does multiple parsing passes on the parameter. This was
discussed in the thread '2.6.13-rc6-mm1'

gregkh-driver-sysfs-strip_leading_trailing_whitespace-3.patch
  should replace in 2.6.13-rc6-mm1
gregkh-driver-sysfs-strip_leading_trailing_whitespace.patch

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

--=20
Jon Smirl
jonsmirl@gmail.com

------=_Part_3491_13642074.1124804652353
Content-Type: text/x-diff; name="gregkh-driver-sysfs-strip_leading_trailing_whitespace-3.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="gregkh-driver-sysfs-strip_leading_trailing_whitespace-3.patch"

ZGlmZiAtLWdpdCBhL2ZzL3N5c2ZzL2ZpbGUuYyBiL2ZzL3N5c2ZzL2ZpbGUuYwotLS0gYS9mcy9z
eXNmcy9maWxlLmMKKysrIGIvZnMvc3lzZnMvZmlsZS5jCkBAIC02LDYgKzYsNyBAQAogI2luY2x1
ZGUgPGxpbnV4L2Zzbm90aWZ5Lmg+CiAjaW5jbHVkZSA8bGludXgva29iamVjdC5oPgogI2luY2x1
ZGUgPGxpbnV4L25hbWVpLmg+CisjaW5jbHVkZSA8bGludXgvY3R5cGUuaD4KICNpbmNsdWRlIDxh
c20vdWFjY2Vzcy5oPgogI2luY2x1ZGUgPGFzbS9zZW1hcGhvcmUuaD4KIApAQCAtMjA3LDggKzIw
OCw0MSBAQCBmbHVzaF93cml0ZV9idWZmZXIoc3RydWN0IGRlbnRyeSAqIGRlbnRyCiAJc3RydWN0
IGF0dHJpYnV0ZSAqIGF0dHIgPSB0b19hdHRyKGRlbnRyeSk7CiAJc3RydWN0IGtvYmplY3QgKiBr
b2JqID0gdG9fa29iaihkZW50cnktPmRfcGFyZW50KTsKIAlzdHJ1Y3Qgc3lzZnNfb3BzICogb3Bz
ID0gYnVmZmVyLT5vcHM7CisJc2l6ZV90IHdzX2NvdW50ID0gY291bnQsIGxlYWRpbmcgPSAwOwor
CWludCByZXQgPSAwOworCWNoYXIgKng7CiAKLQlyZXR1cm4gb3BzLT5zdG9yZShrb2JqLGF0dHIs
YnVmZmVyLT5wYWdlLGNvdW50KTsKKwkvKiBsb2NhdGUgdHJhaWxpbmcgd2hpdGUgc3BhY2UgKi8K
Kwl3aGlsZSAoKHdzX2NvdW50ID4gMCkgJiYgaXNzcGFjZShidWZmZXItPnBhZ2Vbd3NfY291bnQg
LSAxXSkpCisJCXdzX2NvdW50LS07CisJaWYgKHdzX2NvdW50ID09IDApCisJCXJldHVybiBjb3Vu
dDsKKworCS8qIGxvY2F0ZSBsZWFkaW5nIHdoaXRlIHNwYWNlICovCisJeCA9IGJ1ZmZlci0+cGFn
ZTsKKwl3aGlsZSAoaXNzcGFjZSgqeCkpCisJCXgrKzsKKwlsZWFkaW5nID0geCAtIGJ1ZmZlci0+
cGFnZTsKKwl3c19jb3VudCAtPSBsZWFkaW5nOworCisJLyogaW50ZXJmYWNlIGlzIHN0aWxsIGFt
Ymlnb3VzIGFib3V0IHRoaXMgKi8KKwkvKiBzdHJpbmcgaXMgYm90aCBwYXNzZWQgYnkgbGVuZ3Ro
IGFuZCB0ZXJtaW5hdGVkICovCisJaWYgKHdzX2NvdW50ICE9IFBBR0VfU0laRSkKKwkJeFt3c19j
b3VudF0gPSAnXDAnOworCisJcmV0ID0gb3BzLT5zdG9yZShrb2JqLCBhdHRyLCB4LCB3c19jb3Vu
dCk7CisKKwkvKiBpcyBpdCBhbiBlcnJvcj8gKi8KKwlpZiAocmV0IDwgMCkgCisJCXJldHVybiBy
ZXQ7CisKKwkvKiB0aGUgd2hvbGUgc3RyaW5nIHdhcyBjb25zdW1lZCAqLworCWlmIChyZXQgPT0g
d3NfY291bnQpCisJCXJldHVybiBjb3VudDsKKworCS8qIG9ubHkgcGFydCBvZiB0aGUgc3RyaW5n
IHdhcyBjb25zdW1lZCAqLworCS8qIHJldHVybiBjb3VudCBjYW4gbm90IGluY2x1ZGUgdHJhaWxp
bmcgc3BhY2UgKi8KKwlyZXR1cm4gbGVhZGluZyArIHJldDsKIH0KIAogCg==
------=_Part_3491_13642074.1124804652353--
