Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUAFTFn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 14:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbUAFTFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 14:05:42 -0500
Received: from 195-23-16-24.nr.ip.pt ([195.23.16.24]:8357 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S264919AbUAFTFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 14:05:41 -0500
Message-ID: <3FFB06AF.6000503@grupopie.com>
Date: Tue, 06 Jan 2004 19:04:15 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, johnstultz@us.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix get_jiffies_64 to work on voyager
References: <1073405053.2047.28.camel@mulgrave> <Pine.LNX.4.58.0401060819000.2653@home.osdl.org> <3FFAFE7A.7030404@grupopie.com> <Pine.LNX.4.58.0401061033490.9166@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> 
> On Tue, 6 Jan 2004, Paulo Marques wrote:
> 
>>	....
> 
> Yes, we used to do things like that at some point (and your code is 
> buggy: by leaving out the size, the "volatile" cast casts to the implicit 
> "int" size in C). 
> 


Ugh, stupid mistake. Just wrote the code to fast... :(


Anyway, thanks for your clarification. People like me that code a lot of 
user-space stuff, take a while to realize all the implications of SMP, ordering, 
preemption, etc., etc.

By the way, after double checking your logic, it looks good as long as there are 
no interrupts that take more than 3 jiffies to complete :)

-- 
Paulo Marques - www.grupopie.com

"In a world without walls and fences who needs windows and gates?"

