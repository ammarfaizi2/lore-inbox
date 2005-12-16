Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbVLPPLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVLPPLu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 10:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbVLPPLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 10:11:50 -0500
Received: from moutvdom.kundenserver.de ([212.227.126.249]:50916 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932328AbVLPPLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 10:11:49 -0500
Message-ID: <43A2D932.3030909@anagramm.de>
Date: Fri, 16 Dec 2005 16:11:46 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] idle.c fix unused var compile warning
Content-Type: multipart/mixed;
 boundary="------------090208030907010108070000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090208030907010108070000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This fixes a little warning about unused cpu variable for non SMP PPC systems.

Signed-off-by: Clemens Koller <clemens.koller@anagramm.de>
-- 

--------------090208030907010108070000
Content-Type: text/plain;
 name="idle_c-fix-unused-var-warning.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idle_c-fix-unused-var-warning.patch"

--- linux-2.6/arch/ppc/kernel/idle.c.ori	2005-12-14 12:27:26.000000000 +0100
+++ linux-2.6/arch/ppc/kernel/idle.c	2005-12-16 16:02:18.000000000 +0100
@@ -37,7 +37,9 @@
 void default_idle(void)
 {
 	void (*powersave)(void);
+#ifdef CONFIG_SMP
 	int cpu = smp_processor_id();
+#endif
 
 	powersave = ppc_md.power_save;
 

--------------090208030907010108070000--
