Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVCLMVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVCLMVF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 07:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVCLMVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 07:21:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19405 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261701AbVCLMVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 07:21:00 -0500
Date: Sat, 12 Mar 2005 13:20:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3
Message-ID: <20050312122048.GP28188@suse.de>
References: <20050312034222.12a264c4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050312034222.12a264c4.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12 2005, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm3/
> 
> 
> - A new version of the "acpi poweroff fix".  People who were having trouble
>   with ACPI poweroff, please test and report.
> 
> - A very large update to the CFQ I/O scheduler.  Treat with caution, run
>   benchmarks.  Remember that the I/O scheduler can be selected on a per-disk
>   basis with 
> 
> 	echo as > /sys/block/sda/queue/scheduler

echo anticipatory > /sys/block/sda/queue/scheduler

I think it's really messy that AS is 'as' in some places and
'anticipatory' elsewhere. I would suggest we rename it to 'as' all over,
it's easier to type.

> 	echo deadline > /sys/block/sda/queue/scheduler
> 	echo cfq > /sys/block/sda/queue/scheduler

-- 
Jens Axboe

