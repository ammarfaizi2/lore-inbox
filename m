Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267990AbUHEVKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267990AbUHEVKd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267991AbUHEVEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:04:20 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:9378 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S267990AbUHEVDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:03:41 -0400
Date: Thu, 5 Aug 2004 14:03:03 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Olaf Hering <olh@suse.de>, Giuliano Pochini <pochini@shiny.it>,
       kumar.gala@freescale.com, tnt@246tNt.com,
       linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH][PPC32] Makefile cleanups and gcc-3.4+binutils-2.14 c
Message-ID: <20040805140303.B14159@home.com>
References: <XFMail.20040729100549.pochini@shiny.it> <20040729144347.GE16468@smtp.west.cox.net> <20040730205901.4d4181f4.pochini@shiny.it> <20040730190731.GQ16468@smtp.west.cox.net> <20040730224828.0f06e37a.pochini@shiny.it> <20040730210318.GS16468@smtp.west.cox.net> <20040805141257.GA14826@suse.de> <20040805165410.GA555@smtp.west.cox.net> <20040805180025.GA20390@suse.de> <20040805181425.GD555@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040805181425.GD555@smtp.west.cox.net>; from trini@kernel.crashing.org on Thu, Aug 05, 2004 at 11:14:25AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 11:14:25AM -0700, Tom Rini wrote:
> 
> On Thu, Aug 05, 2004 at 08:00:25PM +0200, Olaf Hering wrote:
> >  On Thu, Aug 05, Tom Rini wrote:
> >
> > > On Thu, Aug 05, 2004 at 04:12:57PM +0200, Olaf Hering wrote:
> > > >  On Fri, Jul 30, Tom Rini wrote:
> > > >
> > > > >
> > > > > +aflags-$(CONFIG_PPC64BRIDGE)	+= -mppc64bridge
> > > >
> > > > this should be -Wa,-mppc64bridge for some reasons.
> > >
> > > That, er, doesn't make sense.  The assembler needs -Wa,?
> >
> > This makes g5 32bit happy. aflags- is used with 'gcc $options', not for as
> > I'm not sure if the other aflags- should stay.
> 
> I mistook AFLAGS for being always invoked with gas, which is not the
> case.  Lets do the following:
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>

This fixed the build problems (unrecognized -m405) with a PPC440 native
toolchain.

-Matt
