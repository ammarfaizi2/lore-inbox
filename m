Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267225AbTACESU>; Thu, 2 Jan 2003 23:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267376AbTACESU>; Thu, 2 Jan 2003 23:18:20 -0500
Received: from dp.samba.org ([66.70.73.150]:35982 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267225AbTACEST>;
	Thu, 2 Jan 2003 23:18:19 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.54 kill module.h compiler warnings 
In-reply-to: Your message of "Thu, 02 Jan 2003 16:57:19 BST."
             <200301021557.QAA06497@harpo.it.uu.se> 
Date: Fri, 03 Jan 2003 11:01:02 +1100
Message-Id: <20030103042650.599842C09C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200301021557.QAA06497@harpo.it.uu.se> you write:
> Rusty,
> 
> Compiling kernel 2.5.54 with CONFIG_MODULES=n results in
> tons and tons of the following warnings:
> 
> include/linux/module.h:317: warning: statement with no effect
> include/linux/module.h:353: warning: statement with no effect
> 
> patch-2.5.54 changed *MOD_INC_USE_COUNT from macros to
> __deprecated functions, but also dropped the (void) casts
> in front of the try_module_get() calls. Without modules,
> try_module_get() is the constant 1, hence the warnings.
> 
> The patch below silences the warnings by adding back the
> missing (void) casts. Works for me.

I know, Christoph Hellwig changed this, and I believe RTH fixed it in
his merge with Linus.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
