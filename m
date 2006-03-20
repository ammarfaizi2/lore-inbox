Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWCTKVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWCTKVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 05:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWCTKVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 05:21:54 -0500
Received: from [194.90.237.34] ([194.90.237.34]:36447 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1750746AbWCTKVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 05:21:53 -0500
Date: Mon, 20 Mar 2006 12:22:34 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: "David S. Miller" <davem@davemloft.net>
Cc: rick.jones2@hp.com, netdev@vger.kernel.org, rdreier@cisco.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: TSO and IPoIB performance degradation
Message-ID: <20060320102234.GV29929@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <4410C671.2050300@hp.com> <20060309.232301.77550306.davem@davemloft.net> <20060320090629.GA11352@mellanox.co.il> <20060320.015500.72136710.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320.015500.72136710.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 20 Mar 2006 10:24:30.0531 (UTC) FILETIME=[794F0930:01C64C08]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. David S. Miller <davem@davemloft.net>:
> The path an SKB can take is opaque and unknown until the very last
> moment it is actually given to the device transmit function.

Why, I was proposing looking at dst cache. If that's NULL, well,
we won't stretch ACKs. Worst case we apply the wrong optimization.
Right?

> People need to get the "special case this topology" ideas out of their
> heads. :-)

Okay, I get that.

What I'd like to clarify, however: rfc2581 explicitly states that in some cases
it might be OK to generate ACKs less frequently than every second full-sized
segment. Given Matt's measurements, TCP on top of IP over InfiniBand on Linux
seems to hit one of these cases.  Do you agree to that?

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
