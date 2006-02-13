Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWBMVpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWBMVpe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 16:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWBMVpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 16:45:34 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:56547 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030182AbWBMVpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 16:45:33 -0500
Date: Mon, 13 Feb 2006 22:45:27 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] hrtimer: optimize hrtimer_run_queues
In-Reply-To: <20060213195052.GA30679@elte.hu>
Message-ID: <Pine.LNX.4.61.0602132233440.30994@scrub.home>
References: <Pine.LNX.4.61.0602130210120.23827@scrub.home> <20060213133944.GA12923@elte.hu>
 <Pine.LNX.4.61.0602131654470.30994@scrub.home> <20060213195052.GA30679@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Feb 2006, Ingo Molnar wrote:

> > I could also call this perfomance regressions to 2.6.15, unless there 
> > is a good reason not to include them, I'd prefer to see it in 2.6.16.
> 
> can you measure it? This is tricky code, we definitely dont want to 
> change it this late in the v2.6.16 cycles, execpt if it's some 
> measurable performance issue that users will see. (or if it's some 
> regression, which it isnt.)

Why is not a regression?
I'm busy enough with m68k as is just to catch up and you're not making it 
easier. Such repetitive task have a tendency to show up pretty high when I 
occasionally run an profile test run, e.g. a much simpler vertical blank 
interrupt at 50Hz is noticable. The new hrtimer code is much heavier and 
runs twice as much.

bye, Roman
