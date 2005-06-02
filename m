Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVFBTaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVFBTaq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 15:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVFBTaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 15:30:46 -0400
Received: from fsmlabs.com ([168.103.115.128]:16050 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261259AbVFBTam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 15:30:42 -0400
Date: Thu, 2 Jun 2005 13:34:11 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ingo Oeser <ioe-lkml@axxeo.de>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [rfc] [patch] consolidate/clean up spinlock.h files
In-Reply-To: <200506021749.15206.ioe-lkml@axxeo.de>
Message-ID: <Pine.LNX.4.61.0506021333410.3157@montezuma.fsmlabs.com>
References: <20050602144004.GA31807@elte.hu> <200506021749.15206.ioe-lkml@axxeo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2005, Ingo Oeser wrote:

> Hi Ingo,
> you wrote:
> 
> > --- linux/lib/spinlock_debug.c.orig
> > +++ linux/lib/spinlock_debug.c
> > +#define SPIN_BUG_ON(cond, lock, msg) \
> > +		if (unlikely(cond)) spin_bug(lock, __FILE__, __LINE__, msg)
> > +#define RWLOCK_BUG_ON(cond, lock, msg) \
> > +		if (unlikely(cond)) rwlock_bug(lock, __FILE__, __LINE__, msg)
> 
> I would suggest propagating the __FILE__ and __LINE__ from the CALLERS 
> of those functions in lib/spinlock_debug.c into these macros, to make
> this info more useful. At the moment you just know, that the bug happend
> on some spinlock/rwlock, but not who caused this.

That sounds like it has the potential to really bloat things up with 
respect to the kernel image size.

	Zwane

