Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266997AbRGQUX3>; Tue, 17 Jul 2001 16:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266999AbRGQUXT>; Tue, 17 Jul 2001 16:23:19 -0400
Received: from adsl-207-241-136-214.mpl.michix.net ([207.241.136.214]:61706
	"HELO cobalt.deepthought.org") by vger.kernel.org with SMTP
	id <S266997AbRGQUXP>; Tue, 17 Jul 2001 16:23:15 -0400
Date: Tue, 17 Jul 2001 16:15:07 -0400 (EDT)
From: Martin Murray <mmurray@deepthought.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6
In-Reply-To: <Pine.LNX.4.33.0107121706280.4604-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0107171610120.31029-100000@cobalt.deepthought.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I've been away for a few days. 

> Well, I think I've found the reason for your hang.
 
> Your video card is also on irq11.

So does my usb controller. It seems that all the integrated stuff use IRQ
11. 

> And I bet you don't have a driver that knows about it.

You know. 2.2.19 uses my cardbus controller on IRQ 11 without a
problem. Could it be something in the way the yenta_socket driver sets up
the controller? I was thinking of dumping the read/write's from the i82365
from 2.2.19, and comparing it to the yenta_socket driver. Do you think
this is worthwhile? I know your time is precious, but I'd like to fix this
problem and will happily do the work if you can spare a few brain cycles
on the problem. ;)

Thanks, Martin

