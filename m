Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWGORKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWGORKK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 13:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWGORKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 13:10:10 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:53715 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S1750723AbWGORKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 13:10:09 -0400
Message-ID: <44B9216D.4030603@bootc.net>
Date: Sat, 15 Jul 2006 18:10:05 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Jim Cromie <jim.cromie@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: -mm patch] drivers/char/scx200_gpio.c: make code static
References: <20060713224800.6cbdbf5d.akpm@osdl.org> <20060715003536.GH3633@stusta.de> <44B90063.5070504@bootc.net> <20060715153747.GT3633@stusta.de>
In-Reply-To: <20060715153747.GT3633@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sat, Jul 15, 2006 at 03:49:07PM +0100, Chris Boot wrote:
>> Adrian Bunk wrote:
>>> This patch makes needlessly global code static.
>> I don't agree with unexporting scx200_gpio_ops and making the struct 
>> static, this lets other modules use the scx200_gpio module in a 
>> semi-independent way. My net48xx LED Class code is going to be modified to 
>> use the entries in this struct to do its GPIO-twiddling magic, potentially 
>> allowing my module to do more than just the net48xx Error LED.
>> ...
> 
> Can you express "is going to be modified" in the unit "days"?

Hopefully this weekend!

I also have a good mind to do some work on both the scx200_gpio and pc8736x_gpio 
modules to allow whole banks of GPIOs to be changed at once, but that's slightly 
unrelated.

> I've seen too many times that someone said "I will need this export 
> soon", and some months or even a year later the code using it was still 
> part of the kernel.
> 
> Unexporting something today does still allow re-exporting it when it's 
> actually required - simply add the trivial patch undoing my unexport 
> when you submit your driver for inclusion in the kernel.

Indeed not but it seems silly to remove one line of code one day and revert it 
the next, unnecessarily!

Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
