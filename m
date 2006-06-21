Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWFUMH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWFUMH6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 08:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWFUMH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 08:07:58 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34308 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751512AbWFUMH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 08:07:57 -0400
Date: Wed, 21 Jun 2006 14:07:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, linux-kernel@vger.kernel.org,
       Chris Leech <christopher.leech@intel.com>
Subject: Re: 2.6.17-rc5-mm2 another compile error
Message-ID: <20060621120755.GC9111@stusta.de>
References: <20060601014806.e86b3cc0.akpm@osdl.org> <447ED2AB.30107@aitel.hist.no> <20060601092953.169064d5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060601092953.169064d5.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 09:29:53AM -0700, Andrew Morton wrote:
> On Thu, 01 Jun 2006 13:42:35 +0200
> Helge Hafting <helge.hafting@aitel.hist.no> wrote:
> 
> >   CC      drivers/dma/ioatdma.o
> > drivers/dma/ioatdma.c: In function ‘ioat_init_module’:
> > drivers/dma/ioatdma.c:828: error: dereferencing pointer to incomplete type
> > make[2]: *** [drivers/dma/ioatdma.o] Error 1
> > make[1]: *** [drivers/dma] Error 2
> > make: *** [drivers] Error 2
> > 
> 
>         if (THIS_MODULE != NULL)
>                 THIS_MODULE->unsafe = 1;
> 
> Chris, this won't compile with CONFIG_MODULES=n.
> 
> If module unloading is unsafe (why?) then a suitable workaround would be to
> take an additional ref on the module (__module_get()) so that it cannot be
> unloaded.

This bug is still present in 2.6.17-mm1, and even worse it's now in 
Linus' tree.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

