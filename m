Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267282AbSLEKrS>; Thu, 5 Dec 2002 05:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267274AbSLEKqL>; Thu, 5 Dec 2002 05:46:11 -0500
Received: from holomorphy.com ([66.224.33.161]:43401 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267275AbSLEKqE>;
	Thu, 5 Dec 2002 05:46:04 -0500
Date: Thu, 05 Dec 2002 02:52:59 -0800
From: wli@holomorphy.com
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net,
       rmk@arm.linux.org.uk, jgarzik@pobox.com, miura@da-cha.org,
       alan@lxorguk.ukuu.org.uk, viro@math.psu.edu, pavel@ucw.cz
Subject: [warnings] [6/8] fix mismatched function type in arch/i386/kernel/ioapic.c
Message-ID: <0212050252.jbobndDcEaLdlb5bCcEaYaZb~akaFc3d20143@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0212050252.Pd6dQaLdjd~bKaCc5bYa1cXb9dBdsb0a20143@holomorphy.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the function return type so as to match the required initcall
prototype. Alan, this is yours to ack.

===== arch/i386/kernel/io_apic.c 1.33 vs edited =====
--- 1.33/arch/i386/kernel/io_apic.c	Wed Nov 20 07:20:10 2002
+++ edited/arch/i386/kernel/io_apic.c	Thu Dec  5 01:18:11 2002
@@ -1749,10 +1749,11 @@
  *	APIC bugs then we can allow the modify fast path
  */
  
-static void __init io_apic_bug_finalize(void)
+static int __init io_apic_bug_finalize(void)
 {
 	if(sis_apic_bug == -1)
 		sis_apic_bug = 0;
+	return 0;
 }
 
 late_initcall(io_apic_bug_finalize);
