Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318291AbSHPKva>; Fri, 16 Aug 2002 06:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318292AbSHPKva>; Fri, 16 Aug 2002 06:51:30 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:56070 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318291AbSHPKv3>; Fri, 16 Aug 2002 06:51:29 -0400
Date: Fri, 16 Aug 2002 12:54:43 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Greg Banks <gnb@alphalink.com.au>
cc: Peter Samuelson <peter@cadcamlab.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
In-Reply-To: <3D5C5E91.D824123C@alphalink.com.au>
Message-ID: <Pine.LNX.4.44.0208161049200.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 16 Aug 2002, Greg Banks wrote:

> The easy targets being done now are mostly things that I believe would need
> to be done regardless of the eventual strategy, be it a) do nothing b) make
> the existing system suck less c) replace the parsers and keep the rules
> d) replace everything.  For any of these strategies to be successful you would
> need to start with a clean clear and consistent rules corpus.

The problem here is one should consider, how all these little changes will
help to solve the big problems. Do they allow to more easily fix the big
problems or have these changes to be dumped again?
Most of the suggestions I've seen so far fix problems, which either can be
either fixed automatically or which don't exists anymore, once we switch
to a new syntax/parser. That's the reason I ask to understand the whole
picture, so we can judge whether a change is really necessary or not.

> Remember how people were complaining that ESR couldn't prove that the CML2
> rules corpus did the same things as the CML1 rules corpus?  One of the
> reasons was that the CML1 rules corpus is so screwed that's its impossible
> for either a human or a machine to figure out what was supposed to happen
> and whether what was actually happening was deliberate.

I can't give you a mathematical proof, but I tried very hard to keep the
behaviour the same. Unless I made mistake the rules are almost exactly the
same. Most of the CML1 rules are usable, there are only very few cases
which need manual fixing. I can't guarantee that where won't be any
surprises, but they should be easily fixable in the new system. (Unless
ESR I don't insist that my rulebase is correct or perfect, so I'm open to
suggestion/changes. :) )

> This is why I'm not talking about replacing shell based parsers yet.  First
> we need to get a rules corpus for which it is possible to create a parser
> which can parse cleanly, consistently, and correctly.

Most of these problems can actually be fixed without syntax changes.
Something that can't be sanely fixed this way are recursive dependencies,
which I think are not worth fixing with the old parsers, but which are
easily fixable with the new syntax.
If you want to fix logical errors in the rulebase, they will be more
easily fixable with the new tools. For the X interface I'm planning some
debug options, which e.g. allow you to see the complete dependencies of
every symbol.

bye, Roman

