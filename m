Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261422AbREMQwe>; Sun, 13 May 2001 12:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261421AbREMQwY>; Sun, 13 May 2001 12:52:24 -0400
Received: from dire.bris.ac.uk ([137.222.10.60]:27535 "EHLO dire.bris.ac.uk")
	by vger.kernel.org with ESMTP id <S261422AbREMQwH>;
	Sun, 13 May 2001 12:52:07 -0400
Date: Sun, 13 May 2001 17:45:13 +0100 (BST)
From: Matt <madmatt@bits.bris.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Timers
Message-ID: <Pine.LNX.4.21.0105131735140.22953-100000@bits.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having some major headaches trying to get a timer working in my
driver.

The timer is started when the device node is opened, and deleted when it's
closed. The timer code itself calls mod_timer to add itself back in
again. At the moment, it runs every second and does nothing more than
issue a debug printk to say it's working okay.

The problem comes when I try and wrap the timer code inside some down()
and up() calls to make sure it's not fiddling with the hardware at the
same time as some other calls. When I do this, I get a huge oops which
goes right off my screen and I get the "Aieee..." message afterwards and I
have to push the reset button :(.

Should I be using spin_(un)lock_irqsave() calls anywhere instead of just a
semaphore? Or is there anything else I should be doing?

Cheers

Matt

