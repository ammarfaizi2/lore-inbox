Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbUKJXuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbUKJXuh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 18:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUKJXuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 18:50:37 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:23305 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262120AbUKJXu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 18:50:29 -0500
Message-ID: <4192A959.9020806@conectiva.com.br>
Date: Wed, 10 Nov 2004 21:50:49 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix  platform_rename_gsi related ia32 build breakage
Content-Type: multipart/mixed;
 boundary="------------020903070703090806060403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020903070703090806060403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

	This is needed to build current BK tree on IA32.

- Arnaldo

--------------020903070703090806060403
Content-Type: text/plain;
 name="platform_rename_gsi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="platform_rename_gsi.patch"

===== arch/i386/kernel/io_apic.c 1.116 vs edited =====
--- 1.116/arch/i386/kernel/io_apic.c	2004-10-28 05:35:33 -03:00
+++ edited/arch/i386/kernel/io_apic.c	2004-11-10 21:39:57 -02:00
@@ -1039,6 +1039,8 @@
 	return MPBIOS_trigger(idx);
 }
 
+extern int (*platform_rename_gsi)(int ioapic, int gsi);
+
 static int pin_2_irq(int idx, int apic, int pin)
 {
 	int irq, i;

--------------020903070703090806060403--
