Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136114AbRAZQew>; Fri, 26 Jan 2001 11:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136302AbRAZQem>; Fri, 26 Jan 2001 11:34:42 -0500
Received: from [64.64.109.142] ([64.64.109.142]:33540 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S136114AbRAZQe0>; Fri, 26 Jan 2001 11:34:26 -0500
Message-ID: <3A71A6DB.B7921B62@didntduck.org>
Date: Fri, 26 Jan 2001 11:33:31 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Manfred Spraul <manfred@colorfullife.com>, rjohnson@analogic.com,
        linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <Pine.LNX.3.95.1010126110426.1321B-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Fri, 26 Jan 2001, Manfred Spraul wrote:
> 
> > > + *
> > > + * Changed the slow-down I/O port from 0x80 to 0x19. 0x19 is a
> > > + * DMA controller scratch register. rjohnson@analogic.com
> > >    */
> > >
> > What about making that a config option?
> >
> > default: delay with 'outb 0x80', other options could be
> >       udelay(n); (n=1,2,3)
> >       outb 0x19
> >
> > 0x80 is a safe port, and IMHO changing the port on all i386 systems
> > because it's needed for some embedded system debuggers is too dangerous.
> >
> Dangerous? udelay(1) on a 33 MHz system is like udelay(100). Don't
> get too used to 800+ MHz CPUs. There are systems, probably most in
> the world, that need 300 +/- nanosecond delays. This is what the
> port I/O does.

In most of the cases where this delay is needed, it is a _minimum_
delay.  It is usually time enough for the hardware to react to an index
register being written to, etc.  In most cases, a longer delay on slower
machines should not hurt.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
