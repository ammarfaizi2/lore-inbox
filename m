Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135411AbRAZQIa>; Fri, 26 Jan 2001 11:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135469AbRAZQIX>; Fri, 26 Jan 2001 11:08:23 -0500
Received: from chaos.analogic.com ([204.178.40.224]:9088 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135411AbRAZQIC>; Fri, 26 Jan 2001 11:08:02 -0500
Date: Fri, 26 Jan 2001 11:07:37 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: rjohnson@analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <3A719AFE.922A8005@colorfullife.com>
Message-ID: <Pine.LNX.3.95.1010126110426.1321B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2001, Manfred Spraul wrote:

> > + * 
> > + * Changed the slow-down I/O port from 0x80 to 0x19. 0x19 is a 
> > + * DMA controller scratch register. rjohnson@analogic.com 
> >    */ 
> >  
> What about making that a config option?
> 
> default: delay with 'outb 0x80', other options could be
> 	udelay(n); (n=1,2,3)
> 	outb 0x19
> 
> 0x80 is a safe port, and IMHO changing the port on all i386 systems
> because it's needed for some embedded system debuggers is too dangerous.
> 
Dangerous? udelay(1) on a 33 MHz system is like udelay(100). Don't
get too used to 800+ MHz CPUs. There are systems, probably most in
the world, that need 300 +/- nanosecond delays. This is what the
port I/O does.


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
