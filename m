Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWGDFPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWGDFPG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 01:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWGDFPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 01:15:06 -0400
Received: from mxl145v68.mxlogic.net ([208.65.145.68]:26044 "EHLO
	p02c11o145.mxlogic.net") by vger.kernel.org with ESMTP
	id S1750830AbWGDFPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 01:15:04 -0400
Date: Tue, 4 Jul 2006 07:55:47 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Anton Blanchard <anton@samba.org>
Cc: eli@mellanox.co.il, David Miller <davem@davemloft.net>, bos@pathscale.com,
       akpm@osdl.org, Roland Dreier <rdreier@cisco.com>,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, matthew@wil.cx, ak@suse.de, ak@muc.de,
       vojtech@suse.cz
Subject: Re: [PATCH 38 of 39] IB/ipath - More changes to support InfiniPath on PowerPC 970 systems
Message-ID: <20060704045547.GA4325@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <c22b6c244d5db77f7b1d.1151617289@eng-12.pathscale.com> <20060629.145319.71091846.davem@davemloft.net> <1151618499.10886.26.camel@chalcedony.pathscale.com> <20060629.150417.78710870.davem@davemloft.net> <20060703222506.GD31081@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703222506.GD31081@krispykreme>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 04 Jul 2006 05:00:30.0609 (UTC) FILETIME=[C5FFD810:01C69F26]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [63.251.237.3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Anton Blanchard <anton@samba.org>:
> Subject: Re: [PATCH 38 of 39] IB/ipath - More changes to support InfiniPath on PowerPC 970 systems
> 
>  
> Hi,
> 
> > Please fix the generic code if it doesn't provide the facility
> > you need at the moment.  Don't shoe horn it into your driver
> > just to make up for that.
> 
> Ive had 3 drivers asking for write combining recently so I agree this is
> a good idea. How about ioremap_wc as suggested by Willy:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114374741828040&w=2

Hmm ... I think ioremap_wc isn't sufficient by itself to make drivers using
write-combined memory, portable.  Here's another thread on a related subject:

http://lkml.org/lkml/2006/2/24/347

-- 
MST
