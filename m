Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTJRA6u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 20:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbTJRA6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 20:58:50 -0400
Received: from CPE-144-132-162-109.nsw.bigpond.net.au ([144.132.162.109]:13046
	"EHLO tigers-lfs.local") by vger.kernel.org with ESMTP
	id S261262AbTJRA6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 20:58:49 -0400
Date: Sat, 18 Oct 2003 10:57:32 +1000
From: Greg Schafer <gschafer@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: DEBUG - test8
Message-ID: <20031018005732.GA17726@tigers-lfs.nsw.bigpond.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

Booting -test8 I get these in syslog:

Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
Debug: sleeping function called from invalid context at mm/slab.c:1857

Didn't happen with -test7.

Detailed output attached.

Thanks
Greg
(not subscribed)

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="debug.log"

Oct 18 10:17:33 tigers-lfs kernel: Console: colour VGA+ 132x43
Oct 18 10:17:33 tigers-lfs kernel: Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
Oct 18 10:17:33 tigers-lfs kernel: in_atomic():1, irqs_disabled():1
Oct 18 10:17:33 tigers-lfs kernel: Call Trace:
Oct 18 10:17:33 tigers-lfs kernel:  [__might_sleep+157/176] __might_sleep+0x9d/0xb0
Oct 18 10:17:33 tigers-lfs kernel:  [acquire_console_sem+45/80] acquire_console_sem+0x2d/0x50
Oct 18 10:17:33 tigers-lfs kernel:  [register_console+277/416] register_console+0x115/0x1a0
Oct 18 10:17:33 tigers-lfs kernel:  [con_init+472/496] con_init+0x1d8/0x1f0
Oct 18 10:17:33 tigers-lfs kernel:  [rest_init+0/96] _stext+0x0/0x60
Oct 18 10:17:33 tigers-lfs kernel:  [console_init+36/64] console_init+0x24/0x40
Oct 18 10:17:33 tigers-lfs kernel:  [start_kernel+211/368] start_kernel+0xd3/0x170
Oct 18 10:17:33 tigers-lfs kernel:
Oct 18 10:17:33 tigers-lfs kernel: Memory: 1033576k/1048064k available (1763k kernel code, 13496k reserved, 681k data, 328k init, 130496k highmem)
Oct 18 10:17:33 tigers-lfs kernel: Debug: sleeping function called from invalid context at mm/slab.c:1857
Oct 18 10:17:33 tigers-lfs kernel: in_atomic():1, irqs_disabled():0
Oct 18 10:17:33 tigers-lfs kernel: Call Trace:
Oct 18 10:17:33 tigers-lfs kernel:  [__might_sleep+157/176] __might_sleep+0x9d/0xb0
Oct 18 10:17:33 tigers-lfs kernel:  [kmem_cache_alloc+32/112] kmem_cache_alloc+0x20/0x70
Oct 18 10:17:33 tigers-lfs kernel:  [rest_init+0/96] _stext+0x0/0x60
Oct 18 10:17:33 tigers-lfs kernel:  [kmem_cache_create+104/1280] kmem_cache_create+0x68/0x500
Oct 18 10:17:33 tigers-lfs kernel:  [rest_init+0/96] _stext+0x0/0x60
Oct 18 10:17:33 tigers-lfs kernel:  [rest_init+0/96] _stext+0x0/0x60
Oct 18 10:17:33 tigers-lfs kernel:  [kmem_cache_init+250/640] kmem_cache_init+0xfa/0x280
Oct 18 10:17:33 tigers-lfs kernel:  [rest_init+0/96] _stext+0x0/0x60
Oct 18 10:17:33 tigers-lfs kernel:  [start_kernel+232/368] start_kernel+0xe8/0x170

--jRHKVT23PllUwdXP--
