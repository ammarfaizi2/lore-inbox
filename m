Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265374AbTLHKey (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 05:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265375AbTLHKey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 05:34:54 -0500
Received: from gate.corvil.net ([213.94.219.177]:37897 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S265374AbTLHKew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 05:34:52 -0500
Message-ID: <3FD4537A.2040206@draigBrady.com>
Date: Mon, 08 Dec 2003 10:33:30 +0000
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ethan Weinstein <lists@stinkfoot.org>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: w83627hf watchdog
References: <3FCF87C4.2010301@stinkfoot.org>
In-Reply-To: <3FCF87C4.2010301@stinkfoot.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ethan Weinstein wrote:
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

That freestone piece of crap didn't work for me,
and looking at the code I'm not surprised.
I did a patch against the existing advantechwdt
since the newer advantechs use the w83627hf.
http://www.pixelbeat.org/patches/advantechwdt.diff
I think the advantechwdt.c should be renamed to w83627hf_wdt.c
to avoid confusion (or replaced with the w83627hf_wdt.c
you referenced above, that I didn't notice when
I did this).

Pádraig.

p.s. I needed to merge the info from a couple
of different winbond manuals to do the driver.
Note also the advantech manual describes the
wrong watchdog!

