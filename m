Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbVKHM6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbVKHM6q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 07:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbVKHM6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 07:58:46 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:1588
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965136AbVKHM6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 07:58:44 -0500
Message-Id: <4370AF4A.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 13:59:38 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] CONFIG_UNWIND_INFO
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartD0F2EE2A.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartD0F2EE2A.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

As a foundation for reliable stack unwinding, this adds a config option
(available to all architectures except IA64) to enable the generation
of frame unwind information.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__PartD0F2EE2A.0__=
Content-Type: application/octet-stream; name="linux-2.6.14-unwind-info.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-unwind-info.patch"

QXMgYSBmb3VuZGF0aW9uIGZvciByZWxpYWJsZSBzdGFjayB1bndpbmRpbmcsIHRoaXMgYWRkcyBh
IGNvbmZpZyBvcHRpb24KKGF2YWlsYWJsZSB0byBhbGwgYXJjaGl0ZWN0dXJlcyBleGNlcHQgSUE2
NCkgdG8gZW5hYmxlIHRoZSBnZW5lcmF0aW9uCm9mIGZyYW1lIHVud2luZCBpbmZvcm1hdGlvbi4K
CkZyb206IEphbiBCZXVsaWNoIDxqYmV1bGljaEBub3ZlbGwuY29tPgoKLS0tIDIuNi4xNC9NYWtl
ZmlsZQkyMDA1LTEwLTI4IDAyOjAyOjA4LjAwMDAwMDAwMCArMDIwMAorKysgMi42LjE0LXVud2lu
ZC1pbmZvL01ha2VmaWxlCTIwMDUtMTEtMDQgMTY6MjA6NTcuMDAwMDAwMDAwICswMTAwCkBAIC01
MTcsNiArNTE3LDEwIEBAIENGTEFHUwkJKz0gJChjYWxsIGFkZC1hbGlnbixDT05GSUdfQ0NfQUwK
IENGTEFHUwkJKz0gJChjYWxsIGFkZC1hbGlnbixDT05GSUdfQ0NfQUxJR05fTE9PUFMsLWxvb3Bz
KQogQ0ZMQUdTCQkrPSAkKGNhbGwgYWRkLWFsaWduLENPTkZJR19DQ19BTElHTl9KVU1QUywtanVt
cHMpCiAKK2lmZGVmIENPTkZJR19VTldJTkRfSU5GTworQ0ZMQUdTCQkrPSAtZmFzeW5jaHJvbm91
cy11bndpbmQtdGFibGVzCitlbmRpZgorCiBpZmRlZiBDT05GSUdfRlJBTUVfUE9JTlRFUgogQ0ZM
QUdTCQkrPSAtZm5vLW9taXQtZnJhbWUtcG9pbnRlciAkKGNhbGwgY2Mtb3B0aW9uLC1mbm8tb3B0
aW1pemUtc2libGluZy1jYWxscywpCiBlbHNlCi0tLSAyLjYuMTQvbGliL0tjb25maWcuZGVidWcJ
MjAwNS0xMC0yOCAwMjowMjowOC4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xNC11bndpbmQtaW5m
by9saWIvS2NvbmZpZy5kZWJ1ZwkyMDA1LTExLTA4IDEwOjM2OjM5LjAwMDAwMDAwMCArMDEwMApA
QCAtMTc4LDMgKzE3OCwxMiBAQCBjb25maWcgRlJBTUVfUE9JTlRFUgogCSAgb24gc29tZSBhcmNo
aXRlY3R1cmVzIG9yIHlvdSB1c2UgZXh0ZXJuYWwgZGVidWdnZXJzLgogCSAgSWYgeW91IGRvbid0
IGRlYnVnIHRoZSBrZXJuZWwsIHlvdSBjYW4gc2F5IE4uCiAKK2NvbmZpZyBVTldJTkRfSU5GTwor
CWJvb2wgIkNvbXBpbGUgdGhlIGtlcm5lbCB3aXRoIGZyYW1lIHVud2luZCBpbmZvcm1hdGlvbiIK
KwlkZXBlbmRzIG9uICFJQTY0CisJZGVmYXVsdCBERUJVR19LRVJORUwKKwloZWxwCisJICBJZiB5
b3Ugc2F5IFkgaGVyZSB0aGUgcmVzdWx0aW5nIGtlcm5lbCBpbWFnZSB3aWxsIGJlIHNsaWdodGx5
IGxhcmdlcgorCSAgYnV0IG5vdCBzbG93ZXIsIGFuZCBpdCB3aWxsIGdpdmUgdmVyeSB1c2VmdWwg
ZGVidWdnaW5nIGluZm9ybWF0aW9uLgorCSAgSWYgeW91IGRvbid0IGRlYnVnIHRoZSBrZXJuZWws
IHlvdSBjYW4gc2F5IE4sIGJ1dCB3ZSBtYXkgbm90IGJlIGFibGUKKwkgIHRvIHNvbHZlIHByb2Js
ZW1zIHdpdGhvdXQgZnJhbWUgdW53aW5kIGluZm9ybWF0aW9uIG9yIGZyYW1lIHBvaW50ZXJzLgo=

--=__PartD0F2EE2A.0__=--
