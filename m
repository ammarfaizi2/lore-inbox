Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267322AbTA2Uys>; Wed, 29 Jan 2003 15:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267335AbTA2Uys>; Wed, 29 Jan 2003 15:54:48 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:38809 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267322AbTA2Uyr>; Wed, 29 Jan 2003 15:54:47 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mikael Pettersson <mikpe@csd.uu.se>
Date: Thu, 30 Jan 2003 08:03:39 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15928.16811.851512.105997@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: 2.5.59 NFS server keeps local fs live after being stopped
In-Reply-To: message from Mikael Pettersson on Wednesday January 29
References: <15927.56648.966141.528675@harpo.it.uu.se>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday January 29, mikpe@csd.uu.se wrote:
> Kernel 2.5.59. A local ext2 file system is mounted at $MNTPNT
> and exported through NFS V3. A client mounts and unmounts it,
> w/o any I/O in between. The NFS server is shut down. Nothing in
> user-space refers to $MNTPNT.
> 
> The bug is that $MNTPNT now can't be unmounted. umount fails with
> "device is busy". A forced umount at shutdown fails with "device
> or resource busy" and "illegal seek", and leaves the underlying
> fs marked dirty.
> 
> I can't say exactly when this began, but the problem is present
> in 2.5.59 and 2.5.55. 2.4.21-pre4 does not have this problem.

How do you shut down the nfs server?
Is anything in /proc/fs/nfs/export after the shutdown?

NeilBrown

> 
> /Mikael
