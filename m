Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbVLUH2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVLUH2S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 02:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVLUH2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 02:28:18 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:20883 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932306AbVLUH2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 02:28:17 -0500
Date: Wed, 21 Dec 2005 10:28:05 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Chris Leech <christopher.leech@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>
Subject: Re: [RFC][PATCH 1/5] I/OAT DMA support and TCP acceleration
Message-ID: <20051221072805.GA15850@2ka.mipt.ru>
References: <1135142254.13781.18.camel@cleech-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135142254.13781.18.camel@cleech-mobl>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 21 Dec 2005 10:28:06 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 09:17:34PM -0800, Chris Leech (christopher.leech@intel.com) wrote:
> DMA memcpy subsystem
> Provides an API for offloading memory copies to DMA devices.
> Along with client registration and DMA channel allocation, the main APIs are:
> 	dma_async_memcpy_buf_to_buf()
> 	dma_async_memcpy_buf_to_pg()
> 	dma_async_memcpy_pg_to_pg()
> 	dma_async_memcpy_complete()

Is here at least some locking?
All dma chain/engine list manipulations seem very suspicious.


-- 
	Evgeniy Polyakov
