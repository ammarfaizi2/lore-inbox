Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbUCCP3y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 10:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbUCCP3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 10:29:54 -0500
Received: from waste.org ([209.173.204.2]:2455 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262499AbUCCP20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 10:28:26 -0500
Date: Wed, 3 Mar 2004 09:26:20 -0600
From: Matt Mackall <mpm@selenic.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Pavel Machek <pavel@ucw.cz>, George Anzinger <george@mvista.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net,
       "Amit S. Kale" <amitkale@emsyssoft.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
Message-ID: <20040303152619.GE3883@waste.org>
References: <20040302213901.GF20227@smtp.west.cox.net> <40450468.2090700@mvista.com> <20040302221106.GH20227@smtp.west.cox.net> <20040302223143.GE1225@elf.ucw.cz> <20040302230018.GL20227@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302230018.GL20227@smtp.west.cox.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 04:00:18PM -0700, Tom Rini wrote:
> On Tue, Mar 02, 2004 at 11:31:43PM +0100, Pavel Machek wrote:
> 
> > Hi!
> > 
> > > > Tom Rini wrote:
> > > > >Hello.  The following interdiff kills kgdb_serial in favor of function
> > > > >names.  This only adds a weak function for kgdb_flush_io, and documents
> > > > >when it would need to be provided.
> > > > 
> > > > It looks like you are also dumping any notion of building a kernel that can 
> > > > choose which method of communication to use for kgdb at run time.  Is this 
> > > > so?
> > > 
> > > Yes, as this is how Andrew suggested we do it.  It becomes quite ugly if
> > > you try and allow for any 2 of 3 methods.
> > 
> > I do not think that having kgdb_serial is so ugly. Are there any other
> > uglyness associated with that?
> 
> More precisely:
> http://lkml.org/lkml/2004/2/11/224

I think it's a step in the wrong direction. I'd like to be able to
compile all my kernels with support for all the debugging
functionality I _might_ find myself needing. I'd generally prefer to
use kgdboe, but if I have to fall back to using serial for some early
boot issue or network issue and have to recompile on top of that, I'll
be annoyed.

I'd rather see everything be run-time. Ideally, serial kgdb would be
smart enough to read command line args to know whether to grab ports
and so on and need essentially no compile time config.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
