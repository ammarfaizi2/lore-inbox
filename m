Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWIDPoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWIDPoe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 11:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWIDPoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 11:44:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25100 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964879AbWIDPod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 11:44:33 -0400
Date: Mon, 4 Sep 2006 17:44:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.18-rc5-mm1: MMU=n compile error
Message-ID: <20060904154429.GQ4416@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org> <20060903221700.GH4416@stusta.de> <1157355872.14324.6.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157355872.14324.6.camel@twins>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 09:44:32AM +0200, Peter Zijlstra wrote:
> On Mon, 2006-09-04 at 00:17 +0200, Adrian Bunk wrote:
> > mm-tracking-shared-dirty-pages.patch breaks CONFIG_MMU=n architectures:
> > 
> > <--  snip  -->
> > 
> > ....
> >   CC      mm/page-writeback.o
> > /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/mm/page-writeback.c: In function 'test_clear_page_dirty':
> > /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/mm/page-writeback.c:867: error: implicit declaration of function 'page_mkclean'
> > make[2]: *** [mm/page-writeback.o] Error 1
> 
> This might fix it, but I don't have a cross compiler for any nommu arch,
> nor an emulator so I can't test. - Will try to build me a toolchain but
> this could take some time.
>...

Thanks, I can confirm this fixes the compilation.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

