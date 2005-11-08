Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965214AbVKHOUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbVKHOUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 09:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbVKHOUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 09:20:21 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:59717
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965214AbVKHOUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 09:20:20 -0500
Message-Id: <4370C26B.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 15:21:15 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH] x86-64: fix bound check IDT gate
References: <4370AFF0.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartA4869A4B.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartA4869A4B.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Other than apparently commonly assumed, the bound instruction does not
require the corresponding IDT entry to have DPL 3.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__PartA4869A4B.1__=
Content-Type: application/octet-stream; name="linux-2.6.14-x86_64-bound.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-x86_64-bound.patch"

T3RoZXIgdGhhbiBhcHBhcmVudGx5IGNvbW1vbmx5IGFzc3VtZWQsIHRoZSBib3VuZCBpbnN0cnVj
dGlvbiBkb2VzIG5vdApyZXF1aXJlIHRoZSBjb3JyZXNwb25kaW5nIElEVCBlbnRyeSB0byBoYXZl
IERQTCAzLgoKRnJvbTogSmFuIEJldWxpY2ggPGpiZXVsaWNoQG5vdmVsbC5jb20+CgotLS0gMi42
LjE0L2FyY2gveDg2XzY0L2tlcm5lbC90cmFwcy5jCTIwMDUtMTAtMjggMDI6MDI6MDguMDAwMDAw
MDAwICswMjAwCisrKyAyLjYuMTQteDg2XzY0LWJvdW5kL2FyY2gveDg2XzY0L2tlcm5lbC90cmFw
cy5jCTIwMDUtMTEtMDcgMDk6MzM6NTMuMDAwMDAwMDAwICswMTAwCkBAIC05MTcsOCArOTE3LDgg
QEAgdm9pZCBfX2luaXQgdHJhcF9pbml0KHZvaWQpCiAJc2V0X2ludHJfZ2F0ZV9pc3QoMSwmZGVi
dWcsREVCVUdfU1RBQ0spOwogCXNldF9pbnRyX2dhdGVfaXN0KDIsJm5taSxOTUlfU1RBQ0spOwog
CXNldF9zeXN0ZW1fZ2F0ZSgzLCZpbnQzKTsKLQlzZXRfc3lzdGVtX2dhdGUoNCwmb3ZlcmZsb3cp
OwkvKiBpbnQ0LTUgY2FuIGJlIGNhbGxlZCBmcm9tIGFsbCAqLwotCXNldF9zeXN0ZW1fZ2F0ZSg1
LCZib3VuZHMpOworCXNldF9zeXN0ZW1fZ2F0ZSg0LCZvdmVyZmxvdyk7CS8qIGludDQgY2FuIGJl
IGNhbGxlZCBmcm9tIGFsbCAqLworCXNldF9pbnRyX2dhdGUoNSwmYm91bmRzKTsKIAlzZXRfaW50
cl9nYXRlKDYsJmludmFsaWRfb3ApOwogCXNldF9pbnRyX2dhdGUoNywmZGV2aWNlX25vdF9hdmFp
bGFibGUpOwogCXNldF9pbnRyX2dhdGVfaXN0KDgsJmRvdWJsZV9mYXVsdCwgRE9VQkxFRkFVTFRf
U1RBQ0spOwo=

--=__PartA4869A4B.1__=--
