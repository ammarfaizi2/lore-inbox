Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130937AbRAZVOC>; Fri, 26 Jan 2001 16:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130320AbRAZVNw>; Fri, 26 Jan 2001 16:13:52 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:9824
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S130147AbRAZVNm>; Fri, 26 Jan 2001 16:13:42 -0500
Date: Fri, 26 Jan 2001 22:13:35 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: [uPATCH][Probably fucked up] arch/i386/kernel/io_apic.c: missing extern? (241p10)
Message-ID: <20010126221335.B612@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

In arch/i386/kernel we declare nr_ioapics in both io_apic.c and mpparse.c.
I guess that one of them should be an 'extern' declaration? In the patch
below I have guessed that it is io_apic.c that is missing it since (AFAICS)
never assign to nr_ioapic in this file. 

But I am in way over my head here so please be gentle when you point
out my mistake.

The patch (against 241p10 and ac11):


--- linux-ac11-clean/arch/i386/kernel/io_apic.c	Thu Jan 25 20:48:51 2001
+++ linux-ac11/arch/i386/kernel/io_apic.c	Fri Jan 26 21:59:16 2001
@@ -38,7 +38,7 @@
 /*
  * # of IRQ routing registers
  */
-int nr_ioapics;
+extern int nr_ioapics;
 int nr_ioapic_registers[MAX_IO_APICS];
 
 #if CONFIG_SMP

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Freedom of the press is limited to those who own one.
                                 - A.J. Liebling 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
