Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbWHHUvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbWHHUvn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 16:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWHHUvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 16:51:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:37292 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964986AbWHHUvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 16:51:42 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.07,222,1151910000"; 
   d="scan'208"; a="105106127:sNHT44003568"
Message-ID: <44D8F919.7000006@intel.com>
Date: Tue, 08 Aug 2006 13:50:33 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [RFC][PATCH 3/9] e1000 driver conversion
References: <20060808193325.1396.58813.sendpatchset@lappy> <20060808193355.1396.71047.sendpatchset@lappy>
In-Reply-To: <20060808193355.1396.71047.sendpatchset@lappy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Aug 2006 20:51:37.0338 (UTC) FILETIME=[70E0E5A0:01C6BB2C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> Update the driver to make use of the NETIF_F_MEMALLOC feature.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Signed-off-by: Daniel Phillips <phillips@google.com>
> 
> ---
>  drivers/net/e1000/e1000_main.c |   11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> Index: linux-2.6/drivers/net/e1000/e1000_main.c
> ===================================================================
> --- linux-2.6.orig/drivers/net/e1000/e1000_main.c
> +++ linux-2.6/drivers/net/e1000/e1000_main.c
> @@ -4020,8 +4020,6 @@ e1000_alloc_rx_buffers(struct e1000_adap
>  		 */
>  		skb_reserve(skb, NET_IP_ALIGN);
>  
> -		skb->dev = netdev;
> -
>  		buffer_info->skb = skb;
>  		buffer_info->length = adapter->rx_buffer_len;
>  map_skb:
> @@ -4135,8 +4136,6 @@ e1000_alloc_rx_buffers_ps(struct e1000_a
>  		 */
>  		skb_reserve(skb, NET_IP_ALIGN);
>  
> -		skb->dev = netdev;
> -
>  		buffer_info->skb = skb;
>  		buffer_info->length = adapter->rx_ps_bsize0;
>  		buffer_info->dma = pci_map_single(pdev, skb->data,
> -

can we really delete these??

Cheers,

Auke
