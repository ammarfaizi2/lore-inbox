Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269045AbUINGID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269045AbUINGID (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 02:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269063AbUINGID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 02:08:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58292 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269045AbUINGIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 02:08:00 -0400
Date: Tue, 14 Sep 2004 08:06:29 +0200
From: Jens Axboe <axboe@suse.de>
To: "C.Y.M." <syphir@syphir.sytes.net>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
Message-ID: <20040914060628.GC2336@suse.de>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAjtLAU+gqyUq8AePOBiNtXQEAAAAA@syphir.sytes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAjtLAU+gqyUq8AePOBiNtXQEAAAAA@syphir.sytes.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13 2004, C.Y.M. wrote:
> After installing 2.6.9-rc2 on my PC today (x86 VIA Chipset motherboard and
> Athlon XP CPU), The IDE detection during boot in probing for ide2-5 and
> displaying errors, and the hard drives that it does find are telling me that
> "hda: cache flushes not supported" (when they are displayed as supported
> when using 2.6.9-rc1.

Your drive doesn't advertise FLUSH_CACHE support, the model for when we
use these commands changed between -rc1 and -rc2. This essentially means
that you have to turn off write back caching for safe operations on a
journalled drive.

Alan, I bet there are a lot of these. Maybe we should consider letting
the user manually flag support for FLUSH_CACHE, at least it is in their
hands then.

-- 
Jens Axboe

