Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVKIOAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVKIOAx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVKIOAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:00:53 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:47918
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750764AbVKIOAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:00:52 -0500
Message-Id: <43720F5E.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 09 Nov 2005 15:01:50 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/39] NLKD - early panic notification
References: <43720DAE.76F0.0078.0@novell.com> <43720E2E.76F0.0078.0@novell.com> <43720E72.76F0.0078.0@novell.com> <43720EAF.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part06243A5E.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part06243A5E.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

A mechanism to allow debuggers to intercept panic events early.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__Part06243A5E.0__=
Content-Type: application/octet-stream; name="linux-2.6.14-nlkd-notify-prepanic.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-nlkd-notify-prepanic.patch"

QSBtZWNoYW5pc20gdG8gYWxsb3cgZGVidWdnZXJzIHRvIGludGVyY2VwdCBwYW5pYyBldmVudHMg
ZWFybHkuCgpTaWduZWQtT2ZmLUJ5OiBKYW4gQmV1bGljaCA8amJldWxpY2hAbm92ZWxsLmNvbT4K
CkluZGV4OiAyLjYuMTQtbmxrZC9pbmNsdWRlL2xpbnV4L2tlcm5lbC5oCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0t
IDIuNi4xNC1ubGtkLm9yaWcvaW5jbHVkZS9saW51eC9rZXJuZWwuaAkyMDA1LTExLTA5IDEwOjQw
OjE3LjAwMDAwMDAwMCArMDEwMAorKysgMi42LjE0LW5sa2QvaW5jbHVkZS9saW51eC9rZXJuZWwu
aAkyMDA1LTExLTA0IDE2OjE5OjM0LjAwMDAwMDAwMCArMDEwMApAQCAtODYsNiArODYsNyBAQCBl
eHRlcm4gaW50IGNvbmRfcmVzY2hlZCh2b2lkKTsKIAl9KQogCiBleHRlcm4gc3RydWN0IG5vdGlm
aWVyX2Jsb2NrICpwYW5pY19ub3RpZmllcl9saXN0OworZXh0ZXJuIHN0cnVjdCBub3RpZmllcl9i
bG9jayAqcHJlcGFuaWNfbm90aWZpZXJfbGlzdDsKIGV4dGVybiBsb25nICgqcGFuaWNfYmxpbmsp
KGxvbmcgdGltZSk7CiBOT1JFVF9UWVBFIHZvaWQgcGFuaWMoY29uc3QgY2hhciAqIGZtdCwgLi4u
KQogCV9fYXR0cmlidXRlX18gKChOT1JFVF9BTkQgZm9ybWF0IChwcmludGYsIDEsIDIpKSk7Cklu
ZGV4OiAyLjYuMTQtbmxrZC9rZXJuZWwvcGFuaWMuYwo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSAyLjYuMTQtbmxr
ZC5vcmlnL2tlcm5lbC9wYW5pYy5jCTIwMDUtMTEtMDkgMTA6NDA6MTcuMDAwMDAwMDAwICswMTAw
CisrKyAyLjYuMTQtbmxrZC9rZXJuZWwvcGFuaWMuYwkyMDA1LTExLTA0IDE2OjE5OjM0LjAwMDAw
MDAwMCArMDEwMApAQCAtMjcsOCArMjcsMTAgQEAgaW50IHRhaW50ZWQ7CiBFWFBPUlRfU1lNQk9M
KHBhbmljX3RpbWVvdXQpOwogCiBzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKnBhbmljX25vdGlmaWVy
X2xpc3Q7CitzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKnByZXBhbmljX25vdGlmaWVyX2xpc3Q7CiAK
IEVYUE9SVF9TWU1CT0wocGFuaWNfbm90aWZpZXJfbGlzdCk7CitFWFBPUlRfU1lNQk9MKHByZXBh
bmljX25vdGlmaWVyX2xpc3QpOwogCiBzdGF0aWMgaW50IF9faW5pdCBwYW5pY19zZXR1cChjaGFy
ICpzdHIpCiB7CkBAIC03Niw2ICs3OCw3IEBAIE5PUkVUX1RZUEUgdm9pZCBwYW5pYyhjb25zdCBj
aGFyICogZm10LCAKIAl2c25wcmludGYoYnVmLCBzaXplb2YoYnVmKSwgZm10LCBhcmdzKTsKIAl2
YV9lbmQoYXJncyk7CiAJcHJpbnRrKEtFUk5fRU1FUkcgIktlcm5lbCBwYW5pYyAtIG5vdCBzeW5j
aW5nOiAlc1xuIixidWYpOworCW5vdGlmaWVyX2NhbGxfY2hhaW4oJnByZXBhbmljX25vdGlmaWVy
X2xpc3QsIDAsIGJ1Zik7CiAJYnVzdF9zcGlubG9ja3MoMCk7CiAKIAkvKgo=

--=__Part06243A5E.0__=--
