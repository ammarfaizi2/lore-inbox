Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbTKXW05 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 17:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbTKXW04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 17:26:56 -0500
Received: from web40910.mail.yahoo.com ([66.218.78.207]:29505 "HELO
	web40910.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261460AbTKXW0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 17:26:54 -0500
Message-ID: <20031124222652.16351.qmail@web40910.mail.yahoo.com>
Date: Mon, 24 Nov 2003 14:26:52 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0311241356420.1473@home.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Torvalds,

--- Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Mon, 24 Nov 2003, Guennadi Liakhovetski wrote:
> >
> > Well, FWIW, I'm getting 100% reproducible Oopses on __boot__ by enabling
> > preemption AND (almost) all kernel-hacking CONFIG_DEBUG_* options - see my
> > post of 21.11.2003 with subject "[OOPS] 2.6.0-test7 + preempt + hacking".
> > If required, could try to narrow it down to 1 CONFIG option.
> 
> I'd love to have more info - I actually looked at your original report,
> and it's one of those "impossible" things as far as I can tell. The low
> bit of the work "pending" flag should acts as a lock on workqueues, and
> serialize access to one workqueue totally - so having it show up with a
> pending timer is "strange" to say the least. The only two ways to clear
> the "pending" timer is by running the work-queue - either for the timer to
> have gone off (for the delayed case) _or_ the timer not to have evern been
> set in the first place (for the immediate case).
> 
> So more information would be wonderful.

What sort of information would you like me to provide, sir? The bug you're
discussing here isn't affecting me; CONFIG_PREEMPT has been solid on 2.6.0-test10.
This is on a Gateway 600S laptop with a P4-M 2Ghz processor and an i845 Brookdale
chipset.

> 
> 		Linus

Brad


=====


__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
