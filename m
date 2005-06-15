Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVFOTPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVFOTPv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 15:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVFOTPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 15:15:51 -0400
Received: from mailhub3.nextra.sk ([195.168.1.146]:30214 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261391AbVFOTPp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 15:15:45 -0400
Message-ID: <42B07E5D.9070004@rainbow-software.org>
Date: Wed, 15 Jun 2005 21:15:41 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       Grant Coady <grant_lkml@dodo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Odd IDE performance drop 2.4 vs 2.6?
References: <ac0qa19omlt7bsh8mcfsfr2uhshk338f0c@4ax.com>	 <42AD6362.1000109@rainbow-software.org>	 <1118669975.13260.23.camel@localhost.localdomain>	 <42AD92F2.7080108@yahoo.com.au> <1118675343.13773.1.camel@localhost.localdomain>
In-Reply-To: <1118675343.13773.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2005-06-13 at 15:06, Nick Piggin wrote:
> 
>>>Make sure you have pre-empt disabled and the antcipatory I/O scheduler
>>>disabled. 
>>>
>>
>>I don't think that those could explain it.
> 
> 
> Try it and see. The anticipatory I/O scheduler does horrible things to
> my IDE streaming performance numbers and to swap performance. It tries
> to merge I/O by delaying it which is deeply ungood when it comes to IDE
> streaming even if its good for general I/O.

Now I've tested it with preempt disabled and nothing has changed. When 
fiddling around with hdparm, I got about 16MB/s max. with 2.6.12-rc5. 
With 2.4.31, I got about 21MB/s when just the DMA was enabled 
(read-ahead and multcount set to 0 - changing them does not make almost 
any difference).

-- 
Ondrej Zary
