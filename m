Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318552AbSGaXgP>; Wed, 31 Jul 2002 19:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318558AbSGaXgP>; Wed, 31 Jul 2002 19:36:15 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:32468 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318552AbSGaXgO>;
	Wed, 31 Jul 2002 19:36:14 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] automatic module_init ordering 
In-reply-to: Your message of "Wed, 31 Jul 2002 12:06:52 EST."
             <Pine.LNX.4.44.0207311201000.19799-100000@chaos.physics.uiowa.edu> 
Date: Thu, 01 Aug 2002 09:28:19 +1000
Message-Id: <20020731234108.36C064D62@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0207311201000.19799-100000@chaos.physics.uiowa.edu> y
ou write:
> On Wed, 31 Jul 2002, Rusty Russell wrote:
> 
> > My PARAM code actually maps - to _ in parameter parsing, for exactly
> > this reason.  And only a complete idiot would put , in a module name,
> > so I don't care 8)
> 
> Tell that to the author of 53c7,8xx.o ;)

Consider that done.

> > As it happens, the configuration doesn't allow more than one to be
> > built in (they can all be modules though), so it's not actually a
> > problem even after parameter unification.
> 
> Hmmh, I think that'll need some testing. It will be fine if only one of 
> the three is "y", the others being "n/undef". However, it looks like it's 
> possible to have sth like "m/m/y", which would go wrong with the current 
> approach.

That's a bug.  That configuration makes no sense (the modules won't
load).  Hmmm... more Config.in complexity coming up 8(

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
