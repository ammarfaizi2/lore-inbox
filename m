Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVBHTUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVBHTUp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 14:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVBHTUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 14:20:45 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:13930 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261635AbVBHTUZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 14:20:25 -0500
Date: Tue, 8 Feb 2005 20:20:27 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@germaschewski.name>,
       linux-kernel@vger.kernel.org, dholland@eecs.harvard.edu
Subject: Re: [PATCH] Makefiles are not built using a Fortran compiler
Message-ID: <20050208192027.GA8360@mars.ravnborg.org>
Mail-Followup-To: Matthew Wilcox <matthew@wil.cx>,
	Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Kai Germaschewski <kai@germaschewski.name>,
	linux-kernel@vger.kernel.org, dholland@eecs.harvard.edu
References: <20050208030228.GE20386@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.61.0502081322310.6118@scrub.home> <20050208154417.GH20386@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208154417.GH20386@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 03:44:17PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 08, 2005 at 01:23:48PM +0100, Roman Zippel wrote:
> > Enabling the following in the Makefile should have the same effect:
> > 
> > # For maximum performance (+ possibly random breakage, uncomment
> > # the following)
> > 
> > #MAKEFLAGS += -rR
> 
> This reduces the debug output even further (and size of debug output is
> strongly correlated with time taken to do a null build):
> 
> -rw-r--r--  1 willy willy 65582214 2005-02-07 21:13 vanilla.debug
> -rw-r--r--  1 willy willy 51413770 2005-02-07 22:17 nosuffixes.debug
> -rw-r--r--  1 willy willy 37245484 2005-02-08 09:56 maxperf.debug
> 
> Seems like it gets rid of the RCS and SCCS rules -- certainly a big
> improvement, and I'm not sure anyone really uses those rules.
The SCCS rules is the sole reason why -rR has not been enabled.

In my inbox I have a patch that enables SCCS support for all files.
Today it fails for Kconfig files at least.

I'm willing to give it a try. But we will only see people complaining
when it hits linus tree. -mm users uses quilt and the like - and thus
will not be hit by this.

	Sam
