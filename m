Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316127AbSEJVQM>; Fri, 10 May 2002 17:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316128AbSEJVQL>; Fri, 10 May 2002 17:16:11 -0400
Received: from [195.223.140.120] ([195.223.140.120]:275 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316127AbSEJVQK>; Fri, 10 May 2002 17:16:10 -0400
Date: Fri, 10 May 2002 23:17:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Mario Vanoni <vanonim@dial.eunet.ch>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: NFS problem after 2.4.19-pre3, not solved
Message-ID: <20020510231707.M13730@dualathlon.random>
In-Reply-To: <3CDC4962.4B9393D7@dial.eunet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 10:27:46PM +0000, Mario Vanoni wrote:
> Hi Trond, hi Andrea, hi All
> 
> In production environment, since >6 months,
> ethernet 10Mbits/s, on backup_machine
> mount -t nfs production_machine /mnt.
> 
> find `listing from production_machine` | \
> cpio -pdm backup_machine
> 
> Volume ~320MB, nearly constant.
> 
> Medium times:
> 
> 2.4.17-rc1aa1: 1m58s, _the_ champion !!!
> 
> all later's, e.g.:
> 
> 2.4.19-pre8aa2; 4m35s
> 2.4.19-pre8-ac1: 4m00s
> 2.4.19-pre7-rmap13a: 4m02s
> 2.4.19-pre7: 4m35s
> 2.4.19-pre4: 4m20s
> 
> the last usable was:
> 
> 2.4.19-pre3: 2m35s, _not_ a champion
> 
> All benchmarks don't reflect
> some production needs,
> <2 minutes or >4 minutes
> is a great difference !!!

Yep.

Some time ago you told me and Trond that 2.4.19pre8 + this below below
patch applied on top of 2.4.19pre4 returned back to the 2.4.19pre3 2.35
levels (the 1.58-2.35 difference could be not nfs related, and I want to
get to 2.35 first, 2.35-4.20 is a nfs thing).

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa2/00_nfs-backout-cto-1

Could you double check that's the patch that makes the difference if
applied on top of a vanilla 2.4.19pre4?

I cannot figure out why such a patch applied to pre4 fixes the problem,
while it doesn't fix the problem if applied to my tree.

Maybe it wasn't that patch that fixed your problem after all, but one of
the other nfs patches included in pre4. It would be very helpful if you
could double check, just in case.

Many thanks for the feedback! :)

Andrea
