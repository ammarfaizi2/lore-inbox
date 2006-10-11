Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030724AbWJKA1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030724AbWJKA1X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 20:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030730AbWJKA1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 20:27:23 -0400
Received: from dev.mellanox.co.il ([194.90.237.44]:65153 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1030724AbWJKA1W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 20:27:22 -0400
Date: Wed, 11 Oct 2006 02:26:56 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Roland Dreier <rdreier@cisco.com>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, openib-general@openib.org,
       Roland Dreier <rolandd@cisco.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
Message-ID: <20061011002656.GB30093@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <adavemrbtcx.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adavemrbtcx.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Roland Dreier <rdreier@cisco.com>:
> Subject: Re: Dropping NETIF_F_SG since no checksum feature.
> 
>     Michael> Maybe I can patch linux to allow SG without checksum?
>     Michael> Dave, maybe you could drop a hint or two on whether this
>     Michael> is worthwhile and what are the issues that need
>     Michael> addressing to make this work?
> 
> What do you really gain by allowing SG without checksum?  Someone has
> to do the checksum anyway, so I don't see that much difference between
> doing it in the networking core before passing the data to/from the
> driver, or down in the driver itself.

My guess was, an extra pass over data is likely to be expensive - dirtying the
cache if nothing else. But I do plan to measure that, and see.

-- 
MST
