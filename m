Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266567AbRGQPS0>; Tue, 17 Jul 2001 11:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266565AbRGQPSR>; Tue, 17 Jul 2001 11:18:17 -0400
Received: from t2.redhat.com ([199.183.24.243]:61426 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S266562AbRGQPSI>; Tue, 17 Jul 2001 11:18:08 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <OE17UirmJJgWha8vFnq000074b6@hotmail.com> 
In-Reply-To: <OE17UirmJJgWha8vFnq000074b6@hotmail.com>  <Pine.LNX.4.33.0107171532450.1817-100000@ketil.np> 
To: "William Scott Lockwood III" <scottlockwood@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.6-ac5 gives wrong cache info for Duron in /proc/cpuinfo 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Jul 2001 16:18:07 +0100
Message-ID: <7721.995383087@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


thatlinuxguy@hotmail.com said:
> It never ceases to amaze me how ANAL some people on this list are.
> :-)

It's called attention to detail, and it's the _reason_ why a lot of people 
are here.

The correct prefix to signify a multiple of 1024 is 'Ki'.

Index: arch/i386/kernel/setup.c
===================================================================
RCS file: /inst/cvs/linux/arch/i386/kernel/setup.c,v
retrieving revision 1.4.2.57
diff -u -r1.4.2.57 setup.c
--- arch/i386/kernel/setup.c	2001/05/14 10:32:23	1.4.2.57
+++ arch/i386/kernel/setup.c	2001/07/17 15:13:54
@@ -2406,7 +2406,7 @@
 
 		/* Cache size */
 		if (c->x86_cache_size >= 0)
-			p += sprintf(p, "cache size\t: %d KB\n", c->x86_cache_size);
+			p += sprintf(p, "cache size\t: %d KiB\n", c->x86_cache_size);
 		
 		/* We use exception 16 if we have hardware math and we've either seen it or the CPU claims it is internal */
 		fpu_exception = c->hard_math && (ignore_irq13 || cpu_has_fpu);


--
dwmw2


