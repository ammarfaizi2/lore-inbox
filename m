Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbTBSUmB>; Wed, 19 Feb 2003 15:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbTBSUmB>; Wed, 19 Feb 2003 15:42:01 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:9505 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261205AbTBSUmA>; Wed, 19 Feb 2003 15:42:00 -0500
Date: Wed, 19 Feb 2003 14:51:56 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL PATCH 2.5.62] Support make xconfig on Debian sid
Message-ID: <100120000.1045687916@baldur.austin.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1781812778=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1781812778==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


I got tired enough of always having to remember to set QTDIR when I build
that I tracked down what it'd take for 'make xconfig' to work out of the
box on Debian sid (unstable).  Here's the one line patch to make it work.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========1781812778==========
Content-Type: text/plain; charset=iso-8859-1; name="qt-2.5.62-1.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="qt-2.5.62-1.diff"; size=467

--- 2.5.62/scripts/kconfig/Makefile	2003-02-17 16:57:19.000000000 -0600
+++ 2.5.62-anon/scripts/kconfig/Makefile	2003-02-19 14:44:58.000000000 =
-0600
@@ -38,7 +38,7 @@
=20
 # QT needs some extra effort...
 $(obj)/.tmp_qtcheck:
-	@set -e; for d in $$QTDIR /usr/share/qt /usr/lib/qt*3*; do \
+	@set -e; for d in $$QTDIR /usr/share/qt /usr/share/qt3 /usr/lib/qt*3*; do =
\
 	  if [ -f $$d/include/qconfig.h ]; then DIR=3D$$d; break; fi; \
 	done; \
 	if [ -z "$$DIR" ]; then \

--==========1781812778==========--

