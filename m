Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129609AbRBYTLW>; Sun, 25 Feb 2001 14:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129610AbRBYTLN>; Sun, 25 Feb 2001 14:11:13 -0500
Received: from mrelay.cc.umr.edu ([131.151.1.89]:1037 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S129609AbRBYTLE>;
	Sun, 25 Feb 2001 14:11:04 -0500
Date: Sun, 25 Feb 2001 13:10:13 -0600
From: David Fries <dfries@umr.edu>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Stale NFS handles on 2.4.2
Message-ID: <20010225131013.E483@d-131-151-189-65.dynamic.umr.edu>
In-Reply-To: <20010214002750.B11906@unthought.net> <20010224141855.B12988@d-131-151-189-65.dynamic.umr.edu> <15000.39826.947692.141119@notabene.cse.unsw.edu.au> <20010224235342.D483@d-131-151-189-65.dynamic.umr.edu> <15000.53110.664338.230709@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15000.53110.664338.230709@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Sun, Feb 25, 2001 at 08:25:10PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2001 at 08:25:10PM +1100, Neil Brown wrote:
> On Saturday February 24, dfries@umr.edu wrote:
> Verrry odd.  I can see why you were suspecting a cache.
> I'm probably going to have to palm this off to Trond, the NFS client
> maintainer (are you listening Trond?) but could please confirm that
> from the client you can:
> 
>  1/ ping server
>  2/ rpcinfo -p server
>  3/ showmount -e server
>  4/ mount server:/exported/filesys /some/other/mount/point
> 
> If all of these work, them I am mistified.  If one of these fails,
> then that might point the way to further investigation.

I have server:/home mounted on /home, the directory /home/david is the
mount file/directory on that mount that has a stale handle, everything
else on that mount point works including accessing any file under
/home/david.

I mounted it on a different directory and the new mount was fine, and
the problem directory on the new mount was fine, but the problem
directory on the old mount was still stale.

Yes it is a ext2 file system being exported.  It is using the kernel
nfs server.

-- 
		+---------------------------------+
		|      David Fries                |
		|      dfries@umr.edu             |
		+---------------------------------+
