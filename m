Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262432AbTCRJ5q>; Tue, 18 Mar 2003 04:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262433AbTCRJ5q>; Tue, 18 Mar 2003 04:57:46 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:648 "EHLO smtp2.clear.net.nz")
	by vger.kernel.org with ESMTP id <S262432AbTCRJ5o>;
	Tue, 18 Mar 2003 04:57:44 -0500
Date: Tue, 18 Mar 2003 22:06:20 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [PATCH] Don't refill pcp lists during SWSUSP.
In-reply-to: <20030318081809.GB10472@atrey.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: akpm@digeo.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1047981979.2206.3.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1047945372.1714.19.camel@laptop-linux.cunninghams>
 <20030318081809.GB10472@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel.

You need to remember that this is infrastructure for later. I tried it
other ways and would have needed a number of calls to drain local pages.
Perhaps I'm taking the wrong approach, trying to feed a patch at a time
when you can't see how it all fits together. If you like, I'll send a
'whole kit and caboodle' patch as soon as I get the last bugs ironed
out. I have it suspending and resuming at the moment, but have one last
bug to iron out that's stopping me getting back from
do_suspend_lowlevel. It's just a matter of time, and then that will be
fixed. I could send you a monster patch then :> (I'll be posting it
somewhere anyway - I'll want others to test it, of course).

Regards,

Nigel

On Tue, 2003-03-18 at 20:18, Pavel Machek wrote:
> Hi!
> 
> > Here's another patch (the last for a little while, I promise!). It stops
> > the pcp lists from being refilled while SWSUSP is running. Despite the
> > comment in the page, drain_local_pages does only need to get called once
> > right now, but I have patches coming that will (DV) change that. This
> > patch is thus groundwork for them.
> 
> This adds external (and pretty  ugly) dependency of swsusp on the
> outside. And as it still needs to drain_local_pages(), nothing is
> gained. I believe it is better to just call drain_local_pages few
> times. Magic hooks "if suspending, don't do this" seem like wrong
> approach to me.
> 
> 								Pavel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

