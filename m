Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131096AbRAZXG1>; Fri, 26 Jan 2001 18:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131201AbRAZXGR>; Fri, 26 Jan 2001 18:06:17 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:43616
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S131096AbRAZXGJ>; Fri, 26 Jan 2001 18:06:09 -0500
Date: Sat, 27 Jan 2001 00:06:01 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: [uPATCH][Probably fucked up] arch/i386/kernel/io_apic.c: missing extern? (241p10)
Message-ID: <20010127000601.E612@jaquet.dk>
In-Reply-To: <20010126221335.B612@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010126221335.B612@jaquet.dk>; from rasmus@jaquet.dk on Fri, Jan 26, 2001 at 10:13:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 10:13:35PM +0100, Rasmus Andersen wrote:
> Hi.
[...]
> 
> But I am in way over my head here so please be gentle when you point
> out my mistake.
> 

Already someone did :) I was too sloppy in checking my facts; it is only
-ac11 that has the 'int nr_ioapics;' in mpparse.c. As mpparse.c includes 
<mpspec.h> (where nr_ioapics is defined as an extern int) I will risk
another patch removing the declaration from mpparse.c (in ac11). My
original patch should just be silently ignored, thank you ;)

Thanks goes to Manfred Spraul who pointed out the salient facts that
I had blithely ignored. Like, all of them :/ And my apologies for
the brief confusion I might have caused in people looking in 241p10
for my phantom declaration.


This patch is only against ac11. It has been compile-tested with SMP
turned on.

Comments?

--- linux-ac11-clean/arch/i386/kernel/mpparse.c	Thu Jan 25 20:48:51 2001
+++ linux-ac11/arch/i386/kernel/mpparse.c	Fri Jan 26 23:33:31 2001
@@ -48,8 +48,6 @@
 /* MP IRQ source entries */
 int mp_irq_entries;
 
-int nr_ioapics;
-
 int pic_mode;
 unsigned long mp_lapic_addr;
 
-- 
        Rasmus(rasmus@jaquet.dk)

A file that big?
It might be very useful.
But now it is gone.       --- Error messages in haiku
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
