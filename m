Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbTJaNUM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 08:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTJaNUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 08:20:12 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:7894 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S263260AbTJaNUH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 08:20:07 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Jakob Oestergaard <jakob@unthought.net>,
       Maciej Zenczykowski <maze@cela.pl>
Subject: Re: uptime reset after about 45 days
Date: Fri, 31 Oct 2003 08:20:04 -0500
User-Agent: KMail/1.5.1
Cc: Dave Brondsema <dave@brondsema.net>, linux-kernel@vger.kernel.org
References: <1067552357.3fa18e65d1fca@secure.solidusdesign.com> <Pine.LNX.4.44.0310310005090.11473-100000@gaia.cela.pl> <20031031103723.GE10792@unthought.net>
In-Reply-To: <20031031103723.GE10792@unthought.net>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310310820.04764.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.58.154] at Fri, 31 Oct 2003 07:20:05 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 October 2003 05:37, Jakob Oestergaard wrote:
>On Fri, Oct 31, 2003 at 12:09:25AM +0100, Maciej Zenczykowski wrote:
>...
>
>> Uptime is stored in jiffies which is 32bit on your arch, which
>> results in an overflow after 2^32 clock ticks. TTTicks were 100 HZ
>> till recently (overflow after 470 or so days) now, they're 1000 ->
>> overflows after 45 days.  Doesn't wreck anything except for uptime
>> display - known problem, not worth the trouble fixing it would
>> cause (64 bit values are non-atomic, unless MMX/SSE which isn't
>> allowed in kernel) - however there is (if I'm not mistaken) a
>> patch available wihich fixes this 'problem'.
>>
>> However since it is only a matter of uptime display...
>
>For me it would mean that I got disturbed or woken up by an SMS
> every 45 / (number_of_servers) = (low_number) days, because the
> monitoring system sees that a server suddenly has a 'suspiciously
> low' uptime.
>
>Fix the monitoring system to detect uptime wraps?
>
>Perhaps.  It would be needed for Windows 95 as well, anyway.

Win95 needs more than an uptime patch at that point because the 
keyboard is dead and only a reboot fixes it.  We've been rebooting a 
Win95 wire capture machine every 45-46 days on a schedule because of 
that.

>Still, it's pretty darn pathetic to be required to include
> workarounds in *Linux* apps that would otherwise only be needed for
> '95.
>
>All in my humble oppinion of course.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

