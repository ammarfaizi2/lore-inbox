Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSHNWRs>; Wed, 14 Aug 2002 18:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319262AbSHNWRr>; Wed, 14 Aug 2002 18:17:47 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:54156 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S315720AbSHNWRr>; Wed, 14 Aug 2002 18:17:47 -0400
Date: Wed, 14 Aug 2002 17:21:31 -0500
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Get rid of shell based Config.in parsers?
Message-ID: <20020814222131.GC17969@cadcamlab.org>
References: <20020808164742.GA5780@cadcamlab.org> <20020809041543.GA4818@cadcamlab.org> <3D53D50D.7FA48644@alphalink.com.au> <20020809161046.GB687@cadcamlab.org> <3D579629.32732A73@alphalink.com.au> <20020812154721.GA761@cadcamlab.org> <3D587BA7.1D640926@alphalink.com.au> <20020813180415.B1357@mars.ravnborg.org> <3D59A2DF.3DDA38E8@alphalink.com.au> <20020814221400.A1562@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020814221400.A1562@mars.ravnborg.org>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Sam Ravnborg]
> Where comes the requirement that we shall keep the existing shell 
> based config parsers?

I don't make that argument - mconfig is the superior solution by far -
but it is certainly the path of least resistance.

As pertains to CONFIG_EXPERIMENTAL and " (EXPERIMENTAL)", it *is*
possible to add such a feature to the shell-based parsers by changing
the syntax slightly - specifically to lose the '$' on dependencies.

Changing the syntax *does* have ramifications when it means adapting
three separate parsers, but it can be done.

> Remembering the CML2 war there were no serious objections about
> shifting away from shell based parsers (but certainly a lot about
> the alternative selected).

It would have been a big change and a big flag day, and among other
problems, the rulebase conversion issue was handled wrong.  Eric
refused to start from a 1-1 equivalent rulebase, preferring to tweak
the rulebase as he went along - partly just to fix bugs, partly to
show off his new capabilities.  Unfortunately, without the
apples-to-apples comparison, many people distrusted the new system,
superior though it was in many ways.

This is the primary lesson to be learned from CML2.  Anyone trying to
redesign a subsystem such as the kernel config system needs to keep it
in mind.  (Yes, I know from the rest of your message that you learned
it.)

Peter
