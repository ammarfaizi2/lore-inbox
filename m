Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267434AbTAQIvl>; Fri, 17 Jan 2003 03:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267435AbTAQIvl>; Fri, 17 Jan 2003 03:51:41 -0500
Received: from holomorphy.com ([66.224.33.161]:19349 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267434AbTAQIvl>;
	Fri, 17 Jan 2003 03:51:41 -0500
Date: Fri, 17 Jan 2003 01:00:31 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Martin.Bligh@us.ibm.com
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: MAX_IO_APICS #ifdef'd wrongly
Message-ID: <20030117090031.GD940@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Martin.Bligh@us.ibm.com, akpm@zip.com.au,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_X86_NUMA no longer exists. This changes the MAX_IO_APICS
definition to 32, where it is required to be so large on NUMA-Q
in order to boot.


diff -urpN linux-2.5.59/include/asm-i386/apicdef.h ioapic-2.5.59/include/asm-i386/apicdef.h
--- linux-2.5.59/include/asm-i386/apicdef.h	2003-01-16 18:22:15.000000000 -0800
+++ ioapic-2.5.59/include/asm-i386/apicdef.h	2003-01-17 00:58:04.000000000 -0800
@@ -115,7 +115,7 @@
 
 #define APIC_BASE (fix_to_virt(FIX_APIC_BASE))
 
-#ifdef CONFIG_X86_NUMA
+#ifdef CONFIG_X86_NUMAQ
  #define MAX_IO_APICS 32
 #else
  #define MAX_IO_APICS 8
