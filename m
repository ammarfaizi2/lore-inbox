Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVHBQL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVHBQL6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 12:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVHBQJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 12:09:34 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:54796 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261653AbVHBQJO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 12:09:14 -0400
Message-ID: <42EF9B90.4010504@tmr.com>
Date: Tue, 02 Aug 2005 12:13:04 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Cal Peake <cp@absolutedigital.net>, Andrew Morton <akpm@osdl.org>,
       perex@suse.cz, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc4 (snd-cs46xx)
References: <Pine.LNX.4.58.0507281625270.3307@g5.osdl.org>	 <Pine.LNX.4.61.0507282328520.966@lancer.cnet.absolutedigital.net>	 <20050728213543.6264ca60.akpm@osdl.org>	 <Pine.LNX.4.61.0507291315010.869@lancer.cnet.absolutedigital.net>	 <Pine.LNX.4.58.0507291022500.3307@g5.osdl.org> <1122663696.29823.264.camel@localhost.localdomain>
In-Reply-To: <1122663696.29823.264.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Fri, 2005-07-29 at 10:29 -0700, Linus Torvalds wrote:
> 
>>On Fri, 29 Jul 2005, Cal Peake wrote:
>>
>>>Thanks Andrew! Indeed your suspicions are correct. Adding in all the 
>>>debugging moved the problem around, it now shows itself when probing 
>>>parport. Upon further investigation reverting the commit below seems to 
>>>have nixed the problem.
>>
>>Thanks. Just out of interest, does this patch fix it instead?
> 
> 
> Oops,  never thought that size would be zero coming in.  I originally
> had it as a while() instead of a do while but thought that I could speed
> it up if the first word succeeded.  Sorry for that. I blame it on it
> being late when I wrote it and trying several different ways. :-P

You are hardly the first person to implement the "it doesn't work right, 
but it sure is FAST!" algorithm.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
