Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264780AbSKEEvs>; Mon, 4 Nov 2002 23:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264886AbSKEEvs>; Mon, 4 Nov 2002 23:51:48 -0500
Received: from modemcable074.85-202-24.mtl.mc.videotron.ca ([24.202.85.74]:54025
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264780AbSKEEvR>; Mon, 4 Nov 2002 23:51:17 -0500
Date: Mon, 4 Nov 2002 23:59:38 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <venkatesh.pallipadi@intel.com>
Subject: [PATCH][2.5-AC] Start from bank 0 for P4 MCE init (resend)
Message-ID: <Pine.LNX.4.44.0211042107590.27141-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.44-ac5/arch/i386/kernel/cpu/mcheck/p4.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.44-ac5/arch/i386/kernel/cpu/mcheck/p4.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 p4.c
--- linux-2.5.44-ac5/arch/i386/kernel/cpu/mcheck/p4.c	3 Nov 2002 07:20:04 -0000	1.1.1.1
+++ linux-2.5.44-ac5/arch/i386/kernel/cpu/mcheck/p4.c	3 Nov 2002 16:47:14 -0000
@@ -220,7 +220,7 @@
 		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
 	banks = l&0xff;
 
-	for(i=1; i<banks; i++)
+	for(i=0; i<banks; i++)
 		wrmsr(MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
 
 	for(i=0; i<banks; i++)

-- 
function.linuxpower.ca

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


