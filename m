Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945906AbWBCTOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945906AbWBCTOw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945905AbWBCTOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:14:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26528 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945900AbWBCTOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:14:42 -0500
Date: Fri, 3 Feb 2006 11:14:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Holger Eitzenberger <holger@my-eitzenberger.de>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org,
       torvalds@osdl.org, netdev@vger.kernel.org
Subject: Re: Linux 2.6.15.2
Message-Id: <20060203111414.7026f46f.akpm@osdl.org>
In-Reply-To: <20060203120925.GA4393@kruemel.my-eitzenberger.de>
References: <20060131070642.GA25015@kroah.com>
	<20060130233427.5e7912ae.akpm@osdl.org>
	<20060203120925.GA4393@kruemel.my-eitzenberger.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holger Eitzenberger <holger@my-eitzenberger.de> wrote:
>
> On Mon, Jan 30, 2006 at 11:34:27PM -0800, Andrew Morton wrote:
> 
> > - A skbuff_head_cache leak causes oom-killings.
> > 
> > All of these only seem to affect a small minority of machines.
> 
> Hi,
> 
> I have searched for a description for the above mentioned bug report,
> but havent found any.  Can you tell me?

http://www.mail-archive.com/netdev@vger.kernel.org/msg06355.html

> The reason why I am asking that I am facing a similar problem on
> kernel 2.6.10.  During performance tests (Intel XEON, SMP, PCI-X,
> e1000, 2 - 4 Gig RAM) the machine was out of memory.
> 
> Tests showed that LowFree went linearly down to a few megabytes, where
> most of the memory was used in skb_head_cache and size-1024 slab
> caches.  These two summed up to ~270 MG, which was the reason for
> that.
> 
> /proc/net/tcp showed that most of the memory was stuck in the RX
> queues of some processes (two processes with ~1000 sockets each).
> 
> A look into /proc/sys/net/ipv4/tcp_mem showed that that the values in
> there were way to high.  I hope that a reduction of these values will
> help (not done yet).
> 

Sounds different.  Please test a more recent kernel and if the problem is
still there, send a report to linux-kernel and cc netdev@vger.kernel.org. 
Include the contents of /proc/meminfo and /proc/slabinfo.  Thanks.

