Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbSLaOSi>; Tue, 31 Dec 2002 09:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSLaOSi>; Tue, 31 Dec 2002 09:18:38 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61956 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262821AbSLaOSh>; Tue, 31 Dec 2002 09:18:37 -0500
Date: Tue, 31 Dec 2002 09:24:54 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>, `@samba.org
Subject: Re: 2.5.53 : modules_install warnings 
In-Reply-To: <20021231074756.2B9AC2C10B@lists.samba.org>
Message-ID: <Pine.LNX.3.96.1021231091929.10362B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Dec 2002, Rusty Russell wrote:

> In message <Pine.LNX.3.96.1021230212600.8353B-100000@gatekeeper.tmr.com> you wr
> ite:
> > On Sun, 29 Dec 2002, Rusty Russell wrote:
> > 
> > > In message <Pine.LNX.4.44.0212281758230.839-100000@linux-dev> you write:
> > > > Hello all,
> > > >   I received the following warnings while a 'make modules_install'. It 
> > > > looks like there are a few more locking changes that need to be made. :)
> > > 
> > > This is SMP, right?  Those warnings are perfectly correct (yes, those
> > > files need updating).
> > 
> > Any guess when you'll get them fixed?
> 
> I've discovered an interesting (but kinda obvious) phenomenon.  If you
> destabilize some part of the kernel, it becomes the natural suspect
> for problems.
> 
> The corollary is, I'm getting more reports on kernel "module" bugs
> which are not actually my fault at all (and some, like erroneous
> __init sections, which the new module code just shows up).
> 
> This is one: these drivers are actually broken.  They give warnings on
> compile, they won't link when compiled in, and they won't insert as
> modules.
> 
> Hope that clarifies,

If they didn't work in 2.5.47, before the module change, then clearly they
are broken on their own. If they worked until then, and especially if they
work built-in still, I would certainly suspect that the problem is related
to the module change.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

