Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267461AbRGLKDe>; Thu, 12 Jul 2001 06:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267462AbRGLKDX>; Thu, 12 Jul 2001 06:03:23 -0400
Received: from t2.redhat.com ([199.183.24.243]:28919 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267461AbRGLKDG>; Thu, 12 Jul 2001 06:03:06 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: torvalds@transmeta.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] More pedantry.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Jul 2001 11:03:01 +0100
Message-ID: <11825.994932181@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 'errata' as singular instead of 'erratum' seems to one of the more 
common illiteracies found in the kernel.

I'm not sure what the text for the IA64 CONFIG_ACPI20 option 
("Enable ACPI 2.0 with errata 1.3") is supposed to mean, so I can't tell 
whether that's wrong. It's the only user-visible instance.

As the other instances aren't user-visible, it's probably not worth the 
bother of fixing them. 

However, I think we should make an exception for arch/ppc/kernel/misc.S and
arch/i386/kernel/smp.c, in which which we invent a new plural 'erratas' for
the word 'errata' which was already a plural. That is just such an abuse of
the language that I felt it needed to be fixed even though it isn't
user-visible.

English or C. Pick one. Be incoherent in the other.

Index: arch/ppc/kernel/misc.S
===================================================================
RCS file: /inst/cvs/linux/arch/ppc/kernel/misc.S,v
retrieving revision 1.3.2.25
diff -u -r1.3.2.25 misc.S
--- arch/ppc/kernel/misc.S	2001/07/03 09:34:19	1.3.2.25
+++ arch/ppc/kernel/misc.S	2001/07/12 10:00:24
@@ -813,7 +813,7 @@
 _GLOBAL(_set_HID0)
 	sync
 	mtspr	HID0, r3
-	SYNC		/* Handle erratas in some cases */
+	SYNC		/* Handle errata in some cases */
 	blr
 
 _GLOBAL(_get_ICTC)
Index: arch/i386/kernel/smp.c
===================================================================
RCS file: /inst/cvs/linux/arch/i386/kernel/smp.c,v
retrieving revision 1.6.2.26
diff -u -r1.6.2.26 smp.c
--- arch/i386/kernel/smp.c	2001/02/24 19:12:22	1.6.2.26
+++ arch/i386/kernel/smp.c	2001/07/12 10:00:24
@@ -28,21 +28,21 @@
  *	The Linux implications for SMP are handled as follows:
  *
  *	Pentium III / [Xeon]
- *		None of the E1AP-E3AP erratas are visible to the user.
+ *		None of the E1AP-E3AP errata are visible to the user.
  *
  *	E1AP.	see PII A1AP
  *	E2AP.	see PII A2AP
  *	E3AP.	see PII A3AP
  *
  *	Pentium II / [Xeon]
- *		None of the A1AP-A3AP erratas are visible to the user.
+ *		None of the A1AP-A3AP errata are visible to the user.
  *
  *	A1AP.	see PPro 1AP
  *	A2AP.	see PPro 2AP
  *	A3AP.	see PPro 7AP
  *
  *	Pentium Pro
- *		None of 1AP-9AP erratas are visible to the normal user,
+ *		None of 1AP-9AP errata are visible to the normal user,
  *	except occasional delivery of 'spurious interrupt' as trap #15.
  *	This is very rare and a non-problem.
  *


--
dwmw2


