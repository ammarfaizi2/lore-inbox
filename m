Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWHUAHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWHUAHY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 20:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWHUAHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 20:07:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29907 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750703AbWHUAHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 20:07:23 -0400
Date: Sun, 20 Aug 2006 17:07:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug Report 2.6.17.8
Message-Id: <20060820170717.e6f98f23.akpm@osdl.org>
In-Reply-To: <20060820134022.c1d676d6.skraw@ithnet.com>
References: <20060820134022.c1d676d6.skraw@ithnet.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2006 13:40:22 +0200
Stephan von Krawczynski <skraw@ithnet.com> wrote:

> Hello,
> 
> in case of additional questions feel free to ask. 
> 
> -- 
> Regards,
> Stephan
> 
> Aug 20 03:43:11 a01 kernel: BUG: unable to handle kernel paging request at virtual address 02000044
> Aug 20 03:43:11 a01 kernel:  printing eip:
> Aug 20 03:43:11 a01 kernel: c0176356
> Aug 20 03:43:11 a01 kernel: *pde = 00000000
> Aug 20 03:43:11 a01 kernel: Oops: 0000 [#1]
> Aug 20 03:43:11 a01 kernel: Modules linked in: speedstep_lib freq_table ipv6 intel_agp agpgart hw_random nfs lockd sunrpc e100 mii e1000
> Aug 20 03:43:11 a01 kernel: CPU:    0
> Aug 20 03:43:11 a01 kernel: EIP:    0060:[dqput+14/338]    Not tainted VLI
> Aug 20 03:43:11 a01 kernel: EIP:    0060:[<c0176356>]    Not tainted VLI
> Aug 20 03:43:11 a01 kernel: EFLAGS: 00010206   (2.6.17.8 #1)
> Aug 20 03:43:11 a01 kernel: EIP is at dqput+0xe/0x152
> Aug 20 03:43:11 a01 kernel: eax: 02000000   ebx: 02000000   ecx: f5fd0c00   edx: 00000000

Looks like a single-bit error.  Try running memtest86 for 24 hours?
