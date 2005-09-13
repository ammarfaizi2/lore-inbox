Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbVIMWQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbVIMWQi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 18:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbVIMWQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 18:16:38 -0400
Received: from serv01.siteground.net ([70.85.91.68]:54757 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932496AbVIMWQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 18:16:37 -0400
Date: Tue, 13 Sep 2005 15:16:32 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: shemminger@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, bharata@in.ibm.com, shai@scalex86.org,
       rusty@rustcorp.com.au, netdev@vger.kernel.org
Subject: Re: [patch 7/11] net: Use bigrefs for net_device.refcount
Message-ID: <20050913221632.GB6249@localhost.localdomain>
References: <20050913155112.GB3570@localhost.localdomain> <20050913161012.GI3570@localhost.localdomain> <20050913092659.791bddec@localhost.localdomain> <20050913.132607.113443001.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913.132607.113443001.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 01:26:07PM -0700, David S. Miller wrote:
> From: Stephen Hemminger <shemminger@osdl.org>
> Date: Tue, 13 Sep 2005 09:26:59 -0700
> 
> > Since when is bringing a network device up/down performance critical?
> 
> The issue is the dev_get()'s that occur all over the place
> to during packet transmit/receive, that's what they are
> trying to address.
> 
> I'm still against all of these invasive NUMA changes to the
> networking though, they are simply too ugly and special cased
> to consider seriously.

All of them or the dst ones?  Hopefully the netdevice refcounter patch
is not ugly or complicated as the dst ones? And why are they special cased?
Are networking workloads with high route locality not interesting?

Thanks,
Kiran
