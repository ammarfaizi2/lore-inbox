Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTE0OYH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 10:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTE0OYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 10:24:07 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:5384 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S263638AbTE0OYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 10:24:04 -0400
Date: Tue, 27 May 2003 16:37:05 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Willy Tarreau <willy@w.ods.org>, Jason Papadopoulos <jasonp@boo.net>,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Linux 2.4.21-rc3 : IDE pb on Alpha
Message-ID: <20030527143705.GA27846@alpha.home.local>
References: <5.2.1.1.2.20030526232835.00a468e0@boo.net> <20030527045302.GA545@alpha.home.local> <20030527134017.B3408@jurassic.park.msu.ru> <20030527123152.GA24849@alpha.home.local> <20030527180403.A2292@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030527180403.A2292@jurassic.park.msu.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 06:04:03PM +0400, Ivan Kokshaysky wrote:
> On Tue, May 27, 2003 at 02:31:52PM +0200, Willy Tarreau wrote:
> > Sorry, I pasted the .config that I used just after, and which allowed me to
> > boot. Later I set CONFIG_BLK_DEV_ALI15X3 again and CONFIG_BLK_DEV_IDEDMA_PCI,
> > but I left CONFIG_IDEDMA_PCI_AUTO disabled. I now can boot and enable DMA
> > later. That's weird, but it works.
> 
> Perhaps not that weird. From my experience, ALi DMA is sensitive to
> some of "PIO timings". That is, if SRM hasn't initialized the chipset
> properly (on Nautilus it has, BTW), DMA won't work. When you boot with
> DMA disabled, driver has to set right PIO mode, so you can safely
> enable DMA later.
> 
> Can you (and Jason) try this patch with CONFIG_IDEDMA_PCI_AUTO=y?

Compilation in progress, but it will wait for me to get in touch with the
machine to reboot it (probably this evening).

Cheers,
Willy

