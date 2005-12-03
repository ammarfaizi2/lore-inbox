Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbVLCMq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVLCMq2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 07:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVLCMq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 07:46:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6917 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751247AbVLCMq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 07:46:27 -0500
Date: Sat, 3 Dec 2005 13:46:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: al@alarsen.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/qnx4/bitmap.c: #if 0 qnx4_new_block()
Message-ID: <20051203124628.GH31395@stusta.de>
References: <20051203121944.GC31395@stusta.de> <9a8748490512030428o55d9c8cfl112fadf8e8b7e02c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490512030428o55d9c8cfl112fadf8e8b7e02c@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 01:28:31PM +0100, Jesper Juhl wrote:
> On 12/3/05, Adrian Bunk <bunk@stusta.de> wrote:
> > qnx4_new_block() is neither implemented nor used.
> >
> >
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >
> > --- linux-2.6.15-rc3-mm1/fs/qnx4/bitmap.c.old   2005-12-03 11:32:46.000000000 +0100
> > +++ linux-2.6.15-rc3-mm1/fs/qnx4/bitmap.c       2005-12-03 11:33:07.000000000 +0100
> > @@ -23,10 +23,12 @@
> >  #include <linux/buffer_head.h>
> >  #include <linux/bitops.h>
> >
> > +#if 0
> >  int qnx4_new_block(struct super_block *sb)
> >  {
> >         return 0;
> >  }
> > +#endif  /*  0  */
> >
> >  static void count_bits(register const char *bmPart, register int size,
> >                        int *const tf)
> >
> 
> Adrian,
> You submit a lot of nice patches, but your "#if 0" patches have always
> puzzled me. Why is it that you prefer to use #if 0 to remove code
> rather than simply delete it?

I started with patches simply deleting the code, but since too often 
people complained "we might need this code at some time in the future", 
I've switched to using the #if 0's...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

