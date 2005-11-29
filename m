Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbVK2RZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVK2RZh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 12:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVK2RZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 12:25:36 -0500
Received: from eastrmmtao01.cox.net ([68.230.240.38]:35226 "EHLO
	eastrmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932263AbVK2RZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 12:25:36 -0500
Date: Tue, 29 Nov 2005 12:25:34 -0500
From: Chris Shoemaker <c.shoemaker@cox.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Michael Krufky <mkrufky@m1k.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc3
Message-ID: <20051129172534.GA4514@pe.Belkin>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <438C0124.3030700@m1k.net> <Pine.LNX.4.64.0511290808510.3177@g5.osdl.org> <438C80DD.7050809@m1k.net> <Pine.LNX.4.64.0511290835220.3177@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511290835220.3177@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 08:38:48AM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 29 Nov 2005, Michael Krufky wrote:
> > 
> > In other words, the OOPS is the last thing to show on the screen in text mode,
> > before the console switches into X, using debian sarge's default bootup
> > process.
> 
> Ok. Whatever it is, I'm happy it is doing that, since it caused us to see 
> the oops quickly. None of _my_ boxes do that, obviously (and I tested on 
> x86, x86-64 and ppc64 exactly to get reasonable coverage of what different 
> architectures might do - but none of the boxes are debian-based).
> 
> > I have no idea why gdb is running.... hmm... Anyhow, I'm away from that
> > machine right now, and it is powered off, so I can't look directly at the
> > startup scripts right now.  Would you like me to send more info later on when
> > I get home?  If so, what would you like to see?
> 
> It's not important, I was just curious about what strange things people 
> have in their bootup scripts.  If you can just grep through the rc.d files 
> to see what uses gdb, I'd just like to know...

I doubt gdb is in rc.d scripts.  My wild uninformed guess would be
that some process (maybe xinit?) hit a SEGV and had its own signal
handler installed that tried to call gdb and attach to the crashing
process.  I could imagine something like that being useful for
generating nice userspace stack traces to send to the developers.  I
think I've seen something similar in some builds.

-chris
