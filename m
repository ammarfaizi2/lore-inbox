Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318131AbSGRPMk>; Thu, 18 Jul 2002 11:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318122AbSGRPMj>; Thu, 18 Jul 2002 11:12:39 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:40905 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318131AbSGRPMh>;
	Thu, 18 Jul 2002 11:12:37 -0400
Date: Thu, 18 Jul 2002 17:15:31 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stelian Pop <stelian.pop@fr.alcove.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: input subsystem config ?
Message-ID: <20020718171531.A30511@ucw.cz>
References: <20020717132459.GF14581@tahoe.alcove-fr> <20020717154448.A19761@ucw.cz> <20020717135823.GG14581@tahoe.alcove-fr> <20020717162904.B19935@ucw.cz> <20020717145523.GJ14581@tahoe.alcove-fr> <20020717172235.A20474@ucw.cz> <20020717153336.GK14581@tahoe.alcove-fr> <20020718144130.GB2326@tahoe.alcove-fr> <20020718164536.A30363@ucw.cz> <20020718144838.GC2326@tahoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020718144838.GC2326@tahoe.alcove-fr>; from stelian.pop@fr.alcove.com on Thu, Jul 18, 2002 at 04:48:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 04:48:38PM +0200, Stelian Pop wrote:

> > > Any further idea ?
> > 
> > Yes. Can you try, with i8042 debugging enabled, after the kernel boots,
> > moving the mouse? I suspect the data will appear in the log ...
> 
> Maybe I wasn't very clear, but if I disable the 'return -1', the mouse
> will work, and the debugging data is like in:
> 	...
> 	i8042.c: 08 <- i8042 (interrupt, aux, 12) [627526]
> 	i8042.c: 03 <- i8042 (interrupt, aux, 12) [627527]
> 	i8042.c: 00 <- i8042 (interrupt, aux, 12) [627528]
> 	...
> 
> If I do not disable the 'return -1', the mouse will not be found at
> all, and moving it will get no messages in the logs...

Ok, that's what I wanted to know - I was wondering whether the mouse
would simply ignore all control commands. And it doesn't not. It needs
the commands, but doesn't send any replies.

Can you check what happens if you use an external mouse together with
the internal one?

I suspect both will work OK.

-- 
Vojtech Pavlik
SuSE Labs
