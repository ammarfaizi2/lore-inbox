Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVBADa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVBADa2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 22:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVBADa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 22:30:28 -0500
Received: from [195.23.16.24] ([195.23.16.24]:22155 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261519AbVBADaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 22:30:16 -0500
Message-ID: <1107228501.41fef755e66e8@webmail.grupopie.com>
Date: Tue,  1 Feb 2005 03:28:21 +0000
From: "" <pmarques@grupopie.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] 1/7 create kstrdup library function
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ110722850125d9ae896cd9d74201e447a3802e075b"
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 82.154.143.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

---MOQ110722850125d9ae896cd9d74201e447a3802e075b
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


This patch creates the kstrdup library function so that it doesn't have t=
o be
reimplemented (or even EXPORT'ed) by every user that needs it.

Signed-off-by: Paulo Marques <pmarques@grupopie.com>

--
Paulo Marques - www.grupopie.com
=20
All that is necessary for the triumph of evil is that good men do nothing=
.
Edmund Burke (1729 - 1797)

---MOQ110722850125d9ae896cd9d74201e447a3802e075b
Content-Type: text/x-diff; name="patch1"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch1"

ZGlmZiAtYnVwck4gLVggZG9udGRpZmYgdmFuaWxsYS0yLjYuMTEtcmMyLWJrOS9pbmNsdWRlL2xp
bnV4L3N0cmluZy5oIGxpbnV4LTIuNi4xMS1yYzItYms5L2luY2x1ZGUvbGludXgvc3RyaW5nLmgK
LS0tIHZhbmlsbGEtMi42LjExLXJjMi1iazkvaW5jbHVkZS9saW51eC9zdHJpbmcuaAkyMDA0LTEy
LTI0IDIxOjM0OjMxLjAwMDAwMDAwMCArMDAwMAorKysgbGludXgtMi42LjExLXJjMi1iazkvaW5j
bHVkZS9saW51eC9zdHJpbmcuaAkyMDA1LTAxLTMxIDE5OjMxOjEyLjAwMDAwMDAwMCArMDAwMApA
QCAtODgsNiArODgsOCBAQCBleHRlcm4gaW50IG1lbWNtcChjb25zdCB2b2lkICosY29uc3Qgdm9p
CiBleHRlcm4gdm9pZCAqIG1lbWNocihjb25zdCB2b2lkICosaW50LF9fa2VybmVsX3NpemVfdCk7
CiAjZW5kaWYKCitleHRlcm4gY2hhciAqa3N0cmR1cChjb25zdCBjaGFyICpzLCBpbnQgZ2ZwKTsK
KwogI2lmZGVmIF9fY3BsdXNwbHVzCiB9CiAjZW5kaWYKZGlmZiAtYnVwck4gLVggZG9udGRpZmYg
dmFuaWxsYS0yLjYuMTEtcmMyLWJrOS9saWIvc3RyaW5nLmMgbGludXgtMi42LjExLXJjMi1iazkv
bGliL3N0cmluZy5jCi0tLSB2YW5pbGxhLTIuNi4xMS1yYzItYms5L2xpYi9zdHJpbmcuYwkyMDA1
LTAxLTMxIDIwOjA1OjM3LjAwMDAwMDAwMCArMDAwMAorKysgbGludXgtMi42LjExLXJjMi1iazkv
bGliL3N0cmluZy5jCTIwMDUtMDEtMzEgMjA6MDA6MzEuMDAwMDAwMDAwICswMDAwCkBAIC01OTks
MyArNTk5LDIzIEBAIHZvaWQgKm1lbWNocihjb25zdCB2b2lkICpzLCBpbnQgYywgc2l6ZV8KIH0K
IEVYUE9SVF9TWU1CT0wobWVtY2hyKTsKICNlbmRpZgorCisvKgorICoga3N0cmR1cCAtIGFsbG9j
YXRlIHNwYWNlIGZvciBhbmQgY29weSBhbiBleGlzdGluZyBzdHJpbmcKKyAqCisgKiBAczogdGhl
IHN0cmluZyB0byBkdXBsaWNhdGUKKyAqIEBnZnA6IHRoZSBHRlAgbWFzayB1c2VkIGluIHRoZSBr
bWFsbG9jKCkgY2FsbCB3aGVuIGFsbG9jYXRpbmcgbWVtb3J5CisgKi8KK2NoYXIgKmtzdHJkdXAo
Y29uc3QgY2hhciAqcywgaW50IGdmcCkKK3sKKwlpbnQgbGVuOworCWNoYXIgKmJ1ZjsKKworCWlm
ICghcykgcmV0dXJuIE5VTEw7CisKKwlsZW4gPSBzdHJsZW4ocykgKyAxOworCWJ1ZiA9IGttYWxs
b2MobGVuLCBnZnApOworCWlmIChidWYpCisJCW1lbWNweShidWYsIHMsIGxlbik7CisJcmV0dXJu
IGJ1ZjsKK30KKworRVhQT1JUX1NZTUJPTChrc3RyZHVwKTsK

---MOQ110722850125d9ae896cd9d74201e447a3802e075b--
