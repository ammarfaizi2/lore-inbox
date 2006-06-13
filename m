Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWFMS0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWFMS0P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 14:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWFMS0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 14:26:15 -0400
Received: from rtr.ca ([64.26.128.89]:53170 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932220AbWFMS0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 14:26:14 -0400
Message-ID: <448F0344.9000008@rtr.ca>
Date: Tue, 13 Jun 2006 14:26:12 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: John Heffner <jheffner@psc.edu>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       davem@davemloft.net
Subject: Re: 2.6.17: networking bug??
References: <448EC6F3.3060002@rtr.ca> <448ECB09.3010308@rtr.ca> <448ED2FC.2040704@rtr.ca> <448ED9B3.8050506@rtr.ca> <448EEE9D.10105@rtr.ca> <448EF45B.2080601@rtr.ca> <448EF85E.50405@psc.edu> <Pine.LNX.4.64.0606131048550.5498@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606131048550.5498@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 13 Jun 2006, John Heffner wrote:
>> The best thing you can do is try to find this broken box and inform its owner
>> that it needs to be fixed.  (If you can find out what it is, I'd be interested
>> to know.)  In the meantime, disabling window scaling will work around the
>> problem for you.
> 
> Well, arguably, we shouldn't necessarily have defaults that use window 
> scaling, or we should have ways to recognize automatically when it 
> doesn't work (which may not be possible).
> 
> It's not like there aren't broken boxes out there, and it might be better 
> to make the default buffer sizes just be low enough that window scaling 
> simply isn't an issue.
> 
> I suspect that the people who really want/need window scaling know about 
> it, and could be assumed to know enough to raise their limits, no?

Agreed.  It's taken me over a month here to realize that the particular
webserver in question (www.everymac.com) wasn't "dead", but merely being
blocked by my 2.6.17 kernel.  All was fine with 2.6.16, as I discovered today.

I wonder how many other "dead sites" there are out there,
that will be shut off from people when they "upgrade" to 2.6.17 ?

I'm a kernel hacker.  Most users of 2.6.17 will not be.
The default should be something that works "by default".

Cheers
