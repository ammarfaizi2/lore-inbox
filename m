Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWCFUPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWCFUPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 15:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWCFUPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 15:15:55 -0500
Received: from [194.90.237.34] ([194.90.237.34]:29322 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1751360AbWCFUPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 15:15:54 -0500
Date: Mon, 6 Mar 2006 22:16:03 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: David Stevens <dlstevens@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: RFC: move SDP from AF_INET_SDP to IPPROTO_SDP
Message-ID: <20060306201603.GA17048@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060306190636.GA14849@mellanox.co.il> <OFB3CB1E4D.355F7555-ON88257129.006C1001-88257129.006C836D@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFB3CB1E4D.355F7555-ON88257129.006C1001-88257129.006C836D@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 06 Mar 2006 20:18:14.0484 (UTC) FILETIME=[190E6140:01C6415B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. David Stevens <dlstevens@us.ibm.com>:
> Subject: Re: RFC: move SDP from AF_INET_SDP to IPPROTO_SDP
> 
> I don't know any details about SDP, but if there are no differences at the
> protocol layer, then neither the address family nor the protocol is
> appropriate. If it's just an API change, the socket type is the right
> selector. So, maybe SOCK_DIRECT to go along with SOCK_STREAM,
> SOCK_DGRAM, etc.

No, the API SDP implements is the regular SOCK_STREAM semantics.

The difference is in the way connections are established with
infiniband connection management messages, and data is transferred
with infiniband reliable connection send messages.

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
