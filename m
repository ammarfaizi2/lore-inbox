Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWFMTJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWFMTJD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 15:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWFMTJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 15:09:02 -0400
Received: from rtr.ca ([64.26.128.89]:23962 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750990AbWFMTJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 15:09:01 -0400
Message-ID: <448F0D4B.30201@rtr.ca>
Date: Tue, 13 Jun 2006 15:08:59 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: John Heffner <jheffner@psc.edu>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       davem@davemloft.net
Subject: Re: 2.6.17: networking bug??
References: <448EC6F3.3060002@rtr.ca> <448ECB09.3010308@rtr.ca> <448ED2FC.2040704@rtr.ca> <448ED9B3.8050506@rtr.ca> <448EEE9D.10105@rtr.ca> <448EF45B.2080601@rtr.ca> <448EF85E.50405@psc.edu> <Pine.LNX.4.64.0606131048550.5498@g5.osdl.org> <448F0344.9000008@rtr.ca>
In-Reply-To: <448F0344.9000008@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Linus Torvalds wrote:
>
>> It's not like there aren't broken boxes out there, and it might be 
>> better to make the default buffer sizes just be low enough that window 
>> scaling simply isn't an issue.
>>
>> I suspect that the people who really want/need window scaling know 
>> about it, and could be assumed to know enough to raise their limits, no?
> 
> Agreed.  It's taken me over a month here to realize that the particular
> webserver in question (www.everymac.com) wasn't "dead", but merely being
> blocked by my 2.6.17 kernel.  All was fine with 2.6.16, as I discovered 
> today.
> 
> I wonder how many other "dead sites" there are out there,
> that will be shut off from people when they "upgrade" to 2.6.17 ?
> 
> I'm a kernel hacker.  Most users of 2.6.17 will not be.
> The default should be something that works "by default".

Further to this, the current behaviour is badly unpredictable.

A machine could be working perfectly, not (noticeably) affected
by this bug.  And then the user adds another stick of RAM to it.

Poof.. many sites from the internet stop responding.
Obviously the RAM upgrade broke things.. must be bad RAM, right?

Err.. no, the networking stack simply decided to become incompatible
with certain sites, as a result of the user adding more RAM to their machine.

BbD.
