Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVBIUmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVBIUmU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 15:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVBIUmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 15:42:20 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:53408 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S261837AbVBIUmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 15:42:17 -0500
Message-ID: <420A75BF.1080106@einar-lueck.de>
Date: Wed, 09 Feb 2005 21:42:39 +0100
From: =?ISO-8859-1?Q?Einar_L=FCck?= <lkml@einar-lueck.de>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH 2/2] ipv4 routing: multipath with cache support, 2.6.10-rc3
References: <41C6B54F.2020604@einar-lueck.de>	<20050202172333.4d0ad5f0.davem@davemloft.net>	<420A1011.1030602@einar-lueck.de>	<20050209120157.18dc75c1.davem@davemloft.net>	<420A715D.7050106@einar-lueck.de> <20050209123004.2d65e1cf.davem@davemloft.net>
In-Reply-To: <20050209123004.2d65e1cf.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> This was brought up before.  It's the case where the system is acting
> as a router, you have to consider that case and not just the one where
> the local system is where the connections are originating from.
> 
> Your trick only works because of how routes are cached per-socket.
> Once you get into the realm of traffic going through the machine as
> a router, the trick stops to work.

We considered the routing case: in the routing case ip_route_input is called. 
In this case we just select the first route in the cache which is always the same 
(we ensure that). Consequently, the routing behaviour is not changed in this case and 
remains in the way you like it. 

Regards,
Einar.
