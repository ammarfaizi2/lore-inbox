Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290157AbSBRSip>; Mon, 18 Feb 2002 13:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290616AbSBRSag>; Mon, 18 Feb 2002 13:30:36 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:42202 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S287769AbSBRSZG>; Mon, 18 Feb 2002 13:25:06 -0500
Date: Mon, 18 Feb 2002 11:25:05 -0700
Message-Id: <200202181825.g1IIP5D01884@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "Ishan Jayawardena" <ioshadij@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
In-Reply-To: <F74iP3FJVRA4kB7CA5r0001cc7d@hotmail.com>
In-Reply-To: <F74iP3FJVRA4kB7CA5r0001cc7d@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ishan Jayawardena writes:
> This is a multi-part message in MIME format.

First comment: please send the patch inline, not MIME-encoded.

> I'd love to extend this work to support Paul Russell's hotplug cpu work, but 
> I have absolutely no way at present to test it. (If some kind party would 
> like to donate a quad pentium 4 Xeon with hotplug cpu support, I'll be more 
> than happy to do so ;)
> 
> This is against 2.4.18-pre9-ac4 with devfs v199.9
> 
> Relevent comments, advise, improvisations, flames, welcome.

Second comment: devfs_(un)register_per_cpu() doesn't belong in
fs/devfs/base.c. I don't even think it should be in fs/devfs/util.c.
I think it belongs kernel/smp.c (that's right, create a new file).
There's too much duplicated SMP code in each arch/ tree. Let's create
a place for new stuff to be shared.

So, please send along your next version of the patch (inlined, of
course:-).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
