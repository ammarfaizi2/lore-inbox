Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292792AbSBZUMZ>; Tue, 26 Feb 2002 15:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292777AbSBZUMQ>; Tue, 26 Feb 2002 15:12:16 -0500
Received: from chaos.analogic.com ([204.178.40.224]:28811 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S292792AbSBZUMA>; Tue, 26 Feb 2002 15:12:00 -0500
Date: Tue, 26 Feb 2002 15:14:58 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: schedule()
In-Reply-To: <3C7BEA6F.97CB8AD4@mandrakesoft.com>
Message-ID: <Pine.LNX.3.95.1020226151347.5437A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Jeff Garzik wrote:

> "Richard B. Johnson" wrote:
> > 
> > I just read on this list that:
> > 
> >     while(something)
> >     {
> >       current->policy |= SCHED_YIELD;
> >       schedule();
> >     }
> > 
> > Will no longer be allowed in a kernel module! If this is true, how
> > do I loop, waiting for a bit in a port, without wasting CPU time?
> 
> Call yield() or better yet, schedule_timeout()
> 
> In 2.4, define the above to be yield() in some compatibility module...

Okay, thanks. I'll change my code to YIELD and define a macro for
both versions.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

