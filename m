Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269276AbUINLPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269276AbUINLPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269087AbUINLNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:13:04 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:44476 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269273AbUINLJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:09:07 -0400
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: "C.Y.M." <syphir@syphir.sytes.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040914060628.GC2336@suse.de>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAjtLAU+gqyUq8AePOBiNtXQEAAAAA@syphir.sytes.net>
	 <20040914060628.GC2336@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095156346.16572.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Sep 2004 11:05:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-14 at 07:06, Jens Axboe wrote:
> Alan, I bet there are a lot of these. Maybe we should consider letting
> the user manually flag support for FLUSH_CACHE, at least it is in their
> hands then.

You are assuming the drive supports "FLUSH_CACHE" just because it
doesn't error it. Thats a good way to have accidents. 

The patch I posted originally did turn wcache off for barrier if no
flush cache support was present but had a small bug so that bit got
dropped.


