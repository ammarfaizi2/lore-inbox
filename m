Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbVIHO27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbVIHO27 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 10:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVIHO27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 10:28:59 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:13659
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750940AbVIHO27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 10:28:59 -0400
Message-Id: <4320670B0200007800024411@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 16:30:03 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] minor ELF definitions addition
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartBA98D4FB.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartBA98D4FB.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

A trivial addition to the EFL definitions.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/include/linux/elf.h 2.6.13-elf/include/linux/elf.h
--- 2.6.13/include/linux/elf.h	2005-08-29 01:41:01.000000000 +0200
+++ 2.6.13-elf/include/linux/elf.h	2005-03-16 12:24:42.000000000
+0100
@@ -150,6 +150,8 @@ typedef __s64	Elf64_Sxword;
 #define STT_FUNC    2
 #define STT_SECTION 3
 #define STT_FILE    4
+#define STT_COMMON  5
+#define STT_TLS     6
 
 #define ELF_ST_BIND(x)		((x) >> 4)
 #define ELF_ST_TYPE(x)		(((unsigned int) x) & 0xf)


--=__PartBA98D4FB.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-elf.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-elf.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCkEgdHJpdmlhbCBhZGRpdGlvbiB0byB0aGUg
RUZMIGRlZmluaXRpb25zLgoKU2lnbmVkLW9mZi1ieTogSmFuIEJldWxpY2ggPGpiZXVsaWNoQG5v
dmVsbC5jb20+CgpkaWZmIC1OcHJ1IDIuNi4xMy9pbmNsdWRlL2xpbnV4L2VsZi5oIDIuNi4xMy1l
bGYvaW5jbHVkZS9saW51eC9lbGYuaAotLS0gMi42LjEzL2luY2x1ZGUvbGludXgvZWxmLmgJMjAw
NS0wOC0yOSAwMTo0MTowMS4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xMy1lbGYvaW5jbHVkZS9s
aW51eC9lbGYuaAkyMDA1LTAzLTE2IDEyOjI0OjQyLjAwMDAwMDAwMCArMDEwMApAQCAtMTUwLDYg
KzE1MCw4IEBAIHR5cGVkZWYgX19zNjQJRWxmNjRfU3h3b3JkOwogI2RlZmluZSBTVFRfRlVOQyAg
ICAyCiAjZGVmaW5lIFNUVF9TRUNUSU9OIDMKICNkZWZpbmUgU1RUX0ZJTEUgICAgNAorI2RlZmlu
ZSBTVFRfQ09NTU9OICA1CisjZGVmaW5lIFNUVF9UTFMgICAgIDYKIAogI2RlZmluZSBFTEZfU1Rf
QklORCh4KQkJKCh4KSA+PiA0KQogI2RlZmluZSBFTEZfU1RfVFlQRSh4KQkJKCgodW5zaWduZWQg
aW50KSB4KSAmIDB4ZikK

--=__PartBA98D4FB.0__=--
