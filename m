Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262485AbRFLQXR>; Tue, 12 Jun 2001 12:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262568AbRFLQXH>; Tue, 12 Jun 2001 12:23:07 -0400
Received: from www.transvirtual.com ([206.14.214.140]:43017 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S262550AbRFLQWs>; Tue, 12 Jun 2001 12:22:48 -0400
Date: Tue, 12 Jun 2001 09:21:51 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: __gsr@mail.ru, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PC keyboard rate/delay
In-Reply-To: <E159qcp-0001XE-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10106120920360.12103-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > In file include/linux/kd.h was declared KDKBDREP ioctl number
> > to tune up keyboard rate/delay with struct kbd_repeat.
> > But in 2.4.x kernel there is only m68k version for that.
> > I wrote some code for implement this feature on x86 machines.
> > Gzipped and uuencoded patch for kernel 2.4.5 is attached.
> > To setup keyboard rate/delay on x86 you should use code like that:
> > 
> > struct kbd_repeat kbd_rep={
> >        1000,      /* delay in ms */
> >        30         /* repeat rate in cps */
> > };
> > ioctl(0,KDKBDREP,&kbd_rep);
> > 
> > After that ioctl kbd_rep is filled with previous values.
> > I hope it will be useful for someone.
> 
> You must have been reading my mind. Yesterday I traced at least one X11
> hang down to the kernel and X server both frobbing with the port at the same
> time and crashing the microcontroller on my PC110.

Also the beeper is a problem. Have X and a console app set off a beep at
the same time. I'm glad the input api will make these problems go away :-)



