Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSF3JbS>; Sun, 30 Jun 2002 05:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSF3JbS>; Sun, 30 Jun 2002 05:31:18 -0400
Received: from mail3.alphalink.com.au ([202.161.124.59]:18444 "EHLO
	mail3.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S313571AbSF3JbQ>; Sun, 30 Jun 2002 05:31:16 -0400
Message-ID: <3D1ED000.1DB1888F@alphalink.com.au>
Date: Sun, 30 Jun 2002 19:31:44 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Keith Owens <kaos@ocs.com.au>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, mec@shout.net,
       kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: [PATCH] kconfig: menuconfig and config uses 
 $objtree
References: <20020628192807.A2142@mars.ravnborg.org> <5050.1025315441@ocs3.intra.ocs.com.au> <20020629092601.A2019@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> 
> Every CML program
> -----------------
> There are 3 CML programs within the kernel tree (Configure, menuconfig
> and xconfig). To me the best thing that could happen was that they
> disappeared, being replaced by a single config tool - that provided
> the same type of interfaces. This tools we could extend to do a little
> more semantic checks etc.

<sigh> if only...

> There exist several not-in-the-tree config tools, and they just have
> to adapt. No-one told them they could rely on current behaviour
> forever.

Speaking as the author of one of these, I'm willing to deal with
this behaviour change.

> I hope that one of the existing out-of-tree tools (mconfig, llc, autoconf,
> CML2, GCML2 - others?) one day will get mature enough to replace the
> existing tools.

I don't think maturity is the issue, or CML2 would have been merged by now.

> Create a shadow structure for config tools to use
> -------------------------------------------------
> The only sole reason why kbuild.2-5 needs to create a shadow tree
> of all the config related files is simply that you have decided
> what you consider the best way to support shadow trees are.
> So in our discussion about shadow-tress I recall you mentioned
> several times that using a built-only tree of src-files would create
> a lot of problems when changes were made, and you had to distribute
> changes back in the original trees.
> My point then was that changes were always made in the original tree.
> And now I see that you use the exact same apporach for config-files
> within kbuild-2.5. So do you agree that creating a built-only tree
> suddenly becomes an OK solution?

                     Keith Owens      Sam Ravnborg
               +-----------------------------------------
symlink tree   |
for source     |        bad             good
               |
symlink tree   |       good              bad
for config     | 


As for me, I'm agnostic.  In GCML2, getting from the argument to the
"source" statement to an argument to fopen(3) is by far the least
of the problems caused by having to parse CML1 rules.

> Therefor I see a good point optimizing the current config tools
> to current kbuild. I see no point in keeping the current behaviour
> if this is only for the sake of kbuild-2.5.

Agreed.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.	   - Roger Sandall, The Age, 28Sep2001.
