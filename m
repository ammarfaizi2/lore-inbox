Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030486AbWGINAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbWGINAa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 09:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbWGINAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 09:00:30 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1805 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030486AbWGINA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 09:00:29 -0400
Date: Sun, 9 Jul 2006 15:00:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Gregoire Favre <gregoire.favre@gmail.com>,
       Vojtech Pavlik <vojtech@suse.cz>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: 2.6.18-rc1-mm1 fails on amd64 (smp_call_function_single)
Message-ID: <20060709130027.GG13938@stusta.de>
References: <20060709021106.9310d4d1.akpm@osdl.org> <20060709114925.GA9009@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709114925.GA9009@gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 01:49:25PM +0200, Gregoire Favre wrote:
> Hello,
> 
> can't compil it :
> 
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/x86_64/kernel/built-in.o: In function `vsyscall_set_cpu':
> (.init.text+0x1e87): undefined reference to `smp_call_function_single'
> make: *** [.tmp_vmlinux1] Error 1

Thanks for your report, it seems x86_64-mm-getcpu-vsyscall.patch broke 
COMFIG_SMP=n x86_64 compiles.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

