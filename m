Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266854AbUH2Mgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266854AbUH2Mgh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 08:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267786AbUH2Mgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 08:36:37 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:65425 "EHLO
	fmmailgate02.web.de") by vger.kernel.org with ESMTP id S266854AbUH2Mge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 08:36:34 -0400
Date: Sun, 29 Aug 2004 14:36:32 +0200
Message-Id: <1248337375@web.de>
MIME-Version: 1.0
From: "Joachim Bremer" <joachim.bremer@web.de>
To: linux-kernel@vger.kernel.org
Cc: nickpiggin@yahoo.com.au
Subject: <no subject>
Organization: http://freemail.web.de/
Content-Type: multipart/mixed; boundary="STEFAN4131cdd13d1e"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME encoded message.
--STEFAN4131cdd13d1e
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

As mentioned before I got even with Nicks patch some errors. Looking
closer at the source there is is a second "goto page_ok" a few lines
down the label "page_not_up_to_date". Inserting the same calculating
code used before the label "readpage_error" fixes the errors on my machine.
These for instance where failure to do reiserfsck (bread complains on last block
of device) and compiling the linux-tree (file truncated).

The leads to the same calculation 3 times...

Patch attached


Joachim
_______________________________________________________
WEB.DE Video-Mail - Sagen Sie mehr mit bewegten Bildern
Informationen unter: http://freemail.web.de/?mc=021199
--STEFAN4131cdd13d1e
Content-Type: text/plain; name="mm-filemap-np-missing.patch.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="mm-filemap-np-missing.patch.txt"

LS0tIGxpbnV4LTIuNi45LW5wL21tL2ZpbGVtYXAuYwkyMDA0LTA4LTI5IDE0OjAzOjQwLjk4
OTM1MzQ0OCArMDIwMAorKysgbGludXgtMi42L21tL2ZpbGVtYXAuYwkyMDA0LTA4LTI5IDEz
OjQ4OjM3LjAwMDAwMDAwMCArMDIwMApAQCAtNzk4LDYgKzc5OCwxNSBAQCBwYWdlX25vdF91
cF90b19kYXRlOgogCQkvKiBEaWQgc29tZWJvZHkgZWxzZSBmaWxsIGl0IGFscmVhZHk/ICov
CiAJCWlmIChQYWdlVXB0b2RhdGUocGFnZSkpIHsKIAkJCXVubG9ja19wYWdlKHBhZ2UpOwor
CQkJbnIgPSBQQUdFX0NBQ0hFX1NJWkU7CisJCQlpZiAoaW5kZXggPT0gZW5kX2luZGV4KSB7
CisJCQkJbnIgPSBpc2l6ZSAmIH5QQUdFX0NBQ0hFX01BU0s7CisJCQkJaWYgKG5yIDw9IG9m
ZnNldCkgeworCQkJCQlwYWdlX2NhY2hlX3JlbGVhc2UocGFnZSk7CisJCQkJCWdvdG8gb3V0
OworCQkJCX0KKwkJCX0KKwkJCW5yID0gbnIgLSBvZmZzZXQ7CiAJCQlnb3RvIHBhZ2Vfb2s7
CiAJCX0KIAo=

--STEFAN4131cdd13d1e--


