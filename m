Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbVKHMy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbVKHMy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 07:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbVKHMy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 07:54:56 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:18483
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965068AbVKHMyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 07:54:55 -0500
Message-Id: <4370AE63.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 13:55:47 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386: don't blindly enable interrupts in die()
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartB89A8643.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartB89A8643.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Rather than blindly re-enabling interrupts in die(), save their state
upon entry and then restore that state.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__PartB89A8643.0__=
Content-Type: application/octet-stream; name="linux-2.6.14-i386-die-irq.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-i386-die-irq.patch"

UmF0aGVyIHRoYW4gYmxpbmRseSByZS1lbmFibGluZyBpbnRlcnJ1cHRzIGluIGRpZSgpLCBzYXZl
IHRoZWlyIHN0YXRlCnVwb24gZW50cnkgYW5kIHRoZW4gcmVzdG9yZSB0aGF0IHN0YXRlLgoKRnJv
bTogSmFuIEJldWxpY2ggPGpiZXVsaWNoQG5vdmVsbC5jb20+CgotLS0gMi42LjE0L2FyY2gvaTM4
Ni9rZXJuZWwvdHJhcHMuYwkyMDA1LTEwLTI4IDAyOjAyOjA4LjAwMDAwMDAwMCArMDIwMAorKysg
Mi42LjE0LWkzODYtZGllLWlycS9hcmNoL2kzODYva2VybmVsL3RyYXBzLmMJMjAwNS0xMS0wNCAx
NzowMDo0Ny4wMDAwMDAwMDAgKzAxMDAKQEAgLTMwNiwxNCArMzA2LDE3IEBAIHZvaWQgZGllKGNv
bnN0IGNoYXIgKiBzdHIsIHN0cnVjdCBwdF9yZWcKIAkJLmxvY2tfb3duZXJfZGVwdGggPQkwCiAJ
fTsKIAlzdGF0aWMgaW50IGRpZV9jb3VudGVyOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAKIAlp
ZiAoZGllLmxvY2tfb3duZXIgIT0gcmF3X3NtcF9wcm9jZXNzb3JfaWQoKSkgewogCQljb25zb2xl
X3ZlcmJvc2UoKTsKLQkJc3Bpbl9sb2NrX2lycSgmZGllLmxvY2spOworCQlzcGluX2xvY2tfaXJx
c2F2ZSgmZGllLmxvY2ssIGZsYWdzKTsKIAkJZGllLmxvY2tfb3duZXIgPSBzbXBfcHJvY2Vzc29y
X2lkKCk7CiAJCWRpZS5sb2NrX293bmVyX2RlcHRoID0gMDsKIAkJYnVzdF9zcGlubG9ja3MoMSk7
CiAJfQorCWVsc2UKKwkJbG9jYWxfc2F2ZV9mbGFncyhmbGFncyk7CiAKIAlpZiAoKytkaWUubG9j
a19vd25lcl9kZXB0aCA8IDMpIHsKIAkJaW50IG5sID0gMDsKQEAgLTM0MCw3ICszNDMsNyBAQCB2
b2lkIGRpZShjb25zdCBjaGFyICogc3RyLCBzdHJ1Y3QgcHRfcmVnCiAKIAlidXN0X3NwaW5sb2Nr
cygwKTsKIAlkaWUubG9ja19vd25lciA9IC0xOwotCXNwaW5fdW5sb2NrX2lycSgmZGllLmxvY2sp
OworCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRpZS5sb2NrLCBmbGFncyk7CiAKIAlpZiAoa2V4
ZWNfc2hvdWxkX2NyYXNoKGN1cnJlbnQpKQogCQljcmFzaF9rZXhlYyhyZWdzKTsK

--=__PartB89A8643.0__=--
