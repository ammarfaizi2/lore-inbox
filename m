Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWF3AoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWF3AoK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWF3AoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:44:09 -0400
Received: from palrel12.hp.com ([156.153.255.237]:43981 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1751338AbWF3AoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:44:07 -0400
Message-ID: <44A473D5.70809@hp.com>
Date: Thu, 29 Jun 2006 17:44:05 -0700
From: Rick Jones <rick.jones2@hp.com>
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.6) Gecko/20040304
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Cc: bos@pathscale.com, akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 39 of 39] IB/ipath - use streaming copy in RDMA	interrupt
 handler to reduce packet loss
References: <1151624063.10886.34.camel@chalcedony.pathscale.com>	<20060629.164623.59469884.davem@davemloft.net>	<44A47042.8060203@hp.com> <20060629.173206.48800902.davem@davemloft.net>
In-Reply-To: <20060629.173206.48800902.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> From: Rick Jones <rick.jones2@hp.com>
> Date: Thu, 29 Jun 2006 17:28:50 -0700
> 
> 
>>I thought that most PCI controllers (that is to say the things bridging 
>>PCI to the rest of the system) could do prefetching and/or that PCI-X 
>>(if not PCI, no idea about PCI-e) cards could issue multiple 
>>transactions anyway?
> 
> 
> People doing deep CMT chips have found out that all of that
> prefetching and store buffering is unnecessary when everything is so
> tightly integrated.

Then is prefetching in memcpy really that important to them (BTW besides 
  Sun/Niagra who are doing "deep CMT"?)

> All of the previous UltraSPARC boxes before Niagara had a
> streaming cache sitting on the PCI controller.  It basically
> prefetched for reads and collected writes from PCI devices
> into cacheline sized chunks.
> 
> The PCI controller in the current Niagara systems has none of that
> stuff.

Relying on PCI-X devices to issue multiple requests then?

rick jones
