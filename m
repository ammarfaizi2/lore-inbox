Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVIPV7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVIPV7u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVIPV7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:59:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:57077 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750712AbVIPV7t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:59:49 -0400
Message-ID: <432B3FEB.1070303@mvista.com>
Date: Fri, 16 Sep 2005 14:58:03 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux@horizon.com
CC: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: NTP leap second question
References: <20050914222003.23790.qmail@science.horizon.com>
In-Reply-To: <20050914222003.23790.qmail@science.horizon.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:
> The simplest way to achieve this is to:
> a) Hack ntpd to "not notice" the leap-second announce bits 01 in
>    the packet header and pretend they're actually 00.  This will
>    make it not insert a leap second.

Would a rude and crude way to do this be to shut down ntpd at say 
11:55PM and restart it at 00:01?

What I am asking is when is the flag sent to the kernel.  My reading of 
the kernel code says that it will insert the second on the second roll 
immeadiatly after the flag is set.


> b) Run it with the -x flag so that it always slews the time.
> 
> The real solution would be to implement Markus Kuhn's UTS proposal
> (http://www.cl.cam.ac.uk/~mgk25/uts.txt), which is about the most
> reasonable meshing of the expectation that there are 86400
> seconds per day with the fact that there are not.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
