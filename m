Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVBBJg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVBBJg1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 04:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVBBJg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 04:36:27 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:38905 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262090AbVBBJgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 04:36:21 -0500
From: Peter Busser <busser@m-privacy.de>
Organization: m-privacy
To: "Theodore Ts'o" <tytso@mit.edu>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Date: Wed, 2 Feb 2005 10:35:59 +0100
User-Agent: KMail/1.7.1
References: <200501311015.20964.arjan@infradead.org> <200502011044.39259.busser@m-privacy.de> <20050202001549.GA17689@thunk.org>
In-Reply-To: <20050202001549.GA17689@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502021035.59536.busser@m-privacy.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e784f4497a7e52bfc8179ee7209408c3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Umm, so exactly how many applications use multithreading (or otherwise
> trigger the GLIBC mprotect call), and how many applications use nested
> functions (which is not ANSI C compliant, and as a result, very rare)?
>
> Do the tests both ways, and document when the dummy() re-entrant
> function might actually be hit in real life, and then maybe people
> won't feel that you are deliberately and unfairly overstating things
> to try to root for one security approach versus another. 

Well, you can already do the test both ways. There is a kiddie mode, which 
doesn't do this test. And a blackhat mode, which does it. Basically removing 
the mprotect and nested function is demoting blackhat mode into kiddie mode.

> Of course, 
> with name like "paxtest", maybe its only goal was propganda for the
> PaX way of doing things, in which case, that's fine. 

Well, I can understand that perception. That is, if I would have made any 
contributions to PaX. Fact is, I haven't contributed as much as a single 
ASCII character to PaX. I'm just a user of PaX, just as I am a user of the 
Linux kernel. Sure, I recommend other people to use PaX. Why not? It works 
well for me. I recommend Linux to other people. I guess that's a bad thing 
too, right?

When I started Trusted Debian (which is what Adamantix used to be called), I 
looked around for security related stuff and found out about PaX. So I 
decided to give it a try and also the ET_DYN executable to maximise the use 
of ASLR (Address Space Layout Randomisation). After compiling a bunch of 
programs this way, I was kind of feeling uneasy. One would expect that such 
an intrusive kernel patch would break stuff. And PaX didn't. In fact, I 
didn't have any proof whether it worked or not.

Since my purpose was to distribute this stuff and I am not smart enough to 
fully understand the kernel code, I would not be able to truthfully tell 
people wether this PaX stuff worked or not. So I decided to write a 
test-suite. Well, it tests PaX functionality, not GCC functionality or POSIX 
compliance, so I named it PaXtest. That is how PaXtest began.

I don't understand where this ``propaganda'' mindframe comes from, but I don't 
have any money I make off of PaXtest, I don't have a stock price to worry 
about, no trademarks to defend and stuff like that. And in fact, I don't care 
whether you use PaXtest or not and what you think about the results. It is 
sufficient for me to know that they are accurately reflecting the underlying 
system.

> But if you want 
> it to be viewed as an honest, fair, and unbaised, then make it very
> clear in the test results how programs with and without nested
> functions, and with and without multithreading, would actually behave.

Ok, so how exactly do you propose to do this?

> Or are you afraid that someone might then say --- oh, so PaX's extra
> complexity is only needed if we care about programs that use nested
> functions --- yawn, I think we'll pass on the complexity.  Is that a
> tradeoff that you're afraid to allow people to make with full
> knowledge?

That's looking at this from the bottom up. I'm looking at this from a 
different perspective. In civil engineering, it is normal to explore worst 
case scenarios. Suppose you don't do that and a bridge collapses and people 
die. Or a plane breaks in two while flying and people die. I'm sure you agree 
that that is a Really Bad Thing<tm>, right?

In the computer industry however, we mostly insist in building fragile 
systems. I'm just stating a fact, and not trying to imply that I'm any better 
than anyone else. There is a whole list of perfectly good excuses for 
building fragile computer systems. These systems are a risk. That's ok, as 
long as the risk can be managed. That is basically what most of security in 
the real-world (and I'm not talking about the technical level real-world 
here) is about: Risk management.

But you can't do risk management properly, unless you know what could happen 
in the worst case. Otherwise you get situations which Linus described 
regarding the OpenWall patch, where people might get a false sense of 
security (note that this is also reflected in the PaXtest results when run on 
an OpenWall kernel). There are clear differences between how PaX and 
exec-shield behave in worst case situations. PaXtest shows these when you run 
blackhat mode but not when you run kiddie mode. And that's all there is to 
it.

Now, what any person does with the PaXtest results, that is up to that person 
and not for you or me to decide. And that is why I want to stop the FUD which 
is being spread and to stop people from abusing their reputation as kernel 
developer to influence other people to cripple their copies of PaXtest, 
thereby removing their ability to explore the worst-case scenario. Crippling 
PaXtest effectively works as a form of censorship. Personally, I think the 
Linux community is more served by an open discussion than by censorship. But 
I seems some people have a different opinion on that.

Groetjes,
Peter.
