Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVASICK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVASICK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVASIB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:01:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53439 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261635AbVASHdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:42 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/29] x86-rename-apic_mode_exint
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <overview-11061198973484@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Maciej W. Rozycki" <macro@linux-mips.org>

Rename APIC_MODE_EXINT to APIC_MODE_EXTINT - I think it should be named
after what the mode is called in documentation.

From: "Eric W. Biederman" <ebiederm@lnxi.com>

I have reduced this patch to just the name change in the header.  And
integrated the changes into the patches that add those
lines. Otherwise I ran into some ugly dependencies.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org
Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 asm-i386/apicdef.h   |    2 +-
 asm-x86_64/apicdef.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -uNr linux-2.6.11-rc1-mm1-nokexec/include/asm-i386/apicdef.h linux-2.6.11-rc1-mm1-nokexec-x86-rename-apic_mode_exint/include/asm-i386/apicdef.h
--- linux-2.6.11-rc1-mm1-nokexec/include/asm-i386/apicdef.h	Mon Oct 18 15:54:31 2004
+++ linux-2.6.11-rc1-mm1-nokexec-x86-rename-apic_mode_exint/include/asm-i386/apicdef.h	Tue Jan 18 22:43:44 2005
@@ -90,7 +90,7 @@
 #define			SET_APIC_DELIVERY_MODE(x,y)	(((x)&~0x700)|((y)<<8))
 #define				APIC_MODE_FIXED		0x0
 #define				APIC_MODE_NMI		0x4
-#define				APIC_MODE_EXINT		0x7
+#define				APIC_MODE_EXTINT	0x7
 #define 	APIC_LVT1	0x360
 #define		APIC_LVTERR	0x370
 #define		APIC_TMICT	0x380
diff -uNr linux-2.6.11-rc1-mm1-nokexec/include/asm-x86_64/apicdef.h linux-2.6.11-rc1-mm1-nokexec-x86-rename-apic_mode_exint/include/asm-x86_64/apicdef.h
--- linux-2.6.11-rc1-mm1-nokexec/include/asm-x86_64/apicdef.h	Fri Jan  7 12:54:16 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86-rename-apic_mode_exint/include/asm-x86_64/apicdef.h	Tue Jan 18 22:43:44 2005
@@ -94,7 +94,7 @@
 #define			SET_APIC_DELIVERY_MODE(x,y)	(((x)&~0x700)|((y)<<8))
 #define				APIC_MODE_FIXED		0x0
 #define				APIC_MODE_NMI		0x4
-#define				APIC_MODE_EXINT		0x7
+#define				APIC_MODE_EXTINT	0x7
 #define 	APIC_LVT1	0x360
 #define		APIC_LVTERR	0x370
 #define		APIC_TMICT	0x380
