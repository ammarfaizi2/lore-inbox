Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbVKHQyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbVKHQyI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbVKHQyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:54:08 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:63840
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965136AbVKHQyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:54:06 -0500
Message-Id: <4370E676.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 17:55:02 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386: handle NMI case in IPI sending
References: <4370AEE1.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartF5D7CB76.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartF5D7CB76.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Define NMI_VECTOR for all sub-architectures, and handle it in the IPI
sending code.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__PartF5D7CB76.0__=
Content-Type: application/octet-stream; name="linux-2.6.14-i386-nmi-ipi.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-i386-nmi-ipi.patch"

RGVmaW5lIE5NSV9WRUNUT1IgZm9yIGFsbCBzdWItYXJjaGl0ZWN0dXJlcywgYW5kIGhhbmRsZSBp
dCBpbiB0aGUgSVBJCnNlbmRpbmcgY29kZS4KCkZyb206IEphbiBCZXVsaWNoIDxqYmV1bGljaEBu
b3ZlbGwuY29tPgoKLS0tIDIuNi4xNC9hcmNoL2kzODYva2VybmVsL3NtcC5jCTIwMDUtMTAtMjgg
MDI6MDI6MDguMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTQtaTM4Ni1ubWktaXBpL2FyY2gvaTM4
Ni9rZXJuZWwvc21wLmMJMjAwNS0xMS0wNCAxNjo1MToxNC4wMDAwMDAwMDAgKzAxMDAKQEAgLTEx
NCw3ICsxMTQsMTcgQEAgREVGSU5FX1BFUl9DUFUoc3RydWN0IHRsYl9zdGF0ZSwgY3B1X3RsYgog
CiBzdGF0aWMgaW5saW5lIGludCBfX3ByZXBhcmVfSUNSICh1bnNpZ25lZCBpbnQgc2hvcnRjdXQs
IGludCB2ZWN0b3IpCiB7Ci0JcmV0dXJuIEFQSUNfRE1fRklYRUQgfCBzaG9ydGN1dCB8IHZlY3Rv
ciB8IEFQSUNfREVTVF9MT0dJQ0FMOworCXVuc2lnbmVkIGludCBjZmcgPSBzaG9ydGN1dCB8IHZl
Y3RvciB8IEFQSUNfREVTVF9MT0dJQ0FMOworCisJc3dpdGNoICh2ZWN0b3IpIHsKKwlkZWZhdWx0
OgorCQljZmcgfD0gQVBJQ19ETV9GSVhFRDsKKwkJYnJlYWs7CisJY2FzZSBOTUlfVkVDVE9SOgor
CQljZmcgfD0gQVBJQ19ETV9OTUk7CisJCWJyZWFrOworCX0KKwlyZXR1cm4gY2ZnOwogfQogCiBz
dGF0aWMgaW5saW5lIGludCBfX3ByZXBhcmVfSUNSMiAodW5zaWduZWQgaW50IG1hc2spCi0tLSAy
LjYuMTQvaW5jbHVkZS9hc20taTM4Ni9tYWNoLWRlZmF1bHQvaXJxX3ZlY3RvcnMuaAkyMDA1LTEw
LTI4IDAyOjAyOjA4LjAwMDAwMDAwMCArMDIwMAorKysgMi42LjE0LWkzODYtbm1pLWlwaS9pbmNs
dWRlL2FzbS1pMzg2L21hY2gtZGVmYXVsdC9pcnFfdmVjdG9ycy5oCTIwMDUtMTEtMDQgMTY6MTk6
MzQuMDAwMDAwMDAwICswMTAwCkBAIC0yMiw2ICsyMiw3IEBACiAjaWZuZGVmIF9BU01fSVJRX1ZF
Q1RPUlNfSAogI2RlZmluZSBfQVNNX0lSUV9WRUNUT1JTX0gKIAorI2RlZmluZSBOTUlfVkVDVE9S
CQkweDAyCiAvKgogICogSURUIHZlY3RvcnMgdXNhYmxlIGZvciBleHRlcm5hbCBpbnRlcnJ1cHQg
c291cmNlcyBzdGFydAogICogYXQgMHgyMDoKLS0tIDIuNi4xNC9pbmNsdWRlL2FzbS1pMzg2L21h
Y2gtdmlzd3MvaXJxX3ZlY3RvcnMuaAkyMDA1LTEwLTI4IDAyOjAyOjA4LjAwMDAwMDAwMCArMDIw
MAorKysgMi42LjE0LWkzODYtbm1pLWlwaS9pbmNsdWRlL2FzbS1pMzg2L21hY2gtdmlzd3MvaXJx
X3ZlY3RvcnMuaAkyMDA1LTExLTA0IDE2OjE5OjM0LjAwMDAwMDAwMCArMDEwMApAQCAtMSw2ICsx
LDcgQEAKICNpZm5kZWYgX0FTTV9JUlFfVkVDVE9SU19ICiAjZGVmaW5lIF9BU01fSVJRX1ZFQ1RP
UlNfSAogCisjZGVmaW5lIE5NSV9WRUNUT1IJCTB4MDIKIC8qCiAgKiBJRFQgdmVjdG9ycyB1c2Fi
bGUgZm9yIGV4dGVybmFsIGludGVycnVwdCBzb3VyY2VzIHN0YXJ0CiAgKiBhdCAweDIwOgotLS0g
Mi42LjE0L2luY2x1ZGUvYXNtLWkzODYvbWFjaC12b3lhZ2VyL2lycV92ZWN0b3JzLmgJMjAwNS0x
MC0yOCAwMjowMjowOC4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xNC1pMzg2LW5taS1pcGkvaW5j
bHVkZS9hc20taTM4Ni9tYWNoLXZveWFnZXIvaXJxX3ZlY3RvcnMuaAkyMDA1LTExLTA0IDE2OjE5
OjM0LjAwMDAwMDAwMCArMDEwMApAQCAtMTIsNiArMTIsNyBAQAogI2lmbmRlZiBfQVNNX0lSUV9W
RUNUT1JTX0gKICNkZWZpbmUgX0FTTV9JUlFfVkVDVE9SU19ICiAKKyNkZWZpbmUgTk1JX1ZFQ1RP
UgkJMHgwMgogLyoKICAqIElEVCB2ZWN0b3JzIHVzYWJsZSBmb3IgZXh0ZXJuYWwgaW50ZXJydXB0
IHNvdXJjZXMgc3RhcnQKICAqIGF0IDB4MjA6Cg==

--=__PartF5D7CB76.0__=--
