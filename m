Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbTESIAH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 04:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTESIAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 04:00:06 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:53632
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262362AbTESIAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 04:00:05 -0400
Date: Mon, 19 May 2003 04:03:26 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] Add Focus processor bit comment
Message-ID: <Pine.LNX.4.50.0305190401340.28750-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an explanation for clearing the focus bit on P4

Index: linux-2.5-devel/arch/i386/kernel/apic.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/kernel/apic.c,v
retrieving revision 1.40
diff -u -p -B -r1.40 apic.c
--- linux-2.5-devel/arch/i386/kernel/apic.c	17 Apr 2003 23:28:48 -0000	1.40
+++ linux-2.5-devel/arch/i386/kernel/apic.c	19 May 2003 07:07:52 -0000
@@ -291,6 +291,8 @@ void __init init_bsp_APIC(void)
 	value = apic_read(APIC_SPIV);
 	value &= ~APIC_VECTOR_MASK;
 	value |= APIC_SPIV_APIC_ENABLED;
+	
+	/* This bit is reserved on P4/Xeon and should be cleared */
 	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 == 15))
 		value &= ~APIC_SPIV_FOCUS_DISABLED;
 	else

-- 
function.linuxpower.ca
