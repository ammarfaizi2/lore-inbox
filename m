Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTE0MTC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263328AbTE0MTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:19:02 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:4104 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S263319AbTE0MTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:19:01 -0400
Date: Tue, 27 May 2003 14:31:52 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Willy Tarreau <willy@w.ods.org>, Jason Papadopoulos <jasonp@boo.net>,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Linux 2.4.21-rc3 : IDE pb on Alpha
Message-ID: <20030527123152.GA24849@alpha.home.local>
References: <5.2.1.1.2.20030526232835.00a468e0@boo.net> <20030527045302.GA545@alpha.home.local> <20030527134017.B3408@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030527134017.B3408@jurassic.park.msu.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 01:40:17PM +0400, Ivan Kokshaysky wrote:
> On Tue, May 27, 2003 at 06:53:02AM +0200, Willy Tarreau wrote:
> > I realized that a "idex=nodma" option is really lacking here. Shouldn't we
> > disable IDE by default on Alpha at the moment, so that it at least boots ?
> 
> According to your .config and dmesg output, you didn't have the
> chipset driver compiled in (CONFIG_BLK_DEV_ALI15X3).
> Naturally, you would have troubles with DMA.

Sorry, I pasted the .config that I used just after, and which allowed me to
boot. Later I set CONFIG_BLK_DEV_ALI15X3 again and CONFIG_BLK_DEV_IDEDMA_PCI,
but I left CONFIG_IDEDMA_PCI_AUTO disabled. I now can boot and enable DMA
later. That's weird, but it works.

Regards,
Willy

