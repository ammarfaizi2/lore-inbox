Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWFIIUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWFIIUL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 04:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWFIIUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 04:20:10 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:35807 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751419AbWFIIUI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 04:20:08 -0400
Date: Fri, 9 Jun 2006 02:20:14 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Valdis.Kletnieks@vt.edu
Cc: cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609082013.GP5964@schatzie.adilger.int>
Mail-Followup-To: Valdis.Kletnieks@vt.edu, cmm@us.ibm.com,
	linux-kernel@vger.kernel.org,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-fsdevel@vger.kernel.org
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <200606090240.k592enXj009395@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606090240.k592enXj009395@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 08, 2006  22:40 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 08 Jun 2006 18:20:54 PDT, Mingming Cao said:
> > To address this need, there are co-effort from RedHat, ClusterFS, IBM
> > and BULL to move ext3 from 32 bit filesystem to 48 bit filesystem,
> > expanding ext3 filesystem limit from 8TB today to 1024 PB. The 48 bit
> > ext3 is build on top of extent map changes for ext3, originally from
> > Alex Tomas. In short, the new ext3 on-disk extents format is:
> 
> which implies matching changes to mkfs.ext2 and possibly mount..

The extents format doesn't need any support from mke2fs.  Currently this
is activated by a mount option "-o extents", so it won't be used until
a system administrator actively enables it.

> > Appreciate any comments and feedbacks!
> 
> Somebody else was recently discussing a set of patches to ext3 for
> extents+delalloc+mballoc patches - is this work compatible with that?

Yes, completely compatible (author is the same person).  We have all been
working to get these improvements into the vanilla kernel so that everyone
can benefit from the improved performance.  These patches are just the
start - the mballoc and delalloc patches are follow-on patches, but they
do not affect the on-disk format just the in-memory implementation of
block allocation.

> Also, a pointer to the matching userspace patches would help anybody
> who's gung-ho enough to test the code....

They were posted to the ext2-devel mailing list previously, or you can
download a patched RPM at ftp://ftp.lustre.org/pub/lustre/other/e2fsprogs/
(the extent support is making its way into the official e2fsprogs also).

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

