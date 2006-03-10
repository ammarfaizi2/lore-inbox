Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751574AbWCJPfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbWCJPfs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWCJPfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:35:48 -0500
Received: from [194.90.237.34] ([194.90.237.34]:30622 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1751574AbWCJPfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:35:47 -0500
Date: Fri, 10 Mar 2006 17:35:59 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] [PATCH 0 of 20] [RFC] ipath driver - another round for review
Message-ID: <20060310153559.GA12778@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <patchbomb.1141950930@eng-12.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <patchbomb.1141950930@eng-12.pathscale.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 10 Mar 2006 15:38:06.0875 (UTC) FILETIME=[A097C6B0:01C64458]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Bryan O'Sullivan <bos@pathscale.com>:
>   - We've added an ethernet emulation driver so that if you're not
>     using Infiniband support, you still have a high-performance net
>     device (lower latency and higher bandwidth than IPoIB) for IP
>     traffic.

Two questions on this
1. It is not standard ethernet nor standard IP over Infiniband either, is it?
Is there some documentation on the wire protocol that you use?
Is it pathscale specific?

2. Are there practical reasons why you get lower latency and higher
bandwidth with this than with IPoIB? IP over IB simply encapsulates
each packet within a UD work request, so I don't see anything here that
might introduce extra latency or limit bandwidth.
If there are optimizations, can they not be added to the standard, common
IP over IB driver?

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
