Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267247AbTAAOm6>; Wed, 1 Jan 2003 09:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbTAAOm5>; Wed, 1 Jan 2003 09:42:57 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:7871 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267247AbTAAOm4>; Wed, 1 Jan 2003 09:42:56 -0500
Date: Wed, 1 Jan 2003 15:51:20 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: a few more "make xconfig" inconsistencies
Message-ID: <20030101145120.GL14184@louise.pinerecords.com>
References: <20030101141644.GI14184@louise.pinerecords.com> <Pine.LNX.4.44.0301010922160.18348-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301010922160.18348-100000@dell>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [rpjday@mindspring.com]
> 
> On Wed, 1 Jan 2003, Tomas Szepe wrote:
> 
> > > [rpjday@mindspring.com]
> > >
> > >   even if, under "Networking options", i deselect IPv6,
> > > i'm still presented with an inactive IPv6 Netfilter Configuration
> > > screen.
> > 
> > This is fixed in both 2.4.20 & 2.5.53 as far as I can see.
> 
> i'm looking at 2.4.20 with the 2.4.21-pre2 patch as we speak,
> and, under "make xconfig", after deselecting IPv6, i am still
> presented with a (deactivated) IPv6 netfilter configuration
> dialog.

Oh, I see what you mean.  This behavior is a "feature" of the old
xconfig (it's been so since the 2.0 times or thereabouts). menuconfig
will hide entirely what xconfig merely grays out.

> granted, it's deactivated (is that what you were referring to?)

Right.

> but it's still presented to me.  this seems to be inconsistent
> with one of your recent patches -- don't show arcnet dialog if
> arcnet is deselected.

That's just my word choice sucking noodles as usual.  I should
probably be referring to these changes with something like "make
the submenu dependent on its parent entry," which wouldn't take
for granted any of the pecularities a certain config frontend
might throw in.  You see, in 2.4, config, menuconfig and xconfig
all have their own mechanics for work with Config.in files.
(Ever noticed how menuconfig and xconfig produce different
.config's while the options chosen are identical?)

> am i understanding all this correctly?

Hope this clarifies.

> i'm downloading it as we speak. :-)  but on a more general note,
> here's something i was thinking about -- some of the more general
> selections should have their overall select button moved up in 
> the hierarchy.

Yes, but no one is really fond of the thought of the options getting
rearranged too much.  There's the old "Yes, it's not ideal, but if
you woke me up totally wasted at 3 a.m., I'd know where to look for
CONFIG_HRM0PS54554."

> anyway, i'll switch over to 2.5.53 and let you know what i find.

Thanks.

-- 
Tomas Szepe <szepe@pinerecords.com>
