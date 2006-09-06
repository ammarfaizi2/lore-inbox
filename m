Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWIFSBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWIFSBJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 14:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWIFSBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 14:01:09 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:11691 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1751274AbWIFSBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 14:01:06 -0400
Message-ID: <44FF0D04.5020405@candelatech.com>
Date: Wed, 06 Sep 2006 11:01:40 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       waltje@uwalt.nl.mugnet.org, ross.biro@gmail.com, davem@davemloft.net,
       yoshfuji@linux-ipv6.org, netdev@vger.kernel.org
Subject: Re: Unable to halt or reboot due to - unregister_netdevice: waiting
 for eth0.20 to become free. Usage count = 1
References: <9a8748490609010259l7c42ca88tbcc87410a770b48c@mail.gmail.com>	 <E1GJ6St-0004Te-00@gondolin.me.apana.org.au>	 <9a8748490609010351kd8f0d40ud3509e2f3eaa89ac@mail.gmail.com> <9a8748490609010435k6b327237ve6a23ddcaa0f4065@mail.gmail.com>
In-Reply-To: <9a8748490609010435k6b327237ve6a23ddcaa0f4065@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> Ok, I've done some more testing and it seems, unfortunately, that I
> can't trigger the problem reliably. I guess I was just "lucky" with my
> first few reboots.
> It now seems that uptime and/or amount of data that has flowed over
> the vlan interface impacts the probability of hitting the problem.

Back when I was chasing the neighbor table leak, I wrote a patch to
catch ref-count leaks for net devices.  It was against 2.6.13 or so,
but if nothing else is helping, it might be worth dusting off.

I put what I believe was the last iteration of that patch here:

http://www.candelatech.com/oss/rfcnt.patch

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

