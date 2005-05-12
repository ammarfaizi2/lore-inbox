Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVELIuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVELIuD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVELItC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:49:02 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:18208
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S261349AbVELIsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:48:10 -0400
Message-Id: <s2832659.037@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.4 
Date: Thu, 12 May 2005 10:48:27 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH] eliminate duplicate rdpmc definition
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartFAD9364B.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartFAD9364B.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Eliminate duplicate definition of rdpmc in x86-64's mtrr.h.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/include/asm-x86_64/msr.h linux-2.6.12-rc4/=
include/asm-x86_64/msr.h
--- linux-2.6.12-rc4.base/include/asm-x86_64/msr.h	2005-05-11 =
17:28:24.819299352 +0200
+++ linux-2.6.12-rc4/include/asm-x86_64/msr.h	2005-05-11 17:50:36.3088821=
68 +0200
@@ -57,11 +57,6 @@
      (val) =3D ((unsigned long)__a) | (((unsigned long)__d)<<32); \
 } while(0)
=20
-#define rdpmc(counter,low,high) \
-     __asm__ __volatile__("rdpmc" \
-			  : "=3Da" (low), "=3Dd" (high) \
-			  : "c" (counter))
-
 #define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
=20
 #define rdpmc(counter,low,high) \



--=__PartFAD9364B.1__=
Content-Type: text/plain; name="linux-2.6.12-rc4-x86_64-rdpmc.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.12-rc4-x86_64-rdpmc.patch"

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Eliminate duplicate definition of rdpmc in x86-64's mtrr.h.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/include/asm-x86_64/msr.h linux-2.6.12-rc4/include/asm-x86_64/msr.h
--- linux-2.6.12-rc4.base/include/asm-x86_64/msr.h	2005-05-11 17:28:24.819299352 +0200
+++ linux-2.6.12-rc4/include/asm-x86_64/msr.h	2005-05-11 17:50:36.308882168 +0200
@@ -57,11 +57,6 @@
      (val) = ((unsigned long)__a) | (((unsigned long)__d)<<32); \
 } while(0)
 
-#define rdpmc(counter,low,high) \
-     __asm__ __volatile__("rdpmc" \
-			  : "=a" (low), "=d" (high) \
-			  : "c" (counter))
-
 #define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
 
 #define rdpmc(counter,low,high) \

--=__PartFAD9364B.1__=--
