Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVBHRFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVBHRFk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 12:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVBHRFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 12:05:40 -0500
Received: from mail.autoweb.net ([198.172.237.26]:260 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261568AbVBHRFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 12:05:31 -0500
Date: Tue, 8 Feb 2005 12:04:01 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@germaschewski.name>,
       linux-kernel@vger.kernel.org, dholland@eecs.harvard.edu
Subject: Re: [PATCH] Makefiles are not built using a Fortran compiler
Message-ID: <20050208170401.GB7828@mythryan2.michonline.com>
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
User-Agent: Mutt/1.5.6+20040907i
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
> improvement, and I'm not sure anyone really uses those rules.  Can we
> perhaps uncomment this line at the beginning of 2.6.12 and see if anyone
> complains?  This should reduce make overhead by 30-40% which is really
> worth doing.

The BitKeeper users sometimes make use of the SCCS rules.

BK installs itself in such a way as to provide the SCCS commands, and
Make will update things if you forget to do a bk -r get -Sq after a
pull.

>From a totally clean tree, this doesn't work (I forget why, offhand, but
I think it's something to do with the *config targets), but it is
helpful at times from partially clean trees to automatically "get" from
the SCCS copy of the file.

-- 

Ryan Anderson
  sometimes Pug Majere
