Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289161AbSAVRph>; Tue, 22 Jan 2002 12:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289175AbSAVRp2>; Tue, 22 Jan 2002 12:45:28 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:32015 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S289161AbSAVRpU>; Tue, 22 Jan 2002 12:45:20 -0500
Date: Tue, 22 Jan 2002 12:45:18 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Rainer Krienke <krienke@uni-koblenz.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
Message-ID: <20020122124518.B27968@devserv.devel.redhat.com>
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com> <200201221308.g0MD8EY16176@bliss.uni-koblenz.de> <E16T0ye-0002K6-00@charged.uio.no> <200201221523.g0MFNst03011@bliss.uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200201221523.g0MFNst03011@bliss.uni-koblenz.de>; from krienke@uni-koblenz.de on Tue, Jan 22, 2002 at 04:23:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Rainer Krienke <krienke@uni-koblenz.de>
> Date: Tue, 22 Jan 2002 16:23:54 +0100

> Thanks for the hint. I fixed pmap_create() according to your proposal and now 
> nfsd works again. 

Care to share the patch?

> Raising the count of elements of 
> unnamed_dev_in_use in fs/super.c to eg 4096 resulted in the opportunity to 
> mount as many NFS directories.

You did not send your patch (yet again), so there is no way
to tell precisely what you have accomplished. I suspect that it may
create pages with same device number that belong to different
mounts. I do not pretend to understand how VFS and page cache
use device numbers. If device numbers are used for any indexing,
pages may be mixed up with resulting data corruption.
I cannot say if this scenario is likely without looking
at the VFS code. Perhaps we ought to ask Stephen, Al, or Trond
about it.

> Why did you 
> Pete base your patch on 4 new major device numbers whereas Andis patch did 
> not need them?

He probably never tested his patch. I asked him and we'll know
soon if it was so.

-- Pete
