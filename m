Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbRETCMZ>; Sat, 19 May 2001 22:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261334AbRETCMQ>; Sat, 19 May 2001 22:12:16 -0400
Received: from lpce017.lss.emc.com ([168.159.62.17]:12036 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S261333AbRETCME>; Sat, 19 May 2001 22:12:04 -0400
Date: Sat, 19 May 2001 12:43:27 -0600
Message-Id: <200105191843.f4JIhRx00343@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andries.Brouwer@cwi.nl
Cc: andrewm@uow.edu.au, viro@math.psu.edu, bcrl@redhat.com, clausen@gnu.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code inuserspace
In-Reply-To: <UTC200105191130.NAA53601.aeb@vlet.cwi.nl>
In-Reply-To: <UTC200105191130.NAA53601.aeb@vlet.cwi.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer writes:
> Andrew Morton writes:
> 
>     > > (2) what about bootstrapping?  how do you find the root device?
>     > > Do you do "root=/dev/hda/offset=63,limit=1235823"?  Bit nasty.
>     > 
>     > Ben's patch makes initrd mandatory.
> 
>     Can this be fixed?  I've *never* had to futz with initrd.
>     Probably most systems are the same.  It seems a step
>     backward to make it necessary.
> 
> I don't think so. It is necessary, and it is good.

It most certainly is not. This attitude of pushing more and more stuff
out of the kernel and into initrd is really annoying. Initrd is messy,
nasty and opaque. It makes the boot process more complex. There is no
way in hell I want to be forced to use it.

Removing N lines from the kernel at the cost of adding N+k lines to
user-space is a *loss*, not a gain. I want my *system* to be simple
and transparent.

> But it is easy to make the transition painless.

No, initrd is fundamentally painful. Let go of this ideology of
removing code from the kernel at all costs. A super-slim kernel which
requires a more complex to administer user-space is too high a cost.
The benefits of removing partition support from the kernel are
basically zero.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
