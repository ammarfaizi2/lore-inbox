Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVJ0Uoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVJ0Uoc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 16:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVJ0Uoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 16:44:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16545 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932230AbVJ0Uob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 16:44:31 -0400
Date: Thu, 27 Oct 2005 13:43:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: magnus.damm@gmail.com, clameter@sgi.com, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/4] Swap migration V3: Overview
Message-Id: <20051027134347.56d29cfa.akpm@osdl.org>
In-Reply-To: <20051027150142.GE13500@logos.cnet>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
	<aec7e5c30510201857r7cf9d337wce9a4017064adcf@mail.gmail.com>
	<20051022005050.GA27317@logos.cnet>
	<aec7e5c30510230550j66d6e37fg505fd6041dca9bee@mail.gmail.com>
	<20051024074418.GC2016@logos.cnet>
	<aec7e5c30510250437h6c300066s14e39a0c91be772c@mail.gmail.com>
	<20051025143741.GA6604@logos.cnet>
	<aec7e5c30510260004p5a3b07a9v28ae67b2982f1945@mail.gmail.com>
	<20051027150142.GE13500@logos.cnet>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> The fair approach would be to have the
>  number of pages to reclaim also relative to zone size.
> 
>  sc->nr_to_reclaim = (zone->present_pages * sc->swap_cluster_max) /
>                                  total_memory;

You can try it, but that shouldn't matter.  SWAP_CLUSTER_MAX is just a
batching factor used to reduce CPU consumption.  If you make it twice as
bug, we run DMA-zone reclaim half as often - it should balance out.  

