Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbUCGKfx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 05:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbUCGKfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 05:35:52 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9638 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261803AbUCGKfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 05:35:43 -0500
Date: Sun, 7 Mar 2004 11:35:42 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 ide-cd DMA ripping
Message-ID: <20040307103542.GD23525@suse.de>
References: <20040303113756.GQ9196@suse.de> <6ufzcmm5qt.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ufzcmm5qt.fsf@zork.zork.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06 2004, Sean Neakums wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> > Hi,
> >
> > 2.6 still uses PIO for CDROMREADAUDIO cdda ripping, which is less than
> > optimal of course... This patch uses the block layer infrastructure to
> > enable zero copy DMA ripping through CDROMREADAUDIO.
> >
> > I'd appreciate people giving this a test spin. Patch is against
> > 2.6.4-rc1 (well current BK, actually).
> 
> Applied successfully to 2.6.4-rc1-mm2, and it works great.  For some
> reason, on two different machines, ripping with cdparanoia used to
> somehow crowd out the serial port, but now everything just works.

cd ripping was highly cpu intensive when it ran in pio, so it's very
likely that this screwed up your serial port communication. It doesn't
matter with the patch, but had you used hdparm -u1 on your cd device
on an unpatched kernel, you would have had better luck.

-- 
Jens Axboe

