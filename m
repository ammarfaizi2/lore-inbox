Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbUCLCEI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 21:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbUCLCEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 21:04:07 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:10389 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261899AbUCLCEE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 21:04:04 -0500
Message-ID: <40511A89.3040204@cyberone.com.au>
Date: Fri, 12 Mar 2004 13:03:53 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
References: <20040310233140.3ce99610.akpm@osdl.org> <20040311134955.GB16751@krispykreme> <4050F657.3050005@cyberone.com.au>
In-Reply-To: <4050F657.3050005@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

> Anton Blanchard wrote:
>
>>
>>
>>> - The CPU scheduler changes in -mm (sched-domains) have been hanging 
>>> about
>>>  for too long.  I had been hoping that the people who care about SMT 
>>> and
>>>  NUMA performance would have some results by now but all seems to be 
>>> silent.
>>>
>>>  I do not wish to merge these up until the big-iron guys can say 
>>> that they
>>>  suit their requirements, with a reasonable expectation that we will 
>>> not
>>>  need to churn this code later in the 2.6 series.
>>>
>>>  So.  If you have been testing, please speak up.  If you have not been
>>>  testing, please do so.
>>>
>>
>> I sucked sched-* out of mm, added sched-ppc64bits (attached) and am
>> having problems with the following threaded test case. NUMA is enabled.
>
>

Hi Anton,
You need to be setting cpu_power for each of the CPU groups.

Nick
