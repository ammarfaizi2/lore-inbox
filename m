Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262341AbRERPUN>; Fri, 18 May 2001 11:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262346AbRERPUD>; Fri, 18 May 2001 11:20:03 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:5126 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S262341AbRERPT4>;
	Fri, 18 May 2001 11:19:56 -0400
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
In-Reply-To: <20010505192731.A2374@thyrsus.com> <d33da9tjjw.fsf@lxplus015.cern.ch> <20010513112543.A16121@thyrsus.com> <d3d79awdz3.fsf@lxplus015.cern.ch> <20010515173316.A8308@thyrsus.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 18 May 2001 17:19:48 +0200
In-Reply-To: "Eric S. Raymond"'s message of "Tue, 15 May 2001 17:33:16 -0400"
Message-ID: <d3wv7eptuz.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Eric" == Eric S Raymond <esr@thyrsus.com> writes:

Eric> Jes Sorensen <jes@sunsite.dk>:
>>  For a start, so far there has been no reason whatsoever to change
>> the format of definitions.

Eric> The judgment of the kbuild team is unanimous that you are
Eric> mistaken on this.  That's the five people (excluding me) who
Eric> wrote and maintained the CML1 code.  *They* said that code had
Eric> to go, Linus has concurred with their judgment, and the argument
Eric> is over.

Replacing the code does not require changing the style of the config
files. Thats a major problem with CML2, you introduce a new 'let me do
everything for you' tool that relies on a programming language that is
not being shipped by any major vendor nor does it look like they are
planning to do it anytime soon. And even if they start doing so, this
is a totally unreasonable requirement, you *must* to make it possible
to compile kernels on older distributions without requiring people to
update half of their system. On some architectures, the majority of
the users are still on glibc 2.0 and other old versions of
tools. Telling them to install an updated gcc for kernel compilation
is a necessary evil, which can easily be done without disturbing the
rest of the system. Updating the system's python installation is not a
reasonable request. Nobody disagrees that the Makefiles needs a
redesign, however that doesn't mean everything else has to be
redisigned in a totally incompatible manner.

Eric> If you persist in misunderstanding what I am doing, you are
Eric> neither going to be able to influence my behavior nor to
Eric> persuade other people that it is wrong.  Listen carefully,
Eric> please:

Oh I don't, on the other hand I see you consistently ignoring the
needs and requirements of the users. So far I haven't heard a single
developer say something positive about CML2, the most positive I have
heard so far has been "whatever", "it's his choice", "I don't care",
"I want to hack". The majority are of the "NO!" and "you got to be
kiddin'".

Eric> 1. The CML2 system neither changes the CONFIG_ symbol namespace
Eric> nor assumes any changes in it.  (Earlier versions did, but Greg
Eric> Banks showed me how to avoid needing to.)

Let's just say you didn't exactly give peoiple a good impression with
the trolling around on how everybody had to change their option names 
and how important it was for the world.

Eric> 2. The ruleset changes I have made simplify the configuration
Eric> process, but they do *not* in any way restrict the space of
Eric> configurations that are possible.  By design, every valid
Eric> (consistent) configuration in CML1 can be generated in CML2.  I
Eric> treat departures from that rule as rulesfile bugs and fix them
Eric> (as I just did at Ray Knight's instruction).

What spawned this recent discussion was you wanting to remove config
options and automatically enable things instead of giving the users
the explicit choice to do so. Now you are trying to tell me that you
are not changing things?

Eric> 3. I do not have (nor do I seek) the power to "impose" anything
Eric> on anyone.

We'll let that one stand on display for a few minutes.

Eric> You really ought to give CML2 a technical evaluation yourself
Eric> before you flame me again.  Much of what you seem to think you
Eric> know is not true.

So far I have had to deal with a number of requests from you trying to
impose unreasonable changes on developers. Thats more than plenty for
me. I do not have Python2 installed and I do not plan to, if you
change CML2 to use a reasonable programming language I might give it a
try.

Jes

PS: And if you could start making your .signature rfc1855 compliant it
was be pleasant for all readers of this mailing list.
