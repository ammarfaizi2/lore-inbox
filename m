Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278374AbRJMTgU>; Sat, 13 Oct 2001 15:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278382AbRJMTfz>; Sat, 13 Oct 2001 15:35:55 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:16132 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S278395AbRJMTfd>;
	Sat, 13 Oct 2001 15:35:33 -0400
Date: Wed, 10 Oct 2001 16:26:52 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jamal <hadi@cyberus.ca>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>,
        Linux-Kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011010162652.B35@toy.ucw.cz>
In-Reply-To: <Pine.GSO.4.30.0110081146050.5473-100000@shell.cyberus.ca> <E15qczg-00011N-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E15qczg-00011N-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Oct 08, 2001 at 05:11:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Agreed if you add the polling cardbus bit.
> > Note polling cardbus would require more changes than the above.
> 
> I don't think it does. There are two pieces to the problem
> 
> 	a)	Not dying horribly
> 	b)	Handling it elegantly
> 
> b) is driver specific (NAPI etc) and I think well understood to the point
> its being used already for performance reasons
> 
> a) is as simple as 
> 
> 	if(stuck_in_irq(foo) && irq_shared(foo))
> 	{
> 		disable_real_irq(foo);
> 		timer_fake_irq_foo();
> 	}

I'd kill irq_shared() test, and added a printk :-).
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

