Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317945AbSHPCD0>; Thu, 15 Aug 2002 22:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317947AbSHPCDZ>; Thu, 15 Aug 2002 22:03:25 -0400
Received: from zok.SGI.COM ([204.94.215.101]:21890 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S317945AbSHPCDY>;
	Thu, 15 Aug 2002 22:03:24 -0400
Message-ID: <3D5C5E91.D824123C@alphalink.com.au>
Date: Fri, 16 Aug 2002 12:08:17 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org.com>
CC: Peter Samuelson <peter@cadcamlab.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
References: <Pine.LNX.4.44.0208151111130.8911-100000@serv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> Hi,
> 
> (Could you please fix your mailer? linux-m68k.org.com does not really
> exist.)

I believe the problem is upstream of the machine I control.  I'll see what I can do.

> That's fine with me, but nonetheless I'd really like to know where it will
> go to. Just fixing the easy problems is simple, but so far I haven't seen
> any plan on how to fix the hard problems. Anyone starting to fix all the
> problems should have at least some ideas how to do it and I'd really like
> to hear them. I don't want to discourage anyone, but he should understand
> the complete problem first before going for the easy targets.

The easy targets being done now are mostly things that I believe would need
to be done regardless of the eventual strategy, be it a) do nothing b) make
the existing system suck less c) replace the parsers and keep the rules
d) replace everything.  For any of these strategies to be successful you would
need to start with a clean clear and consistent rules corpus.

Remember how people were complaining that ESR couldn't prove that the CML2
rules corpus did the same things as the CML1 rules corpus?  One of the
reasons was that the CML1 rules corpus is so screwed that's its impossible
for either a human or a machine to figure out what was supposed to happen
and whether what was actually happening was deliberate.  

Roman, I believe the exactly same issue will apply to your config system
too, because it uses a machine translation step from CML1.  GCML2's syntax
checker started life as a CML1-to-CML2 converter (inspired by your work), but
I gave up on machine translating because it would be GIGO.

This is why I'm not talking about replacing shell based parsers yet.  First
we need to get a rules corpus for which it is possible to create a parser
which can parse cleanly, consistently, and correctly.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
