Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbVJJSFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbVJJSFV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 14:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVJJSFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 14:05:21 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:40206 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751130AbVJJSFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 14:05:20 -0400
Message-ID: <434AAD94.2060109@tmr.com>
Date: Mon, 10 Oct 2005 14:06:12 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Riesen <raa.lkml@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: select(0,NULL,NULL,NULL,&t1) used for delay
References: <1128606546.14385.26.camel@penguin.madhu> <81b0412b0510060727h35c0fd78i260037ca89f253f9@mail.gmail.com>
In-Reply-To: <81b0412b0510060727h35c0fd78i260037ca89f253f9@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen wrote:
> On 10/6/05, Madhu K.S. <madhu.subbaiah@wipro.com> wrote:
> 
>>Hi all,
>>
>>In many application we use select() system call for delay.
>>
>>example:
>>select(0,NULL,NULL,NULL,&t1);
>>
>>select() for delay is very inefficient. I modified sys_select() code for
> 
> 
> Why don't you just use nanosleep(2) (or usleep)?

I think the answers here are (a) because there's an existing code base, 
and (b) as long as the functionality is required it might as well be 
provided optimally. If tou're going to do something at all, do it right.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
