Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVLFRdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVLFRdF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVLFRdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:33:05 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:44953 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932598AbVLFRdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 12:33:04 -0500
Date: Tue, 6 Dec 2005 18:32:41 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: tglx@linutronix.de
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       rostedt@goodmis.org, johnstul@us.ibm.com, mingo@elte.hu
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
In-Reply-To: <20051206000126.589223000@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.61.0512061628050.1610@scrub.home>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, 6 Dec 2005 tglx@linutronix.de wrote:

Before I get into a detailed review, I have to asked a question I already 
asked earlier: are even interested in a discussion about this?

Since I posted the ptimer patches, I haven't gotten a single direct 
response from you, except some generic description in your last patch.
I would prefer if we could work together on this, but this requires some 
communication. I know I'm sometimes a little hard to understand, but you 
don't even try to ask if something is unclear or to explain the details 
from your perspective.
Slowly I'm asking myself why I should bother, the alternative would be to 
just continue my own patch set. I don't really want that and Andrew 
certainly doesn't want to choose between two versions either. So Thomas, 
please get over yourself and start talking.

> We worked through the subsystem and its users and further reduced the 
> implementation to the basic required infrastructure and generally 
> streamlined it. (We did this with easy extensibility for the high 
> resolution clock support still in mind, so we kept some small extras 
> around.)

It looks better, but could you please explain, what these extras are good 
for?

> After reading the Posix specification again, we came to the conclusion 
> that it is possible to do no rounding at all for the ktime_t values, and 
> to still ensure that the timer is not delivered early.

Nice, that you finally also come to that conclusion, after I said that 
already for ages. (It's also interesting how you do that without giving me 
any credit for it.)
Nevertheless, if you read my explanation of the rounding carefully and 
look at my implementation, you may notice that I still disagree with the 
actual implementation.

BTW there is one thing I'm currently curious about. Why did you rename the 
timer from high-precision timer to high-resolution timer? hrtimer was just 
a suggestion from Andrew and ptimer would have been fine as well.

bye, Roman
