Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267579AbUHMUSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267579AbUHMUSJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 16:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUHMUPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 16:15:38 -0400
Received: from colin2.muc.de ([193.149.48.15]:13327 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S267334AbUHMUOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 16:14:12 -0400
Date: 13 Aug 2004 22:14:10 +0200
Date: Fri, 13 Aug 2004 22:14:10 +0200
From: Andi Kleen <ak@muc.de>
To: Pawe?? Sikora <pluto@pld-linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [ix86,x86_64] cpu features.
Message-ID: <20040813201410.GA35817@muc.de>
References: <2sMat-61I-43@gated-at.bofh.it> <m3smarrpau.fsf@averell.firstfloor.org> <200408131902.46553.pluto@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408131902.46553.pluto@pld-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 07:02:45PM +0200, Pawe?? Sikora wrote:
> On Friday 13 of August 2004 18:11, Andi Kleen wrote:
> > Pawe? Sikora <pluto@pld-linux.org> writes:
> > > +++ linux-2.6.8-rc4/arch/i386/kernel/cpu/proc.c	2004-08-13
> > > 16:48:53.971370504 +0200 @@ -44,8 +44,8 @@
> > >  		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
> > >
> > >  		/* Intel-defined (#2) */
> > > -		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "tm2",
> > > -		"est", NULL, "cid", NULL, NULL, NULL, NULL, NULL,
> > > +		"sse3", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "est",
> > > +		"tm2", NULL, "cid", NULL, NULL, NULL, "xtpr", NULL,
> >
> > You cannot just do the pni -> sse3 rename. That could break existing
> > applications that read /proc/cpuinfo and parse it. The only way would
> > be to add a new sse3 flag in addition to pni, but I guess that would
> > be not worth the ugly special case.
> 
> Ok, it's now correct?

Can you please send a new diff, a diff of a diff is not very nice
to read.

-Andi
