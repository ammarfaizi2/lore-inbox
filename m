Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269750AbSISCO4>; Wed, 18 Sep 2002 22:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269755AbSISCO4>; Wed, 18 Sep 2002 22:14:56 -0400
Received: from crack.them.org ([65.125.64.184]:14095 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S269750AbSISCOz>;
	Wed, 18 Sep 2002 22:14:55 -0400
Date: Wed, 18 Sep 2002 22:19:24 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Roman Zippel <zippel@linux-m68k.org>, kaos@ocs.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7
Message-ID: <20020919021924.GA31417@nevyn.them.org>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Roman Zippel <zippel@linux-m68k.org>, kaos@ocs.com.au,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209182313360.8911-100000@serv> <20020919020654.9B68E2C04C@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020919020654.9B68E2C04C@lists.samba.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 11:00:23AM +1000, Rusty Russell wrote:
> In message <Pine.LNX.4.44.0209182313360.8911-100000@serv> you write:
> > Hi,
> > 
> > On Wed, 18 Sep 2002, Rusty Russell wrote:
> > 
> > > 	I've rewritten my in-kernel module loader: this version breaks
> > > much less existing code.  Basically, we go to a model of
> > > externally-controlled module refcounts with possibility of failure
> > > (ie. try_inc_mod_count, now called try_module_get()).
> > 
> > You add a lot of complexity in an attempt to solve a quite simple problem.
> > I agree that the module load mechanism could be simplified, but why do you
> > want to do it in the kernel?
> 
> Count the total lines of code in the kernel.  It's less than it was
> before.  Even for ia64, it's around the same IIRC.
> 
> Now add the userspace code, and it's obviously far simpler.  Not to
> mention not having to worry about problems like insmod dying between
> the two system calls...
> 
> I'm all for keeping things out of the kernel, but you can take things
> too far.  I was originally reluctant, but the beauty and simplicity of
> doing it in-kernel changed my mind.

I still think that the kernel has no business knowing how to parse ELF
relocation.  It's just as easy to parse it in userspace; and what do
you gain from moving the complexity from userspace to kernelspace?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
