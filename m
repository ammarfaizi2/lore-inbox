Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263244AbSJCME7>; Thu, 3 Oct 2002 08:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263248AbSJCME6>; Thu, 3 Oct 2002 08:04:58 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:27610 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263244AbSJCMEy>;
	Thu, 3 Oct 2002 08:04:54 -0400
Date: Thu, 3 Oct 2002 14:10:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.40: AT keyboard input problem
Message-ID: <20021003141021.A38642@ucw.cz>
References: <20021003104750.A37411@ucw.cz> <Pine.LNX.4.44.0210031405570.13946-100000@boris.prodako.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0210031405570.13946-100000@boris.prodako.se>; from tori@ringstrom.mine.nu on Thu, Oct 03, 2002 at 02:08:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 02:08:26PM +0200, Tobias Ringstrom wrote:
> On Thu, 3 Oct 2002, Vojtech Pavlik wrote:
> 
> > Yes, please try with #I8042_DEBUG_IO enabled, try all the suspicious key
> > combinations and add comments to the log file which is which. This will
> > allow me to fix it properly.
> 
> I hope this is enough.  There are more combinations, I'm sure.  I hope 
> that it is one bug causing them all, though.

Perfect, thanks.

Are you possible to reproduce it when you use "i8042_direct" on the
kernel command line?

> /Tobias
> 
> 
> Oct  3 13:59:40 gtbdhcp105 kernel: i8042.c: 20 <- i8042 (interrupt, kbd, 1) [44928]
> Oct  3 13:59:40 gtbdhcp105 kernel: i8042.c: a0 <- i8042 (interrupt, kbd, 1) [45011]
> Oct  3 13:59:40 gtbdhcp105 kernel: i8042.c: 32 <- i8042 (interrupt, kbd, 1) [45036]
> Oct  3 13:59:40 gtbdhcp105 kernel: i8042.c: b2 <- i8042 (interrupt, kbd, 1) [45110]
> Oct  3 13:59:40 gtbdhcp105 kernel: i8042.c: 12 <- i8042 (interrupt, kbd, 1) [45114]
> Oct  3 13:59:40 gtbdhcp105 kernel: i8042.c: 92 <- i8042 (interrupt, kbd, 1) [45185]
> Oct  3 13:59:40 gtbdhcp105 kernel: i8042.c: 1f <- i8042 (interrupt, kbd, 1) [45274]
> Oct  3 13:59:41 gtbdhcp105 kernel: i8042.c: 22 <- i8042 (interrupt, kbd, 1) [45307]
> Oct  3 13:59:41 gtbdhcp105 kernel: i8042.c: 9f <- i8042 (interrupt, kbd, 1) [45329]
> Oct  3 13:59:41 gtbdhcp105 kernel: i8042.c: a2 <- i8042 (interrupt, kbd, 1) [45373]
> Oct  3 13:59:41 gtbdhcp105 kernel: i8042.c: 1c <- i8042 (interrupt, kbd, 1) [45495]
> Oct  3 13:59:41 gtbdhcp105 kernel: i8042.c: 9c <- i8042 (interrupt, kbd, 1) [45547]
> Oct  3 13:59:46 gtbdhcp105 kernel: i8042.c: 1d <- i8042 (interrupt, kbd, 1) [51078]
> Oct  3 13:59:47 gtbdhcp105 kernel: i8042.c: 38 <- i8042 (interrupt, kbd, 1) [51315]
> Oct  3 13:59:47 gtbdhcp105 kernel: i8042.c: b8 <- i8042 (interrupt, kbd, 1) [51484]
> Oct  3 13:59:47 gtbdhcp105 kernel: i8042.c: 9d <- i8042 (interrupt, kbd, 1) [51764]
> Oct  3 13:59:48 gtbdhcp105 kernel: i8042.c: 1d <- i8042 (interrupt, kbd, 1) [53237]
> Oct  3 13:59:49 gtbdhcp105 kernel: i8042.c: 38 <- i8042 (interrupt, kbd, 1) [53459]
> Oct  3 13:59:49 gtbdhcp105 kernel: i8042.c: b8 <- i8042 (interrupt, kbd, 1) [53640]
> Oct  3 13:59:49 gtbdhcp105 kernel: i8042.c: 9d <- i8042 (interrupt, kbd, 1) [53905]
> Oct  3 13:59:50 gtbdhcp105 kernel: i8042.c: 1c <- i8042 (interrupt, kbd, 1) [54660]
> Oct  3 13:59:50 gtbdhcp105 kernel: i8042.c: 9c <- i8042 (interrupt, kbd, 1) [54751]
> Oct  3 13:59:50 gtbdhcp105 kernel: i8042.c: 1c <- i8042 (interrupt, kbd, 1) [54926]
> Oct  3 13:59:50 gtbdhcp105 kernel: i8042.c: 9c <- i8042 (interrupt, kbd, 1) [55022]
> Oct  3 13:59:52 gtbdhcp105 kernel: i8042.c: 38 <- i8042 (interrupt, kbd, 1) [56998]
> Oct  3 13:59:52 gtbdhcp105 kernel: i8042.c: 38 <- i8042 (interrupt, kbd, 1) [57243]
> Oct  3 13:59:52 gtbdhcp105 kernel: i8042.c: 38 <- i8042 (interrupt, kbd, 1) [57273]
> Oct  3 13:59:52 gtbdhcp105 kernel: i8042.c: 38 <- i8042 (interrupt, kbd, 1) [57304]
> Oct  3 13:59:53 gtbdhcp105 kernel: i8042.c: 38 <- i8042 (interrupt, kbd, 1) [57334]
> Oct  3 13:59:53 gtbdhcp105 kernel: i8042.c: 38 <- i8042 (interrupt, kbd, 1) [57365]
> Oct  3 13:59:53 gtbdhcp105 kernel: i8042.c: 38 <- i8042 (interrupt, kbd, 1) [57395]
> Oct  3 13:59:53 gtbdhcp105 kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) [57410]
> Oct  3 13:59:53 gtbdhcp105 kernel: i8042.c: 38 <- i8042 (interrupt, kbd, 1) [57415]
> Oct  3 13:59:53 gtbdhcp105 kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) [57596]
> Oct  3 13:59:53 gtbdhcp105 kernel: i8042.c: b8 <- i8042 (interrupt, kbd, 1) [57605]
> Oct  3 13:59:53 gtbdhcp105 kernel: i8042.c: b8 <- i8042 (interrupt, kbd, 1) [57955]
> Oct  3 13:59:53 gtbdhcp105 kernel: atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
> Oct  3 13:59:55 gtbdhcp105 kernel: i8042.c: 1c <- i8042 (interrupt, kbd, 1) [59584]
> Oct  3 13:59:55 gtbdhcp105 kernel: i8042.c: 9c <- i8042 (interrupt, kbd, 1) [59683]
> Oct  3 13:59:55 gtbdhcp105 kernel: i8042.c: 1c <- i8042 (interrupt, kbd, 1) [59875]
> Oct  3 13:59:55 gtbdhcp105 kernel: i8042.c: 9c <- i8042 (interrupt, kbd, 1) [59974]
> Oct  3 13:59:56 gtbdhcp105 kernel: i8042.c: 38 <- i8042 (interrupt, kbd, 1) [61228]
> Oct  3 13:59:57 gtbdhcp105 kernel: i8042.c: b8 <- i8042 (interrupt, kbd, 1) [61311]
> Oct  3 13:59:57 gtbdhcp105 kernel: i8042.c: 1c <- i8042 (interrupt, kbd, 1) [61721]
> Oct  3 13:59:57 gtbdhcp105 kernel: i8042.c: 9c <- i8042 (interrupt, kbd, 1) [61838]
> Oct  3 13:59:57 gtbdhcp105 kernel: i8042.c: 1c <- i8042 (interrupt, kbd, 1) [62137]
> Oct  3 13:59:57 gtbdhcp105 kernel: i8042.c: 9c <- i8042 (interrupt, kbd, 1) [62248]
> Oct  3 13:59:58 gtbdhcp105 kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) [62980]
> Oct  3 13:59:58 gtbdhcp105 kernel: i8042.c: 38 <- i8042 (interrupt, kbd, 1) [62985]
> Oct  3 13:59:58 gtbdhcp105 kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) [63229]
> Oct  3 13:59:58 gtbdhcp105 kernel: i8042.c: 38 <- i8042 (interrupt, kbd, 1) [63233]
> Oct  3 13:59:58 gtbdhcp105 kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) [63263]
> Oct  3 13:59:58 gtbdhcp105 kernel: i8042.c: 38 <- i8042 (interrupt, kbd, 1) [63268]
> Oct  3 13:59:58 gtbdhcp105 kernel: i8042.c: 38 <- i8042 (interrupt, kbd, 1) [63283]
> Oct  3 13:59:59 gtbdhcp105 kernel: i8042.c: b8 <- i8042 (interrupt, kbd, 1) [63505]
> Oct  3 13:59:59 gtbdhcp105 kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) [63932]
> Oct  3 13:59:59 gtbdhcp105 kernel: i8042.c: b8 <- i8042 (interrupt, kbd, 1) [63941]
> Oct  3 13:59:59 gtbdhcp105 kernel: atkbd.c: Unknown key (set 2, scancode 0x1b8, on isa0060/serio0) pressed.
> Oct  3 14:00:01 gtbdhcp105 kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) [65563]
> Oct  3 14:00:01 gtbdhcp105 kernel: i8042.c: 38 <- i8042 (interrupt, kbd, 1) [65567]
> Oct  3 14:00:01 gtbdhcp105 kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) [65676]
> Oct  3 14:00:01 gtbdhcp105 kernel: i8042.c: b8 <- i8042 (interrupt, kbd, 1) [65685]
> Oct  3 14:00:01 gtbdhcp105 kernel: i8042.c: 1c <- i8042 (interrupt, kbd, 1) [66281]
> Oct  3 14:00:02 gtbdhcp105 kernel: i8042.c: 9c <- i8042 (interrupt, kbd, 1) [66379]
> Oct  3 14:00:02 gtbdhcp105 kernel: i8042.c: 1c <- i8042 (interrupt, kbd, 1) [66501]
> Oct  3 14:00:02 gtbdhcp105 kernel: i8042.c: 9c <- i8042 (interrupt, kbd, 1) [66576]
> Oct  3 14:00:02 gtbdhcp105 kernel: i8042.c: 1c <- i8042 (interrupt, kbd, 1) [66680]
> Oct  3 14:00:02 gtbdhcp105 kernel: i8042.c: 9c <- i8042 (interrupt, kbd, 1) [66763]

-- 
Vojtech Pavlik
SuSE Labs
