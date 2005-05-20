Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVETJWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVETJWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 05:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVETJWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 05:22:10 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:61195 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261400AbVETJV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 05:21:58 -0400
Message-ID: <428DAD71.4050105@aitel.hist.no>
Date: Fri, 20 May 2005 11:27:13 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: Arjan van de Ven <arjan@infradead.org>, linux-os@analogic.com,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       "Gilbert, John" <JGG@dolby.com>, linux-kernel@vger.kernel.org
Subject: Re: Illegal use of reserved word in system.h
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>	 <20050518195337.GX5112@stusta.de>	 <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>	 <20050519112840.GE5112@stusta.de>	 <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com> <1116505655.6027.45.camel@laptopd505.fenrus.org> <428CCD19.6030909@candelatech.com>
In-Reply-To: <428CCD19.6030909@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:

> Arjan van de Ven wrote:
>
>> HZ may not exist. At all; people are trying to remove it. And userspace
>> has no business knowing about it either.
>
>
> It can be helpful to know what HZ you are running at, for instance if 
> you care
> very much about the (average) precision of a select/poll timeout.
>
Will  knowing it help?  You may find out that you don't have much precision,
but then theres nothing to do about it.  And there may not even be a HZ,
as mentioned.  Less cpu is used if there is no periodic interrupts when
there is nothing to do.  People are trying to *not* have a regular timer
interrupt; instead, a one-shot timer can be programmed for the next
necessary timeout which may very well be quite a few "ticks" into
the future. In this case there is no notion of HZ at all.

Helge Hafting


