Return-Path: <linux-kernel-owner+w=401wt.eu-S1754915AbXACH3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915AbXACH3k (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 02:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754905AbXACH3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 02:29:40 -0500
Received: from brick.kernel.dk ([62.242.22.158]:14179 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754867AbXACH3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 02:29:39 -0500
Date: Wed, 3 Jan 2007 08:32:26 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] block: remove BKL dependency from drivers/block/loop.c
Message-ID: <20070103073226.GF11203@kernel.dk>
References: <20061227115207.GA20721@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227115207.GA20721@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27 2006, Ingo Molnar wrote:
> Subject: [patch] block: remove BKL dependency from drivers/block/loop.c
> From: Ingo Molnar <mingo@elte.hu>
> 
> the block loopback device is protected by lo->lo_ctl_mutex and it does 
> not need to hold the BKL anywhere. Convert its ioctl to unlocked_ioctl 
> and remove the BKL acquire/release from its compat_ioctl.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Acked-by: Jens Axboe <jens.axboe@oracle.com>

-- 
Jens Axboe

