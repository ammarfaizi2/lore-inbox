Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbTEYUQV (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 16:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263737AbTEYUQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 16:16:21 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46058 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263731AbTEYUQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 16:16:18 -0400
Date: Sun, 25 May 2003 22:29:21 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Ed Sweetman <ed.sweetman@wmich.edu>, linux-kernel@vger.kernel.org,
   linux-mm@kvack.org
Subject: Re: 2.5.69-mm9
Message-ID: <20030525202920.GE16791@fs.tum.de>
References: <20030525042759.6edacd62.akpm@digeo.com> <200305251456.39404.rudmer@legolas.dynup.net> <3ED0CE0E.4080403@wmich.edu> <20030525130601.5a105fa8.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030525130601.5a105fa8.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 01:06:01PM -0700, Andrew Morton wrote:
> Ed Sweetman <ed.sweetman@wmich.edu> wrote:
> >
> > got this with my current config. Along with other misc gcc 3 warnings.
> > 
> >  Compiling with gcc (GCC) 3.3 (Debian)
> > 
> >            ld -m elf_i386  -T arch/i386/vmlinux.lds.s
> >  arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o
> >  --start-group  usr/built-in.o  arch/i386/kernel/built-in.o
> >  arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o
> >  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o
> >  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a
> >  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o
> >  net/built-in.o --end-group  -o vmlinux
> >  kernel/built-in.o(.text+0x1708e): In function `free_module':
> >  : undefined reference to `percpu_modfree'
> >  kernel/built-in.o(.text+0x17873): In function `load_module':
> >  : undefined reference to `find_pcpusec'
> >  kernel/built-in.o(.text+0x179a9): In function `load_module':
> >  : undefined reference to `percpu_modalloc'
> >  kernel/built-in.o(.text+0x17c52): In function `load_module':
> >  : undefined reference to `percpu_modcopy'
> >  kernel/built-in.o(.text+0x17d3d): In function `load_module':
> >  : undefined reference to `percpu_modfree'
> 
> Well that is strange.  The functions are there, inlined, in the right
> place.
>...

Note that in Ed's .config CONFIG_MODULE_UNLOAD is not set and the
missing functions are inside a big #ifdef CONFIG_MODULE_UNLOAD block...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

