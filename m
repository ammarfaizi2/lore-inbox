Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbTGEVcZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 17:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbTGEVcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 17:32:25 -0400
Received: from evrtwa1-ar2-4-33-045-074.evrtwa1.dsl-verizon.net ([4.33.45.74]:6071
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S266512AbTGEVcX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 17:32:23 -0400
Message-ID: <3F074739.9090006@candelatech.com>
Date: Sat, 05 Jul 2003 14:46:33 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Sipek <jeffpc@optonline.net>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com
Subject: Re: [PATCH - RFC] [1/5] 64-bit network statistics - generic net
References: <Pine.LNX.4.44.0307032005340.8468-100000@home.osdl.org> <200307051449.32934.jeffpc@optonline.net>
In-Reply-To: <200307051449.32934.jeffpc@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Sipek wrote:

> Using KB would give us additional 10 bits (making the overflow at 4 TB.) I 
> don't really like the idea of using MB, but the underlying idea is the same - 
> 20 more bits, making the limit 4 PB.
> 
> What is the consensus on this way of solving the problem?

I guess it could be useful for something like ifconfig, but serious
applications will need more precision and should deal with wraps anyway
(even on 64-bits, in my opinion..why have to fix bugs in 10 years because
we were too lazy to take the 10 minutes to make it right now).

Ben


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


