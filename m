Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWAaXjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWAaXjC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 18:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWAaXjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 18:39:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62141 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932146AbWAaXjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 18:39:00 -0500
Date: Tue, 31 Jan 2006 15:40:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: apw@shadowen.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] timer tsc ensure we allow for initial tsc and tsc sync
Message-Id: <20060131154058.007511cd.akpm@osdl.org>
In-Reply-To: <1138750103.10057.67.camel@cog.beaverton.ibm.com>
References: <20060120125342.GA7632@shadowen.org>
	<1138399887.14289.107.camel@cog.beaverton.ibm.com>
	<43DE14F0.5070208@shadowen.org>
	<20060131152113.14781abf.akpm@osdl.org>
	<1138750103.10057.67.camel@cog.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> wrote:
>
> > >  	offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
> > > -	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last != 0))) {
> > > +	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last != 0))
> > > +					&& detect_lost_ticks) {
> > 
> > Simple enough.  John, so you feel that this is 2.6.16 material?
> 
> Yep.  There's a signed off version somewhere in your inbox.

<looks>

Oh yeah.  Hate it when that happens.

> > Note that the time changes in -mm will blow this change away, so I'd be
> > needing a fresh version of this patch against next-mm, please.
> 
> Uh, not sure I followed that. Do mean you'd want a new set of the
> generic timefoday patches to apply ontop of this fix?

argh, spare me from that.

No, I'd like a new version of this patch which applies on top of the
generic-tod patches please.  Could do it myself, but you moved all the code
around and I can't find anything ;)
