Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbRBEGcQ>; Mon, 5 Feb 2001 01:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129108AbRBEGcH>; Mon, 5 Feb 2001 01:32:07 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:43158 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S129044AbRBEGb7>; Mon, 5 Feb 2001 01:31:59 -0500
Date: Sun, 4 Feb 2001 23:31:45 -0700
Message-Id: <200102050631.f156Vje04234@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: drepper@cygnus.com (Ulrich Drepper)
Cc: Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        David Ford <david@linux.com>, devfs@oss.sgi.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] devfsd, compiling on glibc22x
In-Reply-To: <m3wvbgnnk3.fsf@otr.mynet.cygnus.com>
In-Reply-To: <3A7383B2.19DDD006@linux.com>
	<3A73C1D8.578AEEE@wanadoo.fr>
	<m3wvbgnnk3.fsf@otr.mynet.cygnus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper writes:
> Pierre Rousselet <pierre.rousselet@wanadoo.fr> writes:
> 
> > for me :
> > make CFLAGS='-O2 -I. -D_GNU_SOURCE' 
> > compiles without any patch. is it correct ?
> 
> Yes.  RTLD_NEXT is not in any standard, it's an extension available
> via -D_GNU_SOURCE.

So why do old binaries (compiled with glibc 2.1.3) segfault when they
call dlsym() with RTLD_NEXT?  Even newly compiled binaries (with glibc
2.2) still segfault.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
