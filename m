Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313795AbSDUVMX>; Sun, 21 Apr 2002 17:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313815AbSDUVMW>; Sun, 21 Apr 2002 17:12:22 -0400
Received: from [195.39.17.254] ([195.39.17.254]:1166 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S313795AbSDUVMW>;
	Sun, 21 Apr 2002 17:12:22 -0400
Date: Sun, 21 Apr 2002 21:52:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org
Subject: Re: SSE related security hole
Message-ID: <20020421195220.GA12120@elf.ucw.cz>
In-Reply-To: <20020418183639.20946.qmail@science.horizon.com> <Pine.LNX.3.95.1020418144215.30908A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Um, people here seem to be assuming that, in the absence of MMX,
> > fninit *doesn't* leak information.
> > 
> > I thought it was well-known to just clear (set to all-ones) the
> > tag register and not alter the actual floating-point registers.
> > 
> > Thus, it seems quite feasible to reset the tag word with FLDENV and
> > store out the FPU registers, even on an 80387.
> > 
> > Isn't this the same security hole?  Shouldn't there be 8 FLDZ instructions
> > (or equivalent) in the processor state initialization?
> 
> Well, if what's on the internal stack of the FPU can actually leak
> information, I think the notion of "leak" has expanded just a bit
> too much.
> 
> A rogue process could not even know what instruction was about to
> be executed, nor what the previous instruction was, nor when since
> boot it was executed, nor by whom. The 'data' associated with those

If fpu unit was used to memcpy your .ssh/identity, well, you might
change your mind.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
