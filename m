Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVGYQnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVGYQnu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 12:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVGYQnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 12:43:50 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:7690 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261331AbVGYQnt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 12:43:49 -0400
Message-ID: <42E517B6.1010704@tmr.com>
Date: Mon, 25 Jul 2005 12:47:50 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lgb@lgb.hu
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel cached memory
References: <003401c58ea2$4dfd76f0$5601010a@ashley> <20050722132523.GJ20995@vega.lgb.hu>
In-Reply-To: <20050722132523.GJ20995@vega.lgb.hu>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gábor Lénárt wrote:
> On Fri, Jul 22, 2005 at 05:46:58PM +0800, Ashley wrote:
> 
>>   I've a server with 2 Operton 64bit CPU and 12G memory, and this server 
>>is used to run  applications which will comsume huge memory,
>>the problem is: when this aplications exits,  the free memory of the server 
>>is still very low(accroding to the output of "top"), and
>>from the output of command "free", I can see that many GB memory was cached 
>>by kernel. Does anyone know how to free the kernel cached
>>memory? thanks in advance.
> 
> 
> It's a very - very - very old and bad logic (at least nowdays) from the
> stone age to free up memory.

It's very Microsoft to claim that the OS always knows best, and not let 
the user tune the system the way they want it tuned. And if that means 
to leave a bunch of free memory for absolute fastest availability, the 
admin should have that option.

>                              Memory is for using ... If you have memory why
> don't you want to use? For an actively used system, memory should be used as
> much as possible to maximize the performance. The only problem when kernel
> does not want to "give back" used memory for eg caching for an application
> though but it's another problem ...

No, that's the problem he's trying to address.
> 
> Anyway, want to have 'free memory' is a thing like having dozens of cars
> in your garage which don't want to be used ...
> 
Which wait to be used when needed, rather than after someone cleans a 
bunch of old junk out of them and scurries around the garage looking for 
the right car to let you use.

Just because default operation works well for you, kindly don't try to 
convice us that there are no cases when the default operation is NOT 
optimal. And IMHO Linux is *way* too willing to evicy clean pages of my 
programs to use as disk buffer, so that when system memory is full I pay 
the overhead of TWO disk i/o's, one to finally write the data to the 
disk and one to read my program back in. If free software is about 
choice, I wish there was more in the area of how memory is used.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
