Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317851AbSHOXr6>; Thu, 15 Aug 2002 19:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317845AbSHOXr5>; Thu, 15 Aug 2002 19:47:57 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:53901 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317851AbSHOXr4>; Thu, 15 Aug 2002 19:47:56 -0400
Message-ID: <3D5C3E20.7080907@us.ibm.com>
Date: Thu, 15 Aug 2002 16:49:52 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] i386 ksyms cleanup
Content-Type: multipart/mixed;
 boundary="------------070906080602020307040201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070906080602020307040201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is a very trivial change.  Just moving the EXPORT_SYMBOL for xquad_portio 
up in the file into the platform dependent area... More appropriate there.

-Matt

--------------070906080602020307040201
Content-Type: text/plain;
 name="i386_ksyms_cleanup-2531.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386_ksyms_cleanup-2531.patch"

diff -Nur linux-2.5.31-vanilla/arch/i386/kernel/i386_ksyms.c linux-2.5.31-xquad/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.31-vanilla/arch/i386/kernel/i386_ksyms.c	Sat Aug 10 18:41:28 2002
+++ linux-2.5.31-xquad/arch/i386/kernel/i386_ksyms.c	Thu Aug 15 14:29:58 2002
@@ -58,6 +58,9 @@
 EXPORT_SYMBOL(EISA_bus);
 #endif
 EXPORT_SYMBOL(MCA_bus);
+#ifdef CONFIG_MULTIQUAD
+EXPORT_SYMBOL(xquad_portio);
+#endif
 EXPORT_SYMBOL(__verify_write);
 EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(dump_fpu);
@@ -170,7 +173,3 @@
 EXPORT_SYMBOL(is_sony_vaio_laptop);
 
 EXPORT_SYMBOL(__PAGE_KERNEL);
-
-#ifdef CONFIG_MULTIQUAD
-EXPORT_SYMBOL(xquad_portio);
-#endif

--------------070906080602020307040201--

