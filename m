Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbUKDSV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbUKDSV3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 13:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbUKDSU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 13:20:58 -0500
Received: from shinjuku.zaphods.net ([194.97.108.52]:50873 "EHLO
	shinjuku.zaphods.net") by vger.kernel.org with ESMTP
	id S262345AbUKDSTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 13:19:05 -0500
Date: Thu, 4 Nov 2004 19:18:57 +0100
From: Stefan Schmidt <zaphodb@zaphods.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures (Part 2)
Message-ID: <20041104181856.GE28163@zaphods.net>
References: <20041103222447.GD28163@zaphods.net> <20041104121722.GB8537@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104121722.GB8537@logos.cnet>
X-Origin-AS: AS5430
X-NCC-nic-hdl: ZAP-RIPE
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: zaphodb@zaphods.net
X-SA-Exim-Scanned: No (on shinjuku.zaphods.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 10:17:22AM -0200, Marcelo Tosatti wrote:
> What is min_free_kbytes default on your machine?
I think it was 768, definitely around 700-800.
2.6.9 said:
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 4058200k/4095936k available (2005k kernel code, 36816k reserved, 995k
data, 196k init, 3178432k highmem)

> > I tried the following kernels: 2.6.9-mm1, 2.6.10-rc1-bk12, 2.6.9-rc3-bk6,
> > 2.6.9-rc3-bk5 all of which froze at some point presenting me only with the
> > above page allocation failure. (no more sysrq) 
> This should be harmless as Andrew said - it would be helpful if you could 
> plug a serial cable to the box - this last oops on the picture doesnt say 
> much.
Well right now the machine is running 2.4.28-rc1 with the 3w-9nnn patch by
Adam Radford from this list and i would like to see it run stable for about a
day before i give 2.6 another try. I think i'll have a terminal server hooked
up by then.

> How intense is the network traffic you're generating?
I was around 60-80 mbit/s each direction at i think 16k interrupts/s.

With 2.4.28-rc1 this is currently at 180mbit/s 27kpps up, 116mbit/s 24kpps down 
still swapping a bit but no kernel messages on this, just around 1.7 rx
errors/s.

> 2.6.7 was stable under the same load?
No, sorry to give you this impression, 2.6.7 is just what some of my collegues
and i consider the more stable 2.6 kernel under heavy i/o load.

> Something is definately screwed, and there are quite an amount of 
> similar reports.
Can i tell people its ok to see nf_hook_slow in the stack trace as it's
vm-related? A collegue was quite bluffed when i showed him. ;)

> XFS also seems to be very memory hungry...
I have 8 XFS-Filesystems in use here with several thousand files from some k to
your 'usual' 4GB DVD-image. XFS built as a module at first and then inline but
that did not change anything off course. 2x200 + 6x250GB that is.

	Stefan
