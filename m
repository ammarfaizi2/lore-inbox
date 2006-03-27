Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWC0K1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWC0K1O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 05:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWC0K1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 05:27:13 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:975 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750847AbWC0K1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 05:27:13 -0500
Date: Mon, 27 Mar 2006 12:26:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mark Lord <lkml@rtr.ca>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] swsusp: separate swap-writing/reading code
Message-ID: <20060327102636.GH14344@elf.ucw.cz>
References: <200603231702.k2NH2OSC006774@hera.kernel.org> <200603240713.41566.ncunningham@cyclades.com> <200603232253.01025.rjw@sisk.pl> <442325DA.80300@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <442325DA.80300@rtr.ca>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 23-03-06 17:48:58, Mark Lord wrote:
> Rafael J. Wysocki wrote:
> >
> >I agree it probably may be improved.  Still it seems to be good enough.  
> >Further,
> >it's more efficient than the previous solution, so I consider it as an 
> >improvement.
> >Also this code has been tested for quite some time in -mm and appears to
> >behave properly, at least we haven't got any bug reports related to it so 
> >far.
> 
> I find the in-kernel swsusp to be quite slow, and it seems to use
> an awful lot of memory for book-keeping.  So count that as encouragement
> to improve the performance when you can.

Extents will provide 0.01% speedup at most, and with increase of code
complexity. Not a nice tradeoff if you ask me.

If you want faster suspend, that should be easy. You'll need *current*
2.6.16-git , and userland tools from suspend.sf.net . There's HOWTO
that explains how to set it up. We can even do LZF these days... 

> >Currently I'm not working on any better solution.  If you can provide any
> >patches to implement one, please submit them, but I think they'll have to 
> >be
> >tested for as long as this code, in -mm.
> 
> It would be *really nice* if you guys could stop being so underhandedly
> nasty in every single reply to anything from Nigel.

> He really is trying to help, you know.

Actually Rafael was *very* nice at him, I'd say. Pointing for tiny
inefficiencies, without patch attached is not really helpful.

I have repeatedly pointed him on ways how he can *really* help. There
are ways to do suspend2 in userspace these days, but Nigel refuses to
use them.
								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
