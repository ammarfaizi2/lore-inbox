Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280904AbRKTEj1>; Mon, 19 Nov 2001 23:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280902AbRKTEjR>; Mon, 19 Nov 2001 23:39:17 -0500
Received: from chaos.ao.net ([205.244.242.21]:48062 "EHLO chaos.ao.net")
	by vger.kernel.org with ESMTP id <S280900AbRKTEjC>;
	Mon, 19 Nov 2001 23:39:02 -0500
Message-Id: <200111200438.fAK4cwHt000575@vulpine.ao.net>
To: linux-kernel@vger.kernel.org
Subject: Re: radeonfb bug: text ends up scrolling in the middle of tux. 
Date: Mon, 19 Nov 2001 23:38:58 -0500
From: Dan Merillat <harik@chaos.ao.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ryan Cumming writes:
> On November 19, 2001 17:33, Dan Merillat wrote:
> > Ok, I've poked around but I can't find a penguin or tux bitmap to
> > figure out why scrolling is so broken.  I've got to login blind and type
> > reset to get the console back.  Needless to say, no kernel messages
> > are readable after the mode-switch (they all overwrite themselves on
> > a single line)
> 
> Type 'dmesg' as root to get all your lost kernel messages back. Hopefully 
> they'll shed some light on the problem.

Yes, yes.  The boot messages are normal, and typing 'reset' once I login 
restores normal console.  The code that sets up a scrolling window below tux
is well, missing the mark.

Tux looks like he's about 5 lines high, so lines 1-3 are tux, 4 is the one
line of scroll, 5 is his feet, and 6-30 is the previous kernel boot
messages.

--Dan
