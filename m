Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263191AbVG3XhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbVG3XhB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 19:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbVG3XhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 19:37:01 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:29411 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S263191AbVG3XhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 19:37:00 -0400
Date: Sun, 31 Jul 2005 01:35:35 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Nishanth Aravamudan <nacc@us.ibm.com>
cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] Add schedule_timeout_{interruptible,uninterruptible}{,_msecs}()
 interfaces
In-Reply-To: <20050727222914.GB3291@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0507310046590.3728@scrub.home>
References: <1122078715.5734.15.camel@localhost.localdomain>
 <Pine.LNX.4.61.0507231247460.3743@scrub.home> <1122116986.3582.7.camel@localhost.localdomain>
 <Pine.LNX.4.61.0507231340070.3743@scrub.home> <1122123085.3582.13.camel@localhost.localdomain>
 <Pine.LNX.4.61.0507231456000.3728@scrub.home> <20050723164310.GD4951@us.ibm.com>
 <Pine.LNX.4.61.0507231911540.3743@scrub.home> <20050723191004.GB4345@us.ibm.com>
 <Pine.LNX.4.61.0507232151150.3743@scrub.home> <20050727222914.GB3291@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 27 Jul 2005, Nishanth Aravamudan wrote:

> > > My goal is to distinguish between these cases in sleeping-logic:
> > > 
> > > 1) tick-oriented
> > > 	use schedule_timeout(), add_timer(), etc.
> > > 
> > > 2) time-oriented
> > > 	use schedule_timeout_msecs()
> > 
> > There is _no_ difference, the scheduler is based on ticks. Even if we soon 
> > have different time sources, the scheduler will continue to measure the 
> > time in ticks and for a simple reason - portability. Jiffies _are_ simple, 
> > don't throw that away.
> 
> I agree that from an internal perspective there is no difference, but
> from an *interface* perspective they are hugely different, simply on the
> basis that one uses human-time units and one does not.
> 
> I guess we must continue to agree to disagree.

I'm not really sure, what you disagree about.
1 HZ is about one second, which I don't think is such a difficult concept. 
I already said wrapper functions are fine and for anything smaller than 
HZ/2 it's probably a good idea nowadays.
My main point is to keep the core functionality in jiffies and provide 
some wrapper functions. What exactly do you disagree here on?

bye, Roman
