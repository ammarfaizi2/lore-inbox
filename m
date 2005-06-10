Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVFJEDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVFJEDu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 00:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbVFJEDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 00:03:50 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:53461 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261604AbVFJEDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 00:03:47 -0400
X-ORBL: [67.117.73.34]
Date: Thu, 9 Jun 2005 21:03:30 -0700
From: Tony Lindgren <tony@atomide.com>
To: Christian Hesse <mail@earthworm.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050602-2
Message-ID: <20050610040330.GA18103@atomide.com>
References: <20050602013641.GL21597@atomide.com> <200506030808.12903.mail@earthworm.de> <20050603173940.GA18025@atomide.com> <200506041451.14518.mail@earthworm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506041451.14518.mail@earthworm.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christian Hesse <mail@earthworm.de> [050604 05:51]:
> On Friday 03 June 2005 19:39, Tony Lindgren wrote:
> [ ... ]
> > > Software suspend still does not work, it hangs on resume. Any ideas what
> > > could be the cause? I've applied these patches on top of 2.6.12-rc5:
> > >
> > > 2.6.12-rc4-ck1
> > > software suspend 2.1.8.10
> > > reiser from 2.6.12-rc5-mm1
> > > ieee802.11 stack and ipw2100 1.1.0
> > > hostap 0.3.7
> > > shfs 0.35
> > > fbsplash 0.9.2-r2
> > > dyn-tick
> >
> > I don't think it's the dyn-tick patch that causes it. Does the
> > resume work properly without the dyn-tick patch?
> 
> I've simply disabled CONFIG_NO_IDLE_HZ, recompiled the kernel and resume works 
> perfectly.

Weird, it suspend and resume works fine for me. Or worked on my small laptop
until I fried it's mobo few days ago...

> But I found another drawback. ping -f reports lots of these errors (though it 
> still works):
> 
> Warning: time of day goes back (0.122us), taking countermeasures.

I haven't seen this one either. Maybe try the patch I'll post shortly.

Tony
