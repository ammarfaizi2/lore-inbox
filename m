Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbUCHUIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 15:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbUCHUIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 15:08:00 -0500
Received: from smtp02.web.de ([217.72.192.151]:61985 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261178AbUCHUHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 15:07:49 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Andrew Morton <akpm@osdl.org>, luming.yu@intel.com, len.brown@intel.com
Subject: Re: 2.6.4-rc2-mm1
Date: Mon, 8 Mar 2004 20:44:57 +0100
User-Agent: KMail/1.5.4
References: <20040307223221.0f2db02e.akpm@osdl.org>
In-Reply-To: <20040307223221.0f2db02e.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_80MTAOfw1SMKBlu"
Message-Id: <200403082045.00527.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_80MTAOfw1SMKBlu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

the bk-acpi.patch leads to following warning:

In file included from include/asm/fixmap.h:18,
                 from arch/i386/kernel/time_hpet.c:17:
include/asm/acpi.h: In function `__acpi_acquire_global_lock':
include/asm/acpi.h:72: Warnung: implicit declaration of function `cmpxchg'

The attached patch fixes it by including <asm/system.h>.

Best regards
  Thomas Schlichter

--Boundary-00=_80MTAOfw1SMKBlu
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix-acpi_cmpxchg.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="fix-acpi_cmpxchg.diff"

--- linux-2.6.4-rc2-mm1/include/asm-i386/acpi.h.orig	2004-03-08 14:18:31.000000000 +0100
+++ linux-2.6.4-rc2-mm1/include/asm-i386/acpi.h	2004-03-08 14:55:21.000000000 +0100
@@ -28,6 +28,8 @@
 
 #ifdef __KERNEL__
 
+#include <asm/system.h>
+
 #define COMPILER_DEPENDENT_INT64   long long
 #define COMPILER_DEPENDENT_UINT64  unsigned long long
 

--Boundary-00=_80MTAOfw1SMKBlu--


