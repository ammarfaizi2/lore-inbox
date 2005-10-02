Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbVJBDSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbVJBDSw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 23:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbVJBDSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 23:18:52 -0400
Received: from mail.ctyme.com ([69.50.231.10]:8646 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S1750945AbVJBDSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 23:18:52 -0400
Message-ID: <433F519B.5070505@perkel.com>
Date: Sat, 01 Oct 2005 20:18:51 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Making nice niser for system hogging programs
References: <433F4563.5060700@perkel.com> <200510021307.10372.kernel@kolivas.org>
In-Reply-To: <200510021307.10372.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Sun, 2 Oct 2005 12:26, Marc Perkel wrote:
>  
>
>>Just a thought -----
>>
>>Programs like cp -a /bigdir /backup and rsync usually bring the server
>>to a crawl no matter how much "nice" you put on them. Is there any way
>>to make "nice" smarter in that it limits io as well as processor usage?
>>If cp and rsyne ran a little slower IO wise then everything else could
>>run too.
>>    
>>
>
>The latest cfq io scheduler supports io nice levels. By default it links the 
>io nice levels to the cpu nice levels so if you use cfq and set your file 
>commands nice 19 they will use as little io priority as possible. Note this 
>only works on the read side but that makes a dramatic difference already.
>
>Cheers
>Con
>  
>

Kewl - so - what version is it in?


-- 
Marc Perkel - marc@perkel.com

Spam Filter: http://www.junkemailfilter.com
    My Blog: http://marc.perkel.com

