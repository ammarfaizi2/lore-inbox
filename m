Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWCTLrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWCTLrV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 06:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWCTLrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 06:47:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26780 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750893AbWCTLrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 06:47:20 -0500
Subject: Re: TSO and IPoIB performance degradation
From: Arjan van de Ven <arjan@infradead.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: "David S. Miller" <davem@davemloft.net>, rick.jones2@hp.com,
       netdev@vger.kernel.org, rdreier@cisco.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20060320112753.GX29929@mellanox.co.il>
References: <20060320090629.GA11352@mellanox.co.il>
	 <20060320.015500.72136710.davem@davemloft.net>
	 <20060320102234.GV29929@mellanox.co.il>
	 <20060320.023704.70907203.davem@davemloft.net>
	 <20060320112753.GX29929@mellanox.co.il>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 12:47:03 +0100
Message-Id: <1142855223.3114.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 13:27 +0200, Michael S. Tsirkin wrote:
> Quoting David S. Miller <davem@davemloft.net>:
> > I disagree with Linux changing it's behavior.  It would be great to
> > turn off congestion control completely over local gigabit networks,
> > but that isn't determinable in any way, so we don't do that.
> 
> Interesting. Would it make sense to make it another tunable knob in
> /proc, sysfs or sysctl then?

that's not the right level; since that is per interface. And you only
know the actual interface waay too late (as per earlier posts).
Per socket.. maybe
But then again it's not impossible to have packets for one socket go out
to multiple interfaces
(think load balancing bonding over 2 interfaces, one IB another
ethernet)


