Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265879AbUGEAhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbUGEAhX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 20:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265880AbUGEAhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 20:37:23 -0400
Received: from web51809.mail.yahoo.com ([206.190.38.240]:3253 "HELO
	web51809.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265879AbUGEAhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 20:37:18 -0400
Message-ID: <20040705003717.96046.qmail@web51809.mail.yahoo.com>
Date: Sun, 4 Jul 2004 17:37:17 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: secure computing for 2.6.7
To: andrea@cpushare.com, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040704233250.GF7281@dualathlon.random>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that there is a website (www.cpushare.com)
for what you are speaking of, however, I do not
clearly understand the scope of your project.  Is
there a breif definition/scope of what you are trying
to accomplish?

Thank you for your time.
Phy

--- andrea@cpushare.com wrote:
> On Sun, Jul 04, 2004 at 02:35:26PM -0700, Andrew
> Morton wrote:
> > Of course, yes, the patch is sufficiently safe and
> simple for it to be
> 
> Ok, great.
> 
> > mergeable in 2.6, if this is the way we want to do
> secure computing.  I'd
> 
> In the last weekends I evaluated many different ways
> to solve the issue
> (most of them in userspace because they would have
> the huge advantage of
> working in other OS too, the python way that parsed
> the bytecode looked
> quite intriguing, but it's an order of magnitude
> slower compared to x86
> bytecode and it was a lot more complex to make it
> work with the math
> module and similar other safe operations, plus it
> was non portable to
> non-x86 arch [though portable to other x86 OS] and I
> believe it was less
> secure since the virtual machine was still
> involved).
> 
> At the end this linux centric kernel-space solution
> I'm proposing is the
> only simple enough way that I would be confortable
> enough to trust
> myself without feeling to risk anything, plus it
> will run the stuff at
> full speed and with zero memory resource waste for
> another virtual
> machine. This approach basically can only break if
> the cpu has bugs
> (like 0xf00f or an mmx capable processor on a
> non-mmx aware OS, mmx is
> not backwards compatible cpu feature w.r.t.
> security) but linux is
> getting everything right in terms of cpu bugs.
> 
> BTW, of course this will also require a "safe"
> userspace loader, that
> will take care of closing all file descriptors and
> to set the stack
> rlimit before enabling the kernel feature, but
> that's very easy to
> implement safely (even easier than the kernel side).
> 
> One interesting thing is that the vsyscalls will
> make gettimeofday
> available too, but I don't think the output of
> gettimeofday can be
> considered sensitive data. Though I need to keep an
> eye open on the
> vsyscall page to be sure nothing sensitive goes in
> there.
> 
> > wonder whether the API should be syscall-based
> rather than /proc-based, and
> 
> I find the /proc-based simpler, but I certainly
> wouldn't be against
> making it a syscall. So just let me know if you
> prefer to change it to a
> syscall. The syscall would be a bit faster to run
> but it's not a fast
> path.
> 
> > whether there should be a config option for it.
> 
> I don't think it worth to have a config option for
> this (you could
> return to use testb instead of testw but it doesn't
> seem to be
> significant enough to require a config option),
> 
> > But the wider questions are stuff like "where is
> all this coming from",
> > "where will it all end up" and "what are the
> alternatives".
> 
> I'm not ready to talk about my usage, but it has
> absolutely nothing to do
> with the kernel (except for needing this kind of
> feature from either the
> kernel, or from an higher level virtual machine). So
> this probably
> wouldn't be the appropriate forum.
> 
> Thanks a lot for the quick and positive comments.
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
