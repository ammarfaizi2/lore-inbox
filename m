Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUBYQ7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbUBYQ7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:59:47 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:58888 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261425AbUBYQ7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:59:45 -0500
Message-ID: <403CD6DB.7040507@techsource.com>
Date: Wed, 25 Feb 2004 12:09:47 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: John Lee <johnl@aurema.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <Pine.GSO.4.03.10402260130140.2680-100000@swag.sw.oz.au>
In-Reply-To: <Pine.GSO.4.03.10402260130140.2680-100000@swag.sw.oz.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Lee wrote:

> X Windows Performance
> =====================
> 
> The X server isn't strictly an interactive process, but it does have a major
> influence on interactive response. The fact that it services a large number
> of clients means that its CPU usage rate can be quite high, and this negates 
> the above mentioned favourable treatment of interactive and I/O bound 
> processes.
> 
> Therefore, for best interactive feel, it is recommended that the X server run 
> with a nice value of at least -15. From my own testing, doing a window wiggle 
> test with a make -j16 in the background and X reniced was slightly better than 
> for the stock kernel. 
> 
> When running apps such as xmms, I recommend that they should be reniced as well
> when the background load is high. With the above setup and xmms reniced to -9,
> there were no sound skips at all (without renicing, a few skips could be
> detected).


Well, considering that X is suid root, it's okay to require that it be 
run at nice -15, but how is the user without root access going to renice 
xmms?  Even for those who do, they're not going to want to have to 
renice xmms every time they run it.  Furthermore, it seems like a bad 
idea to keep marking more and more programs as suid root just so that 
they can boost their priority.

Not to say that your idea is bad... in fact, it may be a pipe dream to 
get "flawless" interactivity without explicitly marking which programs 
have to be boosted in priority.  Still, Nick and Con have done a 
wonderful job at getting close.

This is a tough problem.

