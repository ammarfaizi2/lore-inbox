Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313075AbSDCGJN>; Wed, 3 Apr 2002 01:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSDCGJD>; Wed, 3 Apr 2002 01:09:03 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:23682 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S313068AbSDCGIu>; Wed, 3 Apr 2002 01:08:50 -0500
Date: Tue, 2 Apr 2002 23:08:47 -0700
Message-Id: <200204030608.g3368l903461@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops cleanup 3/4
In-Reply-To: <E16sbI0-0005ug-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell writes:
> Linus, please apply (no object code changes).
> 
> This changes everything arch specific PPC and i386 which should have
> been unsigned long (it doesn't *matter*, but bad habits get copied).
> 
> I left the devfs ones for Richard to submit separately, since they
> actually change the resulting code.

??? But you didn't leave the devfs ones alone: your patch changes a
devfs file:

> diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/devfs_fs_kernel.h working-2.5.7-pre1-bitops/include/linux/devfs_fs_kernel.h
> --- linux-2.5.7-pre1/include/linux/devfs_fs_kernel.h	Fri Mar 15 15:37:39 2002
> +++ working-2.5.7-pre1-bitops/include/linux/devfs_fs_kernel.h	Sat Mar 16 13:54:53 2002
> @@ -54,7 +54,7 @@
>      unsigned char sem_initialised;
>      unsigned int num_free;          /*  Num free in bits       */
>      unsigned int length;            /*  Array length in bytes  */
> -    __u32 *bits;
> +    unsigned long *bits;
>      struct semaphore semaphore;
>  };
>  

Anyway, I hope to have a devfs patch for 2.5.x ready before next
week. I've got some other changes in the works, as well as the bitops
changes, which I've already submitted for 2.4.x.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
