Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422701AbWHXVtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422701AbWHXVtW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422732AbWHXVtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:49:22 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39686 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422701AbWHXVtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:49:21 -0400
Date: Thu, 24 Aug 2006 23:49:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tiny@selenic.com, devel@laptop.org
Subject: Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
Message-ID: <20060824214919.GT19810@stusta.de>
References: <1156429585.3012.58.camel@pmac.infradead.org> <1156433068.3012.115.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156433068.3012.115.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 04:24:28PM +0100, David Woodhouse wrote:
>...
> Using a combination of these two compiler options for building kernel
> code leads to some useful optimisation -- especially with modules which
> are made up of a bunch of incestuous C files, where none of the global
> symbols actually _need_ to be visible outside the directory they reside
> in. File systems are a prime example of this -- on PPC64 I see a
> reduction in size of ext3.ko by 2.6%, jffs2.ko by 5%, cifs.ko by 8% and
> befs.ko by a scary 14%. Strangely, udf.ko seems to have _grown_ by 6.6%
> -- that'll probably be another optimisation bug like GCC PR28755.
>...

Looks good.  :-)

What kernel are your patches against?

2.6.18-rc4 gives me:

<--  snip  -->

...
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CC      arch/i386/kernel/asm-offsets.s
  GEN     include/asm-i386/asm-offsets.h
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/bin2c
make[1]: *** No rule to make target `/home/bunk/linux/linux-2.6.18-rc4/dummy.c', needed by `init/init.o'.  Stop.
make: *** [init] Error 2

<--  snip  -->
 
> dwmw2

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

