Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUFXOnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUFXOnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 10:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbUFXOnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 10:43:04 -0400
Received: from cantor.suse.de ([195.135.220.2]:13037 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264704AbUFXOnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 10:43:00 -0400
Date: Thu, 24 Jun 2004 16:42:58 +0200
From: Andi Kleen <ak@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: ak@muc.de, tripperda@nvidia.com, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-Id: <20040624164258.1a1beea3.ak@suse.de>
In-Reply-To: <s5h4qp1hvk0.wl@alsa2.suse.de>
References: <m3acyu6pwd.fsf@averell.firstfloor.org>
	<20040623213643.GB32456@hygelac>
	<20040623234644.GC38425@colin2.muc.de>
	<s5hhdt1i4yc.wl@alsa2.suse.de>
	<20040624112900.GE16727@wotan.suse.de>
	<s5h4qp1hvk0.wl@alsa2.suse.de>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2004 16:36:47 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 24 Jun 2004 13:29:00 +0200,
> Andi Kleen wrote:
> > 
> > > Can't it be called with GFP_KERNEL at first, then with GFP_DMA if the
> > > allocated pages are out of dma mask, just like in pci-gart.c?
> > > (with ifdef x86-64)
> > 
> > That won't work reliable enough in extreme cases.
> 
> Well, it's not perfect, but it'd be far better than GFP_DMA only :)

The only description for this patch I can think of is "russian roulette" 

-Andi
