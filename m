Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290708AbSA3WpK>; Wed, 30 Jan 2002 17:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290707AbSA3WpB>; Wed, 30 Jan 2002 17:45:01 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:52206 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S290704AbSA3Wot>;
	Wed, 30 Jan 2002 17:44:49 -0500
Date: Wed, 30 Jan 2002 15:44:34 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: David Dyck <dcd@tc.fluke.com>
Cc: linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl
Subject: Re: 2.5.3 missing <linux/malloc.h>
Message-ID: <20020130154434.L763@lynx.adilger.int>
Mail-Followup-To: David Dyck <dcd@tc.fluke.com>,
	linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl
In-Reply-To: <Pine.LNX.4.33.0201301239370.19671-100000@dd.tc.fluke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201301239370.19671-100000@dd.tc.fluke.com>; from dcd@tc.fluke.com on Wed, Jan 30, 2002 at 02:28:28PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 30, 2002  14:28 -0800, David Dyck wrote:
> Haven't seen this posted yet, so I'm surprised to report that
> several 2.5.3 source files
> 
>     arch/arm/mach-clps711x/dma.c
>     drivers/base/core.c
>     drivers/base/fs.c
>     drivers/video/neofb.c
> 
> 
> try to include linux/malloc.h
> but there is no file in the include directory by that name.
> 
> I worked around the problem by copying an older linux/malloc.h:
> 
> #ifndef _LINUX_MALLOC_H
> #define _LINUX_MALLOC_H
> 
> #include <linux/slab.h>
> #endif /* _LINUX_MALLOC_H */

So, why not just change the above files to include <linux/slab.h>
instead?

> and I've noticed that many source files have
>   #include <linux/slab.h>     /* kmalloc(), kfree() */
> instead of trying to include linux/malloc.h

That's because they have been updated, and the other ones have not.
Don't ask me _why_ it was changed that way, but it was.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

