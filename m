Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161848AbWKPFwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161848AbWKPFwq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 00:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161857AbWKPFwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 00:52:46 -0500
Received: from tapsys.com ([72.36.178.242]:22200 "EHLO tapsys.com")
	by vger.kernel.org with ESMTP id S1161848AbWKPFwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 00:52:45 -0500
Message-ID: <455BFC47.3020006@madrabbit.org>
Date: Wed, 15 Nov 2006 21:51:03 -0800
From: Ray Lee <ray-lk@madrabbit.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Michael Buesch <mb@bu3sch.de>, Bcm43xx-dev@lists.berlios.de,
       LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       John Linville <linville@tuxdriver.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: bcm43xx regression 2.6.19rc3 -> rc5, rtnl_lock trouble?
References: <455B63EC.8070704@madrabbit.org> <200611152015.07844.mb@bu3sch.de> <455B6D74.2020507@madrabbit.org> <455BD219.8080104@lwfinger.net>
In-Reply-To: <455BD219.8080104@lwfinger.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry Finger wrote:
> Ray Lee wrote:
>> Michael Buesch wrote:
>>> On Wednesday 15 November 2006 20:01, Ray Lee wrote:
>>>> Suggestions? Requests for <shudder> even more info?
>>> Yeah, enable bcm43xx debugging.
>>
>> Sigh, didn't even think to look for that. Okay, enabled and compiling
>> a new kernel. This will take a few days to trigger, if the pattern holds, so
>> in the meantime, any *other* thoughts?
> 
> Which chip and revision do you have? Send me your equivalent of the line
> "bcm43xx: Chip ID 0x4306, rev 0x2".

bcm43xx: Chip ID 0x4306, rev 0x3

Also, another thing I wasn't clear about in my first email was that the netdev
watchdog timeouts are new with rc5:

$ zgrep 'NETDEV WATCH' /var/log/messages{,.0,.1.gz} | cut -d: -f2| cut -c 1-6
| uniq -c
   1249 Nov 13
      6 Nov  6
      1 Nov  7
      3 Nov  8
      2 Nov  9
   5717 Nov 10
   5652 Nov 11
      5 Oct 29
      3 Oct 30
      3 Oct 31
      4 Nov  1
      1 Nov  2
      1 Nov  3

I booted into 2.6.19-rc5 on November 10th. Previous to that was 2.6.19-rc3.
There really does seem to be something suspicious with that patch, yes?

Thanks,

Ray
