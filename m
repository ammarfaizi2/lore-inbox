Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267533AbTGTRDZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 13:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267548AbTGTRDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 13:03:24 -0400
Received: from dp.samba.org ([66.70.73.150]:2223 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267533AbTGTRDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 13:03:24 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Norbert Kiesel <nk@iname.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 1/5] Centralize linker-generated symbols. 
In-reply-to: Your message of "Sun, 20 Jul 2003 00:21:40 MST."
             <pan.2003.07.20.07.21.32.296776@iname.com> 
Date: Mon, 21 Jul 2003 01:09:07 +1000
Message-Id: <20030720171824.A31782C131@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <pan.2003.07.20.07.21.32.296776@iname.com> you write:
> You forgot to remove them from kernel/suspend.c, breaking compile.
>
> Trivial patch:

Thanks!  Linus, please apply.

--- linux-2.5/kernel/suspend.c-orig	2003-07-20 00:04:59.000000000 -0700
+++ linux-2.5/kernel/suspend.c	2003-07-20 00:12:52.000000000 -0700
@@ -83,7 +83,6 @@
 #define ADDRESS2(x) __ADDRESS(__pa(x))		/* Needed for x86-64 where some pages are in memory twice */
 
 /* References to section boundaries */
-extern char _text, _etext, _edata, __bss_start, _end;
 extern char __nosave_begin, __nosave_end;
 
 extern int is_head_of_free_region(struct page *);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
