Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVBIN2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVBIN2h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 08:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVBIN2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 08:28:37 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:27116 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S261819AbVBIN2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 08:28:35 -0500
Message-ID: <420A1011.1030602@einar-lueck.de>
Date: Wed, 09 Feb 2005 14:28:49 +0100
From: =?ISO-8859-1?Q?Einar_L=FCck?= <lkml@einar-lueck.de>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH 2/2] ipv4 routing: multipath with cache support, 2.6.10-rc3
References: <41C6B54F.2020604@einar-lueck.de> <20050202172333.4d0ad5f0.davem@davemloft.net>
In-Reply-To: <20050202172333.4d0ad5f0.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Can you describe more precisely "the scenerios, that are relevant
> to us"?

The scenarios we have in mind are setups in which a set of collaborating 
servers steadly establish connections among each other with a very high rate. 
This high rate requirement drove us to consider the inclusion of all 
alternative routes into the routing cache because the corresponding delay 
for each connection establishment is low and the load is balanced over all
available routes. That's why we did not consider a slow lookup in the fib 
for each connection established.

Regards,
Einar.
