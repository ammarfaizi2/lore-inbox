Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVCOJKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVCOJKi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 04:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbVCOJKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 04:10:37 -0500
Received: from mxc.rambler.ru ([81.19.66.31]:43281 "EHLO mxc.rambler.ru")
	by vger.kernel.org with ESMTP id S262353AbVCOJKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 04:10:32 -0500
Date: Tue, 15 Mar 2005 12:13:20 -0500
From: Pavel Fedin <sonic_amiga@rambler.ru>
To: linux-kernel@vger.kernel.org
Cc: urban@teststation.com, Sven Luther <sven.luther@wanadoo.fr>
Subject: [PATCH] smbfs bug fix
Message-Id: <20050315121320.6bd21d53.sonic_amiga@rambler.ru>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__15_Mar_2005_12_13_20_-0500_28I+bsKL+oh5w6Me"
X-Auth-User: sonic_amiga, whoson: (null)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__15_Mar_2005_12_13_20_-0500_28I+bsKL+oh5w6Me
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

 Current smbfs has a bug: you can't supply "user, noauto" flags for it
in /etc/fstab. smbmount tool expands this to "noexec, nosuid, nodev,
user, noauto" and smbfs rejects all arguments because it doesn't know
any of these keywords.
 This patch fixes it. It introduces these arguments to the smbfs which
will silently ignore them in the same way as cifs does.
 The patch is made for 2.6.11.1 kernel.

-- 
Best regards,
Pavel Fedin,									mailto:sonic_amiga@rambler.ru

--Multipart=_Tue__15_Mar_2005_12_13_20_-0500_28I+bsKL+oh5w6Me
Content-Type: text/plain;
 name="smbfs-fix.diff"
Content-Disposition: attachment;
 filename="smbfs-fix.diff"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi4xMS4xL2ZzL3NtYmZzL2lub2RlLmMub3JpZwkyMDA1LTAzLTA0IDEyOjI2
OjI5LjAwMDAwMDAwMCAtMDUwMA0KKysrIGxpbnV4LTIuNi4xMS4xL2ZzL3NtYmZzL2lub2RlLmMJ
MjAwNS0wMy0xNSAxMTo1Nzo1Mi4wMDAwMDAwMDAgLTA1MDANCkBAIC0zNTEsNiArMzUxLDExIEBA
DQogCXsgImlvY2hhcnNldCIsCTAsICdpJyB9LA0KIAl7ICJjb2RlcGFnZSIsCTAsICdjJyB9LA0K
IAl7ICJ0dGwiLAkwLCAndCcgfSwNCisJeyAibm9leGVjIiwJU01CX01PVU5UX0lHTk9SRSwgMX0s
DQorCXsgIm5vc3VpZCIsCVNNQl9NT1VOVF9JR05PUkUsIDF9LA0KKwl7ICJub2RldiIsCVNNQl9N
T1VOVF9JR05PUkUsIDF9LA0KKwl7ICJ1c2VyIiwJU01CX01PVU5UX0lHTk9SRSwgMX0sDQorCXsg
Im5vYXV0byIsCVNNQl9NT1VOVF9JR05PUkUsIDF9LA0KIAl7IE5VTEwsCQkwLCAwfQ0KIH07DQog
DQotLS0gbGludXgtMi42LjExLjEvaW5jbHVkZS9saW51eC9zbWJfbW91bnQuaC5vcmlnCTIwMDUt
MDMtMDQgMTI6MjY6MjcuMDAwMDAwMDAwIC0wNTAwDQorKysgbGludXgtMi42LjExLjEvaW5jbHVk
ZS9saW51eC9zbWJfbW91bnQuaAkyMDA1LTAzLTE1IDExOjM4OjI4LjAwMDAwMDAwMCAtMDUwMA0K
QEAgLTQyLDYgKzQyLDcgQEANCiAjZGVmaW5lIFNNQl9NT1VOVF9HSUQJCTB4MDA0MCAgLyogVXNl
IHVzZXIgc3BlY2lmaWVkIGdpZCAqLw0KICNkZWZpbmUgU01CX01PVU5UX0ZNT0RFCQkweDAwODAg
IC8qIFVzZSB1c2VyIHNwZWNpZmllZCBmaWxlIG1vZGUgKi8NCiAjZGVmaW5lIFNNQl9NT1VOVF9E
TU9ERQkJMHgwMTAwICAvKiBVc2UgdXNlciBzcGVjaWZpZWQgZGlyIG1vZGUgKi8NCisjZGVmaW5l
IFNNQl9NT1VOVF9JR05PUkUJMHg4MDAwICAvKiBEdW1teSBmbGFnICovDQogDQogc3RydWN0IHNt
Yl9tb3VudF9kYXRhX2tlcm5lbCB7DQogCWludCB2ZXJzaW9uOw0K

--Multipart=_Tue__15_Mar_2005_12_13_20_-0500_28I+bsKL+oh5w6Me--
