Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129177AbQJZRn5>; Thu, 26 Oct 2000 13:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129822AbQJZRnr>; Thu, 26 Oct 2000 13:43:47 -0400
Received: from chaos.analogic.com ([204.178.40.224]:59652 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129177AbQJZRne>; Thu, 26 Oct 2000 13:43:34 -0400
Date: Thu, 26 Oct 2000 13:42:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Yoann Vandoorselaere <yoann@mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible critical VIA vt82c686a chip bug (private question)
In-Reply-To: <20001026190309.A372@suse.cz>
Message-ID: <Pine.LNX.3.95.1001026134131.13342A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2000, Vojtech Pavlik wrote:

> On Thu, Oct 26, 2000 at 12:04:21PM -0400, Richard B. Johnson wrote:
> 
> > ../drivers/block/ide.c, line 162, on version 2.2.17 does bad things
> > to the timer. It writes 0 to the control-word for timer 0. This
> > does the following:
[Snipped...]
>  
> Well, at least on 2.4.0-test9, the above timing code is #ifed to
> DISK_RECOVERY_TIME > 0, which in turn is #defined to 0 in
> include/linux/ide.h.
> 
> So this is not our problem here. Anyway I guess it's time to hunt for
> i8259 accesses in the kernel that lack the necessary spinlock, even when
> they're not probably the cause of the problem we see here.

Okay, good.

Cheers,
Dick Johnson

Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
