Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267376AbSLLA3q>; Wed, 11 Dec 2002 19:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267379AbSLLA3q>; Wed, 11 Dec 2002 19:29:46 -0500
Received: from dp.samba.org ([66.70.73.150]:61642 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267376AbSLLA3p>;
	Wed, 11 Dec 2002 19:29:45 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Benjamin Reed <breed@users.sourceforge.net>,
       Jeff Garzik <jgarzik@mandrakesoft.com>, dahinds@users.sourceforge.net
Subject: Re: Status new-modules + 802.11b/IrDA 
In-reply-to: Your message of "Wed, 11 Dec 2002 09:43:05 -0800."
             <20021211174305.GB11264@bougret.hpl.hp.com> 
Date: Thu, 12 Dec 2002 09:46:02 +1100
Message-Id: <20021212003733.2AF922C0E0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021211174305.GB11264@bougret.hpl.hp.com> you write:
> On Wed, Dec 11, 2002 at 07:34:53PM +1100, Rusty Russell wrote:
> > > 	o removal of airo_cs : "Uninitialised timer!/nThis is a
> > > warning. Your computer is OK". Call trace on demand. Also, the module
> > > airo not removed (probably due to problem with airo_cs).
> > 
> > That, in itself, should be harmless.
> 
> 	Yes, but this is new and I don't really like it. I suspect
> something is wrong in the Pcmcia code itself. Last I tried was 2.5.46
> and I see some suspicious init_timer() added where I would not expect,
> and some missing where they would be needed.
> 	Hum... Who is in charge ?

Well, Andrew Morton made the change that required timers to be
initialized, and the check which locates ones which are not.  As to
who is responsible for airo_cs, I'm guessing Ben Reed, as author.

> 	I personally believe the timer thingy is important and cause
> of problems.

I disagree: the warning is supposed to silently fix it up.

> 	Thanks a lot !
> 
> 	Jean

That's what I'm here for,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
