Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965264AbWFINgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965264AbWFINgf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 09:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965265AbWFINgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 09:36:35 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:37256
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S965264AbWFINgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 09:36:35 -0400
Message-ID: <44897937.9010201@microgate.com>
Date: Fri, 09 Jun 2006 08:35:51 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16.18 kernel freezes while pppd is exiting
References: <200606081909_MC3-1-C1F0-8B6B@compuserve.com>
In-Reply-To: <200606081909_MC3-1-C1F0-8B6B@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
>>What kind of device are you using with pppd?
>>(so I can identify which driver is feeding
>>the tty layer receive data)
> 
> 
> Just a regular 16550A port at 57600 baud using the 8250 driver.
> 
> 
>>Are you setting the low_latency flag on that device?
>>(setserial)
> 
> 
> Not that I know of.

OK, thanks.

I'm 99.9% sure I've identified the problem correctly,
as it would effect the free list in precisely the
way necessary to cause an infinite loop when trying to
free the list.

My first suggested fix has problems, but there is
a straight forward solution I'll try to post
today (I've got a backlog of stuff to do here at
work before I can get to that.)

-- 
Paul Fulghum
Microgate Systems, Ltd.
