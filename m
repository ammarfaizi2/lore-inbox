Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263819AbTIIAA3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 20:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263822AbTIIAA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 20:00:28 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:35790 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S263819AbTIIAAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 20:00:18 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Timothy Miller <miller@techsource.com>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 8 Sep 2003 16:57:06 -0700 (PDT)
Subject: Re: Use of AI for process scheduling
In-Reply-To: <3F5D0A41.9090807@techsource.com>
Message-ID: <Pine.LNX.4.44.0309081651220.22562-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The biggest problem is that  the developers basicly can't suplicate the
problems. the best that could be done would be to add something to let a
user who runs into a problem hit a key and gather info to then send to a
developer to try and duplicate the problem on their 'development' kernel,
but since the development kernel doesn't make the same decisions in the
same amount of time it's going to be very hard to duplicate the problem
state.

even more fundamentally you don't know what info to feed into your AI
program to let it make it's decision, you can't feed in every detail that
the kernel knows about every program on the system or you will take
multiple seconds to make each scheduling decision

if it could be made fast enough to permanently replace the existing
scheduler then I think you would have a very interesting idea, but as long
as you are talking about a 'develop with AI and put the result into an
expert system' design I don't see how you could generate useful results.

the scheduler is by definition a real-time entity, if it takes twice as
long to make a decision that in itself alters what the correct decision
should be.

David Lang


 On Mon, 8 Sep 2003,
Timothy Miller wrote:

> Date: Mon, 08 Sep 2003 19:01:21 -0400
> From: Timothy Miller <miller@techsource.com>
> To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: Use of AI for process scheduling
>
>
>
> Felipe Alfaro Solana wrote:
> > On Mon, 2003-09-08 at 21:28, Timothy Miller wrote:
> >
> >
> >>Basically, we need to write and install into the kernel an AI engine
> >>which uses user feedback about the "feel" of the system to adjust
> >>heuristics dynamically.  For instance, if the user sees that the system
> >>is misbehaving, they can pause the system in the kernel debugger,
> >>examine process priorities, and indicate what "outputs" from the AI
> >>engine are wrong.  It then learns from that.  Heuristics can be tweaked
> >>until things run as desired.  At that point, scheduler developers trade
> >>emails in the AI heuristic language.
> >
> >
> > I'm no kernel expert but I think that doing what you suggest would take
> > an enormous amount of time and resources to do. Also, the scheduler must
> > be a real-time piece of software, and needs to take decisions as fast
> > and as accurately as possible. I think that implementing an IA-like
> > engine would take an great deal of resources. By the time the IA-like
> > scheduler has taken its decision, the whole world could have changed
> > since.
>
> The AI scheduler is only used for _development_.
>
> For deployment, the rules learned from the AI scheduler are converted to
> C code (or compiled directly to machine language) and used in real-time.
>   I don't expect the rules to be so complex that the C version would use
> much more CPU than the current interactive schedulers being worked on by
> Con, Ingo, and Nick.
>
> During development, the AI scheduler would be used in real-time, and
> that would have a significant effect on the performance of the system.
> But since it's a constant, the relative interactive behavior should be
> about the same between AI and deployed versions, even though the AI
> version uses a lot more CPU time in the kernel.  That is, if the system
> works well with the AI scheduler, it'll work even BETTER with the
> compiled version.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
