Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133029AbRDRGWB>; Wed, 18 Apr 2001 02:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133030AbRDRGVv>; Wed, 18 Apr 2001 02:21:51 -0400
Received: from mx1.sac.fedex.com ([199.81.208.10]:57362 "EHLO
	mx1.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S133029AbRDRGVn>; Wed, 18 Apr 2001 02:21:43 -0400
Date: Wed, 18 Apr 2001 14:21:49 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.4.4-pre4 nfsd.o unresolved symbol
In-Reply-To: <Pine.GSO.4.21.0104180040050.9930-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0104181421000.8661-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


great! working fine one.

Thanks,
Jeff
[ jchua@fedex.com ]

On Wed, 18 Apr 2001, Alexander Viro wrote:

>
>
> On Wed, 18 Apr 2001, Jeff Chua wrote:
>
> > depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre4/kernel/fs/nfsd/nfsd.o
> > depmod:         nfsd_linkage_Rb56858ea
>
> Grrr...
>
> Add #include <linux/module.h> to fs/filesystems.c. My apologies.
>
> --- fs/filesystems.c    Tue Apr 17 23:40:32 2001
> +++ /tmp/filesystems.c  Wed Apr 18 00:41:01 2001
> @@ -7,6 +7,7 @@
>   */
>
>  #include <linux/config.h>
> +#include <linux/module.h>
>  #include <linux/sched.h>
>  #include <linux/smp_lock.h>
>  #include <linux/kmod.h>
>
>

