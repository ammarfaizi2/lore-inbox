Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267852AbUHaLOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267852AbUHaLOm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 07:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267882AbUHaLOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 07:14:42 -0400
Received: from [195.23.16.24] ([195.23.16.24]:6122 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S267852AbUHaLOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 07:14:39 -0400
Message-ID: <41345D91.2050202@grupopie.com>
Date: Tue, 31 Aug 2004 12:14:25 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, Adrian Bunk <bunk@fs.tum.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: What policy for BUG_ON()?
References: <20040830201519.GH12134@fs.tum.de> <1093897329.2870.11.camel@laptop.fenrus.com> <20040831062815.GA2312@suse.de>
In-Reply-To: <20040831062815.GA2312@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.38; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Aug 30 2004, Arjan van de Ven wrote:
> 
>>On Mon, 2004-08-30 at 22:15, Adrian Bunk wrote:
>>
>>>Let me try to summarize the different options regarding BUG_ON, 
>>>concerning whether the argument to BUG_ON might contain side effects, 
>>>and whether it should be allowed in some "do this only if you _really_ 
>>>know what you are doing" situations to let BUG_ON do nothing.
>>>
>>>Options:
>>>1. BUG_ON must not be defined to do nothing
>>>1a. side effects are allowed in the argument of BUG_ON
>>>1b. side effects are not allowed in the argument of BUG_ON
>>>2. BUG_ON is allowed to be defined to do nothing
>>>2a. side effects are allowed in the argument of BUG_ON
>>>2b. side effects are not allowed in the argument of BUG_ON
>>
>>since you quoted me earlier my 2 cents:
>>1) I would prefer BUG_ON() arguments to not have side effects; its just 
>>cleaner that way. (similar to assert)
>>
>>2) if one wants to compiel out BUG_ON, I rather alias it to panic() than
>>to nothing.
> 
> 
> I agree completely with that.

This would mean that the condition would still have to be
tested which kind of defeats the purpose of removing the
BUG_ON in the first place, doesn't it?

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978
