Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVKIOFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVKIOFK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVKIOFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:05:09 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:37423
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750736AbVKIOFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:05:07 -0500
Message-Id: <4372105B.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 09 Nov 2005 15:06:03 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/39] NLKD - time adjustment
References: <43720DAE.76F0.0078.0@novell.com> <43720E2E.76F0.0078.0@novell.com> <43720E72.76F0.0078.0@novell.com> <43720EAF.76F0.0078.0@novell.com> <43720F5E.76F0.0078.0@novell.com> <43720F95.76F0.0078.0@novell.com> <43720FBA.76F0.0078.0@novell.com> <43720FF6.76F0.0078.0@novell.com> <43721024.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part00223C5B.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part00223C5B.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Generic part of an interface to allow debuggers to update time after
having halted the system for perhaps extended periods of time. This
generally requires arch-dependent changes, too, unless the arch-
dependent time handling is already overflow-safe.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__Part00223C5B.0__=
Content-Type: application/octet-stream; name="linux-2.6.14-nlkd-time.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-nlkd-time.patch"

R2VuZXJpYyBwYXJ0IG9mIGFuIGludGVyZmFjZSB0byBhbGxvdyBkZWJ1Z2dlcnMgdG8gdXBkYXRl
IHRpbWUgYWZ0ZXIKaGF2aW5nIGhhbHRlZCB0aGUgc3lzdGVtIGZvciBwZXJoYXBzIGV4dGVuZGVk
IHBlcmlvZHMgb2YgdGltZS4gVGhpcwpnZW5lcmFsbHkgcmVxdWlyZXMgYXJjaC1kZXBlbmRlbnQg
Y2hhbmdlcywgdG9vLCB1bmxlc3MgdGhlIGFyY2gtCmRlcGVuZGVudCB0aW1lIGhhbmRsaW5nIGlz
IGFscmVhZHkgb3ZlcmZsb3ctc2FmZS4KClNpZ25lZC1PZmYtQnk6IEphbiBCZXVsaWNoIDxqYmV1
bGljaEBub3ZlbGwuY29tPgoKSW5kZXg6IDIuNi4xNC1ubGtkL2luY2x1ZGUvbGludXgvamlmZmll
cy5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0KLS0tIDIuNi4xNC1ubGtkLm9yaWcvaW5jbHVkZS9saW51eC9qaWZmaWVz
LmgJMjAwNS0xMS0wOSAxMDo0MDoxNy4wMDAwMDAwMDAgKzAxMDAKKysrIDIuNi4xNC1ubGtkL2lu
Y2x1ZGUvbGludXgvamlmZmllcy5oCTIwMDUtMTEtMDQgMTY6MTk6MzQuMDAwMDAwMDAwICswMTAw
CkBAIC04Myw2ICs4MywxMSBAQAogICovCiBleHRlcm4gdTY0IF9famlmZnlfZGF0YSBqaWZmaWVz
XzY0OwogZXh0ZXJuIHVuc2lnbmVkIGxvbmcgdm9sYXRpbGUgX19qaWZmeV9kYXRhIGppZmZpZXM7
CisjaWZuZGVmIENPTkZJR19ERUJVR19LRVJORUwKKyMgZGVmaW5lIGRlYnVnZ2VyX2ppZmZpZXMg
MAorI2Vsc2UKK2V4dGVybiB1NjQgZGVidWdnZXJfamlmZmllczsKKyNlbmRpZgogCiAjaWYgKEJJ
VFNfUEVSX0xPTkcgPCA2NCkKIHU2NCBnZXRfamlmZmllc182NCh2b2lkKTsKSW5kZXg6IDIuNi4x
NC1ubGtkL2tlcm5lbC90aW1lci5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIDIuNi4xNC1ubGtkLm9yaWcva2Vy
bmVsL3RpbWVyLmMJMjAwNS0xMS0wOSAxMDo0MDoxNy4wMDAwMDAwMDAgKzAxMDAKKysrIDIuNi4x
NC1ubGtkL2tlcm5lbC90aW1lci5jCTIwMDUtMTEtMDcgMTU6MjA6MjcuMDAwMDAwMDAwICswMTAw
CkBAIC00Niw2ICs0NiwxMCBAQCBzdGF0aWMgdm9pZCB0aW1lX2ludGVycG9sYXRvcl91cGRhdGUo
bG9uCiAjZGVmaW5lIHRpbWVfaW50ZXJwb2xhdG9yX3VwZGF0ZSh4KQogI2VuZGlmCiAKKyNpZmRl
ZiBDT05GSUdfREVCVUdfS0VSTkVMCit1NjQgZGVidWdnZXJfamlmZmllczsKKyNlbmRpZgorCiAv
KgogICogcGVyLUNQVSB0aW1lciB2ZWN0b3IgZGVmaW5pdGlvbnM6CiAgKi8KQEAgLTkzNSw2ICs5
MzksMjggQEAgc3RhdGljIGlubGluZSB2b2lkIHVwZGF0ZV90aW1lcyh2b2lkKQogCXRpY2tzID0g
amlmZmllcyAtIHdhbGxfamlmZmllczsKIAlpZiAodGlja3MpIHsKIAkJd2FsbF9qaWZmaWVzICs9
IHRpY2tzOworI2lmbmRlZiBkZWJ1Z2dlcl9qaWZmaWVzCisJCWlmICh0aWNrcyA+IDEKKwkJICAg
ICYmIGRlYnVnZ2VyX2ppZmZpZXMKKwkJICAgICYmIGppZmZpZXNfNjQgLSBkZWJ1Z2dlcl9qaWZm
aWVzID4gMSkgeworCQkJdTY0IG5zZWM2NCA9ICh1NjQpKHRpY2tzIC0gMSkgKiB0aWNrX25zZWM7
CisJCQl1bnNpZ25lZCBsb25nIG5zZWMgPSBkb19kaXYobnNlYzY0LCBOU0VDX1BFUl9TRUMpOwor
CQkJdW5zaWduZWQgbG9uZyBzZWMgPSBuc2VjNjQ7CisKKwkJCWlmIChzZWMgPiAwCisJCQkgICAg
JiYgeHRpbWUudHZfbnNlYyArIG5zZWMgKyB0aWNrX25zZWMgPCBOU0VDX1BFUl9TRUMpIHsKKwkJ
CQkvKiBNYWtlIHN1cmUgeHRpbWUudHZfbnNlYyBleGNlZWRzIGEgc2Vjb25kIHdoZW4KKwkJCQkg
ICBjaGVja2VkIChpbiB1cGRhdGVfd2FsbF90aW1lKS4gKi8KKwkJCQlzZWMtLTsKKwkJCQluc2Vj
ICs9IE5TRUNfUEVSX1NFQzsKKwkJCX0KKwkJCXh0aW1lLnR2X3NlYyArPSBzZWM7CisJCQl4dGlt
ZS50dl9uc2VjICs9IG5zZWM7CisJCQl0b3VjaF9zb2Z0bG9ja3VwX3dhdGNoZG9nKCk7CisJCQl0
aWNrcyA9IDE7CisJCX0KKwkJZGVidWdnZXJfamlmZmllcyA9IDA7CisjZW5kaWYKIAkJdXBkYXRl
X3dhbGxfdGltZSh0aWNrcyk7CiAJfQogCWNhbGNfbG9hZCh0aWNrcyk7Cg==

--=__Part00223C5B.0__=--
