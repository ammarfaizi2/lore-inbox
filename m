Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVCNEyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVCNEyH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 23:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVCNEyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 23:54:07 -0500
Received: from www.rapidforum.com ([80.237.244.2]:25062 "HELO rapidforum.com")
	by vger.kernel.org with SMTP id S261523AbVCNExp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 23:53:45 -0500
Message-ID: <423518C7.10207@rapidforum.com>
Date: Mon, 14 Mar 2005 05:53:27 +0100
From: Christian Schmid <webmaster@rapidforum.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: de, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Ben Greear <greearb@candelatech.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com>	 <422BAAC6.6040705@candelatech.com>	<422BB548.1020906@rapidforum.com>	 <422BC303.9060907@candelatech.com>	<422BE33D.5080904@yahoo.com.au>	 <422C1D57.9040708@candelatech.com>	<422C1EC0.8050106@yahoo.com.au>	 <422D468C.7060900@candelatech.com>	<422DD5A3.7060202@rapidforum.com>	 <422F8A8A.8010606@candelatech.com>	<422F8C58.4000809@rapidforum.com>	 <422F9259.2010003@candelatech.com>	<422F93CE.3060403@rapidforum.com>	 <20050309211730.24b4fc93.akpm@osdl.org> <4231B95B.6020209@rapidforum.com>	 <4231ED18.2050804@candelatech.com>  <4231F112.60403@rapidforum.com> <1110775215.5131.17.camel@npiggin-nld.site>
In-Reply-To: <1110775215.5131.17.camel@npiggin-nld.site>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>This effect appeared on 1 task and on 200 tasks. I dont know what it is, but with HT off it doesnt 
>>appear anymore. The slow-down still appears when lower_zone_protection is set to 0 but the peak at 
>>80 MB disappeared when set to 1024. I am now running at 95 MB/Sec smoothly.
>>
> 
> OK well that is a good result for you. Thanks for sticking with it.
> Unfortunately you'll probably not want to test any patches on your
> production system, so the cause of the problem will be difficult to
> fix.
> 
> I am working on patches which improve HT performance in some
> situations though, so with luck they will cure your problems too.
> Basically I think SMP "balancing" is too aggressive - and this may
> explain why 2.6.10 was worse for you, it had patches to *increase*
> the aggressiveness of balancing.
> 
> The other thing that worries me is your need for lower_zone_protection.
> I think this may be due to unbalanced highmem vs lowmem reclaim. It
> would be interesting to know if those patches I sent you improve this.
> They certainly improve reclaim balancing for me... but again I guess
> you'll be reluctant to do much experimentation :\

I have tested your patch and unfortunately on 2.6.11 it didnt change anything :( I reported this 
before, or do you mean something else? I am of course willing to test patches as I do not want to 
stick with 2.6.10 forever.
