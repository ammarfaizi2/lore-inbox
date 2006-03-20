Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbWCTQG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbWCTQG1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965760AbWCTQGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:06:09 -0500
Received: from kanga.kvack.org ([66.96.29.28]:26840 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S965165AbWCTPPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:15:17 -0500
Date: Mon, 20 Mar 2006 10:09:42 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>,
       Arjan van de Ven <arjan@infradead.org>,
       "David S. Miller" <davem@davemloft.net>, rick.jones2@hp.com,
       netdev@vger.kernel.org, rdreier@cisco.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: TSO and IPoIB performance degradation
Message-ID: <20060320150941.GD16108@kvack.org>
References: <20060320090629.GA11352@mellanox.co.il> <20060320.015500.72136710.davem@davemloft.net> <20060320102234.GV29929@mellanox.co.il> <20060320.023704.70907203.davem@davemloft.net> <20060320112753.GX29929@mellanox.co.il> <1142855223.3114.30.camel@laptopd505.fenrus.org> <20060320114933.GA3058@xi.wantstofly.org> <20060320120407.GY29929@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320120407.GY29929@mellanox.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 02:04:07PM +0200, Michael S. Tsirkin wrote:
> does not stretch ACKs anymore. RFC 2581 does mention that it might be OK to
> stretch ACKs "after careful consideration", and we are seeing that it helps
> IP over InfiniBand, so recent Linux kernels perform worse in that respect.
> 
> And since there does not seem to be a way to figure it out automagically when
> doing this is a good idea, I proposed adding some kind of knob that will let the
> user apply the consideration for us.

Wouldn't it make sense to strech the ACK when the previous ACK is still in 
the TX queue of the device?  I know that sort of behaviour was always an 
issue on modem links where you don't want to send out redundant ACKs.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
