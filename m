Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266083AbTLIQA7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 11:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266084AbTLIQA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 11:00:59 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:57989 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S266083AbTLIQA5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 11:00:57 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Tomasz Torcz <zdzichu@irc.pl>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: sensors vs 2.6
Date: Tue, 9 Dec 2003 11:00:47 -0500
User-Agent: KMail/1.5.1
References: <200312090258.01944.gene.heskett@verizon.net> <200312090741.31290.gene.heskett@verizon.net> <20031209141837.GA29636@irc.pl>
In-Reply-To: <20031209141837.GA29636@irc.pl>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312091100.47665.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.57.120] at Tue, 9 Dec 2003 10:00:47 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 December 2003 09:18, Tomasz Torcz wrote:
>On Tue, Dec 09, 2003 at 07:41:31AM -0500, Gene Heskett wrote:
>> So obviously something didn't get built, and it looks like its the
>> winbond stuff.  The question is why?  Is there some method that
>> can be used to interrogate the kernel and determine if the stuff
>> is actually in there?
>
>Maybe related: via sensors stuff is very picky about order of module
>loading.
>It does NOT work when i2c-dev, i2c-algo-bit and rest of sensors
> stuff (isa bus, via modules) are built INTO kernel.
>When everything is in modules, iw works ONLY when via modules are
>modprobed _before_ anything using i2c.
>Loading other i2c modules (bttv, lirc or sth else) before via
> modules makes sensors unusable - there is no /sys/[...]/via
> directory, or this directory is empty.

Humm, I've got a bt878 tv card thats rather noisey when eeprom inits.

This sounds like a change in the order the kernel inits this stuff 
might be in order but I've NDI howto go about that...  According to 
dmesg, all that bttv stuff is found about 1000 lines before the first 
mention of i2c...  I assume that means I'd have to modularize the 
bttv stuffs too so the init order can be conmtrolled?

If I make all that into modules, do you have a working modules.conf I 
can obtain so that this stuff is brought in in the proper order?

I tried it without the VIA686, didn't see anything missing that wasn't 
before, then found I had both VIA and VIAPRO set=y. I don't have a 
VIA 586 chipset, so I turned that off and its remaking now for 
effects.  Somehow I think its gonna be a wasted reboot from what you 
are telling me.

Thanks a bunch for any further assistance you can render.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

