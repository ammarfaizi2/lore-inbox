Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266146AbUA2GD7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 01:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266168AbUA2GD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 01:03:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:26846 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266146AbUA2GD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 01:03:57 -0500
Date: Wed, 28 Jan 2004 22:04:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Peter Lieverdink <peter@cc.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2-mm1 naughtiness
Message-Id: <20040128220423.747ca762.akpm@osdl.org>
In-Reply-To: <1075293718.1810.4.camel@kahlua>
References: <1075293718.1810.4.camel@kahlua>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Lieverdink <peter@cc.com.au> wrote:
>
>  When I run evolution to check/send mail my kern.log gets spammed. (see
>  below) Debian unstable, config attached. This didn't happen with 2.6.
>  vanilla.
> 
>  --
>  Jan 28 23:23:17 kahlua kernel: evolution 0 waking evolution: 1696 1700
>  Jan 28 23:23:17 kahlua kernel: Badness in try_to_wake_up at
>  kernel/sched.c:722
>  Jan 28 23:23:17 kahlua kernel: Call Trace:
>  Jan 28 23:23:17 kahlua kernel:  [try_to_wake_up+145/448]
>  try_to_wake_up+0x91/0x1c0
>  Jan 28 23:23:17 kahlua kernel:  [__wake_up_common+49/96]
>  __wake_up_common+0x31/0x60
>  Jan 28 23:23:17 kahlua kernel:  [__wake_up+49/96] __wake_up+0x31/0x60
>  Jan 28 23:23:17 kahlua kernel:  [wake_futex+49/96] wake_futex+0x31/0x60
>  Jan 28 23:23:17 kahlua kernel:  [futex_wake+207/224]
>  futex_wake+0xcf/0xe0
>  Jan 28 23:23:17 kahlua kernel:  [do_futex+121/128] do_futex+0x79/0x80
>  Jan 28 23:23:17 kahlua kernel:  [sys_futex+278/304]
>  sys_futex+0x116/0x130
>  Jan 28 23:23:17 kahlua kernel:  [sys_write+89/96] sys_write+0x59/0x60
>  Jan 28 23:23:17 kahlua kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
>  Jan 28 23:23:17 kahlua kernel:
>  Jan 28 23:23:17 kahlua kernel: evolution 0 waking evolution: 1696 1700

yeah, sorry, it's bogus debugging code.  Please ignore it, or do a `patch
-p1 -R' of

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2.6.2-rc2-mm1/broken-out/futex-wakeup-debug.patch
 
