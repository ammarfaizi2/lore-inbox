Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbTJaKhZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 05:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbTJaKhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 05:37:25 -0500
Received: from unthought.net ([212.97.129.88]:27352 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S263082AbTJaKhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 05:37:24 -0500
Date: Fri, 31 Oct 2003 11:37:23 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Dave Brondsema <dave@brondsema.net>, linux-kernel@vger.kernel.org
Subject: Re: uptime reset after about 45 days
Message-ID: <20031031103723.GE10792@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Maciej Zenczykowski <maze@cela.pl>,
	Dave Brondsema <dave@brondsema.net>, linux-kernel@vger.kernel.org
References: <1067552357.3fa18e65d1fca@secure.solidusdesign.com> <Pine.LNX.4.44.0310310005090.11473-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0310310005090.11473-100000@gaia.cela.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 31, 2003 at 12:09:25AM +0100, Maciej Zenczykowski wrote:
...
> Uptime is stored in jiffies which is 32bit on your arch, which results in 
> an overflow after 2^32 clock ticks. TTTicks were 100 HZ till recently 
> (overflow after 470 or so days) now, they're 1000 -> overflows after 45 
> days.  Doesn't wreck anything except for uptime display - known problem, 
> not worth the trouble fixing it would cause (64 bit values are 
> non-atomic, unless MMX/SSE which isn't allowed in kernel) - however there 
> is (if I'm not mistaken) a patch available wihich fixes this 'problem'.
> 
> However since it is only a matter of uptime display...

For me it would mean that I got disturbed or woken up by an SMS every 45
/ (number_of_servers) = (low_number) days, because the monitoring system
sees that a server suddenly has a 'suspiciously low' uptime.

Fix the monitoring system to detect uptime wraps?

Perhaps.  It would be needed for Windows 95 as well, anyway.

Still, it's pretty darn pathetic to be required to include workarounds
in *Linux* apps that would otherwise only be needed for '95.

All in my humble oppinion of course.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
