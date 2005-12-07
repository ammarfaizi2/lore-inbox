Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbVLGPEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbVLGPEe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVLGPEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:04:34 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:45986 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751105AbVLGPEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:04:33 -0500
Date: Wed, 7 Dec 2005 16:03:30 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: James Bruce <bruce@andrew.cmu.edu>,
       David Lang <david.lang@digitalinsight.com>,
       Steven Rostedt <rostedt@goodmis.org>, johnstul@us.ibm.com,
       george@mvista.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       ray-gmail@madrabbit.org, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/43] ktimer reworked
In-Reply-To: <0EA7F687-BB3F-4CC2-953E-EEA057F6FC44@mac.com>
Message-ID: <Pine.LNX.4.61.0512071547330.1609@scrub.home>
References: "dlang@dlang.diginsite.com" <Pine.LNX.4.62.0512011734020.10276@qynat.qvtvafvgr.pbz>
 <Pine.LNX.4.61.0512021124360.1609@scrub.home> <4396ACF5.3050204@andrew.cmu.edu>
 <Pine.LNX.4.61.0512071319320.1609@scrub.home> <0EA7F687-BB3F-4CC2-953E-EEA057F6FC44@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 7 Dec 2005, Kyle Moffett wrote:

> > I do, just without the focus on the lifetime, which is really unimportant
> > for most kernel developers.
> 
> It _is_ important.  Not because kernel developers do care about it, but
> because it's important for reasons of its own and therefore they should.
> Networking timeouts and highres audio timers are two _VERY_ different
> applications of "do this thing then", and kernel developers should be made
> aware of them.  If you disagree, please explain in detail exactly why you
> think the lifetime is unimportant.  I have yet to see an email regarding this,
> and I've searched the archives pretty carefully, in addition to watching this

Please be precise, the "for most kernel developers" part is important.
In most situations this guideline is more than enough:
- if you need fast and simple timer, use normal timer
- if you need higher resolution, use hrtimer

Only if you want to push the timer system to its limits, you have to take 
the corner cases into account. I consider lifetime issues an advanced 
topic of timer programming, which Joe Kernelhacker doesn't has to be 
overly concerned about (it worked quite well so far).

bye, Roman
