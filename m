Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTKZJad (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 04:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264105AbTKZJad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 04:30:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45205 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264104AbTKZJaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 04:30:25 -0500
Date: Wed, 26 Nov 2003 10:30:16 +0100
From: Jens Axboe <axboe@suse.de>
To: kernel <kernel@xenon-computing.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
Message-ID: <20031126093016.GA1062@suse.de>
References: <3FC39FF0.3060808@xenon-computing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC39FF0.3060808@xenon-computing.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25 2003, kernel wrote:
> 
> 
> Hi,
> 
> I know it's binary only, but the NVidia driver produces the folowing
> which I thought might help in determining where this problem lies.
> 
> 
> If its useful I can supply more info.
> 
> 
> Regards, Mark.
> 
> 
> Debug: sleeping function called from invalid context at mm/slab.c:1856
> in_atomic():1, irqs_disabled():0
> Call Trace:
>  [<c01202ac>] __might_sleep+0xac/0xe0
>  [<c0145a18>] kmem_cache_alloc+0x78/0x80

Not really, it just shows the nvidia driver being buggy and using a
sleeping gfp allocation mask when it should not.

-- 
Jens Axboe

