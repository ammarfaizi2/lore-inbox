Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267597AbTA3Sep>; Thu, 30 Jan 2003 13:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267595AbTA3Sep>; Thu, 30 Jan 2003 13:34:45 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:2236 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267582AbTA3Sen>; Thu, 30 Jan 2003 13:34:43 -0500
Date: Thu, 30 Jan 2003 13:44:02 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Konrad Eisele <eiselekd@web.de>
Cc: PeteZaitcev <zaitcev@redhat.com>, sparclinux@vger.kernel.org,
       leon_sparc@groups1.vip.scd.yahoo.com, dfoulds@pacbell.net,
       linux-kernel@vger.kernel.org
Subject: Re: Adding sparc-leon linux to sourcetree
Message-ID: <20030130134402.A12226@devserv.devel.redhat.com>
References: <200301301353.h0UDrxO24129@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301301353.h0UDrxO24129@mailgate5.cinetic.de>; from eiselekd@web.de on Thu, Jan 30, 2003 at 02:53:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 30 Jan 2003 14:53:59 +0100
> From: Konrad Eisele <eiselekd@web.de>

> I would like to ask if it would be possible to add arch/sparc-leon as
> a new architecture to the sourcetree of linux. From 16.12.02 to 16.3.03
> I'm employed at the University and by Jiri Gaisler's Gaisler Reasearch
> to add the MMU that I made as a diploma thesis to the official Leon 
> distiribution (the open source sparc chip). [...]

I think it is a worthy goal to have a generic Linux for a generic
LEON, but before I support this particular project, I would like to
discuss one thing.

Your VHDL target must be in use by someone long term.
I do not even care if Opencores or whoever accepts it, but there
must be a nonzero user base, now and in the future. I do not want
to add it then to rip it out like AP-1000. For comparison, a recurring
topic on Sparclinux list is a removal of sun4 and even sun4c.
I was ready to support David Foulds' MMU before, but it never
materialized.

> Almost all the source is a copy from the original sparc distribution
> of you what I'm basically doing is to write the bootup initialization
> routines for leon and to throw out the sun hardware stuff.

"Throw out the sun hardware stuff" sounds broken. Look closer
at CONFIG_SUN4. So far I do not see why you need a separate
architecture. Sure, throwing the stuff away helps you to finish
your diploma on time, but then I have to maintain what's left.

> I'm currently adjusting linux for that platform based on linux 2.5.53.
> I do not know exactly when I willl have a first running kernel,
> but when I have one then what should I do get it into the sourcetree?

Discuss early, discuss often. Use Sparclinux@vger.kernel.org
and, perhaps, the Leon list at (bleah!) yahoogroups. Learn
to send patches, and be ready to stay as a patch for a while
(a year or so). I think Jeff Dike's UML is a model of project
management for you (http://user-mode-linux.sourceforge.net/).
He stayed outside AND in close contact while he proved that the
project was viable, then Linus took it.

Good luck and send those patches,
-- Pete
