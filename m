Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317169AbSHSJWo>; Mon, 19 Aug 2002 05:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318212AbSHSJWo>; Mon, 19 Aug 2002 05:22:44 -0400
Received: from rj.SGI.COM ([192.82.208.96]:48028 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317169AbSHSJWn>;
	Mon, 19 Aug 2002 05:22:43 -0400
Message-ID: <3D60BA16.38B9CC40@alphalink.com.au>
Date: Mon, 19 Aug 2002 19:27:50 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Peter Samuelson <peter@cadcamlab.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
References: <Pine.LNX.4.44.0208161049200.8911-100000@serv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> The problem here is one should consider, how all these little changes will
> help to solve the big problems. Do they allow to more easily fix the big
> problems or have these changes to be dumped again?

I believe fixing the existing rules within the existing syntax is an exercise
worth doing, and that the results will carry across to whatever extended syntax/
new language/new parsers/whatever will be the long-term solution.

Extending the CML1 syntax now is a fun game but a gamble.

> Most of the suggestions I've seen so far fix problems, which either can be
> either fixed automatically or which don't exists anymore, once we switch
> to a new syntax/parser. That's the reason I ask to understand the whole
> picture, so we can judge whether a change is really necessary or not.

Unlike you, I'm not optimistic that a switch to a new language or even a new
parser for the old language will ever happen.

> I can't give you a mathematical proof, but I tried very hard to keep the
> behaviour the same. Unless I made mistake the rules are almost exactly the
> same. Most of the CML1 rules are usable, there are only very few cases
> which need manual fixing. I can't guarantee that where won't be any
> surprises, but they should be easily fixable in the new system. (Unless
> ESR I don't insist that my rulebase is correct or perfect, so I'm open to
> suggestion/changes. :) )

In  http://marc.theaimsgroup.com/?l=linux-kernel&m=101387128818052&w=2
David Woodhouse gives an idea of what would be necessary to get a new
language+parser accepted.  Can you achieve that yet?

> Most of these problems can actually be fixed without syntax changes.

Yes, a great deal of them can be, and those should be done ASAP.

> Something that can't be sanely fixed this way are recursive dependencies,
> which I think are not worth fixing with the old parsers, but which are
> easily fixable with the new syntax.

Indeed, and those are rare corner cases.

> If you want to fix logical errors in the rulebase, they will be more
> easily fixable with the new tools. For the X interface I'm planning some
> debug options, which e.g. allow you to see the complete dependencies of
> every symbol.

Or you could, today, go build gcml2 from source with "make DEBUG=1" and run

cml-check --debug nodes arch/i386/config.in


Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
