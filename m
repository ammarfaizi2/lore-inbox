Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWF3A2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWF3A2y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWF3A2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:28:54 -0400
Received: from palrel11.hp.com ([156.153.255.246]:7064 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S964813AbWF3A2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:28:52 -0400
Message-ID: <44A47042.8060203@hp.com>
Date: Thu, 29 Jun 2006 17:28:50 -0700
From: Rick Jones <rick.jones2@hp.com>
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.6) Gecko/20040304
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Cc: bos@pathscale.com, akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 39 of 39] IB/ipath - use streaming copy in RDMA	interrupt
 handler to reduce packet loss
References: <1151618377.10886.23.camel@chalcedony.pathscale.com>	<20060629.150319.104035601.davem@davemloft.net>	<1151624063.10886.34.camel@chalcedony.pathscale.com> <20060629.164623.59469884.davem@davemloft.net>
In-Reply-To: <20060629.164623.59469884.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you bypass the L2 cache, it's pointless because the next
> agent (PCI controller, CPU thread, etc.) is going to need the
> data in the L2 cache.
> 
> It's better in that kind of setup to eat the L2 cache miss overhead in
> memcpy since memcpy can usually prefetch and store buffer in order to
> absorb some of the L2 miss costs.

I thought that most PCI controllers (that is to say the things bridging 
PCI to the rest of the system) could do prefetching and/or that PCI-X 
(if not PCI, no idea about PCI-e) cards could issue multiple 
transactions anyway?

rick jones
