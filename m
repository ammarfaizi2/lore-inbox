Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271010AbUJUWDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271010AbUJUWDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271009AbUJUWBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:01:18 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:54980 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S271006AbUJUWAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:00:40 -0400
Date: Thu, 21 Oct 2004 15:00:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RESEND][PATCH 2.6.9] ppc32: Fix building for Motorola Sandpoint with O=
Message-ID: <20041021220036.GB1532@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Resend since I still don't see it, Andrew can you pick this up please?
Thanks ]

Since we directly -include $(clear_L2_L3) when needed, we need to point
to the full path of it.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.34/arch/ppc/boot/simple/Makefile	2004-10-05 23:05:22 -07:00
+++ edited/arch/ppc/boot/simple/Makefile	2004-10-19 09:32:39 -07:00
@@ -41,7 +41,7 @@
 # if present on 'classic' PPC.
 cacheflag-y	:= -DCLEAR_CACHES=""
 # This file will flush / disable the L2, and L3 if present.
-clear_L2_L3	:= $(boot)/simple/clear.S
+clear_L2_L3	:= $(srctree)/$(boot)/simple/clear.S
 
 #
 # See arch/ppc/kconfig and arch/ppc/platforms/Kconfig

-- 
Tom Rini
http://gate.crashing.org/~trini/
