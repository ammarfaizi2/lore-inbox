Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263035AbSJWJLw>; Wed, 23 Oct 2002 05:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263045AbSJWJLw>; Wed, 23 Oct 2002 05:11:52 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:46015 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263035AbSJWJLv>;
	Wed, 23 Oct 2002 05:11:51 -0400
Date: Wed, 23 Oct 2002 11:17:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: "'Vojtech Pavlik '" <vojtech@suse.cz>,
       "'LKML '" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] add support for PC-9800 architecture (11/26) inp ut
Message-ID: <20021023111746.D28139@ucw.cz>
References: <E6D19EE98F00AB4DB465A44FCF3FA46903A309@ns.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E6D19EE98F00AB4DB465A44FCF3FA46903A309@ns.cinet.co.jp>; from tomita@cinet.co.jp on Wed, Oct 23, 2002 at 10:42:19AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 10:42:19AM +0900, Osamu Tomita wrote:

> Thanks for many suggestion. 
> 
> -----Original Message-----
> From: Vojtech Pavlik
> To: Osamu Tomita
> Cc: LKML; Linus Torvalds
> Sent: 2002/10/22 19:29
> Subject: Re: [PATCH][RFC] add support for PC-9800 architecture (11/26) input
> 
> > Before I'll think of merging this, it has to be seriously cleaned up.
> > Comments below.
> I see. I work away at cleanup.
> 
> > (Summary: use your own SERIO_TYPE for the PC-98 keyboard, remove dead
> > code and definitions, fix naming, make as little #ifdefs as possible,
> > and maybe you can put the PC-98 keyboard code into xtkbd.c (in which
> > case you may get away with SERIO_XT).
> Since xtkbd has not write keyboard function, I modified atkbd.
> I'll rewrite driver, keycode translations and (un)initialize using xtkbd's
> way. Also rename identifier.
> I don't touch input.h in next patch.

Great, thanks!

Yes, it's true that the xtkbd.c code has no way to set the LEDs on the
keyboard nor any functions that'd support sending bytes to the keyboard.
Anyway, the PC-9800 seems to have diverged from IBM machines at about
the time of the XT, and thus the keyboard controller in it (i8251) and
the keyboard itself speak much like they'd do on an IBM XT, with some
extensions like adding commands to set the LEDs, of course.

-- 
Vojtech Pavlik
SuSE Labs
