Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129442AbRBWJbX>; Fri, 23 Feb 2001 04:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129608AbRBWJbO>; Fri, 23 Feb 2001 04:31:14 -0500
Received: from mons.uio.no ([129.240.130.14]:28089 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S129442AbRBWJbC>;
	Fri, 23 Feb 2001 04:31:02 -0500
To: Russell King <rmk@arm.linux.org.uk>
Cc: samcconn@cotw.com (Scott A McConnell), linux-kernel@vger.kernel.org
Subject: Re: nfs_refresh_inode: inode number mismatch
In-Reply-To: <200102222159.f1MLxb031306@flint.arm.linux.org.uk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Content-Type: text/plain; charset=US-ASCII
Date: 23 Feb 2001 10:30:34 +0100
In-Reply-To: Russell King's message of "Thu, 22 Feb 2001 21:59:37 +0000 (GMT)"
Message-ID: <shsae7dn3ut.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Russell King <rmk@arm.linux.org.uk> writes:

     > Scott A McConnell writes:
    >> I am running RedHat Linux version 2.2.16-3 on my PC and Hardhat
    >> Linux version 2.4.0-test5 on my MIPS board. Any thoughts or
    >> suggestions?
    >>
    >> I saw a discussion start on the ARM list along these lines but
    >> I never saw a solution.

     > The problem is partly caused by the NFS server indefinitely
     > caching NFS request XIDs to responses, and the NFS client not
     > having a way to generate a random initial XID.  (thus, for each
     > reboot, it starts at the same XID number).

That shouldn't be true in the latest kernels. knfsd should normally
cache requests for no longer than 2 minutes with the changes made by
Neil following your bugreport.

Cheers,
   Trond
