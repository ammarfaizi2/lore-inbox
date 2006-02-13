Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWBMTwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWBMTwi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWBMTwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:52:38 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:11401 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964825AbWBMTwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:52:37 -0500
Date: Mon, 13 Feb 2006 20:50:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] hrtimer: optimize hrtimer_run_queues
Message-ID: <20060213195052.GA30679@elte.hu>
References: <Pine.LNX.4.61.0602130210120.23827@scrub.home> <20060213133944.GA12923@elte.hu> <Pine.LNX.4.61.0602131654470.30994@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602131654470.30994@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > hm, we can do this - although the open-coded loop looks ugly. In any 
> > case, this is an optimization, and not necessary for v2.6.16. It is 
> > certainly ok for -mm.
> 
> I could also call this perfomance regressions to 2.6.15, unless there 
> is a good reason not to include them, I'd prefer to see it in 2.6.16.

can you measure it? This is tricky code, we definitely dont want to 
change it this late in the v2.6.16 cycles, execpt if it's some 
measurable performance issue that users will see. (or if it's some 
regression, which it isnt.)

	Ingo
