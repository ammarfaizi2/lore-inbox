Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265294AbUAAE7n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 23:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265299AbUAAE7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 23:59:43 -0500
Received: from eldar.tcsn.co.za ([196.41.199.50]:6669 "EHLO tcsn.co.za")
	by vger.kernel.org with ESMTP id S265294AbUAAE7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 23:59:41 -0500
Date: Thu, 1 Jan 2004 06:57:35 +0200
From: Henti Smith <henti@geekware.co.za>
To: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Cc: mmastrac@canada.com
Subject: Re: error message in dmesg
Message-Id: <20040101065735.10caf986.henti@geekware.co.za>
In-Reply-To: <20040101055355.57a3ddf2.henti@geekware.co.za>
References: <20040101052029.40b10f87.henti@geekware.co.za>
	<1072928707.7243.20.camel@nosferatu.lan>
	<20040101055355.57a3ddf2.henti@geekware.co.za>
Organization: geekware
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jan 2004 05:53:55 +0200
Henti Smith <henti@geekware.co.za> wrote:

> ------------[ cut here ]------------
> kernel BUG at mm/slab.c:1268!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c0138825>]    Not tainted
> EFLAGS: 00010202
> EIP is at kmem_cache_create+0x3c5/0x4cc
> eax: 0000002c   ebx: dfff3498   ecx: c04d30f8   edx: dc6cc000
> esi: c03d3b4d   edi: e0a03d44   ebp: dc6cdf64   esp: dc6cdf34
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 3524, threadinfo=dc6cc000 task=dc70e080)
> Stack: c03aacc0 e0a03d3b 00002000 dc6cdf54 dfe1d794 c0000000 dfe1d758 ffffff80 
>        00000000 00000000 00000004 e0a13c80 dc6cdfbc e0a1511d e0a03d3b 00000080 
>        00000080 00002000 00000000 00000000 c040d3b0 dc6cc000 e0a1500c c040d3b0 
> Call Trace:
>  [<e0a1511d>] scsi_init_queue+0x47/0xca [scsi_mod]
>  [<e0a1500c>] init_scsi+0xc/0xd6 [scsi_mod]
>  [<c0131063>] sys_init_module+0x135/0x27b
>  [<c0109233>] syscall_call+0x7/0xb
> 
> Code: 0f 0b f4 04 d2 a4 3a c0 8b 0b e9 71 ff ff ff 8b 47 34 c7 04 

Upgrading to 2.6.1-rc1-mm1 solves this problem for me, no more kernel BUG report. Maybe try this patchset Matt ? 

-- 
Henti Smith
henti@geekware.co.za
Co-Owner
+27 82 958 2525
http://www.geekware.co.za
