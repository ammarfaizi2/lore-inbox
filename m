Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVE3WW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVE3WW5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 18:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVE3WW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 18:22:57 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:28170 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261706AbVE3WWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 18:22:52 -0400
Date: Mon, 30 May 2005 15:27:47 -0700
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: James Bruce <bruce@andrew.cmu.edu>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050530222747.GB9972@nietzsche.lynx.com>
References: <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au> <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au> <429B1898.8040805@andrew.cmu.edu> <429B2160.7010005@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429B2160.7010005@yahoo.com.au>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 12:21:20AM +1000, Nick Piggin wrote:
> James Bruce wrote:
> [snip lots of stuff]
> 
> Sorry James, we were talking about hard realtime. Read the thread.
> What's more, I don't think you understand how a nanokernel solution
> would work, nor have much idea about the complexity of implementing
> it in Linux (although that could have been a result of your thinking
> that we weren't talking about hard-rt).

He's was talking about it clearly as an experience RT app developer.
His points are clear and clearly show that he's written and run into
a lot of these same issues writing medium to large RT apps.
 
> And my questions for which I got no answer were things like
> "why is a single kernel superior to a nanokernel for hard-RT?",
> "what deterministic services would a hard-RT Linux need to provide?"

That's an RT begineer's question. You have to at least be up to speed
in that one to have the conversation at hand and folks have discussed
this repeatedly. It's not our end that failing and clearly you not
understanding this only reenforces this point..
 
> So most of what you said is irrelevant, but I'll pick out a few bits.

Oh god.

> No, that wasn't part of any of my hole shooting. I asked what operations
> need to be realtime and have not had an answer. fork/exec was "prompting".

I've been on vacation like most of us here and I'd like to avoid this
discussion over the weekend. But experienced RT app folks know this answer
already and that it's *not* created to put guarantees on this and "any thing
crossing the kernel boundary via a syscall" at this point. I've also said
this in previous emails but it went over your head or you didn't care to
to spend the time to understand mailings in the first place.

> >deadlines.  Then at the same time, when someone describes what an RT 
> >application typically does do, you claim how simple and trivial it all 
> >is, and without knowing any of the details tell them that it'd be easy 
> >to split it into separate processes.
> 
> Err, your example was "reading a configuration file". Not exactly
> rocket science my good man.

Again, you didn't understand the variety of services being discussed
here.

Think about what you need to do for app that does sound (hard RT),
3d drawing (mostly soft RT for this example), reading disk IO that's
buffered.

By the time you get the sound playback and IO buffering going, you're
going to get a pretty complicated commuication layer already going
from those points. Now think, what if you intend to do a FFT over that
data and display it ?

It's starting to get unmanagably complicated at that point.

> I have a better idea. I won't read up on any of that, and I will go
> and do my own thing and stop wasting my time on this thread. Then
> whoever wants to start putting hard realtime functionality into Linux
> can *tell* me why nanokernels failed, OK? Let's end the discussion
> until then. It is going nowhere.

bill

