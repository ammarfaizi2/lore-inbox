Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316246AbSEVQbH>; Wed, 22 May 2002 12:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316247AbSEVQbG>; Wed, 22 May 2002 12:31:06 -0400
Received: from www.transvirtual.com ([206.14.214.140]:22792 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S316246AbSEVQbF>; Wed, 22 May 2002 12:31:05 -0400
Date: Wed, 22 May 2002 09:30:48 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: vojtech@suse.cz
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
Message-ID: <Pine.LNX.4.10.10205220924310.4611-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Wed, May 22, 2002 at 03:58:38PM +0100, Alan Cox wrote:
> > > > IOCTL is ineed the way to go to implement such functionality...
> > >
> > > Yes, the EVIOCSREP ioctl will be the one soon (works for USB
> > > keyboards now).
> >
> > The KBDRATE ioctl is already supported by all other keyboard drivers
> > and used by XFree86....
>
>Correct. And it'll work on USB as well once the console code is
>interfaced to USB better than just by injecting scancodes into
>pc_keyb.c.
>
>KBDRATE will work on console, while EVIOCSREP will work if you open the
>keyboard as an event device.

Alan you are thinking to PC here. On embedded devices that run X it is
just extra over head to use the VT interface. It would be much lighter
weigth to use the /dev/input/event interface. Personally I like to see
KBDRATE and alot of other junk go away in the console code. Intead we
just use the input api and /dev/fb with DRI. I have talked to Jim Getty
about this and likes to see things head in this direction.

P.S
   Jim Getty was working on having X windows using the input api :-) 
   

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

