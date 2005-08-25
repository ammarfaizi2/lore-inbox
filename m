Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbVHYIRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbVHYIRY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 04:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbVHYIRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 04:17:24 -0400
Received: from mf01.sitadelle.com ([212.94.174.68]:60796 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S964870AbVHYIRX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 04:17:23 -0400
Message-ID: <430D7E8D.2070305@lifl.fr>
Date: Thu, 25 Aug 2005 10:17:17 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
Organization: LIFL
User-Agent: Mozilla Thunderbird 1.0.6-3mdk (X11/20050322)
X-Accept-Language: en, fr, ja, es
MIME-Version: 1.0
To: Daniel Brockman <daniel@brockman.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where do packets sent to 255.255.255.255 go?
References: <87ek8isual.fsf@wigwam.deepwood.net>
In-Reply-To: <87ek8isual.fsf@wigwam.deepwood.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

25.08.2005 03:02, Daniel Brockman wrote/a écrit:
> Hi list,
> 
> If I understand correctly, packets sent to the all-ones
> broadcast address only go out through a single interface.
Hello,

I have some blur memories about this kind of issue, so my answer my be 
wrong on some points...

> 
> My question is threefold:
> 
>  1. Why doesn't Linux send 255.255.255.255 packages through
>     all network interfaces?  (I realize that this is
>     probably not a Linux-specific question.)
IIRC, Linux 255.255.255.255 as a normal IP address. Therefore it will 
follow the route for such an address and select the interface it is 
associated (probably eth0 if you are on a LAN).

> 
>  2. How does it choose which interface to send through?
>     My first guess was that it just took the first Ethernet
>     interface and used that for broadcasting.  But playing
>     around with nameif, this seems not to be the case.
cf 1

> 
>  3. Can I set the default broadcast interface explicitly?
>     For example, say I wanted broadcasts to go out over eth1
>     by default, instead of over eth0.  What if I wanted them
>     to get sent through tap0?
Again, I'm not sure, but I think that you can force the interface by 
adding a special route for IP 255.255.255.255 and with mask 
255.255.255.255 to the interface you want.


[sniped]

Hope this help, even if my memory is a bit confused,
Eric

