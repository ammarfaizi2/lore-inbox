Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbVKHQto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbVKHQto (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVKHQto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:49:44 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:14944
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932491AbVKHQtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:49:43 -0500
Message-Id: <4370E56D.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 17:50:37 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386: fix bound check IDT gate
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartC1E3FF4D.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartC1E3FF4D.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Other than apparently commonly assumed, the bound instruction does not
require the corresponding IDT entry to have DPL 3.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__PartC1E3FF4D.0__=
Content-Type: application/octet-stream; name="linux-2.6.14-i386-bound.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-i386-bound.patch"

T3RoZXIgdGhhbiBhcHBhcmVudGx5IGNvbW1vbmx5IGFzc3VtZWQsIHRoZSBib3VuZCBpbnN0cnVj
dGlvbiBkb2VzIG5vdApyZXF1aXJlIHRoZSBjb3JyZXNwb25kaW5nIElEVCBlbnRyeSB0byBoYXZl
IERQTCAzLgoKRnJvbTogSmFuIEJldWxpY2ggPGpiZXVsaWNoQG5vdmVsbC5jb20+CgotLS0gMi42
LjE0L2FyY2gvaTM4Ni9rZXJuZWwvdHJhcHMuYwkyMDA1LTEwLTI4IDAyOjAyOjA4LjAwMDAwMDAw
MCArMDIwMAorKysgMi42LjE0LWkzODYtYm91bmQvYXJjaC9pMzg2L2tlcm5lbC90cmFwcy5jCTIw
MDUtMTEtMDQgMTc6MDA6NDcuMDAwMDAwMDAwICswMTAwCkBAIC0xMDgxLDkgKzEwODEsOSBAQCB2
b2lkIF9faW5pdCB0cmFwX2luaXQodm9pZCkKIAlzZXRfdHJhcF9nYXRlKDAsJmRpdmlkZV9lcnJv
cik7CiAJc2V0X2ludHJfZ2F0ZSgxLCZkZWJ1Zyk7CiAJc2V0X2ludHJfZ2F0ZSgyLCZubWkpOwot
CXNldF9zeXN0ZW1faW50cl9nYXRlKDMsICZpbnQzKTsgLyogaW50My01IGNhbiBiZSBjYWxsZWQg
ZnJvbSBhbGwgKi8KKwlzZXRfc3lzdGVtX2ludHJfZ2F0ZSgzLCAmaW50Myk7IC8qIGludDMvNCBj
YW4gYmUgY2FsbGVkIGZyb20gYWxsICovCiAJc2V0X3N5c3RlbV9nYXRlKDQsJm92ZXJmbG93KTsK
LQlzZXRfc3lzdGVtX2dhdGUoNSwmYm91bmRzKTsKKwlzZXRfdHJhcF9nYXRlKDUsJmJvdW5kcyk7
CiAJc2V0X3RyYXBfZ2F0ZSg2LCZpbnZhbGlkX29wKTsKIAlzZXRfdHJhcF9nYXRlKDcsJmRldmlj
ZV9ub3RfYXZhaWxhYmxlKTsKIAlzZXRfdGFza19nYXRlKDgsR0RUX0VOVFJZX0RPVUJMRUZBVUxU
X1RTUyk7Cg==

--=__PartC1E3FF4D.0__=--
