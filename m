Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316781AbSEUXdS>; Tue, 21 May 2002 19:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316787AbSEUXdQ>; Tue, 21 May 2002 19:33:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14349 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316781AbSEUXdM>; Tue, 21 May 2002 19:33:12 -0400
Date: Wed, 22 May 2002 01:33:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
Message-ID: <20020521233312.GA27021@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020521232001.GK22878@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0205211621310.22624-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Do you think I should modify schedule() to do freezing automatically?
> > I wanted to keep my hands off hot paths... I'd rather not do that. 
> 
> No, I just suspect you could freeze them _while_ they sleep by just 
> picking up their information from the normal save area.
>
> Yeah, I know, Linux tends to save a lot of the process stuff implicitly on
> the stack, so maybe that ends up being harder than it sounds, and you've 
> done it for other tasks with the signal handler code instead, but you 
> _should_ be able to do it without any signal handler hackery by just 
> saving off their kernel stack and the stuff in the thread structure.

I need to know more than they are sleeping. I also know they are
sleeping *without holding any semaphores*. I need working system to be
able to save state to disk. That's why I hacked it into signal
handler.
									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
