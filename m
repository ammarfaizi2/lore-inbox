Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWBMW3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWBMW3o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWBMW3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:29:44 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:48100 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030216AbWBMW3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:29:43 -0500
Date: Mon, 13 Feb 2006 23:29:28 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, John Stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 01/13] hrtimer: round up relative start time
In-Reply-To: <20060213195550.GB30679@elte.hu>
Message-ID: <Pine.LNX.4.61.0602132302070.30994@scrub.home>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home>
 <1139827927.4932.17.camel@localhost.localdomain> <Pine.LNX.4.61.0602131208050.30994@scrub.home>
 <20060213130143.GA10771@elte.hu> <Pine.LNX.4.61.0602131441110.9696@scrub.home>
 <20060213144403.GA21317@elte.hu> <Pine.LNX.4.61.0602131643290.30994@scrub.home>
 <20060213195550.GB30679@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Feb 2006, Ingo Molnar wrote:

> > I don't fully agree with the interval behaviour either, [...]
> 
> i.e. you'd want to reintroduce the comulative interval rounding bug that 
> users noticed? Or do you have some other way to change it? I really dont 
> see your point.

And I don't want to expand on it, because otherwise this thread goes 
completely elsewhere again and I want to keep the focus on this patch.
These are two different problems, which have have only in common that it's 
about rounding of time.

> > Since hrtimer is also used for nanosleep(), which I consider more 
> > important (as e.g. posix timer), this one should at least be correct 
> > and consistent with previous 2.6 releases. [...]
> 
> for me it's simple: i dont think we should reintroduce the same type of 
> concept that was clearly causing regressions in previous 2.6 releases.  

You have a weird definition of "regression", since when is a bug fix a 
regression? We can discuss whether it's the correct fix and I described 
earlier in this thread the basic problem, which the current 2.6 behaviour 
fixes. I'd really prefer if we could based on that discuss a proper fix, 
instead of just falling back to the wrong 2.4 behaviour.

bye, Roman
