Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbSBRURC>; Mon, 18 Feb 2002 15:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284264AbSBRUQu>; Mon, 18 Feb 2002 15:16:50 -0500
Received: from M571P006.dipool.highway.telekom.at ([62.46.61.70]:4053 "HELO
	justp.at") by vger.kernel.org with SMTP id <S285417AbSBRUQq>;
	Mon, 18 Feb 2002 15:16:46 -0500
Subject: Re: khubd zombie
From: Patrik Weiskircher <me@justp.at>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020218200041.GE20284@kroah.com>
In-Reply-To: <1014039193.523.42.camel@dev1lap>
	<20020218181417.GA19992@kroah.com> <1014062182.608.36.camel@pat> 
	<20020218200041.GE20284@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 18 Feb 2002 21:16:30 +0100
Message-Id: <1014063390.6649.8.camel@pat>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-18 at 21:00, Greg KH wrote:
> On Mon, Feb 18, 2002 at 08:56:22PM +0100, Patrik Weiskircher wrote:
> > 
> > I tried it with 2.4.5, 2.4.12, 2.4.17.
> > And I have to kill everything except init.
> > I need a "clean" system.
> 
> What?  You want to also get rid of keventd, ksoftirqd_CPUX, kswapd, and
> others and expect your machine to still work properly?

I just do a kill(-1,15);
It doesn't affect keventd, ksoftirqd_CPUX, etc. as far as i know.
Except the khubd, it keeps getting a zombie.

> 
> > Anyway, I don't think that it should behave like that.
> > Killing something from userspace should not affect the kernel, or did I
> > miss something?
> 
> This is a _kernel_ thread, not a userspace program running.

khubd is a kernel thread, yes.
But if I issue a 'killall khubd' it shouldn't become a zombie.

> 
> > I fixed it, it works, patch file attached.
> 
> And what happened to your USB devices when you kill khubd after applying
> your patch?

They work as always.

> 
> The reparent_to_init() seems like the better thing to do.
> 

I have to admit, I'm really new to the kernel sources.
There's still _very_ much I don't know about the kernel.
These are the first steps in kernel programming. 
Sorry if it's the wrong way to do, I just try my best.

> thanks,
> 
> greg k-h

Best Regards,
Patrik Weiskircher

