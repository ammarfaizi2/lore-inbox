Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWHGFVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWHGFVg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 01:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWHGFVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 01:21:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20900 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751063AbWHGFVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 01:21:35 -0400
Date: Sun, 6 Aug 2006 22:21:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Reuther <mreuther@umich.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-mm2 Compile Error
Message-Id: <20060806222129.f1cfffb9.akpm@osdl.org>
In-Reply-To: <200608062330.19628.mreuther@umich.edu>
References: <200608062330.19628.mreuther@umich.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Aug 2006 23:30:19 -0400
Matt Reuther <mreuther@umich.edu> wrote:

> I got an Error while compiling 2.6.18-rc3-mm2:
> 
>   AR      arch/i386/lib/lib.a
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> kernel/built-in.o(.text+0x45667): In function `bacct_add_tsk':
> include/linux/time.h:130: undefined reference to `__divdi3'
> make: *** [.tmp_vmlinux1] Error 1
> 
> I attached the .config file.
> 

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/hot-fixes/csa-basic-accounting-over-taskstats-fix.patch
should fix this, thanks.  
