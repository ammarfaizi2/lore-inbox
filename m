Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275594AbTHMVQb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 17:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275595AbTHMVQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 17:16:31 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:50183 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S275594AbTHMVQ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 17:16:26 -0400
Date: Wed, 13 Aug 2003 16:55:07 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: John Bradford <john@grabjohn.com>
cc: bunk@fs.tum.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       wowbagger@sktc.net
Subject: Re: time for some drivers to be removed?
In-Reply-To: <200308132055.h7DKtTkH002249@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.3.96.1030813165150.12417J-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003, John Bradford wrote:

> > > > Interesting question - whatever I guess. We don't have an existing convention.
> > > > How many drivers have we got nowdays that failing on just SMP ?
> > > 
> > > I 2.6.0-test2 tested on i386 with a .config that is without support for
> > > modules and compiles as much as possible statically into the kernel.
> > > Without claiming completeness, I found this way besides the complete Old
> > > ISDN4Linux subsystem 36 drivers that compile due to cli/sti issues only
> > > on UP.
> >
> > Should those be made to depend on SMP (not SMP) perhaps? They are probably
> > high candidates for fixing if they work UP.
> 
> Especially since a lot of the time, 'works on UP, but not on SMP',
> really means, 'broken on UP and SMP, but the bug is much more
> difficult to trigger on UP'.

I was thinking more of not even compiling with SMP set, not so much
compiling but not working. I think that covers the above cli/sti example,
and perhaps there are still drivers which will work built in, but not
compile as modules due to the module redesign.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

