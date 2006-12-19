Return-Path: <linux-kernel-owner+w=401wt.eu-S1752526AbWLSFUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbWLSFUp (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 00:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbWLSFUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 00:20:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:35239 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbWLSFUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 00:20:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=QXA6zEOYGQZIMT+0pSWWgXeYiQfWkvoCL3PDoVaoFkIgIk30H7BojL1DLAgRj0sVPLGQvXoDZFkPiW4EZJpeBE1FxVqwou7vcMm0vr35HUS2/kcOGrkzmiCxCHsUr8eodVCCODeqeUc6hzH+pxQsBhPobe4twQHjVfviXV8+pQ0=
Message-ID: <8bd0f97a0612182120q30361eceq6219b509f8add29a@mail.gmail.com>
Date: Tue, 19 Dec 2006 00:20:42 -0500
From: "Mike Frysinger" <vapier.adi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] search a little harder for mkimage
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_23475_5158819.1166505642154"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_23475_5158819.1166505642154
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

this small patch checks to see if `${CROSS_COMPILE}mkimage` exists and
if not, fall back to the standard `mkimage`

the Blackfin toolchain includes mkimage, but we dont want to namespace
collide with any of the user's system setup, so we prefix it with our
toolchain name
-mike

------=_Part_23475_5158819.1166505642154
Content-Type: text/x-patch; name="check-cross-compile-mkimage.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="check-cross-compile-mkimage.patch"
X-Attachment-Id: f_evvvaqxo

Q2hlY2sgdG8gc2VlIGlmIHRoZSBta2ltYWdlIHRvb2wgaXMgcGFydCBvZiB0aGUgY3Jvc3MtY29t
cGlsZSB0b29sY2hhaW4uCgpTaWduZWQtb2ZmLWJ5OiBNaWtlIEZyeXNpbmdlciA8dmFwaWVyQGdl
bnRvby5vcmc+CgotLS0gYS9saW51eC0yLjYvc2NyaXB0cy9ta3Vib290LnNoCisrKyBiL2xpbnV4
LTIuNi9zY3JpcHRzL21rdWJvb3Quc2gKQEAgLTQsMTIgKzQsMTUgQEAKICMgQnVpbGQgVS1Cb290
IGltYWdlIHdoZW4gYG1raW1hZ2UnIHRvb2wgaXMgYXZhaWxhYmxlLgogIwogCi1NS0lNQUdFPSQo
dHlwZSAtcGF0aCBta2ltYWdlKQorTUtJTUFHRT0kKHR5cGUgLXBhdGggJHtDUk9TU19DT01QSUxF
fW1raW1hZ2UpCiAKIGlmIFsgLXogIiR7TUtJTUFHRX0iIF07IHRoZW4KLQkjIERvZXNuJ3QgZXhp
c3QKLQllY2hvICcibWtpbWFnZSIgY29tbWFuZCBub3QgZm91bmQgLSBVLUJvb3QgaW1hZ2VzIHdp
bGwgbm90IGJlIGJ1aWx0JyA+JjIKLQlleGl0IDA7CisJTUtJTUFHRT0kKHR5cGUgLXBhdGggbWtp
bWFnZSkKKwlpZiBbIC16ICIke01LSU1BR0V9IiBdOyB0aGVuCisJCSMgRG9lc24ndCBleGlzdAor
CQllY2hvICcibWtpbWFnZSIgY29tbWFuZCBub3QgZm91bmQgLSBVLUJvb3QgaW1hZ2VzIHdpbGwg
bm90IGJlIGJ1aWx0JyA+JjIKKwkJZXhpdCAwOworCWZpCiBmaQogCiAjIENhbGwgIm1raW1hZ2Ui
IHRvIGNyZWF0ZSBVLUJvb3QgaW1hZ2UK
------=_Part_23475_5158819.1166505642154--
