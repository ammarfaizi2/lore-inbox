Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318951AbSIIU6C>; Mon, 9 Sep 2002 16:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318952AbSIIU6C>; Mon, 9 Sep 2002 16:58:02 -0400
Received: from p5088746E.dip.t-dialin.net ([80.136.116.110]:19876 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318951AbSIIU6A>; Mon, 9 Sep 2002 16:58:00 -0400
Date: Mon, 9 Sep 2002 15:02:46 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Florin Iucha <florin@iucha.net>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.34
In-Reply-To: <20020909193519.GD7683@iucha.net>
Message-ID: <Pine.LNX.4.44.0209091501490.3793-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 9 Sep 2002, Florin Iucha wrote:
> depmod:         recalc_sigpending

No need to holler, there has just been a patch on that.

>From vandrove@vc.cvut.cz Mon Sep  9 15:02:28 2002
Date: Mon, 9 Sep 2002 20:32:51 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.34: recalc_sigpending missing for modules

Hi Linus,
  when recalc_sigpending was converted from inline to real function,
appropriate EXPORT_SYMBOL() was not created. Needed at least for ncpfs
and lockd.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz


diff -urdN linux/kernel/signal.c linux/kernel/signal.c
--- linux/kernel/signal.c	2002-09-09 18:01:49.000000000 +0000
+++ linux/kernel/signal.c	2002-09-09 18:25:09.000000000 +0000
@@ -1220,6 +1220,7 @@
 
 #endif
 
+EXPORT_SYMBOL(recalc_sigpending);
 EXPORT_SYMBOL(dequeue_signal);
 EXPORT_SYMBOL(flush_signals);
 EXPORT_SYMBOL(force_sig);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-


