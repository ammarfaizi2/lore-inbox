Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVIQBGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVIQBGQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 21:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbVIQBGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 21:06:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:58616 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750802AbVIQBGP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 21:06:15 -0400
Message-ID: <432B6BDF.2010607@mvista.com>
Date: Fri, 16 Sep 2005 18:05:35 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux@horizon.com, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: NTP leap second question
References: <20050914222003.23790.qmail@science.horizon.com>	 <432B3FEB.1070303@mvista.com> <1126920192.22339.7.camel@localhost.localdomain>
In-Reply-To: <1126920192.22339.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2005-09-16 at 14:58 -0700, George Anzinger wrote:
> 
>>What I am asking is when is the flag sent to the kernel.  My reading of 
>>the kernel code says that it will insert the second on the second roll 
>>immeadiatly after the flag is set.
> 
> 
> Kernel clock ticks are not adjusted or slewed or anything else for a
> leap second when correctly configured. UTC leap second adjustment is
> performed by glibc for locales that expect it (which I think is all of
> them)

Eh??  Then what is one to make of the code in timer.c that add 
leapseconds?  It seems to be controlled by the adjtime() system call.

Sure looks like it sets the system clock (xtime) ahead or back by a 
second at midnight if the flag is set to do so.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
