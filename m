Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265228AbSJaRkw>; Thu, 31 Oct 2002 12:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265240AbSJaRkw>; Thu, 31 Oct 2002 12:40:52 -0500
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:34631 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S265228AbSJaRks>; Thu, 31 Oct 2002 12:40:48 -0500
Date: Thu, 31 Oct 2002 09:54:50 -0800 (PST)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210310941310.20412-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Linus Torvalds wrote:
|>[ Ok, this is a really serious email. If you don't get it, don't bother 
|>  emailing me. Instead, think about it for an hour, and if you still don't 
|>  get it, ask somebody you know to explain it to you. ]

Thanks for the response.  I don't think I need an hour.  This is
pretty simple.

|>On Thu, 31 Oct 2002, Matt D. Robinson wrote:
|>> 
|>> Sure, but why should they have to?  What technical reason is there
|>> for not including it, Linus?
|>
|>There are many:
|>
|> - bloat kills:
|>
|>	My job is saying "NO!"
|>
|>	In other words: the question is never EVER "Why shouldn't it be
|>	accepted?", but it is always "Why do we really not want to live 
|>	without this?"

This isn't bloat.  If you want, it can be built as a module, and
not as part of your kernel.  How can that be bloat?  People who
build kernels can optionally build it in, but we're not asking
that it be turned on by default, rather, built as a module so
people can load it if they want to.  We made it into a module
because 18 months ago you complained about it being bloat.  We
addressed your concerns.

Some people, particularly large SSI configurations, can't live
without this.  You shouldn't crash once.  Crashing twice, or
more often, is inexcusable.

|> - included features kill off (potentially better) projects.
|>
|>	There's a big "inertia" to features. It's often better to keep 
|>	features _off_ the standard kernel if they may end up being
|>	further developed in totally new directions.

I can't argue against this ... to do so would mean that you don't
accept any new features for 2.5, and there are a lot of projects
like mine that need to go in, although I do understand your concerns.

|>	In particular when it comes to this project, I'm told about
|>	"netdump", which doesn't try to dump to a disk, but over the net.
|>	And quite frankly, my immediate reaction is to say "Hell, I
|>	_never_ want the dump touching my disk, but over the network
|>	sounds like a great idea".

We've integrated the "netdump" capabilities as a dump method
for LKCD.  It's an option for dumping, just like all the other
dump methods available to people?  Want to dump to disk?  Use
LKCD.  Want to dump on the network?  USE LKCD.  What's wrong
with that?

We've created a net dump method that allows you to dump across the
network from Mohammed Abbas (modified from Ingo's netconsole dump).
It integrates into LKCD beautifully.  If you want that patch with
the rest of our LKCD patches, we can include it, no problem.

|>To me this says "LKCD is stupid". Which means that I'm not going to apply 
|>it, and I'm going to need some real reason to do so - ie being proven 
|>wrong in the field.

Hopefully some of this changes your mind.

|>(And don't get me wrong - I don't mind getting proven wrong. I change my 
|>opinions the way some people change underwear. And I think that's ok).
|>
|>> I completely don't understand your reasoning here.
|>
|>Tough. That's YOUR problem.

It is.  I lose sleep because this is my problem.  I lose time on
the weekends because this is my problem.

If you've _reviewed_ the LKCD patches and still have the opinions
you've mentioned above, then I'll consider this your position and
be done with it.  Otherwise, please accept the code.

We'll keep doing our best to keep up with your kernels in the
meantime.

|>		Linus

--Matt

