Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129255AbQLLR7o>; Tue, 12 Dec 2000 12:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130312AbQLLR7g>; Tue, 12 Dec 2000 12:59:36 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:49676 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S129345AbQLLR7V>; Tue, 12 Dec 2000 12:59:21 -0500
Date: Tue, 12 Dec 2000 09:28:38 -0800 (PST)
From: ferret@phonewave.net
To: "Mohammad A. Haque" <mhaque@haque.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12 not liking high disk i/o
In-Reply-To: <Pine.LNX.4.30.0012120636480.1053-100000@viper.haque.net>
Message-ID: <Pine.LNX.3.96.1001212092439.12332A-100000@tarot.mentasm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can you tell us what controller chipset you have (output of lspci should
be fine) and if your hard drive has DMA or uDMA enabled?

There have been a few other reports of oopsen and fs corruption during
periods of high interrupt activity. Mine seems to occur whenever I
saturate my local network with traffic to/from the machine, but it is fine
if I turn DMA off (using hdparm -d0 /dev/hda)


On Tue, 12 Dec 2000, Mohammad A. Haque wrote:

> Hey guys,
> 
> Any one else experiencing problems when they do lots of disk activity
> in test12?
> 
> I was able to grab the tail end of an oops. Probably not too usefull.
> 
> Code: 89 42 04 89 10 b8 01 00 00 00 07 43 04 00 00 00 00 c7 03 00
> Aiee, killing interrupt handler
> Kernel panic: Attempted to kill the idle task!
> In interrupt handler - not syncing.
> 
> If I Alt+SysRq+s I get more oops (only tails again) and if I do it
> enough times it hits a BUG and reboots immediately.
> -- 
> 
> =====================================================================
> Mohammad A. Haque                              http://www.haque.net/
>                                                mhaque@haque.net
> 
>   "Alcohol and calculus don't mix.             Project Lead
>    Don't drink and derive." --Unknown          http://wm.themes.org/
>                                                batmanppc@themes.org
> =====================================================================
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
