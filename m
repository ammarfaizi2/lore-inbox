Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293129AbSCWNos>; Sat, 23 Mar 2002 08:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293131AbSCWNoi>; Sat, 23 Mar 2002 08:44:38 -0500
Received: from relay1.pair.com ([209.68.1.20]:38922 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S293129AbSCWNo2>;
	Sat, 23 Mar 2002 08:44:28 -0500
X-pair-Authenticated: 68.5.32.62
Content-Type: text/plain; charset=US-ASCII
From: Shane Nay <shane@minirl.com>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: Tyan S2466 MPX integrated ethernet interrupt happy
Date: Sat, 23 Mar 2002 05:45:24 -0800
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203222229.g2MMT4t30679@zeus.kernel.org> <3C9BE024.B2A5ED0F@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020323134429Z293129-616+181@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > So, approximately 8.5 million ethernet interrupts.  The system is
> > noticably slower when streaming ethernet data, and it's sucking
> > up a lot more processing time than on my other much slower other
> > box. This box is running a stock 2.4.18 kernel from kernel.org
> > (i.e. no custom hacks).  It's running 2 1800+ XPs.
>
> That all looks normal.  Could you be more specific about
> the performance problems?  How much slower? Output from
> `top' and `ps'?  Any nasty messages in the system log?

No nasties in the syslog.  System usage from top averages 50% per 
CPU.  (By system I mean kernel usage, bounces between 70 and 30 per 
CPU)

> Looking at the ethernet driver won't help, I expect - it's
> as efficient as most any other driver.  If there is a problem,
> it lies elsewhere...

Gotcha, yes that could definetly be.  This was extraordinarily 
unscientific.  I was thinking maybe someone had seen something else 
like this on this platform.  So, I'll write a test that isolates 
ethernet from other stuff like ide performance, etc.

> A kernel profile would be illuminating.  Build the kernel with as
> few modules as possible, boot the machine with `profile=1' and play
> with readprofile.

Will do when I return.

Thanks,
Shane Nay.
(Someone else noted their /proc/interrupts for the same machine, but 
my box had only been up for 1.5 hours :)
