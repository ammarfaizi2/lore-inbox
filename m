Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVEJUuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVEJUuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 16:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVEJUto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 16:49:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:22701 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261784AbVEJUqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:46:00 -0400
Date: Tue, 10 May 2005 13:43:33 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Dave Jones <davej@redhat.com>, Christopher Warner <chris@servertogo.com>,
       Hugh Dickins <hugh@veritas.com>, cwarner@kernelcode.com,
       Chris Wright <chrisw@osdl.org>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
Message-ID: <20050510204333.GX27549@shell0.pdx.osdl.net>
References: <Pine.LNX.4.61.0504191636570.13422@goblin.wat.veritas.com> <1114773179.9543.14.camel@jasmine> <20050429173216.GB1832@redhat.com> <20050502170042.GJ7342@wotan.suse.de> <1115047729.19314.1.camel@jasmine> <1115717814.7679.2.camel@jasmine> <20050510163851.GA1128@redhat.com> <20050510164649.GL25612@wotan.suse.de> <20050510165938.GA11835@redhat.com> <20050510203233.GM25612@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050510203233.GM25612@wotan.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> On Tue, May 10, 2005 at 12:59:38PM -0400, Dave Jones wrote:
> > On Tue, May 10, 2005 at 06:46:49PM +0200, Andi Kleen wrote:
> >  > On Tue, May 10, 2005 at 12:38:51PM -0400, Dave Jones wrote:
> >  > > On Tue, May 10, 2005 at 05:36:54AM -0400, Christopher Warner wrote:
> >  > >  > 2.6.11.5 kernel,
> >  > >  > Tyan S2882/dual AMD 246 opterons
> >  > >  > sh:18983: mm/memory.c:99: bad pmd ffff810005974cc8(00007ffffffffe46). 
> >  > >  > sh:18983: mm/memory.c:99: bad pmd ffff810005974cd0(00007ffffffffe47).
> >  > > 
> >  > > That's the 3rd or 4th time I've seen this reported on this hardware.
> >  > > It's not exclusive to it, but it does seem more susceptible
> >  > > for some reason. Spooky.
> >  > 
> >  > It seems to be clear now that it is hardware independent.
> >  > 
> >  > I actually got it once now too, but only after 24+h stress test :/
> >  > 
> >  > I have a better debugging patch now that I will be testing soon,
> >  > hopefully that turns something up.
> > 
> > Ok, I'm respinning the Fedora update kernel today for other
> > reasons, if you have that patch in time, I'll toss it in too.
> 
> The patch has considerable overhead, probably not  good idea
> for a production rpm.

I don't mind running it here.  I've triggered it once, and not hit the
WARN_ON(start == end).  Current was "sh", not that helpful.

thanks,
-chris
