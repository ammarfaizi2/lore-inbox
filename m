Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130107AbRAZN6j>; Fri, 26 Jan 2001 08:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130816AbRAZN63>; Fri, 26 Jan 2001 08:58:29 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2432 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130107AbRAZN6T>; Fri, 26 Jan 2001 08:58:19 -0500
Date: Fri, 26 Jan 2001 08:58:03 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <3A70B26C.16DC1C29@transmeta.com>
Message-ID: <Pine.LNX.3.95.1010126085110.265A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001, H. Peter Anvin wrote:

> "Richard B. Johnson" wrote:
> > 
> > On Thu, 25 Jan 2001, H. Peter Anvin wrote:
> > 
> > > Matthew Dharm wrote:
> > > >
> > > > It occurs to me that it might be a good idea to pick a different port for
> > > > these things.  I know a lot of people who want to use port 80h for
> > > > debugging data, especially in embedded x86 systems.
> > > >
> > >
> > > Find a safe port, make sure it is tested the hell out of, and we'll
> > > consider it.
> > >
> > >       -hpa
> > >
> > 
> > You could use the DMA scratch register at 0x19. I'm sure Linux doesn't
> > "save" stuff there when setting up the DMA controller.
> > 
> 
> Does that break the BIOS in any way, shape, or form?  Again, someone gets
> to make a patch and then test the hell out of it... and find the random
> Olivetti which hooks the screen up to the A20M# signal and other weird
> crap.
> 
> 	-hpa
> 

I will change the port on my machines and run them for a week. I
don't have any DEC Rainbows or other such. Yes, I know Linux will
not run on a '286.

Since 0x19 is a hardware register in a DMA controller, specifically
called a "scratch" register, it is unlikely to hurt anything. Note
that the BIOS saves stuff in CMOS. It never expects hardware registers
to survive a "warm boot". It even checks in CMOS to see if it should
preserve RAM.



Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
