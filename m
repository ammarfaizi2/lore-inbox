Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbTJTR0t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 13:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbTJTR0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 13:26:49 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:38332 "EHLO
	openlab.rtlab.org") by vger.kernel.org with ESMTP id S262720AbTJTR0r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 13:26:47 -0400
Date: Mon, 20 Oct 2003 13:26:26 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Rereading the Partition Table (ioctl BLKRRPART)
In-Reply-To: <20031020103840.J17778@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.33L2.0310201324150.17966-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Oct 2003, Andreas Dilger wrote:

> On Oct 20, 2003  11:38 -0400, Calin A. Culianu wrote:
> > Anyhow, in my quest to keep my uptime as high as possible, I was wondering
> > how feasible it would be to make the BLKRRPART ioctl a little more
> > flexible, so that in some cases a reboot wouldn't be required.
> >
> > Well, what do you guys think?  I am tempted to just hack the sources now
> > to get this working for myself, but before I start I am afraid maybe the
> > situation isn't quite so simple... or there might be something I am
> > overlooking.  Can someone with more experience in the kernel share their
> > thoughts on this?
>
> It already exists, and newer partition editors already support this.  I
> think parted and partx will use the new partition ioctls to change the
> kernel's partition table without a reboot.  Sadly, no documentation on
> how to use partx.

Really? Coolness..  so the onus is on the userspace process to specify
which partitions are suspected of having changed?  Is that the reason for
a new ioctl?

Just out of curiousity: What was the motivation for adding a new ioctl?
What would have been wrong with also hacking BLKRRPART to behave this way,
as in, have it figure out if a re-read is possible based on the heuristics
I already suggested...

-Calin

