Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284970AbSA2Wdd>; Tue, 29 Jan 2002 17:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285226AbSA2WdO>; Tue, 29 Jan 2002 17:33:14 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:30481 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S285352AbSA2Wcc>; Tue, 29 Jan 2002 17:32:32 -0500
Date: Tue, 29 Jan 2002 17:31:49 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <a354iv$ai9$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96.1020129165740.31511A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Linus Torvalds wrote:

> In short, if you have areas or patches that you feel have had problems,
> ask yourself _why_ those areas have problems. 

Easy, because the patch process has bogged down due to bad design and has
failed to scale. And you simply refuse to believe that there is a problem.

> A word of warning: good maintainers are hard to find.  Getting more of
> them helps, but at some point it can actually be more useful to help the
> _existing_ ones.  I've got about ten-twenty people I really trust, and
> quite frankly, the way people work is hardcoded in our DNA.  Nobody
> "really trusts" hundreds of people.  The way to make these things scale
> out more is to increase the network of trust not by trying to push it on
> me, but by making it more of a _network_, not a star-topology around me. 

The problem is that you don't trust ANYONE. There is no reason why you
should be looking at small obvious patches to bugs (note bugs, not
enhancements). In the last batch of messages I see agreement from Alan Cox
and Eric Raymond that things are backed up. I see reiser filesystem
patches, from the original developer, labeled "third try." Quite bluntly
he is a hell of a lot better qualified to do bug fixes in that area than
you are.
 
> In short: don't try to come up with a "patch penguin".  Instead try to
> help existing maintainers, or maybe help grow new ones. THAT is the way
> to scalability.

I'm sure this will be ignored, but here's what should happen, and will,
just maybe not in the Linus kernel series.

BUGS:

There should be a place to send bugs. Every bug should be acknowleged so
mailbots to keep resending will not be needed. People are setting this up
now, the question is not if it will be done this way, but if it will be
done through or around you.

Each bug should be eyeballed by someone with a clue just to see that the
report states a problem, a way to verify the problem, and doesn't grossly
misstate the intended behaviour. Then someone at the maintainer level
would look at the patch, check it carefully, and reject formally or apply.

Here's the heresy: every bug patch should be promoted to the current
kernel unless it is rejected for reason. This will get fixes in, but more
importantly will force people to look at the damn things...

Reasons to drop a patch:
1 - no bug, this process is for bugs, no news features or improvements.
Offhand I see bugs when you have a crash (oops), a failure to compile, or
filesystem corruption. Someone may want to add drivers totally not
working, but I didn't say it.

2 - no bug, you misunderstand the behaviour, failed to provide a test case
or persuasive argument (you are scanning from 0 to N instead of 0 to N-1
type stuff, you are locking one lock and unlocking another, etc).

3 - no fix, the solution doesn't work.

4 - not readable or understandable.

5 - changes some global part of the kernel and would or could impact other
things.

Note that while "there's a better way" can cause an add to the to-do list,
I do not intend to have the users suffer an actual bug if there is a
viable solution.

To all the people who say that "if you don't like the way Linus does
things write your own kernel," I say that's what is happening with the
-aa, -ac, etc lines. That's why I'm typing this on something called
2.4.17-jl15-ll, because I'm in need of a kernel which runs on a small
machine and doesn't piss me off with lousy response to complex stuff like
echoing what I type.

Someone mentioned the army. Note that hte general doesn't decide where to
dig the foxhole. It's about delegation, and while I doubt Linus read this
far, that's how things scale beyond what one person can do.

Fork is not just a system call, I'd hate to see FreeLinux, NetLinux,
OpenLinux, Linux386, along BSD lines, but while people will wait for
enhancements, I don't find that they are nearly so willing to wait for
fixes. Before we have vendor versions which actually start to differ in
syscall behaviour, let's get a handle on this. It's time for the
maintenence to evolve just as the kernel has, and become something bigger
and better. We need "patch-threads" soon, lest we thrash ourself silly.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

