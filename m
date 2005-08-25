Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbVHYRu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbVHYRu1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 13:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVHYRu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 13:50:27 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31222 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751365AbVHYRu0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 13:50:26 -0400
Message-ID: <430E04D3.2010702@mvista.com>
Date: Thu, 25 Aug 2005 10:50:11 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NTP ntp-helper functions
References: <1124936181.20820.158.camel@cog.beaverton.ibm.com>
In-Reply-To: <1124936181.20820.158.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> Andrew, All,
> 
> 	This patch cleans up a commonly repeated set of changes to the NTP
> state variables by adding two helper inline functions:
> 	
> ntp_clear(): Clears the ntp state variables

How many places is this called in any given arch?  I ask because it 
_may_ save space if it is NOT inlined.  I don't think it is ever in a 
critical code path...


-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
