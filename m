Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267011AbTAZWAZ>; Sun, 26 Jan 2003 17:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbTAZWAZ>; Sun, 26 Jan 2003 17:00:25 -0500
Received: from moutng.kundenserver.de ([212.227.126.185]:24023 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S267011AbTAZWAY>; Sun, 26 Jan 2003 17:00:24 -0500
Date: Mon, 27 Jan 2003 00:03:01 +0100
From: Christian Zander <zander@minion.de>
To: Christian Zander <zander@minion.de>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030126230301.GD394@kugai>
Reply-To: Christian Zander <zander@minion.de>
References: <20030123193540.GD13137@ca-server1.us.oracle.com> <Pine.LNX.4.44.0301261054250.15538-100000@chaos.physics.uiowa.edu> <20030126220842.GB394@kugai> <20030126212950.GA6334@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030126212950.GA6334@mars.ravnborg.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2003 at 10:29:50PM +0100, Sam Ravnborg wrote:
> 
> Judging on the number of people that got bid by the mach- include
> changes, I conclude that we better ask people to use kbuild.
> 

Fair enough.

> The whole issues boils down to the following options:
> 1) The "kernel-headers" package shall be extended to include the
> vital part of kbuild
> 2) To develop modules you need the full kernel src
> 3) Do-it-yourself makefiles
> 
> Can we agree on that - and take the discussion from there?
> 
> In 1) and 2) you have total freedom to change options etc.
> Several architectures filter out generic options they dislike.
> Adding extra options is supported by kbuild (EXTRA_CFLAGS).
> 
> In 3) you have all possibilities to screw up things. You would
> probarly argue you have full flexibility.  But then I wonder what
> kind of flexibility you need for your module, that is not needed for
> all the modules included in the kernel?  To take your argument and
> turn it around: What technical reasons are there to avoid kbuild?
> 
> Please realise that you will be hit by changes in include paths,
> compiler options etc.  That is visible in the number of mails seen
> on lkml the last couple of months.
> 

The problem isn't necessarily lack of flexibility, but the lack of
unity across kernel versions. I agree that kbuild is the preferable
solution for Linux 2.5, but it isn't for all incarnations of Linux
2.4 and definetely not for Linux 2.2. I do realize that changes have
resulted in problems for external build systems and understand that
future changes may result in similar problems.

I guess a reasonable solution is adjusting existing Makefiles to be
smart enough to detect kbuild and use it when available.

-- 
christian zander
zander@minion.de
