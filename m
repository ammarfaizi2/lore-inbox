Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWGFOfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWGFOfA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 10:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWGFOfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 10:35:00 -0400
Received: from canuck.infradead.org ([205.233.218.70]:1967 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1030305AbWGFOe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 10:34:59 -0400
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
From: David Woodhouse <dwmw2@infradead.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060706161319.3ae0d9ef@cad-250-152.norway.atmel.com>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	 <1152187083.2987.117.camel@pmac.infradead.org>
	 <20060706161319.3ae0d9ef@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 15:34:52 +0100
Message-Id: <1152196492.2987.185.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 16:13 +0200, Haavard Skinnemoen wrote:
> > "DMA controller framework".... isn't that what drivers/dma was
> > recently invented for? If appropriate, you should probably use that.
> > If not, you should explain why, and perhaps we should get it fixed.
> 
> It was written some time before the drivers/dma stuff. I suppose I
> should try to use the DMA subsystem instead.
> 
> As I understand it, though, drivers/dma is mostly for memory-to-memory
> to transfers, while what I really need is memory-to-hardware and
> hardware-to-memory transfers.

With MMIO those are just a not-so-special case of memory-memory, surely?
If the new framework doesn't support that, it probably _should_.

> > You're a bit behind on syscall support -- I note you have
> > TIF_RESTORE_SIGMASK (which means you're ahead of x86_64) but you
> > haven't wired up ppoll() and pselect(), amongst others.
> 
> I'll sync up with i386. By the way, are there any syscalls I
> _shouldn't_ have wired up? It's probably too late to remove any of them
> at this point, but if we get it sorted out quickly, we might get away
> with a shorter grace period than usual... 

Looks OK -- I don't see any of the obvious ones like oldstat, oldfstat,
etc.

-- 
dwmw2

