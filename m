Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267542AbSKQSP2>; Sun, 17 Nov 2002 13:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267543AbSKQSP2>; Sun, 17 Nov 2002 13:15:28 -0500
Received: from dp.samba.org ([66.70.73.150]:32711 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267542AbSKQSP1>;
	Sun, 17 Nov 2002 13:15:27 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PARAM 2/4 
In-reply-to: Your message of "Sun, 17 Nov 2002 10:00:17 -0800."
             <Pine.LNX.4.44.0211170953140.4425-100000@home.transmeta.com> 
Date: Mon, 18 Nov 2002 05:21:16 +1100
Message-Id: <20021117182227.82F332C059@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0211170953140.4425-100000@home.transmeta.com> you wri
te:
> 
> On Sat, 16 Nov 2002, Rusty Russell wrote:
> > MODULE_PARAM is misleading and wrong.
> 
> Why is MODULE_PARAM() misleading and wrong? I think it's a lot more 
> descriptive, and these things are "modules" whether they are actually 
> compiled in or not. 

I've already conceded this to Jeff Garzik, but...

> The MM layer is just "another module".

In theory.  In practice our current build process in mm/ is not
compiled as a module.  eg: if we put in mm/readahead.c 

	module_param(debug, int, 0600);

It'd be called "readahead.debug" not "mm.debug".  Maybe that's fine,
but indicates the subtle difference.

> Also, can we please stop shouting? I'd much rather see
> 
> 	module_param(debug, int, 0600)

Sure.  MODULE_AUTHOR(), MODULE_DESCRIPTION(), MODULE_PARM_DESC() and
MODULE_LICENSE() fight the other way.  They were previously module
only, but that's an implmentation detail: plan is to expose the first
three at least through sysfs, or just leave them as stubs for
documentation purposes.

Am off to visit Extremadura to see the LinEx project: will update
patch and re-send within 24 hrs,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
