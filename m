Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbULMR6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbULMR6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 12:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbULMR6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 12:58:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42183 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261299AbULMR6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 12:58:00 -0500
Date: Mon, 13 Dec 2004 18:57:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Time sliced cfq with basic io priorities
Message-ID: <20041213175721.GA2721@suse.de>
References: <20041213125046.GG3033@suse.de> <20041213130926.GH3033@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213130926.GH3033@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13 2004, Jens Axboe wrote:
> On Mon, Dec 13 2004, Jens Axboe wrote:
> > 2.6.10-rc2-mm4 patch:
> 
> So 2.6.10-rc3-mm1 is out I notice, here's a patch for that:
> 
> http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3-mm1/cfq-time-slices-10-2.6.10-rc3-mm1.gz
> 
> And an updated ionice.c attached, the syscall numbers changed.

Posted -11 for -mm and -BK as well. Changes:

- Preemption fairness fixes

- Enable preemption

For 2.6.10-rc3-mm1:

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3-mm1/cfq-time-slices-11-2.6.10-rc3-mm1.gz

For 2.6-BK:

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3/cfq-time-slices-11.gz

Note that the syscall numbers are different yet again, I will
consolidate these on next release. For now, find your sys_ioprio_set/get
numbers from include/asm-<your arch/unistd.h and change ionice for your
arch appropriately (if in doubt, just mail me).

-- 
Jens Axboe

