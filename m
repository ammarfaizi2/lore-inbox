Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbUCVDuz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 22:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbUCVDuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 22:50:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:38303 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261670AbUCVDut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 22:50:49 -0500
Date: Sun, 21 Mar 2004 19:50:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Shawn Starr" <shawn.starr@rogers.com>
Cc: linux-kernel@vger.kernel.org, Kai.Makisara@kolumbus.fi
Subject: Re: [PANIC][2.6.5-rc2-bk1] st_probe - Detection of a SCSI tape
 drive (HP Colorado T4000s) - Dump included now
Message-Id: <20040321195049.18453e7c.akpm@osdl.org>
In-Reply-To: <000001c40fbd$add66100$030aa8c0@PANIC>
References: <000001c40fbd$add66100$030aa8c0@PANIC>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Shawn Starr" <shawn.starr@rogers.com> wrote:
>
> Here is the captured dump, the st driver appears to be broken:

You don't tell us which is the last kernel verison which was known to work
OK.

> st: Version 20040226, fixed bufsize 32768, s/g segs 256
> Unable to handle kernel NULL pointer dereference at virtual address 0000002e
>  printing eip:
> e48640fb
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT DEBUG_PAGEALLOC
> CPU:    0
> EIP:    0060:[<e48640fb>]    Not tainted
> EFLAGS: 00010282   (2.6.5-rc2-bk1)
> EIP is at do_create_class_files+0x9b/0x130 [st]
> eax: e1be2e74   ebx: ffffffea   ecx: e3febf78   edx: e4867fc8
> esi: 00000000   edi: e1be2df8   ebp: 00000000   esp: e1b0fe6c
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 439, threadinfo=e1b0e000 task=e2ae29e0)
> Stack: e239ef38 00900000 e3376da4 e486479b e1c5a71c 00000000 00000002
> 00000004
>        e1c5a640 e1be2e74 e4863941 e239cf04 e48646c9 00000000 c0187e09
> e19cef38
>        00000000 e1be2e74 c01920ec 405e5d3a 00000000 e1be2df8 00000000
> 00000000
> Call Trace:
>  [<e4863941>] st_probe+0x501/0x800 [st]
>  [<c0187e09>] __lookup_hash+0x89/0xb0
>  [<c01920ec>] dput+0x1c/0x710
>  [<c01bd502>] sysfs_create_dir+0x32/0x70
>  [<c0252f12>] bus_match+0x32/0x60
>  [<c0253029>] driver_attach+0x59/0x90
>  [<c01f0b12>] kobject_register+0x22/0x60
>  [<c02532e1>] bus_add_driver+0x91/0xb0
>  [<c0253700>] driver_register+0x80/0x90
>  [<e486a088>] init_st+0x88/0xcb [st]
>  [<c0144e2f>] sys_init_module+0x1df/0x3a0
>  [<c01718ff>] filp_close+0x4f/0x80
>  [<c0107dd9>] sysenter_past_esp+0x52/0x71
> 
> Code: 89 43 44 89 d8 e8 cb f7 9e db ba dc 7f 86 e4 89 d8 e8 bf f7
> 
> -----Original Message-----
> From: Shawn Starr [mailto:shawn.starr@rogers.com] 
> Sent: Sunday, March 21, 2004 09:45 PM
> To: 'linux-kernel@vger.kernel.org'
> Subject: [PANIC][2.6.5-rc2-bk1] st_probe - Detection of a SCSI tape drive
> (HP Colorado T4000s)
> 
> 
> Apon booting 2.6.5-rc2-bk1, during detection of the SCSI tape drive, the
> kernel panics
> 
> The backtrace is:
> 
> st_probe
> __lockup_hash
> dput
> sysfs_create_dir
> bus_match
> driver_match
> kobject_register
> bus_add_driver
> driver_register
> init_st
> do_initcalls
> init
> init
> kernel_thread_helper
> 
> Is this known? I will revert to my previous kernel 
> 
> Shawn.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
