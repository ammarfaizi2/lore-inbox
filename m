Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264383AbUAaKcp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 05:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264457AbUAaKcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 05:32:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50105 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264383AbUAaKcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 05:32:43 -0500
Date: Sat, 31 Jan 2004 11:32:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Mans Matulewicz <cybermans@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cdrom / atapi burning bug - 2.6.1
Message-ID: <20040131103241.GV11683@suse.de>
References: <1075511134.5412.59.camel@localhost> <20040131093438.GS11683@suse.de> <1075543838.5426.1.camel@localhost> <20040131102045.GU11683@suse.de> <1075544832.5660.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075544832.5660.3.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31 2004, Mans Matulewicz wrote:
> On Sat, 2004-01-31 at 11:20, Jens Axboe wrote:
> > On Sat, Jan 31 2004, Mans Matulewicz wrote:
> > > On Sat, 2004-01-31 at 10:34, Jens Axboe wrote:
> > > > On Sat, Jan 31 2004, Mans Matulewicz wrote:
> > > > > Hi,
> > > > > After replacing my 2.4.22  with a 2.6.1 kernel I tried ATAPI cd burning.
> > > > > This totally fails. Most of the CD's are corrupt and my system totally
> > > > > locks up when erasing an cdrw (reset button was the option I needed to
> > > > > reboot my system) . k3b reports cd is completely burned but fails are
> > > > > not identical or totally unreadable. I tried it both with an tainted
> > > > > (nvidia) and an untainted (nv) kernel: same results. With ide-scsi
> > > > > burning in 2.4.x I had no problems. 
> > > > 
> > > > Did you use DMA in 2.4 as well? Does 2.6 work if you turn it off? It's
> > > > most likely an issue with your via adapter.
> > > 
> > > I used DMA in 2.4.
> > > 
> > > I tried without dma on but it still totally locks my system while
> > > erasing an rw.
> > 
> > Do you really have an SMP box, or are you just using an SMP kernel? If
> > you have SMP, it would be interesting to enable the nmi watchdog (if it
> > works on your system).
> > 
> > Are you using preempt?
> 
> Its just an smp kernel. I only have one cpu.
> 
> Preempt is enabled in kernel

Could you try disabling preempt?

-- 
Jens Axboe

