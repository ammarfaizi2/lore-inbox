Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270439AbRHHKJA>; Wed, 8 Aug 2001 06:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270438AbRHHKIu>; Wed, 8 Aug 2001 06:08:50 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:60075 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S270439AbRHHKIh>; Wed, 8 Aug 2001 06:08:37 -0400
Date: Wed, 8 Aug 2001 11:08:45 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Keith Owens <kaos@ocs.com.au>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.8-pre6 - towards a clean kernel compile
In-Reply-To: <29863.997248595@kao2.melbourne.sgi.com>
Message-ID: <Pine.SOL.3.96.1010808110633.4799B-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2001, Keith Owens wrote:

> Correct missing () in ldm.h.
> 
> Some of these patches have already appeared on l-k but they are not in
> the latest pre-patch.
> 
> Index: 8-pre6.1/fs/partitions/ldm.h
> --- 8-pre6.1/fs/partitions/ldm.h Sun, 05 Aug 2001 13:29:36 +1000 kaos (linux-2.4/I/e/44_ldm.h 1.2 644)
> +++ 8-pre6.1(w)/fs/partitions/ldm.h Wed, 08 Aug 2001 11:14:24 +1000 kaos (linux-2.4/I/e/44_ldm.h 1.2 644)
> @@ -81,13 +81,13 @@
>  #define TOC_BITMAP2		"log"		/* bitmaps in the TOCBLOCK. */
>  
>  /* Borrowed from msdos.c */
> -#define SYS_IND(p)		(get_unaligned(&p->sys_ind))
> -#define NR_SECTS(p)		({ __typeof__(p->nr_sects) __a =	\
> -					get_unaligned(&p->nr_sects);	\
> +#define SYS_IND(p)		(get_unaligned(&(p)->sys_ind))
> +#define NR_SECTS(p)		({ __typeof__((p)->nr_sects) __a =3D	\
                                                                 ^^^^^^
> +					get_unaligned(&(p)->nr_sects);	\
>  					le32_to_cpu(__a);		\
>  				})
> -#define START_SECT(p)		({ __typeof__(p->start_sect) __a =	\
> -					get_unaligned(&p->start_sect);	\
> +#define START_SECT(p)		({ __typeof__((p)->start_sect) __a =3D	\
                                                                     ^^^^^^
> +					get_unaligned(&(p)->start_sect);\
>  					le32_to_cpu(__a);		\
>  				})

Something's gone wrong with this patch. What's this __a =3D stuff that
has appeared out of the blue in two places?

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

