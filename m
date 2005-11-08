Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbVKHQwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbVKHQwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965133AbVKHQwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:52:07 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:42592
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965080AbVKHQwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:52:06 -0500
Message-Id: <4370E5FB.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 17:52:59 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386: int3 adjustment
References: <4370AEE1.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part775549FB.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part775549FB.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Remove conditionals from the way INT3 is handled; since the IDT gate
is always set up as an interrupt gate, the restore_interrupts() call
should also always be issued, making the conditional code unnecessary.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__Part775549FB.0__=
Content-Type: application/octet-stream; name="linux-2.6.14-i386-int3.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-i386-int3.patch"

UmVtb3ZlIGNvbmRpdGlvbmFscyBmcm9tIHRoZSB3YXkgSU5UMyBpcyBoYW5kbGVkOyBzaW5jZSB0
aGUgSURUIGdhdGUKaXMgYWx3YXlzIHNldCB1cCBhcyBhbiBpbnRlcnJ1cHQgZ2F0ZSwgdGhlIHJl
c3RvcmVfaW50ZXJydXB0cygpIGNhbGwKc2hvdWxkIGFsc28gYWx3YXlzIGJlIGlzc3VlZCwgbWFr
aW5nIHRoZSBjb25kaXRpb25hbCBjb2RlIHVubmVjZXNzYXJ5LgoKRnJvbTogSmFuIEJldWxpY2gg
PGpiZXVsaWNoQG5vdmVsbC5jb20+CgotLS0gMi42LjE0L2FyY2gvaTM4Ni9rZXJuZWwvdHJhcHMu
YwkyMDA1LTEwLTI4IDAyOjAyOjA4LjAwMDAwMDAwMCArMDIwMAorKysgMi42LjE0LWkzODYtaW50
My9hcmNoL2kzODYva2VybmVsL3RyYXBzLmMJMjAwNS0xMS0wNCAxNzowMDo0Ny4wMDAwMDAwMDAg
KzAxMDAKQEAgLTQ0Nyw5ICs0NDcsNiBAQCBmYXN0Y2FsbCB2b2lkIGRvXyMjbmFtZShzdHJ1Y3Qg
cHRfcmVncyAqCiB9CiAKIERPX1ZNODZfRVJST1JfSU5GTyggMCwgU0lHRlBFLCAgImRpdmlkZSBl
cnJvciIsIGRpdmlkZV9lcnJvciwgRlBFX0lOVERJViwgcmVncy0+ZWlwKQotI2lmbmRlZiBDT05G
SUdfS1BST0JFUwotRE9fVk04Nl9FUlJPUiggMywgU0lHVFJBUCwgImludDMiLCBpbnQzKQotI2Vu
ZGlmCiBET19WTTg2X0VSUk9SKCA0LCBTSUdTRUdWLCAib3ZlcmZsb3ciLCBvdmVyZmxvdykKIERP
X1ZNODZfRVJST1IoIDUsIFNJR1NFR1YsICJib3VuZHMiLCBib3VuZHMpCiBET19FUlJPUl9JTkZP
KCA2LCBTSUdJTEwsICAiaW52YWxpZCBvcGVyYW5kIiwgaW52YWxpZF9vcCwgSUxMX0lMTE9QTiwg
cmVncy0+ZWlwKQpAQCAtNjc2LDcgKzY3Myw2IEBAIHZvaWQgdW5zZXRfbm1pX2NhbGxiYWNrKHZv
aWQpCiB9CiBFWFBPUlRfU1lNQk9MX0dQTCh1bnNldF9ubWlfY2FsbGJhY2spOwogCi0jaWZkZWYg
Q09ORklHX0tQUk9CRVMKIGZhc3RjYWxsIHZvaWQgX19rcHJvYmVzIGRvX2ludDMoc3RydWN0IHB0
X3JlZ3MgKnJlZ3MsIGxvbmcgZXJyb3JfY29kZSkKIHsKIAlpZiAobm90aWZ5X2RpZShESUVfSU5U
MywgImludDMiLCByZWdzLCBlcnJvcl9jb2RlLCAzLCBTSUdUUkFQKQpAQCAtNjg3LDcgKzY4Myw2
IEBAIGZhc3RjYWxsIHZvaWQgX19rcHJvYmVzIGRvX2ludDMoc3RydWN0IHAKIAlyZXN0b3JlX2lu
dGVycnVwdHMocmVncyk7CiAJZG9fdHJhcCgzLCBTSUdUUkFQLCAiaW50MyIsIDEsIHJlZ3MsIGVy
cm9yX2NvZGUsIE5VTEwpOwogfQotI2VuZGlmCiAKIC8qCiAgKiBPdXIgaGFuZGxpbmcgb2YgdGhl
IHByb2Nlc3NvciBkZWJ1ZyByZWdpc3RlcnMgaXMgbm9uLXRyaXZpYWwuCg==

--=__Part775549FB.0__=--
