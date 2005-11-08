Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbVKHNBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbVKHNBa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 08:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbVKHNBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 08:01:30 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:35380
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965115AbVKHNB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 08:01:29 -0500
Message-Id: <4370AFF0.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 14:02:24 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH] x86-64: separate unwind info generation from
	CONFIG_DEBUG_INFO
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part0A2834F0.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part0A2834F0.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

As a follow-up to the introduction of CONFIG_UNWIND_INFO, this
separates the generation of frame unwind information for x86-64 from
that of full debug information.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__Part0A2834F0.1__=
Content-Type: application/octet-stream; name="linux-2.6.14-unwind-info-x86_64.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-unwind-info-x86_64.patch"

QXMgYSBmb2xsb3ctdXAgdG8gdGhlIGludHJvZHVjdGlvbiBvZiBDT05GSUdfVU5XSU5EX0lORk8s
IHRoaXMKc2VwYXJhdGVzIHRoZSBnZW5lcmF0aW9uIG9mIGZyYW1lIHVud2luZCBpbmZvcm1hdGlv
biBmb3IgeDg2LTY0IGZyb20KdGhhdCBvZiBmdWxsIGRlYnVnIGluZm9ybWF0aW9uLgoKRnJvbTog
SmFuIEJldWxpY2ggPGpiZXVsaWNoQG5vdmVsbC5jb20+CgotLS0gMi42LjE0L2FyY2gveDg2XzY0
L01ha2VmaWxlCTIwMDUtMTAtMjggMDI6MDI6MDguMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTQt
dW53aW5kLWluZm8teDg2XzY0L2FyY2gveDg2XzY0L01ha2VmaWxlCTIwMDUtMTEtMDQgMTY6MTk6
MzMuMDAwMDAwMDAwICswMTAwCkBAIC0zOCw4ICszOCwxMCBAQCBDRkxBR1MgKz0gLXBpcGUKICMg
YWN0dWFsbHkgaXQgbWFrZXMgdGhlIGtlcm5lbCBzbWFsbGVyIHRvby4KIENGTEFHUyArPSAtZm5v
LXJlb3JkZXItYmxvY2tzCQogQ0ZMQUdTICs9IC1Xbm8tc2lnbi1jb21wYXJlCi1pZm5lcSAoJChD
T05GSUdfREVCVUdfSU5GTykseSkKK2lmbmVxICgkKENPTkZJR19VTldJTkRfSU5GTykseSkKIENG
TEFHUyArPSAtZm5vLWFzeW5jaHJvbm91cy11bndpbmQtdGFibGVzCitlbmRpZgoraWZuZXEgKCQo
Q09ORklHX0RFQlVHX0lORk8pLHkpCiAjIC1md2ViIHNocmlua3MgdGhlIGtlcm5lbCBhIGJpdCwg
YnV0IHRoZSBkaWZmZXJlbmNlIGlzIHZlcnkgc21hbGwKICMgaXQgYWxzbyBtZXNzZXMgdXAgZGVi
dWdnaW5nLCBzbyBkb24ndCB1c2UgaXQgZm9yIG5vdy4KICNDRkxBR1MgKz0gJChjYWxsIGNjLW9w
dGlvbiwtZndlYikKLS0tIDIuNi4xNC9hcmNoL3g4Nl82NC9rZXJuZWwvdm1saW51eC5sZHMuUwky
MDA1LTEwLTI4IDAyOjAyOjA4LjAwMDAwMDAwMCArMDIwMAorKysgMi42LjE0LXVud2luZC1pbmZv
LXg4Nl82NC9hcmNoL3g4Nl82NC9rZXJuZWwvdm1saW51eC5sZHMuUwkyMDA1LTExLTA0IDE2OjE5
OjMzLjAwMDAwMDAwMCArMDEwMApAQCAtMTg5LDcgKzE4OSw3IEBAIFNFQ1RJT05TCiAgIC8qIFNl
Y3Rpb25zIHRvIGJlIGRpc2NhcmRlZCAqLwogICAvRElTQ0FSRC8gOiB7CiAJKiguZXhpdGNhbGwu
ZXhpdCkKLSNpZm5kZWYgQ09ORklHX0RFQlVHX0lORk8KKyNpZm5kZWYgQ09ORklHX1VOV0lORF9J
TkZPCiAJKiguZWhfZnJhbWUpCiAjZW5kaWYKIAl9Ci0tLSAyLjYuMTQvaW5jbHVkZS9hc20teDg2
XzY0L2R3YXJmMi5oCTIwMDUtMTAtMjggMDI6MDI6MDguMDAwMDAwMDAwICswMjAwCisrKyAyLjYu
MTQtdW53aW5kLWluZm8teDg2XzY0L2luY2x1ZGUvYXNtLXg4Nl82NC9kd2FyZjIuaAkyMDA1LTEx
LTA0IDE2OjE5OjM0LjAwMDAwMDAwMCArMDEwMApAQCAtMTQsNyArMTQsNyBAQAogICAgYXdheSBm
b3Igb2xkZXIgdmVyc2lvbi4gCiAgKi8KIAotI2lmZGVmIENPTkZJR19ERUJVR19JTkZPCisjaWZk
ZWYgQ09ORklHX1VOV0lORF9JTkZPCiAKICNkZWZpbmUgQ0ZJX1NUQVJUUFJPQyAuY2ZpX3N0YXJ0
cHJvYwogI2RlZmluZSBDRklfRU5EUFJPQyAuY2ZpX2VuZHByb2MK

--=__Part0A2834F0.1__=--
