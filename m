Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314499AbSEBOzf>; Thu, 2 May 2002 10:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314504AbSEBOze>; Thu, 2 May 2002 10:55:34 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:1225 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314499AbSEBOzc>; Thu, 2 May 2002 10:55:32 -0400
Date: Thu, 2 May 2002 09:54:58 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <3CD13FF3.5020406@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0205020947510.32217-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2002, Martin Dalecki wrote:

> > Modversions solves a huge number of problems very very well. The fact that
> > you don't like it doesn't change the reality of the situation.
> 
> Could you name *ONE* please? Maybe the following?

Are you sure you know what you're talking about?

> - It's solving the problem of applying quick security
> fixes to vendor specific kern src.rpm packeges for the user
> very well.

??? If you patch a kernel in a src.rpm, and rebuild from scratch, 
modversions won't be in your way.

> - It solves the problem of too fast kernel compiles as well fine.

I doubt you really notice the difference (make dep takes a bit longer, 
yes, but so what)

> - As an added bonus it makes you use
> the force flag to insmod more often with binary only modules, which
> everybody loves... This gives you the good feeling of polite
> questions you have been missing from DOS for so long:
> "Do you really wan't to delete this file Y/N"...

If the versioning goes wrong (which does happen with current kbuild, and 
that's a bug), insmod -f won't help you at all to cope with the unresolved 
symbols.

> - And then we have no better use for our RAM then
> storing some extendid redundant string information there of course
> as well.

Oh well, if you care about these couple of hundred bytes.

> - And of course it is not annoying if you want to move
> modules which you have just compiled yourself between
> two machines. Or perhaps a compilation host and some testing systems.

Well, if you have the same config, modules will be interchangeable, if 
not, modversions will prevent using the wrong modules, that's the very 
case it's been designed for. 

If you think you know better, or if any of the points above bother you too
much, you're free to turn off modversions, which I guess most developers
do. But because they're not useful to you, that doesn't mean they're not
useful for anyone.

--Kai

