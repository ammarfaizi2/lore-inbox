Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129814AbRBEHBu>; Mon, 5 Feb 2001 02:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131268AbRBEHBk>; Mon, 5 Feb 2001 02:01:40 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:48278 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S129814AbRBEHBd>; Mon, 5 Feb 2001 02:01:33 -0500
Date: Mon, 5 Feb 2001 00:01:29 -0700
Message-Id: <200102050701.f1571TH04804@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: drepper@cygnus.com (Ulrich Drepper)
Cc: Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        David Ford <david@linux.com>, devfs@oss.sgi.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] devfsd, compiling on glibc22x
In-Reply-To: <m3lmrl62rm.fsf@otr.mynet.cygnus.com>
In-Reply-To: <3A7383B2.19DDD006@linux.com>
	<3A73C1D8.578AEEE@wanadoo.fr>
	<m3wvbgnnk3.fsf@otr.mynet.cygnus.com>
	<200102050631.f156Vje04234@vindaloo.ras.ucalgary.ca>
	<m3lmrl62rm.fsf@otr.mynet.cygnus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper writes:
> Richard Gooch <rgooch@ras.ucalgary.ca> writes:
> 
> > So why do old binaries (compiled with glibc 2.1.3) segfault when they
> > call dlsym() with RTLD_NEXT?  Even newly compiled binaries (with glibc
> > 2.2) still segfault.
> 
> What do you ask me?  You wrote the code.

But you wrote dlsym(), right I have a debug trace from someone which
shows that the call to dlsym() segfaults. It's being called thusly:
	dlsym (RTLD_NEXT, "symlink");

This doesn't fail with libc 5 nor with glibc 2.1.3. But it does with
glibc 2.2.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
