Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263370AbVCKP3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbVCKP3q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 10:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263371AbVCKP3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 10:29:46 -0500
Received: from www.rapidforum.com ([80.237.244.2]:23190 "HELO rapidforum.com")
	by vger.kernel.org with SMTP id S263370AbVCKP3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 10:29:44 -0500
Message-ID: <4231B95B.6020209@rapidforum.com>
Date: Fri, 11 Mar 2005 16:29:31 +0100
From: Christian Schmid <webmaster@rapidforum.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: greearb@candelatech.com, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com>	<422BAAC6.6040705@candelatech.com>	<422BB548.1020906@rapidforum.com>	<422BC303.9060907@candelatech.com>	<422BE33D.5080904@yahoo.com.au>	<422C1D57.9040708@candelatech.com>	<422C1EC0.8050106@yahoo.com.au>	<422D468C.7060900@candelatech.com>	<422DD5A3.7060202@rapidforum.com>	<422F8A8A.8010606@candelatech.com>	<422F8C58.4000809@rapidforum.com>	<422F9259.2010003@candelatech.com>	<422F93CE.3060403@rapidforum.com> <20050309211730.24b4fc93.akpm@osdl.org>
In-Reply-To: <20050309211730.24b4fc93.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OHGAWD I GOT IT!!!!!!!!

I admit, totally coincidentially but its really FIXED. Today I went to the puter scanning the 
servers by routine and wondered why the bandwidth is at 100% without any holes.

The only thing I have done is I switched off hyper-threading because the server is at only 20% CPU 
anyway so I just disabled it.

So its something with linux dealing with hyper-threading. YAY :)

Andrew Morton wrote:
> Christian Schmid <webmaster@rapidforum.com> wrote:
> 
>> > So, maybe a VM problem?  That would be a good place to focus since
>> > I think we can be fairly certain it isn't a problem in just the
>> > networking code.  Otherwise, my tests would show lower bandwidth.
>>
>> Thanks to your tests I am really sure that its no network-code problem anymore. But what I THINK it 
>> is: The network is allocating buffers dynamically and if the vm doesnt provide that buffers fast 
>> enough, it locks as well.
> 
> 
> Did anyone have a 100-liner which demonstrates this problem?
> 
> The output of `vmstat 1' when the thing starts happening would be interesting.
> 
> 
