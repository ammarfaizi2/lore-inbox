Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262442AbSJDQcG>; Fri, 4 Oct 2002 12:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262447AbSJDQcG>; Fri, 4 Oct 2002 12:32:06 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:15765 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262442AbSJDQcE>; Fri, 4 Oct 2002 12:32:04 -0400
Date: Fri, 4 Oct 2002 10:37:34 -0600
Message-Id: <200210041637.g94GbYS09161@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg KH <greg@kroah.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] minor devfs cleanup for 2.5.40
In-Reply-To: <20021004173105.A3478@infradead.org>
References: <20021003213908.GB1388@kroah.com>
	<200210041617.g94GHY008334@vindaloo.ras.ucalgary.ca>
	<20021004172457.A3390@infradead.org>
	<200210041627.g94GR7M08781@vindaloo.ras.ucalgary.ca>
	<20021004173105.A3478@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
> On Fri, Oct 04, 2002 at 10:27:07AM -0600, Richard Gooch wrote:
> > Those names *were* in mainline. They've been there all through 2.4.x.
> > It's a useful feature that is *still* being used. Change this and lots
> > of people will get a panic at boot because there root FS is "missing".
> 
> They have never been the devfs names in_any_ kernel.  Linus made you
> change to saner names before merging devfs (saner code would also
> have been a good idea, btw..).  Anyway, 2.5 is going to initramfs,
> so feel free to put devfsd into your initramfs.

The convenience names for the root FS *have* been in the kernel since
before 2.4.x. I agree with the initramfs approach: that's been my plan
for handling the rootFS compatibility names (put a mini devfsd into
initramfs). But until all the infrastructure for that is ready, you
can't just go around breaking features people rely on. Especially
where there is no benefit to breaking it.

If you really feel strongly about it, and don't want to wait for
devfsd to be added to initramfs, by all means move the current code
(or the moral equivalent) to initramfs. But you'll have to wait for
initramfs to be available and for it to be the default.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
