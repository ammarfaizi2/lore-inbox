Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbUCKPoO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 10:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbUCKPoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 10:44:14 -0500
Received: from kempelen.iit.bme.hu ([152.66.241.120]:32690 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S261395AbUCKPoM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 10:44:12 -0500
Date: Thu, 11 Mar 2004 16:44:07 +0100 (MET)
Message-Id: <200403111544.i2BFi7O06675@kempelen.iit.bme.hu>
From: Miklos Szeredi <mszeredi@inf.bme.hu>
To: hallyn@CS.WM.EDU
CC: linux-kernel@vger.kernel.org
In-reply-to: <20040311151343.GA943@escher.cs.wm.edu> (hallyn@CS.WM.EDU)
Subject: Re: unionfs
References: <200403080952.i289qsU12658@kempelen.iit.bme.hu> <20040311151343.GA943@escher.cs.wm.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If you get a response from Al, could you let me know?

OK.

> I've been wondering about this myself, and beyond simple
> coolness/usefullness, we may also need the unionfs for mls
> polyinstantiation.
> 
> If you don't hear from Al, please let me know whether you plan to tackle
> it yourself or not.

I'll have to, as this is needed for AVFS.  Not unionfs, but something
similar, that allows file/directory lookups for special filenames to
be redirected to another filesystem.

For the time I plan to go along the easy way, and create a filesystem
specifically for AVFS that doesn't need modifications to the kernel.
This will be inefficient in a number of ways: doubling the memory use
by the dentry/inode caches, deeper call chains for all filesystem
operations (even those, that require no intervention).

The next step will be to try to optimize and generalize it to be
usable for other filesystems like unionsfs.  I'd really love to have
some input about this from Al or anybody who has any ideas.

Miklos
