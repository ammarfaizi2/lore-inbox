Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265002AbSLMAMk>; Thu, 12 Dec 2002 19:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267550AbSLMAMj>; Thu, 12 Dec 2002 19:12:39 -0500
Received: from dp.samba.org ([66.70.73.150]:11946 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265002AbSLMAMj>;
	Thu, 12 Dec 2002 19:12:39 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Matt Reppert <arashi@arashi.yi.org>
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] "extern inline" to "static inline" allows compile 
In-reply-to: Your message of "Thu, 12 Dec 2002 17:09:02 MDT."
             <20021212170902.34e344b1.arashi@arashi.yi.org> 
Date: Fri, 13 Dec 2002 11:18:57 +1100
Message-Id: <20021213002028.C2CC72C0AB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021212170902.34e344b1.arashi@arashi.yi.org> you write:
> Hi,
> 
> I can't compile 2.5.51 on an EV56 without this. Tested, boots.
> There are a bunch of symbols in core_cia.h that break the build if they're
> extern inline because they're only defined in the header now. Make them
> static inline instead. (Important, since they're #defined to things like
> inb)
> 
> Comments?

This patch is simple, but not trivial, and since RTH wrote this, I'm
assuming all those __EXTERN_INLINE's are defined and undefned in
multiple places for a reason.

Richard?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
