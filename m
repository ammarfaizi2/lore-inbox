Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268595AbUHLPz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268595AbUHLPz1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 11:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268598AbUHLPz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 11:55:26 -0400
Received: from [12.177.129.25] ([12.177.129.25]:30147 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268595AbUHLPzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 11:55:22 -0400
Message-Id: <200408121656.i7CGu8JA002731@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: William Lee Irwin III <wli@holomorphy.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] 2.6.8-rc4-mm1 - UML fixes 
In-Reply-To: Your message of "Wed, 11 Aug 2004 23:50:47 PDT."
             <20040812065047.GG11200@holomorphy.com> 
References: <200408120415.i7C4FWJd010494@ccure.user-mode-linux.org> <20040812033012.GE11200@holomorphy.com> <200408120541.i7C5fIJd010913@ccure.user-mode-linux.org>  <20040812065047.GG11200@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Aug 2004 12:56:08 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wli@holomorphy.com said:
> This might confuse CONFIG_DEBUG_PAGEALLOC, which uses THREAD_SIZE to
> detect the end of the kernel stack in store_stackinfo() in mm/slab.c
> and kstack_end() in include/linux/sched.h, and the sizing heuristic
> for max_threads in fork_init().

I think it's OK.  UML isn't lying about its stack size, just that snippet of
code is misleading.

> Also, how is this meant to interoperate with CONFIG_KERNEL_STACK_ORDER?
>  It seems to ignore the setting from the config option. 

I'm going to fix that.  For this patch I just did the quickest thing and 
reverted back to what was there before.

				Jeff

