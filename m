Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129759AbRA0RDn>; Sat, 27 Jan 2001 12:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130651AbRA0RDd>; Sat, 27 Jan 2001 12:03:33 -0500
Received: from [194.213.32.137] ([194.213.32.137]:50692 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129759AbRA0RD2>;
	Sat, 27 Jan 2001 12:03:28 -0500
Message-ID: <20010127132847.A485@bug.ucw.cz>
Date: Sat, 27 Jan 2001 13:28:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: Brian Gerst <bgerst@didntduck.org>, root@chaos.analogic.com
Cc: Manfred Spraul <manfred@colorfullife.com>, rjohnson@analogic.com,
        linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <Pine.LNX.3.95.1010126110426.1321B-100000@chaos.analogic.com> <3A71A6DB.B7921B62@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A71A6DB.B7921B62@didntduck.org>; from Brian Gerst on Fri, Jan 26, 2001 at 11:33:31AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > + *
> > > > + * Changed the slow-down I/O port from 0x80 to 0x19. 0x19 is a
> > > > + * DMA controller scratch register. rjohnson@analogic.com
> > > >    */
> > > >
> > > What about making that a config option?
> > >
> > > default: delay with 'outb 0x80', other options could be
> > >       udelay(n); (n=1,2,3)
> > >       outb 0x19
> > >
> > > 0x80 is a safe port, and IMHO changing the port on all i386 systems
> > > because it's needed for some embedded system debuggers is too dangerous.
> > >
> > Dangerous? udelay(1) on a 33 MHz system is like udelay(100). Don't
> > get too used to 800+ MHz CPUs. There are systems, probably most in
> > the world, that need 300 +/- nanosecond delays. This is what the
> > port I/O does.
> 
> In most of the cases where this delay is needed, it is a _minimum_
> delay.  It is usually time enough for the hardware to react to an index
> register being written to, etc.  In most cases, a longer delay on slower
> machines should not hurt.

Except getting your ne2000 slower by factor of 300.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
