Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVBIU0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVBIU0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 15:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVBIUYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 15:24:13 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:63386 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S261919AbVBIUXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 15:23:36 -0500
Message-ID: <420A715D.7050106@einar-lueck.de>
Date: Wed, 09 Feb 2005 21:23:57 +0100
From: =?ISO-8859-1?Q?Einar_L=FCck?= <lkml@einar-lueck.de>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: netdev@oss.sgi.com
Subject: Re: [PATCH 2/2] ipv4 routing: multipath with cache support, 2.6.10-rc3
References: <41C6B54F.2020604@einar-lueck.de>	<20050202172333.4d0ad5f0.davem@davemloft.net>	<420A1011.1030602@einar-lueck.de> <20050209120157.18dc75c1.davem@davemloft.net>
In-Reply-To: <20050209120157.18dc75c1.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

> So essentially you want per-flow multipathing.  Except that you're implementation
> is over-optimizing it to the point where it's only per-flow for your specific
> case where the connections are short lived and high rate.
>
> This hurts long lasting connections.
>
> So I'm pretty much against this change.  Do it right by making it occur
> per-connection attempt, it's not my problem to figure out how to do that
> efficiently, it's your's :-)


We do not want per-flow multipathing. We want per connection multipathing with fast route lookups (that's why we have all routes in the cache). That is exactly what we implemented. Our tests prove that a connection keeps its route as long as it lives (the dstentry remains associated with the socket). That's why I do not really
understand why our approach hurts long lasting connections in any way. Can you explain your point more precisely?

Regards,
Einar.
