Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266855AbUHISuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266855AbUHISuJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266853AbUHIS36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:29:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:54151 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266846AbUHIS1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:27:35 -0400
Date: Mon, 9 Aug 2004 11:25:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-Id: <20040809112550.2ea19dbf.akpm@osdl.org>
In-Reply-To: <200408091122.48492.jbarnes@engr.sgi.com>
References: <20040808152936.1ce2eab8.akpm@osdl.org>
	<200408091122.48492.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> wrote:
>
> On Sunday, August 8, 2004 3:29 pm, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc3/2.6
> >.8-rc3-mm2/
> 
> Hangs on boot for me, and doesn't appear related to the dont-pass-mem_map-* 
> patches (I reverted them and got the same behavior, besides I think the 
> kernel is past paging_init at this point).  Trying to track it down.
> 
> Jesse
> 
> SGI SAL version 3.40
> Virtual mem_map starts at 0xa0007fffce938000
> Built 1 zonelists
> Kernel command line: BOOT_IMAGE=scsi0:\EFI\sgi\vmlinuz.jb root=/dev/sda3 
> console=ttySG0 console=ttyS0 ro
> PID hash table entries: 4096 (order 12: 65536 bytes)
> CPU 0: base freq=200.000MHz, ITC ratio=10/2, ITC freq=1000.000MHz+/--1ppm
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 1048576 (order: 9, 8388608 bytes)
> Inode-cache hash table entries: 524288 (order: 8, 4194304 bytes)
> Memory: 5937856k/6004928k available (7074k code, 79072k reserved, 3376k data, 
> 352k init)
> McKinley Errata 9 workaround not needed; disabling it
> Calibrating delay loop... 1481.36 BogoMIPS (lpj=722944)
> Mount-cache hash table entries: 1024 (order: 0, 16384 bytes)
> Boot processor id 0x0/0x0
> task migration cache decay timeout: 10 msecs.
> ** hang, then machine check **

I had the same hang on my ia64 test box, once.  But during the
binary-search-through-patches process it disappeared.  Try booting again :(

I'd be suspecting one of the CPU scheduler patches.
