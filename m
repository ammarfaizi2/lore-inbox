Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261807AbTCGVtY>; Fri, 7 Mar 2003 16:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261808AbTCGVtX>; Fri, 7 Mar 2003 16:49:23 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:3093
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261807AbTCGVtW>; Fri, 7 Mar 2003 16:49:22 -0500
Date: Fri, 7 Mar 2003 16:57:38 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Andrew Morton <akpm@digeo.com>, "" <linux-kernel@vger.kernel.org>
Subject: Re: Oops: 2.5.64 check_obj_poison for 'size-64'
In-Reply-To: <3E68F552.1010807@colorfullife.com>
Message-ID: <Pine.LNX.4.50.0303071656160.18716-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303062358130.17080-100000@montezuma.mastecende.com>
 <20030306222328.14b5929c.akpm@digeo.com>
 <Pine.LNX.4.50.0303070221470.18716-100000@montezuma.mastecende.com>
 <20030306233517.68c922f9.akpm@digeo.com>
 <Pine.LNX.4.50.0303070351060.18716-100000@montezuma.mastecende.com>
 <20030307010539.3c0a14a3.akpm@digeo.com> <3E68F552.1010807@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Mar 2003, Manfred Spraul wrote:

> Andrew Morton wrote:
> 
> >This is a bad, bad bug.  How are you triggering it?
> >
> >Manfred, would it be possible to add builtin_return_address(0) into each
> >object, so we can find out who did the initial kmalloc (or kfree, even)?
> >
> >It'll probably require CONFIG_FRAME_POINTER.
> >  
> >
> No, CONFIG_FRAME_POINTER is only needed for __builtin_return_address(x, 
> x>0). _address(0) always works.
> 
> I've attached a patch that records the last kfree address and prints 
> that if a poison check fails.
> 
> Zwane, could you try to reproduce the bug?

I can almost always witness it given approx 30minutes of runtime, however 
i still don't know how to trigger it by on demand. I'll apply your patch 
and get back to you when it triggers next.

	Zwane
-- 
function.linuxpower.ca
