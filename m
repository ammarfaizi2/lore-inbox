Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965063AbWECBGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbWECBGk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 21:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbWECBGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 21:06:40 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:36338 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S965063AbWECBGj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 21:06:39 -0400
Date: Tue, 2 May 2006 18:06:27 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Marcin Hlybin <marcin.hlybin@swmind.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Open Discussion, kernel in production environment
In-Reply-To: <200605012357.48623.marcin.hlybin@swmind.com>
Message-ID: <Pine.LNX.4.62.0605021757520.11269@qynat.qvtvafvgr.pbz>
References: <200605012357.48623.marcin.hlybin@swmind.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 May 2006, Marcin Hlybin wrote:

> Hello,
>
> I always configure and compile a kernel throwing out all unusable options and
> I never use modules in production environment (especially for the router).
> But my superior has got the other opinion - he claims that distribution
> kernel is quite good and in these days optimization has no sense because of
> powerful hadrware.
> What do you think? I have few arguments for this discussion but I wonder what
> you say. Please, try to substantiate your opinions.

At one point in the past I did some testing of stock 386 kernels (standard 
at the time) vs K7 optimized kernels that were stripped down and saw a 
substantial difference (30% IIRC). nowdays the distros are optimizing for 
better chips so it makes less of a difference (and there's not a lot of 
variation yet among the amd64 options)

however, by rolling your own you can avoid including features that you 
don't need, and by eliminating those features you also eliminate any 
bugs/vunerabilities that those features include (the trade-off is that 
sometimes there are dependancies that require non-obvious features and/or 
features are buggy and break things when turned off).

I got burned by distro kernels in the past, and the distro was not much 
help (not everything in the system was on that distro's 'approved 
hardware' list, and even the stuff that was hadn't been testing in that 
particular combination). this makes me cynical about the testing that the 
distro does (they can't possibly test every combination), so if I have to 
test things myself why wait the extra time for the disto to do it's 
release?

things are getting better with the distros staying close to the vanilla 
kernel, but my memory is long enough to not really trust them yet ;-)

David Lang


-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

