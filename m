Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261699AbSJJSBw>; Thu, 10 Oct 2002 14:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261744AbSJJSBw>; Thu, 10 Oct 2002 14:01:52 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:19178 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S261699AbSJJSBv>; Thu, 10 Oct 2002 14:01:51 -0400
Message-ID: <3DA5C1AB.8060708@drugphish.ch>
Date: Thu, 10 Oct 2002 20:06:35 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gianni Tedesco <gianni@ecsc.co.uk>
Cc: Martin Renold <martinxyz@gmx.ch>, linux-kernel@vger.kernel.org
Subject: Re: [patch] tcp connection tracking 2.4.19
References: <20021008205053.GA2621@old.homeip.net>	 <3DA348EF.7060709@drugphish.ch> <1034166655.30384.13.camel@lemsip>	 <3DA4668A.5070501@drugphish.ch> <1034246310.1489.74.camel@lemsip>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Fair enough. I thought that last time I checked with the code the SYN 
>>cookie functionality would only kick in _after_ the backlog queue is full.
> > It does. When using syn cookies you cant use some of the new advanced
> features of tcp. Linux uses the backlog queue when not under attack.
> When the queue overflows it just uses cookies - but can still accept
> connections.

That was my understanding so far. So then I haven't gone crazy, thank god.

> I don't think these statements are entirely true. While it is true that
> you can't use things like window scaling or SACK - syncookies 100%
> successfully stop syn flood attacks.

Someone needs to adjust the text then.

> The attack is that if you fill the syn backlog queue with bogus requests
> then legitimate clients can no longer connect. The syn flood attack
> isn't "your legitimate connections wont be able to use window scaling".

I completely agree with this definition of SYN flooding and then I will 
also say that you can 'stop' SYN flooding, well, at least you give 
legitimate clients a real chance to still successfully connect to your 
service, while it is under a SYN flood. I think we agree now. It should 
only be remarked that the line is still flooded, thus the wording "100 
stop SYN flood" is simply inappropriate in my eyes. It's all a matter of 
definition.

Regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

