Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbVHWKKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVHWKKR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 06:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVHWKKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 06:10:17 -0400
Received: from smtp1.netcologne.de ([194.8.194.112]:40066 "EHLO
	smtp1.netcologne.de") by vger.kernel.org with ESMTP
	id S1751209AbVHWKKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 06:10:16 -0400
Message-ID: <430AF661.9070409@mch.one.pl>
Date: Tue, 23 Aug 2005 12:11:45 +0200
From: Tomasz Chmielewski <mangoo@mch.one.pl>
User-Agent: Mozilla Thunderbird 1.0.6-3mdk (X11/20050322)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: jerome lacoste <jerome.lacoste@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: mass "tulip_stop_rxtx() failed", network stops
References: <430AE85E.5040002@mch.one.pl> <5a2cf1f6050823023741682524@mail.gmail.com>
In-Reply-To: <5a2cf1f6050823023741682524@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste schrieb:
> On 8/23/05, Tomasz Chmielewski <mangoo@mch.one.pl> wrote:

(...)

>>We are running four more machines like that, the only difference is the
>>kernel they are running (2.6.11.4).
>>
>>On some of them, there are serious problems with a network, and they
>>usually happen when the traffic is bigger than usual (i.e., some big
>>software deployment to several workstations, remote backup, etc.).
>>
>>The syslog is then full of entries like that:
>>
>>Aug 21 04:04:30 SERVER-B-HS kernel: NETDEV WATCHDOG: eth0: transmit
>>timed out
>>Aug 21 04:04:30 SERVER-B-HS kernel: 0000:00:06.0: tulip_stop_rxtx() failed
> 
> 
> I am seeing thousands of tulip_stop_rxtx() failed messages as well
> with 2.6.11. No regular network failure though.
> 
> See http://kerneltrap.org/mailarchive/1/message/110291/flat

This may have something to do with this patch, introduced with 2.6.10 
(see the ChangeLog-2.6.10).
It would explain why I had no problems on ~20 machines with 2.6.8.1 
kernel, and I have this issue on the machines with 2.6.11.5 kernel.



[PATCH] tulip: make tulip_stop_rxtx() wait for DMA to fully stop
	
From: "John W. Linville" <linville@.........com>
	
tulip_stop_rxtx() doesn't wait for DMA to fully stop like the function
call name implies.
	
This was submitted through my employer -- I am not the original author 
of this	patch.  However, I passed it by Jeff Garizk and he expressed 
interest in having it upstream.


-- 
Tomek
http://wpkg.org
