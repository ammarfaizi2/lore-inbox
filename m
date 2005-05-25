Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVEYR4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVEYR4F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 13:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVEYRzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 13:55:52 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24315 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261889AbVEYRzX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 13:55:23 -0400
Message-ID: <4294BBE8.3030004@mvista.com>
Date: Wed, 25 May 2005 10:54:48 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
CC: bhavesh@avaya.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 timeval_to_jiffies() wrong for ms resolution timers
References: <1116975555.2050.10.camel@cof110earth.dr.avaya.com> <4294B42D.2020008@mvista.com> <4294B7ED.2030307@nortel.com>
In-Reply-To: <4294B7ED.2030307@nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> George Anzinger wrote:
> 
>> Bhavesh P. Davda wrote:
>>
>>> setitimer for 20ms was firing at 21ms
> 
> 
>> If we do NOT account for this PIT issue, the result is a time drift 
>> that is outside of what ntp can handle...
> 
> 
> Still, it is non-intuitive that a multi-GHz machine can't wake you up 
> more accurately than 1ms.
> 
> What about telling it to wake up a jiffy earlier, then checking whether 
> the scheduling lag was enough to cause it to have waited the full 
> specified time.  If not, put it to sleep for another jiffy.

The user is, of course, free to do what ever they would like.  For a more 
complete solution you might be interested in HRT (High Res Timers).  See my 
signature below.
> 
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
