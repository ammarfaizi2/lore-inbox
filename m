Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267822AbTBKO7q>; Tue, 11 Feb 2003 09:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267851AbTBKO7q>; Tue, 11 Feb 2003 09:59:46 -0500
Received: from [64.65.46.176] ([64.65.46.176]:38087 "EHLO ns.nealtech.net")
	by vger.kernel.org with ESMTP id <S267822AbTBKO7p>;
	Tue, 11 Feb 2003 09:59:45 -0500
Message-Id: <200302111509.KAA03238@ns.nealtech.net>
Content-Type: text/plain; charset=US-ASCII
From: anton wilson <anton.wilson@camotion.com>
To: Andries Brouwer <aebr@win.tue.nl>, Dan Parks <Dan.Parks@camotion.com>
Subject: Re: Keystrokes, USB, and Latency
Date: Tue, 11 Feb 2003 10:28:35 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
References: <1044907523.1438.475.camel@localhost> <20030210221655.GA3875@win.tue.nl>
In-Reply-To: <20030210221655.GA3875@win.tue.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 February 2003 05:16 pm, Andries Brouwer wrote:
> On Mon, Feb 10, 2003 at 03:05:22PM -0500, Dan Parks wrote:
> > ...  However, if the user presses caps
> > lock, num lock, or scroll lock (everything else is ok), it ALWAYS misses
> > 7-8 milliseconds.
>
> You didnt mention a kernel version, and details very much depend on it.
> But you may look into LED setting, and e.g. whether interrupts are
> disabled during LED setting.


linux 2.4.19 - preempt - low latency O(1)

Yes, interrupts are disabled, and the code is sprinkled with loops and mdelay 
calls while interrupts are disabled. I'm roughly and probably inaccurately 
estimating that in the worst case the pc_keyb driver could call mdelay about 
25000 times before giving up with interrupts disabled. What's the best way to 
avoid the slow behaviour of the led lights if we don't care about numlock, 
capslock, or scroll lock?

Anton


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
