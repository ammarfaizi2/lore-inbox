Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbTLaQRB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 11:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265210AbTLaQRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 11:17:01 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:10943 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265207AbTLaQQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 11:16:59 -0500
Date: Wed, 31 Dec 2003 10:34:59 -0500
From: Ben Collins <bcollins@debian.org>
To: Robert Gadsdon <robert@gadsdon.giointernet.co.uk>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1-mm1 - ieee1394 broken again?
Message-ID: <20031231153459.GN5570@phunnypharm.org>
References: <3FF2EFF3.6010001@gadsdon.giointernet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF2EFF3.6010001@gadsdon.giointernet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ohci1394: $Rev: 1087 $ Ben Collins <bcollins@debian.org>
> ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[18] 
> MMIO=[febfe800-febfefff]  Max Packet=[2048]
> raw1394: /dev/raw1394 device initialized
> blk: queue c1343200, I/O limit 4095Mb (mask 0xffffffff)
> blk: queue c1333e00, I/O limit 4095Mb (mask 0xffffffff)
> ieee1394: Host added: ID:BUS[0-00:1023]  GUID[090050c50000046f]
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> c028301e
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT SMP
> CPU:    1
> EIP:    0060:[<c028301e>]    Not tainted VLI
> EFLAGS: 00010282
> EIP is at vt_ioctl+0x1e/0x1ec0
> eax: 00000000   ebx: 00005401   ecx: bffffbec   edx: bffffbec
> esi: c0283000   edi: cfb5b000   ebp: cf53b2c0   esp: cfb31eb0
> ds: 007b   es: 007b   ss: 0068
> Process rc (pid: 1467, threadinfo=cfb30000 task=cfb426c0)
> Stack: cfb31f70 cffe6220 00000000 00000000 cf06ece0 cfd0c600 00000001 
> cfb30000
>        cf0354f0 cf036cc0 4f106e70 c01520df cf036cc0 cf9e44a0 4f106e70 
> 00000000
>        cf0a7418 cf0354f0 00008802 cf036cc0 cf036ce0 cf9e44a0 cfb426c0 
> c011beac
> Call Trace:
>  [<c01520df>] handle_mm_fault+0x10f/0x1c0
>  [<c011beac>] do_page_fault+0x33c/0x530
>  [<c0160564>] dentry_open+0x1e4/0x230
>  [<c0283000>] vt_ioctl+0x0/0x1ec0
>  [<c027d9a0>] tty_ioctl+0x480/0x590
>  [<c01756a7>] sys_ioctl+0x117/0x2c0
>  [<c036c59e>] sysenter_past_esp+0x43/0x65

Not sure how vt/tty stuff relates to ieee1394.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
