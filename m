Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265236AbTLFT77 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 14:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265239AbTLFT77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 14:59:59 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:16512 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S265236AbTLFT75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 14:59:57 -0500
Date: Sat, 6 Dec 2003 20:59:56 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Ethan Weinstein <lists@stinkfoot.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: w83627hf watchdog
Message-ID: <20031206195955.GA6573@MAIL.13thfloor.at>
Mail-Followup-To: Ethan Weinstein <lists@stinkfoot.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <3FCF87C4.2010301@stinkfoot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCF87C4.2010301@stinkfoot.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 02:15:16PM -0500, Ethan Weinstein wrote:
> Hi,
> 
> My Supermicro X5DPL-iGM-O has a winbond w83627hf chip onboard that 
> includes a watchdog timer.  I found a driver on freshmeat that points 
> here: http://www.freestone.net/soft/pkg/w83627hf-wdt.tar.gz
> but this does not seem to work correctly on 2.4.23, even with my 
> modifications to the ioports and registers that Supermicro sent me. I 
> have tried to contact the developer, he hasn't responded.  I also 
> located a post to linux-kerel quite sometime ago:
> 
> http://seclists.org/lists/linux-kernel/2002/Dec/att-4150/w83627hf_wdt.c
> 
>  I haven't tried this driver just yet. The lm_sensors project seems to 
> include a driver for this chip as well, but not for the watchdog part. 
> The specifications Supermicro sent me for the watchdog function are 
> located here:
> 
> http://www.stinkfoot.org/wdt.txt
> 
> Any help would greatly be appreciated, I know this particular chip is 
> included with many motherboards.

well, judging from the Super Micro documentation
(which looks sufficient to me I would say it shouldn't 
be too hard to code a watchdog driver similar to the 
one in linux-2.4.23/drivers/char/wdt.c

the testing will be a little more complicated, as
as you'll have to do it with the 'reboot' activated
which will force your system down, if it works
(in development the actual reset is often replaced
by a signal light showing that the reset 'would'
occur)

best,
Herbert

> Ethan
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
