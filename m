Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263589AbTAJHZu>; Fri, 10 Jan 2003 02:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263794AbTAJHY6>; Fri, 10 Jan 2003 02:24:58 -0500
Received: from dp.samba.org ([66.70.73.150]:9708 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263760AbTAJHYo>;
	Fri, 10 Jan 2003 02:24:44 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: PATCH: module_text_address() defined but not used in module.h 
In-reply-to: Your message of "Tue, 07 Jan 2003 15:12:43 +0200."
             <20030107131243.GJ25540@alhambra> 
Date: Wed, 08 Jan 2003 23:01:48 +1100
Message-Id: <20030110073329.185902C506@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030107131243.GJ25540@alhambra> you write:
> module_text_address() is defined as 'static int ...' if modules are
> not configured in in module.h, leading to a compiler warning that it
> is defined but not used. Make it static inline. Patch against
> 2.5.54-bk. 

Linus, please apply.  Obviously correct, my mistake.  

From: Muli Ben-Yehuda <mulix@mulix.org>

diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	Tue Jan  7 14:18:37 2003
+++ b/include/linux/module.h	Tue Jan  7 14:18:37 2003
@@ -328,7 +328,7 @@
 }
 
 /* Is this address in a module? */
-static int module_text_address(unsigned long addr)
+static inline int module_text_address(unsigned long addr)
 {
 	return 0;
 }

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
