Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313144AbSDDLpv>; Thu, 4 Apr 2002 06:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313143AbSDDLpm>; Thu, 4 Apr 2002 06:45:42 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:47879 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S313137AbSDDLp3>; Thu, 4 Apr 2002 06:45:29 -0500
Date: Thu, 4 Apr 2002 13:45:19 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.8-pre1
In-Reply-To: <3CAC28A7.1060500@evision-ventures.com>
Message-ID: <Pine.LNX.4.33.0204041338500.16693-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Martin Dalecki wrote:

> By just reading the patch I have came across the following code:
> 
> diff -Nru a/arch/cris/drivers/ethernet.c b/arch/cris/drivers/ethernet.c
> --- a/arch/cris/drivers/ethernet.c	Wed Apr  3 17:11:15 2002
> +++ b/arch/cris/drivers/ethernet.c	Wed Apr  3 17:11:15 2002
> ......
> 
> @@ -1313,7 +1313,7 @@
>   static void
>   e100_clear_network_leds(unsigned long dummy)
>   {
> - 
> if (led_active && jiffies > led_next_time) {
> + 
> if (led_active && jiffies > time_after(jiffies, led_next_time)) {
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This should almost certainly be instead:
> 
> + 
> if (led_active && time_after(jiffies, led_next_time)) {
> !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


Yes, my mistake. Please correct.

Tim (wondering how this patch made it into 2.5.8-pre1)

