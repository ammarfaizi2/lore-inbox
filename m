Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVEOA1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVEOA1A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 20:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVEOA1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 20:27:00 -0400
Received: from pat.uio.no ([129.240.130.16]:18907 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261392AbVEOA04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 20:26:56 -0400
Subject: Re: probably NFS related Oops during shutdown with 2.6.12-rc3-mm3
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <428691E3.9040800@g-house.de>
References: <428691E3.9040800@g-house.de>
Content-Type: text/plain
Date: Sat, 14 May 2005 17:26:38 -0700
Message-Id: <1116116799.14297.29.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.99, required 12,
	autolearn=disabled, AWL 2.01, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

su den 15.05.2005 Klokka 02:03 (+0200) skreiv Christian Kujau:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> hi,
> 
> i noticed that i get an Oops during shutdown and it says something about
> rpciod/0 and i do have NFSv3 volumes mounted (and thus unmounted on
> shutdown), full log, dmesg, .config here:
> 
>     http://nerdbynature.de/bits/prinz/2.6.12-rc3-mm3/
> 
> CPU:    0
> EIP:    0060:[<00000000>]    Not tainted VLI
> EFLAGS: 00010282   (2.6.12-rc3-mm3)
> EIP is at _stext+0x3feffdd8/0x8
> eax: c1628ec0   ebx: c1628ec0   ecx: 00000000   edx: dfa600b0
> esi: 00000000   edi: c1628f34   ebp: de9327c0   esp: de413f24
> ds: 007b   es: 007b   ss: 0068
> Process rpciod/0 (pid: 8245, threadinfo=de412000 task=dfa600b0)
> 
> Stack:
> c039942b
> dfa600b0
> dfa601d8
> 00000292
> c1628f3c
> 00000297
> c1628f40
> c012b31e
> 
> 
> 00000000
> 00000000
> dffc4550
> de412000
> de9327d8
> de9327c8
> de9327d0
> de412000
> 
> 
> c1628ec0
> c0399560
> de412000
> ffffffff
> ffffffff
> 00000001
> 00000000
> c0117cf0
> 
> 
> Call Trace:
> [<c039942b>] __rpc_execute+0x14b/0x250
> [<c012b31e>] worker_thread+0x1ae/0x280
> [<c0399560>] rpc_async_schedule+0x0/0x10
> [<c0117cf0>] default_wake_function+0x0/0x10
> [<c0117d37>] __wake_up_common+0x37/0x60
> [<c0117cf0>] default_wake_function+0x0/0x10
> [<c012b170>] worker_thread+0x0/0x280
> [<c012f615>] kthread+0x95/0xd0
> [<c012f580>] kthread+0x0/0xd0
> [<c010136d>] kernel_thread_helper+0x5/0x18


That should already have been fixed in 2.6.12-rc4-mm1.

Cheers,
   Trond

