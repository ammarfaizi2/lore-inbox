Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWHUVVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWHUVVl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 17:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWHUVVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 17:21:40 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23310 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751127AbWHUVVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 17:21:40 -0400
Date: Mon, 21 Aug 2006 23:21:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Jan Beulich <jbeulich@novell.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, discuss@x86-64.org
Subject: 2.6.18-rc4-mm2: x86_64 compile error
Message-ID: <20060821212140.GN11651@stusta.de>
References: <20060819220008.843d2f64.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060819220008.843d2f64.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 10:00:08PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc4-mm1:
>...
> +x86_64-mm-fix-x86-cpuid-keys-used-in-alternative_smp.patch
>...
>  x86_64 tree updates
>...

This patch causes the following compile error (cross compiling from i386 
using gcc 4.1):

<--  snip  -->

...
  LD      .tmp_vmlinux1
kernel/built-in.o:(.smp_altinstructions+0x10): undefined reference to `X86_FEATURE_UP'
kernel/built-in.o:(.smp_altinstructions+0x28): undefined reference to `X86_FEATURE_UP'
kernel/built-in.o:(.smp_altinstructions+0x40): undefined reference to `X86_FEATURE_UP'
kernel/built-in.o:(.smp_altinstructions+0x58): undefined reference to `X86_FEATURE_UP'
make[1]: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

