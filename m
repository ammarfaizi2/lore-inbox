Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318144AbSGRP2l>; Thu, 18 Jul 2002 11:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318145AbSGRP2k>; Thu, 18 Jul 2002 11:28:40 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:49353 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318144AbSGRP2j>;
	Thu, 18 Jul 2002 11:28:39 -0400
Date: Thu, 18 Jul 2002 17:31:32 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stelian Pop <stelian.pop@fr.alcove.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: input subsystem config ?
Message-ID: <20020718173132.A30621@ucw.cz>
References: <20020717135823.GG14581@tahoe.alcove-fr> <20020717162904.B19935@ucw.cz> <20020717145523.GJ14581@tahoe.alcove-fr> <20020717172235.A20474@ucw.cz> <20020717153336.GK14581@tahoe.alcove-fr> <20020718144130.GB2326@tahoe.alcove-fr> <20020718164536.A30363@ucw.cz> <20020718144838.GC2326@tahoe.alcove-fr> <20020718171531.A30511@ucw.cz> <20020718152829.GD2326@tahoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020718152829.GD2326@tahoe.alcove-fr>; from stelian.pop@fr.alcove.com on Thu, Jul 18, 2002 at 05:28:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 05:28:29PM +0200, Stelian Pop wrote:
> On Thu, Jul 18, 2002 at 05:15:31PM +0200, Vojtech Pavlik wrote:
> 
> > > If I do not disable the 'return -1', the mouse will not be found at
> > > all, and moving it will get no messages in the logs...
> > 
> > Ok, that's what I wanted to know - I was wondering whether the mouse
> > would simply ignore all control commands. And it doesn't not. It needs
> > the commands, 
> 
> I'm not sure about that. It will not work if I do not disable the
> 'return -1' because the irq will get freed, so the driver will have
> no chance to get any mouse event.

Actually, no. It also polls the chip repeatedly without needing an irq,
so it can receive bytes even when no irq happens.

> > but doesn't send any replies.
> 
> Maybe I should put some debug statements in the pc_keyb.c interrupt
> handler and see if the mouse does answer the control commands ?

That's a good idea, yes.

> > Can you check what happens if you use an external mouse together with
> > the internal one?
> >
> > I suspect both will work OK.
> 
> External like in 'external PS/2' mouse ? Bad luck, this laptop 
> has no PS/2 (or serial) port. :-(

Ok.

> I can plug in a USB mouse, but I doubt it will show any useful
> information...

No, it won't.

-- 
Vojtech Pavlik
SuSE Labs
