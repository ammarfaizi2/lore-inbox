Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbVHHRLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVHHRLd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbVHHRLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:11:33 -0400
Received: from colin.muc.de ([193.149.48.1]:6662 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932116AbVHHRLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:11:32 -0400
Date: 8 Aug 2005 19:11:26 +0200
Date: Mon, 8 Aug 2005 19:11:26 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-scsi@vger.kernel.org
Subject: Re: 2.6.13-rc5-mm1 doesnt boot on x86_64
Message-ID: <20050808171126.GA32092@muc.de>
References: <20050808094818.A17579@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808094818.A17579@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 09:48:19AM -0700, Ashok Raj wrote:
> Folks,
> 
> Iam getting this on the recent 2.6.12-rc5-mm1 kernel built with defconfig. 
> 
> Cheers,
> Ashok Raj
> 
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at "include/linux/list.h":165
> invalid operand: 0000 [1] SMP
> CPU 2
> Modules linked in:
> Pid: 1, comm: swapper Not tainted 2.6.13-rc5-mm1
> RIP: 0010:[<ffffffff802b9ef4>] <ffffffff802b9ef4>{attribute_container_unregist}RSP: 0018:ffff8100bfb63f00  EFLAGS: 00010283
> RAX: ffff8100bfbd4c58 RBX: ffff8100bfbd4c00 RCX: ffffffff804e6600
> RDX: 0000000000200200 RSI: 0000000000000000 RDI: ffffffff804e6600
> RBP: 0000000000000000 R08: ffff8100bfbd4c48 R09: 0000000000000020
> R10: 0000000000000000 R11: ffffffff8019baa0 R12: ffffffff80100190
> R13: 00000000ffffffff R14: 0000ffffffff8010 R15: ffffffff80627fb0
> FS:  0000000000000000(0000) GS:ffffffff80616980(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006e0
> Process swapper (pid: 1, threadinfo ffff8100bfb62000, task ffff8100bfb614d0)
> Stack: ffffffff8032643d 0000000000000000 ffffffff8064499f ffffffff80100190
>        ffffffff80651288 0000000000000000 ffffffff8010b249 0000000000000246
>        0000000000020800 ffffffff804ae180
> Call Trace:<ffffffff8032643d>{spi_release_transport+13} <ffffffff8064499f>{ahd}       <ffffffff8010b249>{init+505} <ffffffff8010e896>{child_rip+8}
>        <ffffffff8010b050>{init+0} <ffffffff8010e88e>{child_rip+0}

Looks like a SCSI problem. The machine has an Adaptec SCSI adapter, right?

-AndI
> 
> 
> Code: 0f 0b a3 e1 d9 44 80 ff ff ff ff c2 a5 00 49 8b 00 4c 39 40
> RIP <ffffffff802b9ef4>{attribute_container_unregister+52} RSP <ffff8100bfb63f0> <0>Kernel panic - not syncing: Attempted to kill init!
> 
