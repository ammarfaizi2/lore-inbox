Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318139AbSGRPZg>; Thu, 18 Jul 2002 11:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318140AbSGRPZg>; Thu, 18 Jul 2002 11:25:36 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:50067 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S318139AbSGRPZd>; Thu, 18 Jul 2002 11:25:33 -0400
Date: Thu, 18 Jul 2002 17:28:29 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: input subsystem config ?
Message-ID: <20020718152829.GD2326@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020717154448.A19761@ucw.cz> <20020717135823.GG14581@tahoe.alcove-fr> <20020717162904.B19935@ucw.cz> <20020717145523.GJ14581@tahoe.alcove-fr> <20020717172235.A20474@ucw.cz> <20020717153336.GK14581@tahoe.alcove-fr> <20020718144130.GB2326@tahoe.alcove-fr> <20020718164536.A30363@ucw.cz> <20020718144838.GC2326@tahoe.alcove-fr> <20020718171531.A30511@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020718171531.A30511@ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 05:15:31PM +0200, Vojtech Pavlik wrote:

> > If I do not disable the 'return -1', the mouse will not be found at
> > all, and moving it will get no messages in the logs...
> 
> Ok, that's what I wanted to know - I was wondering whether the mouse
> would simply ignore all control commands. And it doesn't not. It needs
> the commands, 

I'm not sure about that. It will not work if I do not disable the
'return -1' because the irq will get freed, so the driver will have
no chance to get any mouse event.

> but doesn't send any replies.

Maybe I should put some debug statements in the pc_keyb.c interrupt
handler and see if the mouse does answer the control commands ?

> Can you check what happens if you use an external mouse together with
> the internal one?
>
> I suspect both will work OK.

External like in 'external PS/2' mouse ? Bad luck, this laptop 
has no PS/2 (or serial) port. :-(

I can plug in a USB mouse, but I doubt it will show any useful
information...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
