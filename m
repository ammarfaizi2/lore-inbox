Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWAKVUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWAKVUT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWAKVUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:20:19 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:46348 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750711AbWAKVUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:20:17 -0500
Date: Wed, 11 Jan 2006 22:20:11 +0100
From: Willy Tarreau <willy@w.ods.org>
To: akennedy@techmoninc.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: ixp4xx_defconfig
Message-ID: <20060111212011.GK7142@w.ods.org>
References: <20060111130342.bfc52cea95091b0fffcb409eab6296ba.5d36bccaec.wbe@email.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111130342.bfc52cea95091b0fffcb409eab6296ba.5d36bccaec.wbe@email.secureserver.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 01:03:42PM -0700, akennedy@techmoninc.com wrote:
> Please CC me :shameful: as I'm not part of the list.
> 
> Please forgive if this has already been asked (I did look and couldn't
> find the answer).
> 
> I have a fresh install of 2.6.15, patched with 2.6.15-git6, edited the
> top-level make file and changed the ARCH ?= <blah> to ARCH = arm
> 
> I then issue the following commands
> make ixp4xx_defconfig
> make
> 
> and I get the following:
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   SPLIT   include/linux/autoconf.h -> include/config/*
>   SYMLINK include/asm-arm/arch -> include/asm-arm/arch-ixp4xx
>   Generating include/asm-arm/mach-types.h
>   SYMLINK include/asm -> include/asm-arm
>   CC      arch/arm/kernel/asm-offsets.s
> cc1: error: invalid option `big-endian'
> cc1: error: invalid option `apcs'
> cc1: error: invalid option `no-sched-prolog'
> cc1: error: invalid option `abi=apcs-gnu'
> cc1: error: invalid option `tune=strongarm110'
> cc1: error: bad value (armv4) for -march= switch
> cc1: error: bad value (armv4) for -mcpu= switch
> make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1
> make: *** [prepare0] Error 2
> 
> I'm sure that I'm not doing something easy, but I'm a virgin to Embedded
> systems.

I suspect that you did not change your CC variable to point to your
ARM toolchain. This is generally what causes gcc to complain about
invalid options.

> Sorry for the post, I know you guys have more to do than answer
> questions
> for embedded newbies.
> 
> Thanks in advance for any assistance you can offer.
> 
> Andy Kennedy
> Sr. Programmer
> Technical Monitoring Research Inc.

Regards,
Willy

