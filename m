Return-Path: <linux-kernel-owner+w=401wt.eu-S1425522AbWLHOO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425522AbWLHOO3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 09:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425517AbWLHOO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 09:14:29 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:4406 "EHLO ra.tuxdriver.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760742AbWLHOO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 09:14:28 -0500
Date: Fri, 8 Dec 2006 09:13:57 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: David Miller <davem@davemloft.net>
Cc: linux-net@vger.kernel.org, mpm@selenic.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, clalance@redhat.com
Subject: Re: [PATCH] netpoll: make arp replies through netpoll use mac address of sender
Message-ID: <20061208141357.GA2661@hmsreliant.homelinux.net>
References: <20061207194553.GB29313@hmsreliant.homelinux.net> <20061208.000727.23014207.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208.000727.23014207.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 12:07:27AM -0800, David Miller wrote:
> From: Neil Horman <nhorman@tuxdriver.com>
> Date: Thu, 7 Dec 2006 14:45:53 -0500
> 
> > Back in 2.4 arp requests that were recevied by netpoll were processed in
> > netconsole_receive_skb, where they were responded to using the src mac of the
> > request sender.  In the 2.6 kernel arp_reply is responsible for this function,
> > but instead of using the src mac address of the incomming request, the stored
> > mac address that was registered for the netconsole application is used.  While
> > this is usually ok, it can lead to failures in netpoll in some situations
> > (specifically situations where a network may have two gateways, as arp requests
> > from one may be responded to using the mac address of the other).  This patch
> > reverts the behavior to what we had in 2.4, in which all arp requests are sent
> > back using the src address of the request sender.
> > 
> > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> 
> Applied, and I'll push this to -stable, thanks Neil.
> 
> But please submit networking patches next time to
> netdev@vger.kernel.org, most of the networking developers did not see
> this patch because you sent it to the user help list (linux-net)
> instead of the developer list (netdev).
> 
My bad, wasn't thinking.  Thanks guys!
Neil

> Thanks again.

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
