Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318980AbSH1U1E>; Wed, 28 Aug 2002 16:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318990AbSH1U1E>; Wed, 28 Aug 2002 16:27:04 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:54184 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318980AbSH1U0F>;
	Wed, 28 Aug 2002 16:26:05 -0400
Date: Wed, 28 Aug 2002 22:30:05 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.32 doesn't beep?
Message-ID: <20020828223005.A21207@ucw.cz>
References: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com> <15724.51593.23255.339865@kim.it.uu.se> <20020828150522.A13090@ucw.cz> <15725.11451.335811.149069@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15725.11451.335811.149069@kim.it.uu.se>; from mikpe@csd.uu.se on Wed, Aug 28, 2002 at 10:04:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 10:04:11PM +0200, Mikael Pettersson wrote:
> Vojtech Pavlik writes:
>  > On Wed, Aug 28, 2002 at 03:00:56PM +0200, Mikael Pettersson wrote:
>  > 
>  > > Linus Torvalds 2.5.32 announcement:
>  > >  > ... The input layer switch-over may also end up being a bit painful
>  > >  > for a while, since that not only adds a lot of config options that you
>  > >  > have to get right to have a working keyboard and mouse (we'll fix that
>  > >  > usability nightmare), but the drivers themselves are different and there
>  > >  > are likely devices out there that depended on various quirks.
>  > > 
>  > > I've noticed that in 2.5.32 with CONFIG_KEYBOARD_ATKBD=y, the kernel no
>  > > longer beeps via the PC speaker. Both (at the console) hitting DEL or BS
>  > > at the start of input or doing a simple echo ^G are now silent.
>  > > 
>  > > Call me old-fashioned, but I want those beeps back :-)
>  > 
>  > 2.5.32 still has quite complex input core config options - sorry, my
>  > fault, and I'll fix it soon. You have to enable CONFIG_INPUT_MISC and
>  > CONFIG_INPUT_PCSPKR.
> 
> That worked. Thanks.
> 
> Another issue: I enabled CONFIG_INPUT_MOUSEDEV_PSAUX, but /dev/psaux
> gave an ENODEV when opened. Turns out CONFIG_INPUT_MOUSEDEV is
> also required, but for some reason 'make config' let me set the
> former without also setting the latter. A bug in input's config.in?

Yes, a bug. Fixed now.

-- 
Vojtech Pavlik
SuSE Labs
