Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265987AbTBKURg>; Tue, 11 Feb 2003 15:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266020AbTBKURf>; Tue, 11 Feb 2003 15:17:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44048 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265987AbTBKURf>; Tue, 11 Feb 2003 15:17:35 -0500
Date: Tue, 11 Feb 2003 12:23:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: Fix random memory corruption during suspend-to-RAM resume
In-Reply-To: <20030211111601.GA11817@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.44.0302111222250.1405-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Feb 2003, Pavel Machek wrote:
> > 
> > Hmm.. The stack grows downwards, are you sure you don't really mean
> > 
> > 	mov $(wakeup_end-wakeup_code),%sp
> > 
> > (because wakeup_end is the end of the wakeup_stack area..)
> 
> Yes, I'm sure:

No. The code is crap. Please send a _fixed_ patch that clearly puts the 
stack pointer at the _end_ of the stack.

What you are sure of is that is _happens_ to work by pure luck.

I'd rather have known-broken code in the kernel than code that works by 
mistake. The former at least gets fixed.

		Linus

