Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261783AbTC1AWu>; Thu, 27 Mar 2003 19:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbTC1AWu>; Thu, 27 Mar 2003 19:22:50 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:59076 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261783AbTC1AWt>; Thu, 27 Mar 2003 19:22:49 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Date: Fri, 28 Mar 2003 11:33:30 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16003.39002.755417.556589@notabene.cse.unsw.edu.au>
Subject: ANNOUNCE : nfs-utils 1.0.3
X-Mailer: VM 7.13 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is announcement for the release of 
   nfs-utils 1.0.3

It is available from sourceforge:
   http://nfs.sourgeforge.net
or kernel.org
   http://www.{countrycode}.kernel.org/pub/linux/utils/nfs/

This release is primarily for people using or planning to use
nfsd on  2.5 series kernels.

Other user's may upgrade if they like.  There are a few small fixes 
which might be of interest.  See the Change Log.

The system call interface for exporting filesystems via NFS is defined
using types like "__kernel_dev_t" which should only be used internally 
to the kernel.  Using these in a user-space interface was a poor decission.

There are patches available for 2.5 which change __kernel_dev_t, at least
for i386, to be 32 bit instead of 16 bit.  This is an incompatable change
and nfs-utils does not work correctly on kernels with these patches.

This version of nfs-utils uses an alternate interface which is available
in 2.5 to export file systems.  This interface is not sensitive to changes
in kernel internal type definitions, and so will work independantly of these
patches.

If the new interface is not available (as it is not in 2.4), this version of
nfs-utils will fall back to the old style interface.  Thus this version should
work on all platforms and all kernel releases.

It may be that when these patches are finally included into the mainline, 
we will able to keep the old systemcall interface working.  However as this is
not certain, using 1.0.3 (or later) is probably the best choice.

NeilBrown
