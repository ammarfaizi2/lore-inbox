Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946768AbWKAKoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946768AbWKAKoB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 05:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946766AbWKAKoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 05:44:01 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:10898 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1946768AbWKAKoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 05:44:00 -0500
Date: Wed, 1 Nov 2006 13:44:00 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Vasily Averin <vvs@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: 2.6.19-rc3-mm1: compilation fails if CONFIG_KEVENT is disabled
Message-ID: <20061101104400.GA4469@2ka.mipt.ru>
References: <45487246.2080309@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <45487246.2080309@sw.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 01 Nov 2006 13:44:01 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 01:09:10PM +0300, Vasily Averin (vvs@sw.ru) wrote:
> Hello Evgeniy,

Hi Vasily.

> Probably this issue is already known for you, but anyway:
> 
> [linux-2.6.19-rc3-mm1]$ ARCH=i386 make
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CHK     include/linux/compile.h
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/i386/kernel/built-in.o(.rodata+0x520): In function `sys_call_table':
> : undefined reference to `sys_kevent_get_events'
> arch/i386/kernel/built-in.o(.rodata+0x524): In function `sys_call_table':
> : undefined reference to `sys_kevent_ctl'
> arch/i386/kernel/built-in.o(.rodata+0x528): In function `sys_call_table':
> : undefined reference to `sys_kevent_wait'
> make: *** [.tmp_vmlinux1] Error 1
> [linux-2.6.19-rc3-mm1]$ grep KEVENT .config
> CONFIG_GENERIC_CLOCKEVENTS=y
> # CONFIG_KEVENT is not set

Hmm, works for me in 2.6.19 kevent git, I will check if some patches
sneaked from -mm.

Thanks.

> thank you,
> 	Vasily Averin

-- 
	Evgeniy Polyakov
