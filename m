Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWGOPht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWGOPht (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 11:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWGOPht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 11:37:49 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38413 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750708AbWGOPhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 11:37:48 -0400
Date: Sat, 15 Jul 2006 17:37:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chris Boot <bootc@bootc.net>
Cc: Andrew Morton <akpm@osdl.org>, Jim Cromie <jim.cromie@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: -mm patch] drivers/char/scx200_gpio.c: make code static
Message-ID: <20060715153747.GT3633@stusta.de>
References: <20060713224800.6cbdbf5d.akpm@osdl.org> <20060715003536.GH3633@stusta.de> <44B90063.5070504@bootc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B90063.5070504@bootc.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2006 at 03:49:07PM +0100, Chris Boot wrote:
> Adrian Bunk wrote:
> >This patch makes needlessly global code static.
> 
> I don't agree with unexporting scx200_gpio_ops and making the struct 
> static, this lets other modules use the scx200_gpio module in a 
> semi-independent way. My net48xx LED Class code is going to be modified to 
> use the entries in this struct to do its GPIO-twiddling magic, potentially 
> allowing my module to do more than just the net48xx Error LED.
>...

Can you express "is going to be modified" in the unit "days"?

I've seen too many times that someone said "I will need this export 
soon", and some months or even a year later the code using it was still 
part of the kernel.

Unexporting something today does still allow re-exporting it when it's 
actually required - simply add the trivial patch undoing my unexport 
when you submit your driver for inclusion in the kernel.

> Chris Boot

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

