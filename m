Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267930AbRGWVva>; Mon, 23 Jul 2001 17:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267931AbRGWVvU>; Mon, 23 Jul 2001 17:51:20 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:47764 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S267930AbRGWVvE>; Mon, 23 Jul 2001 17:51:04 -0400
Date: Mon, 23 Jul 2001 15:50:54 -0600
Message-Id: <200107232150.f6NLosh13126@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
        Linus Torvalds <torvalds@transmeta.com>, Jeff Dike <jdike@karaya.com>,
        user-mode-linux-user <user-mode-linux-user@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: user-mode port 0.44-2.4.7
In-Reply-To: <20010723231136.E16919@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0107231259520.13272-100000@penguin.transmeta.com>
	<3B5C8C96.FE53F5BA@nortelnetworks.com>
	<20010723231136.E16919@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Andrea Arcangeli writes:
> cases if the code breaks in the actual usages of xtime it is likely that
> gcc is doing something stupid in terms of performance. but GCC if it
> wants to is allowed to compile this code:
> 
> 	printf("%lx\n", xtime.tv_sec);
> 
> as:
> 
> 	unsigned long sec = xtime.tv_sec;
> 	if (sec != xtime.tv_sec)
> 		BUG();
> 	printf("%lx\n", sec);

And if it does that, it's stupid. Why on earth would GCC add extra
code to check if a value hasn't changed? I want it to produce
efficient code. What's next? Wrap checking?
    printk ("You've just wrapped an integer: press [ENTER] to confirm,
	    [NT] to ignore   ");

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
