Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbSKNRoc>; Thu, 14 Nov 2002 12:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265111AbSKNRoc>; Thu, 14 Nov 2002 12:44:32 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:14292 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S265095AbSKNRoa>; Thu, 14 Nov 2002 12:44:30 -0500
Date: Thu, 14 Nov 2002 10:51:10 -0700
Message-Id: <200211141751.gAEHpAVm021359@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] devfs API
In-Reply-To: <Pine.GSO.4.21.0211101348350.24061-100000@steklov.math.psu.edu>
References: <Pine.GSO.4.21.0211101348350.24061-100000@steklov.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 	During the last couple of weeks I'd done a lot of digging in
> devfs-related code.  Results are interesting, and not in a good sense.
> 
> 	1) a _lot_ of functions exported by devfs are never used.  At
> all.
[...]

I don't have time right now do deal with all the points you raised,
I'll deal with each of the points you raise over the next week or
so. However, I'll make a couple of quick points:

- I'm leery of changing the API and breaking compatibility between 2.4
  and 2.5 drivers. I also don't want to break out-of-tree drivers
  without giving maintainers plenty of warning. There are a number
  such out there

- I have far more drastic plans for code reduction in devfs. The plan
  I've mentioned since OLS is to leverage sysfs so that devfsd can be
  used to populate devfs from user-space. For the root FS device, I
  figure on writing a mini devfsd for initramfs. From the perspective
  of user-space, this will provide functional compatibility. From
  kernel-space it will effectively be an API change, so I don't want
  to do this twice.

I'd hoped to get the new major version of devfs ready before the
freeze, but limited time (read: funding) has been available. Oh, well.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
