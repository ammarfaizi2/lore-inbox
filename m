Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135174AbRDRNJg>; Wed, 18 Apr 2001 09:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135170AbRDRNJ2>; Wed, 18 Apr 2001 09:09:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:50886 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S133119AbRDRNJE>;
	Wed, 18 Apr 2001 09:09:04 -0400
Date: Wed, 18 Apr 2001 09:08:59 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: James Lewis Nance <jlnance@intrex.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] ext2 directories in pagecache
In-Reply-To: <20010418084420.A857@bessie.dyndns.org>
Message-ID: <Pine.GSO.4.21.0104180903240.12027-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Apr 2001, James Lewis Nance wrote:

> On Thu, Apr 12, 2001 at 12:33:42PM -0400, Alexander Viro wrote:
> > 	Folks, IMO ext2-dir-patch got to the stable stage. Currently
> > it's against 2.4.4-pre2, but it should apply to anything starting with
> > 2.4.2 or so.
> 
> Have you had any feedback about this patch?  I applied it last night to
> 2.4.3.  It seemed to work.  When I booted my computer this morning fsck
> complained about problems with the directory on one of my ext2 file systems.

Anything prior to 2.4.4-pre2 has known metadata-corrupting bugs on ext2.
Whether they show up or not depends on the load, phase of moon, etc. but
they are there.

> Since fsck does not run on every boot I dont really have a way of knowing if
> this has anything to do with your patch or not.  I'm running the patched
> kernel again right now.  Ill shutdown and force an fsck later today to see
> if anything shows up.

Please, upgrade to 2.4.4-pre2 or later. Or, at least, replace bforget()
call in ext2_get_block() with brelse() - that's was the worst one
(and last to be fixed).
								Al

