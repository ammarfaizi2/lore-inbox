Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVCKTbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVCKTbq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVCKTbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:31:10 -0500
Received: from www.rapidforum.com ([80.237.244.2]:9895 "HELO rapidforum.com")
	by vger.kernel.org with SMTP id S261378AbVCKT1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:27:32 -0500
Message-ID: <4231F112.60403@rapidforum.com>
Date: Fri, 11 Mar 2005 20:27:14 +0100
From: Christian Schmid <webmaster@rapidforum.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com>	<422BAAC6.6040705@candelatech.com>	<422BB548.1020906@rapidforum.com>	<422BC303.9060907@candelatech.com>	<422BE33D.5080904@yahoo.com.au>	<422C1D57.9040708@candelatech.com>	<422C1EC0.8050106@yahoo.com.au>	<422D468C.7060900@candelatech.com>	<422DD5A3.7060202@rapidforum.com>	<422F8A8A.8010606@candelatech.com>	<422F8C58.4000809@rapidforum.com>	<422F9259.2010003@candelatech.com>	<422F93CE.3060403@rapidforum.com> <20050309211730.24b4fc93.akpm@osdl.org> <4231B95B.6020209@rapidforum.com> <4231ED18.2050804@candelatech.com>
In-Reply-To: <4231ED18.2050804@candelatech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> Christian Schmid wrote:
> 
>> OHGAWD I GOT IT!!!!!!!!
>>
>> I admit, totally coincidentially but its really FIXED. Today I went to 
>> the puter scanning the servers by routine and wondered why the 
>> bandwidth is at 100% without any holes.
>>
>> The only thing I have done is I switched off hyper-threading because 
>> the server is at only 20% CPU anyway so I just disabled it.
>>
>> So its something with linux dealing with hyper-threading. YAY :)
> 
> 
> For what it's worth, I was running dual-xeon systems with HT turned on.
> 
> But, I have a single process, single-threaded application, so there is 
> not much
> scheduling to be done.  If you have a large number of threads or processes,
> then it would make more sense for turning off HT to have an affect.

This effect appeared on 1 task and on 200 tasks. I dont know what it is, but with HT off it doesnt 
appear anymore. The slow-down still appears when lower_zone_protection is set to 0 but the peak at 
80 MB disappeared when set to 1024. I am now running at 95 MB/Sec smoothly.

Chris
