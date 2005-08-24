Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVHXDip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVHXDip (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 23:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVHXDip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 23:38:45 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:29071 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S932126AbVHXDio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 23:38:44 -0400
X-IronPort-AV: i="3.96,137,1122879600"; 
   d="scan'208"; a="207131990:sNHT30954284"
Message-ID: <430BEB8F.2060306@cisco.com>
Date: Wed, 24 Aug 2005 13:37:51 +1000
From: Lincoln Dale <ltd@cisco.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched_yield() makes OpenLDAP slow
References: <4D8eT-4rg-31@gated-at.bofh.it> <4309E07F.8010304@shaw.ca> <Pine.LNX.4.61.0508230714180.22122@chaos.analogic.com> <200508231507.02252.vda@ilport.com.ua>
In-Reply-To: <200508231507.02252.vda@ilport.com.ua>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

>>>This is what I would expect if run on an otherwise idle machine.
>>>sched_yield just puts you at the back of the line for runnable
>>>processes, it doesn't magically cause you to go to sleep somehow.
>>>      
>>>
>>When a kernel build is occurring??? Plus `top` itself.... It damn
>>well sleep while giving up the CPU. If it doesn't it's broken.
>>    
>>
unless you have all of the kernel source in the buffer cache, a 
concurrent kernel build will spend a fair bit of time in io_wait state ..
as such its perfectly plausible that sched_yield keeps popping back to 
the top of 'runnable' processes . . .


cheers,

lincoln.
