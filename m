Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbTCDWs7>; Tue, 4 Mar 2003 17:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbTCDWs7>; Tue, 4 Mar 2003 17:48:59 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55057 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262420AbTCDWs5>; Tue, 4 Mar 2003 17:48:57 -0500
Date: Tue, 4 Mar 2003 17:43:58 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.63] aha152x, module issues
In-Reply-To: <Pine.LNX.4.44.0303041527020.23375-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.3.96.1030304173612.14884B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Mar 2003, Kai Germaschewski wrote:

> On Tue, 4 Mar 2003, Sam Ravnborg wrote:
> 
> > On Mon, Mar 03, 2003 at 05:11:10PM -0500, Bill Davidsen wrote:
> > > scripts/Makefile.modinst:16: *** Uh-oh, you have stale module entries. You messed with SUBDIRS, do not complain if something goes wrong.
> > 
> > This happens if you have encountered a compile error in a module.
> > In this case you did not succeed the compilation of fs/binfmt_aout,
> > and therefore no .o file can be located.
> > kbuild assumes this is because you have messed with SUBDIRS, which is wrong.
> > 
> > Kai - the following patch fixes this for me.
> 
> Hmmh, interesting. The patch looks good to me, but there's still one thing 
> I don't understand: When compiling a module errors out, we should never 
> even go into the module postprocessing stage. Or were you running with -k?

Yes, this is a s-l-o-w machine, I try to build as much as possible while
I'm at lunch, in meetings, etc. So the fail to find the modules was mine,
the bad error message was a result. And of course it would be nice if all
the modules which compiled in 2.5.59 would still compile in 2.5.63, so I
could spend time trying to debug why the aha152x doesn't actually *work*
if it has to share an interrupt. Since I can't change the IRQ of this old
stuff short of ripping the boards out and readdressing with a soldering
iron, I was hoping to take another path.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

