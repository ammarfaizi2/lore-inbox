Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263515AbTC3Dtq>; Sat, 29 Mar 2003 22:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263516AbTC3Dtq>; Sat, 29 Mar 2003 22:49:46 -0500
Received: from janus.zeusinc.com ([205.242.242.161]:40480 "EHLO
	zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id <S263515AbTC3Dtp>; Sat, 29 Mar 2003 22:49:45 -0500
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Robert Love <rml@tech9.net>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1048992365.13757.23.camel@localhost>
References: <3E8610EA.8080309@telia.com> <1048987260.679.7.camel@teapot>
	 <1048989922.13757.20.camel@localhost>
	 <200303301233.03803.kernel@kolivas.org>
	 <1048992365.13757.23.camel@localhost>
Content-Type: text/plain
Message-Id: <1048996723.3058.41.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
Date: 29 Mar 2003 22:58:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-29 at 21:46, Robert Love wrote:
> Well, I do not necessarily think that renicing X is the problem.  Just
> an idea.
> 
> We do have a problem, though.  Nearly indefinite starvation and all sort
> of weird effects like bash not able to create a new process... its a
> bug.

On my system I get a starvation issue with just about any CPU intensive
task.  For example if create a bzip'd tar file from the linux kernel
source with the command:

tar cvp linux | bzip2 -9 > linux.tar.bz2

During this entire time I can switch between different windows and
everything seems great, but if a try to do something like run 'ps ax' or
login to another virtual terminal, or start almost any other program, it
takes 30-45 seconds or longer.

With 2.5.64 doing the same 'tar | bzip2' command above takes nearly the
same length of time, but I can go about my business of running other
programs without any of the above issue.  It's basically seems that the
one process is starving out everything else.

Don't know if this info helps, but it's 100% reproducible on my machine
(a Dell C810 laptop with a 1.13Ghz P3) with both 2.5.65 & 66.

Later,
Tom


