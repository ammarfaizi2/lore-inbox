Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319162AbSHNBXK>; Tue, 13 Aug 2002 21:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319166AbSHNBXK>; Tue, 13 Aug 2002 21:23:10 -0400
Received: from rj.sgi.com ([192.82.208.96]:9638 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S319162AbSHNBXK>;
	Tue, 13 Aug 2002 21:23:10 -0400
Message-ID: <3D59B212.DC24E231@alphalink.com.au>
Date: Wed, 14 Aug 2002 11:27:46 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] config language dep_* enhancements
References: <3D587483.1C459694@alphalink.com.au> <Pine.LNX.4.44.0208131306040.6035-100000@chaos.physics.uiowa.edu> <20020813204829.GJ761@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> [Kai Germaschewski]
>
> sed '/dep_/s/ \$CONFIG_/ CONFIG_/g' is quite effective.  In any case
> it is not hard to support both syntaxes - once the transition is
> complete, 

Does "complete" mean all the ports have also made the change and been merged back?

or reasonably complete, we can change the semantics to
> 'n'=='', which in Configure/Menuconfig can only be enforced in the
> non-$ case (well, unless we use your 'source' statement idea).

I don't think it's good policy to have the $ and non-$ cases behaving
differently if we can avoid it.

> >   I find a) more intuitive, for people who know sh, it's pretty
> >   clear when we use "$" and when not. Also, for 'if' statements,
> >   we'll have to use the "$" variant anyway for all I can see, so I
> >   prefer that from a consistency point of view.
> 
> The problem with "intuitive for people who know sh" is that people
> think Config.in *is* shell.  They start putting in constructs which
> are not valid Config.in syntax but which *are* valid sh syntax, so
> they work with certain parsers but not others.

Tell me about it ;-) Actually the incidence of this is low, presumably
someone comes along and reports an xconfig failure and the problem gets
fixed.  I found only a half-dozen or so of these.

I'm more concerned about subtle dependencies on execution order resulting
from misuse of conditionals.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
