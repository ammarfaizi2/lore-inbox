Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267288AbTAAQdp>; Wed, 1 Jan 2003 11:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267291AbTAAQdp>; Wed, 1 Jan 2003 11:33:45 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:34751 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267288AbTAAQdo>; Wed, 1 Jan 2003 11:33:44 -0500
Date: Wed, 1 Jan 2003 17:42:08 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: John Bradford <john@grabjohn.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] top-level config menu dependencies
Message-ID: <20030101164207.GG15200@louise.pinerecords.com>
References: <20030101162519.GF15200@louise.pinerecords.com> <200301011632.h01GWOdn001749@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301011632.h01GWOdn001749@darkstar.example.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [john@grabjohn.com]
> 
> > It has been a long-time tradition that no "real tunable options" are
> > present in the top level of the kernel config menu.  I reckon this has
> > to do with an inherent limitation of the original config subsystem.
> > 
> > While converting the way submenus appear in menuconfig depending on
> > their main, parent config option, I stumbled upon certain subsystems
> > (such as MTD or IrDA) that should clearly have an on/off switch directly
> > in the main menu so that one doesn't have to enter the corresponding
> > submenus to even see if they're enabled or disabled.
> > 
> > Since the new kernel configurator would have no problems with such
> > a setup, I'm posting this RFC to get the general opinion on whether
> > this should be carried on with.  I'm willing to create and send in
> > the patches.
> 
> Why not?  The config system is changing so much between 2.4 and 2.5
> anyway, so any re-organisation like that might as well be done in one
> go now, rather than during the 2.7 development cycle.

Well, you see, when I wrote "long-time tradition" above, I actually
meant "I've never seen it work differently and it's been *some* years,"
so I don't want to just go ahead, as I can imagine there might be
people with very valid reasons for why this should not be done.

One convenient aspect of this idea is that "make oldconfig" would still
work because most of the subsystems already have their main on/off switch
the config keyword of which wouldn't change -- it would merely be moved.

-- 
Tomas Szepe <szepe@pinerecords.com>
