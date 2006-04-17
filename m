Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWDQRF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWDQRF0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 13:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWDQRF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 13:05:26 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:41687 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751164AbWDQRFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 13:05:25 -0400
Message-ID: <4443CAD1.9050701@cmu.edu>
Date: Mon, 17 Apr 2006 13:05:21 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: want to randomly drop packets based on percent
References: <444345F9.4090100@cmu.edu>	<20060417091915.67e28361@localhost.localdomain>	<4444171B.90507@cmu.edu> <20060417094634.7191fea5@localhost.localdomain>
In-Reply-To: <20060417094634.7191fea5@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stephen Hemminger wrote:

>On Mon, 17 Apr 2006 18:30:51 -0400
>George Nychis <gnychis@cmu.edu> wrote:
>
>  
>
>>Stephen Hemminger wrote:
>>
>>    
>>
>>>On Mon, 17 Apr 2006 03:38:33 -0400
>>>George Nychis <gnychis@cmu.edu> wrote:
>>>
>>> 
>>>
>>>      
>>>
>>>>Hey,
>>>>
>>>>I'm using the 2.4.32 kernel with madwifi and iproute2 version 
>>>>2-2.6.16-060323.tar.gz
>>>>
>>>>I wanted to insert artificial packet loss based on a percent so i found:
>>>>network emulab qdisc could do it, so i compiled support into the kernel 
>>>>and tried:
>>>>tc qdisc change dev eth0 root netem loss .1%
>>>>        
>>>>
>             ^^^^^^
>
>You need to do add not change. Add will set the queue discipline
>to netem (default is pfifo_fast).  Change is for changing netem parameters
>after it is loaded.
>
>  
>
bahhh I see... the wiki has "change" instead of add.  Now i'm running 
into another problem, I have an XCP qdisc that I have already added via:
tc qdisc add dev ath0 root xcp capacity 54Mbit size 500

therefore when I also try to incorperate loss:
tcq disc add dev ath0 root netem loss .1%

I get:
RTNETLINK answers: File exists

Is it possible to use two qdiscs on the same interface?

Thanks!
George
