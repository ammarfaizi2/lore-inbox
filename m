Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbVAPNUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVAPNUY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 08:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVAPNUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 08:20:24 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:62109 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S262498AbVAPNUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:20:17 -0500
Message-ID: <41EA69F0.5060500@f2s.com>
Date: Sun, 16 Jan 2005 13:19:44 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Richard Purdie <rpurdie@rpsys.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MMC Driver RFC
References: <021901c4f8eb$1e9cc4d0$0f01a8c0@max> <20050112214345.D17131@flint.arm.linux.org.uk> <023c01c4f8f3$1d497030$0f01a8c0@max> <20050112221753.F17131@flint.arm.linux.org.uk> <41E5B177.4060307@f2s.com> <41E7AF11.6030005@drzeus.cx> <41E7DD5E.5070901@f2s.com> <41EA5C8D.8070407@drzeus.cx>
In-Reply-To: <41EA5C8D.8070407@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Ian Molton wrote:

> Afraid everything gets routed to the same account in the end anyway. I 
> checked the logs and the problem is that your mail server has a HELO 
> that differs from its IP

I've sent mail to my ISP re that. cheers.

> I've had the same idea. But I think it will be difficult since we need 
> som funky logic during init. Perhaps a model where each mode 
> (MMC/SD/SDIO) each gets their turn trying to find something on the bus.

Might be worth the effort. I'll need to think on it.

> But this would require a rather large rewrite of the MMC layer.

Im not sure it'd be so catastrophic.

>> Mind you, I have plans to look at SDIO, so that may alter things...
>>
> I need it to determine if the code should send an RCA or ask for one, 
> and to determine if it should try and read the SCR. Your solution used 
> an extra parameter but I thought a mode flag would be better since we 
> might need to know mode later on (after init.).

Fair enough.

>> The toshiba controller appears to want to be told when an ACMD is 
>> issued, compared to a normal CMD.
> 
> No hints in the spec about why?

What spec? ;-)

 > Seems very strange since there's no change in what goes over the wire.

I think the controller (for some odd reason) keeps some extra internal 
state.
