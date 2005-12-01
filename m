Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVLAOfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVLAOfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 09:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVLAOfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 09:35:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44076 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932251AbVLAOfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 09:35:31 -0500
Date: Thu, 1 Dec 2005 15:36:55 +0100
From: Jens Axboe <axboe@suse.de>
To: Dirk Henning Gerdes <mail@dirk-gerdes.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] linux-2.6-block: deactivating pagecache for benchmarks
Message-ID: <20051201143655.GA2835@suse.de>
References: <1133443051.6110.32.camel@noti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133443051.6110.32.camel@noti>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01 2005, Dirk Henning Gerdes wrote:
> Hi Jens!
> 
> For doing benchmarks on the I/O-Schedulers, I thought it would be very
> useful to disable the pagecache.
> 
> I didn't want to make it so complicated so I just mark pages as
> not-uptodate, so they have to be read again. Another reason was, that I
> wanted to keep the conditions as near to reality as possible.
> 
> Further I thought it would be useful, if you could turn the pagecache on
> and off without rebooting the system.
> 
> I implemented a proc-fs entry "/proc/benchmark/pagecache" for this.
> 
> Probably this patch can be useful for anyone else, who wants to do  some
> benchmarks on block-layer stuff.
> And if not, I would appreciate if you could have a look on it.

This is rather odd, if you ask me, I don't like it. If you are doing
serious benchmarking, you do it on a seperate disk / file system which
you can just umount/mount before starting over. Or you reboot the
machine in between.

-- 
Jens Axboe

