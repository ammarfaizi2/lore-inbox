Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbTANIbU>; Tue, 14 Jan 2003 03:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbTANIbU>; Tue, 14 Jan 2003 03:31:20 -0500
Received: from dp.samba.org ([66.70.73.150]:22162 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261721AbTANIbS>;
	Tue, 14 Jan 2003 03:31:18 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: exception tables in 2.5.55 
In-reply-to: Your message of "Mon, 13 Jan 2003 22:03:27 BST."
             <200301132103.h0DL3R0p001528@eeyore.valparaiso.cl> 
Date: Tue, 14 Jan 2003 19:28:02 +1100
Message-Id: <20030114084011.5E9FA2C45C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200301132103.h0DL3R0p001528@eeyore.valparaiso.cl> you write:
> [Massive snippage of Cc:]
> Rusty Russell <rusty@rustcorp.com.au>
> 
> [...]
> 
> > This seems way overkill.  How about you move the search_extable()
> > prototype out of linux/module.h and into each asm/uaccess.h, then:
> > 
> > include/asm-m68knommu/uaccess.h:
> > 
> > 	/* We don't use such things. */
> > 	struct exception_table_entry
> > 	{
> > 		int unused;
> > 	};
> 
> Why not just an empty structure?

Ancient compilers.  See linux/spinlock.h.  Since it's not actually
used, putting in a #ifdef is overkill...

Hope that helps!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
