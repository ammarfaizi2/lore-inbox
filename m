Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWCTLtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWCTLtg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 06:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWCTLtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 06:49:35 -0500
Received: from alephnull.demon.nl ([83.160.184.112]:31209 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S1750741AbWCTLtf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 06:49:35 -0500
Date: Mon, 20 Mar 2006 12:49:33 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       "David S. Miller" <davem@davemloft.net>, rick.jones2@hp.com,
       netdev@vger.kernel.org, rdreier@cisco.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: TSO and IPoIB performance degradation
Message-ID: <20060320114933.GA3058@xi.wantstofly.org>
References: <20060320090629.GA11352@mellanox.co.il> <20060320.015500.72136710.davem@davemloft.net> <20060320102234.GV29929@mellanox.co.il> <20060320.023704.70907203.davem@davemloft.net> <20060320112753.GX29929@mellanox.co.il> <1142855223.3114.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142855223.3114.30.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 12:47:03PM +0100, Arjan van de Ven wrote:

> > > I disagree with Linux changing it's behavior.  It would be great to
> > > turn off congestion control completely over local gigabit networks,
> > > but that isn't determinable in any way, so we don't do that.
> > 
> > Interesting. Would it make sense to make it another tunable knob in
> > /proc, sysfs or sysctl then?
> 
> that's not the right level; since that is per interface. And you only
> know the actual interface waay too late (as per earlier posts).
> Per socket.. maybe
> But then again it's not impossible to have packets for one socket go out
> to multiple interfaces
> (think load balancing bonding over 2 interfaces, one IB another
> ethernet)

I read it as if he was proposing to have a sysctl knob to turn off
TCP congestion control completely (which has so many issues it's not
even funny.)
