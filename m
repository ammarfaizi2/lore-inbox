Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRA2RCB>; Mon, 29 Jan 2001 12:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129306AbRA2RBv>; Mon, 29 Jan 2001 12:01:51 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:39162 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129051AbRA2RBd>; Mon, 29 Jan 2001 12:01:33 -0500
Date: Mon, 29 Jan 2001 11:01:31 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10101281949200.13259-100000@zeus.fh-brandenburg.de>
In-Reply-To: <3A7459AA.84CDCF7B@colorfullife.com>
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-ID: <Ys3tl.A.KcH.rHad6@dinero.interactivesi.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is driving me crazy!  There is absolutely no documentation anywhere that
tells you when to use or not use sleep_on or spin_lock_whatever or any of these
calls.  How is anyone supposed to know how to use these functions?!  The post I
quoted below just proves that a lot of people think they know but apparently
don't!  In fact, I predict that an argument between the two posters and a few
others will soon ensue over who is right.

What makes it more frustrating is that some people on this list talk as if
things things are common knowledge.  I've been following this mailing list for
months, and until today I had no idea sleep_on was bad.  All the documentation
I've read to date freely uses sleep_on in the sample code.  In fact, I still
don't even know WHY it's bad.  Not only that, but what am I supposed to use
instead? 

This is what I find most frustrating about Linux.  If I were a Windows driver
programmer, I could walk into any bookstore and pick up any of a dozen books
that explains everything, leaving no room for doubt.


** Reply to message from Roman Zippel <zippel@fh-brandenburg.de> on Sun, 28 Jan
2001 19:51:57 +0100 (MET)

> Hi,
> 
> On Sun, 28 Jan 2001, Manfred Spraul wrote:
> 
> > And one more point for the Janitor's list:
> > Get rid of superflous irqsave()/irqrestore()'s - in 90% of the cases
> > either spin_lock_irq() or spin_lock() is sufficient. That's both faster
> > and better readable.
> > 
> > spin_lock_irq(): you know that the function is called with enabled
> > interrupts.
> > spin_lock(): can be used in hardware interrupt handlers when only one
> > hardware interrupt uses that spinlocks (most hardware drivers), or when
> > all hardware interrupt handler set the SA_INTERRUPT flag (e.g. rtc and
> > timer interrupt)
> 
> This is not a bug and only helps to make drivers nonportable. Please,
> don't do this.
> 
> bye, Roman
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
