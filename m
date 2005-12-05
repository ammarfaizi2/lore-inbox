Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbVLEXLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbVLEXLE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbVLEXLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:11:04 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:52982 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964847AbVLEXKh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:10:37 -0500
Message-ID: <43949541.9060700@tmr.com>
Date: Mon, 05 Dec 2005 14:30:09 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>
In-Reply-To: <20051203135608.GJ31395@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> The current kernel development model is pretty good for people who 
> always want to use or offer their costumers the maximum amount of the 
> latest bugs^Wfeatures without having to resort on additional patches for 
> them.
> 
> Problems of the current development model from a user's point of view 
> are:
> - many regressions in every new release
> - kernel updates often require updates for the kernel-related userspace 
>   (e.g. for udev or the pcmcia tools switch)
> 
> One problem following from this is that people continue to use older 
> kernels with known security holes because the amount of work for kernel 
> upgrades is too high.

Depending on where you work, "not working" may be acceptable vs. 
"working with a known security hole."
> 
> These problems follow from the development model.
> 
> The latest stable kernel series without these problems is 2.4, but 2.4 
> is becoming more and more obsolete and might e.g. lack driver support 
> for some recent hardware you want to use.
> 
> Since Andrew and Linus do AFAIK not plan to change the development 
> model, what about the following for getting a stable kernel series 
> without leaving the current development model:
> 
> 
> Kernel 2.6.16 will be the base for a stable series.
> 
> After 2.6.16, there will be a 2.6.16.y series with the usual stable 
> rules.
> 
> After the release of 2.6.17, this 2.6.16.y series will be continued with 
> more relaxed rules similar to the rules in kernel 2.4 since the release 
> of kernel 2.6.0 (e.g. driver updates will be allowed).

Actually I would be happy with the stability of this series if people 
would stop trying to take working features OUT of it! That's the largest 
problem I see, not that the existing features are unstable, and we have 
a -stable branch to cover that, but that I can't count on features I use 
and which are required for useful work.

If a firm policy of not removing supported features until 2.7 was 
adopted I don't see a problem. The bulk of the instability (not 
absolutely all, I grant), is in new features, or features which aren't 
working all that well in any case. But if existing features suddenly 
drop out from beneath the user, then you will find people doing what you 
mentioned, staying with old kernels with holes rather than moving to 
kernels which are simply no longer functional.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

