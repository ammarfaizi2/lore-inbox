Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTEIQSj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 12:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbTEIQSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 12:18:39 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:59914 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263285AbTEIQSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 12:18:38 -0400
Date: Fri, 9 May 2003 18:27:52 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Willy Tarreau <willy@w.ods.org>, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-ID: <20030509162752.GA18661@alpha.home.local>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva> <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com> <20030509120659.GA15754@alpha.home.local> <20030509150207.3ff9cd64.skraw@ithnet.com> <20030509132757.GA16649@alpha.home.local> <20030509154637.5cf14c8d.skraw@ithnet.com> <20030509145621.GA17581@alpha.home.local> <1052492883.1529.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052492883.1529.4.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 05:08:03PM +0200, Arjan van de Ven wrote:
> > ull on 32 bits archs, because addr is
> > a bus_addr_t which is in turn dma_addr_t which itself is u32. So unless I don't
> > find the trick this would mean that this code should never be executed. Perhaps
> 
> dma_addr_t is either u32 or u64 on x86

Yes Arjan, but it's u64 only if CONFIG_HIGHMEM is set. So I repost my question
in another way : is this code supposed to be executed when CONFIG_HIGHMEM=n
since (u32)(~0xFFFFFFFF) = 0 ?

Regards,
Willy

