Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbUB0Xva (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 18:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbUB0Xva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 18:51:30 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35556 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263163AbUB0Xv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 18:51:26 -0500
Date: Sat, 28 Feb 2004 00:51:18 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm4
Message-ID: <20040227235118.GF5499@fs.tum.de>
References: <20040225185536.57b56716.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225185536.57b56716.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 06:55:36PM -0800, Andrew Morton wrote:
>...
> All 267 patches:
>...
> sleep_on-needs_lock_kernel.patch
>   sleep_on(): check for lock_kernel
>...

FYI:

This gives the following on my computer:

<--  snip  -->

Feb 27 22:47:37 r063144 kernel: lp0 off-line
Feb 27 22:47:37 r063144 kernel: Badness in interruptible_sleep_on_timeout at kernel/sched.c:2271
Feb 27 22:47:37 r063144 kernel: Call Trace:
Feb 27 22:47:37 r063144 kernel:  [interruptible_sleep_on_timeout+271/288] interruptible_sleep_on_timeout+0x10f/0x120
Feb 27 22:47:37 r063144 kernel:  [default_wake_function+0/16] default_wake_function+0x0/0x10
Feb 27 22:47:37 r063144 kernel:  [parport_release+160/341] parport_release+0xa0/0x155
Feb 27 22:47:37 r063144 kernel:  [printk+285/368] printk+0x11d/0x170
Feb 27 22:47:37 r063144 kernel:  [lp_error+61/176] lp_error+0x3d/0xb0
Feb 27 22:47:37 r063144 kernel:  [lp_check_status+134/208] lp_check_status+0x86/0xd0
Feb 27 22:47:37 r063144 kernel:  [lp_wait_ready+71/128] lp_wait_ready+0x47/0x80
Feb 27 22:47:37 r063144 kernel:  [lp_write+292/912] lp_write+0x124/0x390
Feb 27 22:47:37 r063144 kernel:  [vfs_write+176/256] vfs_write+0xb0/0x100
Feb 27 22:47:37 r063144 kernel:  [sys_write+56/96] sys_write+0x38/0x60
Feb 27 22:47:37 r063144 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 27 22:47:37 r063144 kernel: 
Feb 27 22:47:47 r063144 kernel: Badness in interruptible_sleep_on_timeout at kernel/sched.c:2271

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

