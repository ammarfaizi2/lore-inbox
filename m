Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314748AbSFEKeW>; Wed, 5 Jun 2002 06:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314787AbSFEKeV>; Wed, 5 Jun 2002 06:34:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41158 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314748AbSFEKeU>;
	Wed, 5 Jun 2002 06:34:20 -0400
Date: Wed, 5 Jun 2002 12:33:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Andrew Morton <akpm@zip.com.au>, Andreas Dilger <adilger@clusterfs.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
Message-ID: <20020605103351.GA15883@suse.de>
In-Reply-To: <3CFD453A.B6A43522@zip.com.au> <20020604233124.GA18668@turbolinux.com> <3CFD50B9.259366F4@zip.com.au> <1023272806.15438.106.camel@bip>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05 2002, Xavier Bestel wrote:
> Le mer 05/06/2002 à 01:43, Andrew Morton a écrit :
> 
> > Also, it has been suggested that the feature become more fully-fleshed,
> > to support desktops with one disk spun down, etc.  It's not really
> > rocket science to do that - the `struct backing_dev_info' gives
> > a specific communication channel between the high-level VFS code and
> > the request queue.  But that would require significantly more surgery
> > against the writeback code, so I'm fishing for requirements here.  If
> > the current (simple) patch is sufficient then, well, it is sufficient.
> 
> Have per-disk laptop-mode, so that some user-mode proggy (e.g. hotplug)
> could decide what to do.

And get rid of disk_spun_up(), make it a queue flag instead and signal
the spin up before calling the request_fn instead of shoving it inside
the driver request_fn's.

-- 
Jens Axboe

