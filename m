Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbUAOQoN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 11:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265171AbUAOQoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 11:44:13 -0500
Received: from wilma.widomaker.com ([204.17.220.5]:50706 "EHLO
	wilma.widomaker.com") by vger.kernel.org with ESMTP id S265170AbUAOQoK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 11:44:10 -0500
Date: Thu, 15 Jan 2004 10:58:17 -0500
From: Charles Shannon Hendrix <shannon@widomaker.com>
To: linux-kernel@vger.kernel.org
Subject: Re: VIA and NVIDIA
Message-ID: <20040115155817.GD25550@widomaker.com>
References: <1074106424.6839.15.camel@applehead> <20040114201637.566a9330@Genbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114201637.566a9330@Genbox>
X-Message-Flag: Microsoft Loves You!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, 14 Jan 2004 @ 20:16 +0100, Nuno Alexandre said:

> Hi Eddie.
> I have Asus A7V, KT 333
> AMD 1800+
> Gforce 2gts
> 768 DDR Kingston
> 
> settings on
> pre-empt
> AGPART
> 
> not using framebuffer.
> As you see, very similar setup, apart from the riva fb.  But I have
> had  a framebuffer working with help from some patches available on
> the gentoo forums, but they don't work on the latest kernel build. So
> i dropped it.

You are using framebuffer with the commercial nVidia driver? I didn't
think you could do that.

I run kernel 2.6.1 and the 4620 version of the commercial driver.
The only problem so far is a lot of messages in the logs like
this:

Jan 15 02:05:25 daydream kernel: Debug: sleeping function called from invalid co
ntext at mm/page_alloc.c:550
Jan 15 02:05:25 daydream kernel: in_atomic():1, irqs_disabled():0
Jan 15 02:05:25 daydream kernel: Call Trace:
Jan 15 02:05:25 daydream kernel:  [<c011ad8b>] __might_sleep+0xab/0xd0
Jan 15 02:05:25 daydream kernel:  [<c013aa45>] __alloc_pages+0x365/0x370
Jan 15 02:05:25 daydream kernel:  [<c01192f9>] scheduler_tick+0x489/0x4a0
Jan 15 02:05:25 daydream kernel:  [<c0117378>] pte_alloc_one+0x18/0x50
Jan 15 02:05:25 daydream kernel:  [<c0142834>] pte_alloc_map+0x44/0xd0
Jan 15 02:05:25 daydream kernel:  [<c01438b7>] remap_page_range+0xc7/0x1e0
Jan 15 02:05:25 daydream kernel:  [<d0da3cf6>] os_map_io_space+0x56/0x70 [nvidia
]
Jan 15 02:05:25 daydream kernel:  [<d0c6ceba>] __nvsym00624+0x1e/0x28 [nvidia]
Jan 15 02:05:25 daydream kernel:  [<d0c6b8f1>] __nvsym00601+0x91/0xc4 [nvidia]
Jan 15 02:05:25 daydream kernel:  [<d0c6baa2>] __nvsym00610+0x26/0x5c [nvidia]
Jan 15 02:05:25 daydream kernel:  [<d0c70db3>] rm_map_agp_pages+0x1b/0x24 [nvidi
a]
Jan 15 02:05:25 daydream kernel:  [<d0da0bad>] nv_kern_mmap+0x35d/0x380 [nvidia]
Jan 15 02:05:25 daydream kernel:  [<c0146110>] do_mmap_pgoff+0x360/0x720
Jan 15 02:05:25 daydream kernel:  [<c01100fb>] old_mmap+0x13b/0x180
Jan 15 02:05:25 daydream kernel:  [<c010921b>] syscall_call+0x7/0xb
Jan 15 02:05:25 daydream kernel:  [<c0284627>] ahc_run_qoutfifo+0x27/0xc0
Jan 15 02:05:25 daydream kernel: 

I hope nVidia releases real 2.6 drivers soon.

I have tried to get by with the nv driver, but the performance hit is
just too much, and I still use 3D apps now and then.

-- 
UNIX/Perl/C/Pizza____________________s h a n n o n@wido !SPAM maker.com
