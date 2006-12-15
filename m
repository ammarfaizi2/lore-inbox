Return-Path: <linux-kernel-owner+w=401wt.eu-S932263AbWLOEH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWLOEH2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 23:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWLOEH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 23:07:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58142 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932263AbWLOEH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 23:07:27 -0500
Date: Fri, 15 Dec 2006 15:07:03 +1100
From: David Chinner <dgc@sgi.com>
To: Shinichiro HIDA <shinichiro@stained-g.net>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org, xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, Keith Owens <kaos@sgi.com>
Subject: Re: 2.6.18.3 also 2.6.19 XFS xfs_force_shutdown (was: XFS internal error [...])
Message-ID: <20061215040703.GB44411608@melbourne.sgi.com>
References: <9a8748490611280749k5c97d21bx2e499d2209d27dfe@mail.gmail.com> <20061129013214.GH44411608@melbourne.sgi.com> <9a8748490611290117oc0ba880v1a6407bc4f41088f@mail.gmail.com> <20061130020734.GB37654165@melbourne.sgi.com> <87bqm89y6g.wl%shinichiro@stained-g.net> <20061213062502.GT44411608@melbourne.sgi.com> <877iwu3k9e.wl%shinichiro@stained-g.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877iwu3k9e.wl%shinichiro@stained-g.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 06:21:49PM +0900, Shinichiro HIDA wrote:
> Hi,
> 
> ;; Sorry for late, and Thanks for following up.
> 
> >>>>> In <20061213062502.GT44411608@melbourne.sgi.com> 
> >>>>>	David Chinner <dgc@sgi.com> wrote:
> > On Wed, Dec 13, 2006 at 02:12:23PM +0900, Shinichiro HIDA wrote:
> > > Hi,
> > > 
> > > I met same problem on my 2 machines, 2.6.19 (Debian unstable) also
> > > 2.6.18.3 (Debian stable),
> > Should have been preceeded with some other output explaining the
> > reason for the shutdown.

> Dec 12 21:31:25 lune kernel: xfs_da_do_buf: bno 16777216
> Dec 12 21:31:25 lune kernel: dir: inode 9078346
> Dec 12 21:31:25 lune kernel: Filesystem "hdf5": XFS internal error xfs_da_do_buf(1) at line 1995 of file fs/xfs/xfs_da_btree.c.  Caller 0xc02982ec

Ok, that bno (16777216) is a definite sign of corruption
caused by the 2.6.17.x (x <=6) kernels.

> > Did these machines run 2.6.17.x where x<= 6?
> > i.e. is this problem:
> 
> > http://oss.sgi.com/projects/xfs/faq.html#dir2
> 
> Yes, I could boot this machine(lune) with 2.6.17.6. 

I wasn't suggesting that you use this kernel - that could cause more
corruption to occur.  What I was asking is if you have run a kernel
of this version in the past (i.e. before you upgraded to 2.6.18.3)?

Regardless, I suggest you get the latest xfsprogs and run xfs_repair
on your filesystems to fix the problem.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
