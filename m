Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbVI0RER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbVI0RER (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 13:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVI0RER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 13:04:17 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:32734 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965014AbVI0REQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 13:04:16 -0400
Date: Tue, 27 Sep 2005 19:04:10 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Herbert Poetzl <herbert@13thfloor.at>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] eliminate CLONE_* duplications
In-Reply-To: <20050927162242.GC21927@MAIL.13thfloor.at>
Message-ID: <Pine.LNX.4.61.0509271856430.3728@scrub.home>
References: <20050921092132.GA4710@MAIL.13thfloor.at>
 <Pine.LNX.4.61.0509211252160.3743@scrub.home> <20050921143954.GA10137@MAIL.13thfloor.at>
 <Pine.LNX.4.61.0509211648240.3743@scrub.home> <20050921151124.GB10137@MAIL.13thfloor.at>
 <Pine.LNX.4.61.0509211738160.3728@scrub.home> <20050921235810.GC18040@MAIL.13thfloor.at>
 <Pine.LNX.4.61.0509271705380.3728@scrub.home> <20050927162242.GC21927@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 Sep 2005, Herbert Poetzl wrote:

> > "logically organized" mainly means reducing dependencies by organizing
> > them by their logical dependencies. 
> 
> did you consider that separating out the clone
> stuff might be that basis for reducing dependencies?

Not in this form, all users of this flag need other definitions from 
sched.h.

> > The hardcoded defines actually do need fixing, frv is especially bad,
> > as it even has hardcoded structure offsets.
> 
> so instead of fixing the issue properly, we 
> 'mend' it by adding new code to */asm-offsets.c

Using asm-offsets.c _is_ a proper solution.

> > sched.h is especially challenging due to dependencies between headers
> > under asm and linux. It's not just splitting sched.h, it also requires
> > analyzing its dependencies.
> 
> which you obviously think is nothing I can do
> 'properly' ...

I don't know, but I know that it does require a large amount of experience 
in this area.

bye, Roman
