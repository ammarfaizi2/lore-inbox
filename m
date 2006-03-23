Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932578AbWCWXmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbWCWXmU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 18:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWCWXmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 18:42:20 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47888 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932578AbWCWXmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 18:42:19 -0500
Date: Fri, 24 Mar 2006 00:42:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: 2.6.16-mm1: CONFIG_HOTPLUG_CPU compile error
Message-ID: <20060323234217.GG22727@stusta.de>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323014046.2ca1d9df.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 01:40:46AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc6-mm2:
>...
> +check-if-cpu-can-be-onlined-before-calling-smp_prepare_cpu.patch
>...
>  Random stuff.
>...

This patch broke compilation with CONFIG_HOTPLUG_CPU=y:

<--  snip  -->

...
  CC      arch/i386/kernel/smpboot.o
arch/i386/kernel/smpboot.c: In function '__cpu_up':
arch/i386/kernel/smpboot.c:1429: warning: implicit declaration of function '__smp_prepare_cpu'
...
  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o: In function `__cpu_up': undefined reference to `__smp_prepare_cpu'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

