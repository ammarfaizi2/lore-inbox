Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271755AbTG2PZJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 11:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271814AbTG2PZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 11:25:09 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:27152 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S271755AbTG2PZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 11:25:04 -0400
Message-ID: <3F26944D.8070707@techsource.com>
Date: Tue, 29 Jul 2003 11:35:41 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Valdis.Kletnieks@vt.edu,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O10int for interactivity
References: <200307280112.16043.kernel@kolivas.org> <200307281808.h6SI8C5k004439@turing-police.cc.vt.edu> <3F2682EF.2040702@techsource.com> <200307300035.01354.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:
> On Wed, 30 Jul 2003 00:21, Timothy Miller wrote:
> 
>>Valdis.Kletnieks@vt.edu wrote:
>>
>>>I'm guessing that the anticipatory scheduler is the culprit here.  Soon
>>>as I figure out the incantations to use the deadline scheduler, I'll
>>>report back....
>>
>>It would be unfortunate if AS and the interactivity scheduler were to
>>conflict.  Is there a way we can have them talk to each other and have
>>AS boost some I/O requests for tasks which are marked as interactive?
>>
>>It would sacrifice some throughput for the sake of interactivity, which
>>is what the interactivity patches do anyhow.  This is a reasonable
>>compromise.
> 
> 
> That's not as silly as it sounds. In fact it should be dead easy to 
> increase/decrease the amount of anticipatory time based on the bonus from 
> looking at the code. I dunno how the higher filesystem gods feel about this 
> though.


On the one hand, it's nice to keep systems independent so that you can 
make them separately optional, but on the other hand, if they can talk 
to each other, it makes for an all-around better-performing system, 
because things don't stomp on each other.

They will need to pay attention to each other's kernel config options so 
as to keep or leave out whatever code communicates between them.  How 
hard is that to do?



