Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265070AbUD3FPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265070AbUD3FPz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 01:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbUD3FPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 01:15:55 -0400
Received: from smtp103.mail.sc5.yahoo.com ([66.163.169.222]:15703 "HELO
	smtp103.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265070AbUD3FPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 01:15:54 -0400
Message-ID: <4091E106.5030906@yahoo.com.au>
Date: Fri, 30 Apr 2004 15:15:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
In-Reply-To: <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> said:
> 
> [...]
> 
> 
>>I don't know. What if you have some huge application that only
>>runs once per day for 10 minutes? Do you want it to be consuming
>>100MB of your memory for the other 23 hours and 50 minutes for
>>no good reason?
> 
> 
> How on earth is the kernel supposed to know that for this one particular
> job you don't care if it takes 3 hours instead of 10 minutes, just because
> you don't want to spare enough preciousss RAM?


It doesn't know that.

But if you restrict this guy's working set to a tiny amount
and just allow it to thrash away, then if nothing else, all
that wasted disk IO will slow all your other stuff down too.

However that is something we can allow you to tune, via RSS
limits. I am maintaining Rik's patch for that and will send
it on when rmap optimisation work is more finalised.
