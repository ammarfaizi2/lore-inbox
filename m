Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286603AbRLUWCx>; Fri, 21 Dec 2001 17:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286610AbRLUWCn>; Fri, 21 Dec 2001 17:02:43 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:58807 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S286603AbRLUWC1>; Fri, 21 Dec 2001 17:02:27 -0500
Date: Fri, 21 Dec 2001 15:02:23 -0700
Message-Id: <200112212202.fBLM2N717016@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Gregor Suhr <Gregor@Suhr.home.cs.tu-berlin.de>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: OOPS  at boot in 2.4.17-rc[12]  (kernel BUG at slab.c:815) maybe  devfs
In-Reply-To: <3C23A022.5040307@Suhr.home.cs.tu-berlin.de>
In-Reply-To: <3C210AB9.5000900@suhr.home.cs.tu-berlin.de>
	<200112202338.fBKNcCI05673@vindaloo.ras.ucalgary.ca>
	<3C227F0E.E6A9CF76@zip.com.au>
	<3C23842A.20407@Suhr.home.cs.tu-berlin.de>
	<200112211926.fBLJQ7814544@vindaloo.ras.ucalgary.ca>
	<3C23A022.5040307@Suhr.home.cs.tu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregor Suhr writes:
> >
> >
> >
> >Now this is useful information! I see what's caused this: the second
> >mount of devfs (because you're using initrd) is creating the
> >devfsd_event slab cache again, which is a bug. I've appended a patch
> >which fixes this. Please test it out and let me know how it goes.
> >
> I applied the patch to 2.4.17 and it seems to work well (the system came 
> up).

Great.

> Do you have an idea how I can solve the err. -17 error or may i realy 
> ignore it?

I've added a section to the devfs FAQ to answer this.
http://www.atnf.csiro.au/~rgooch/linux/docs/devfs.html

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
