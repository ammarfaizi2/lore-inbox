Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWFGSda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWFGSda (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 14:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWFGSda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 14:33:30 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:9140 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751218AbWFGSd3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 14:33:29 -0400
Date: Wed, 7 Jun 2006 12:33:34 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: Question regarding ext3 extents+mballoc+delalloc
Message-ID: <20060607183334.GD5964@schatzie.adilger.int>
Mail-Followup-To: Holger Kiehl <Holger.Kiehl@dwd.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
References: <Pine.LNX.4.61.0606061021330.31147@diagnostix.dwd.de> <20060606180336.GS5964@schatzie.adilger.int> <Pine.LNX.4.61.0606070604460.24940@diagnostix.dwd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0606070604460.24940@diagnostix.dwd.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 07, 2006  06:50 +0000, Holger Kiehl wrote:
> On Tue, 6 Jun 2006, Andreas Dilger wrote:
> >One of the main reasons this isn't in the kernel yet is that the extents
> >on-disk format is incompatible with the current ext3 on-disk format.
> >That is OK for Lustre because the storage servers are essentially
> >"appliances" that are used in well-controlled environments, but this
> >isn't so good when random users get involved.  The patches couldn't be
> >merged until there was some consensus reached about the extents on-disk
> >format.
>
> Just to ensure that I understand this correctly. The on-disk format is not
> final and it will still change. This means if I use it now I will have
> to reformat the disk when ever the format is changed.

Actually, in the end the format of the current extents is the one that will
be supported by kernel.org kernels.  It may be that there will be another
extents format at some time in the future, but the current format was deemed
good enough for now.

There are still a couple of minor changes that are being worked on, but
a filesystem with the current extents format will be usable in the future.

> As you mention e2fsprogs also needs to be updated:
> 
>    # dumpe2fs -h /dev/md7
>    dumpe2fs 1.38 (30-Jun-2005)
>    dumpe2fs: Filesystem has unsupported feature(s) while trying to open 
>    /dev/md7
>    Couldn't find valid filesystem superblock.
> 
> Are there any patches down loadable, that add support to the e2fsprogs?

Yes, these were posted as part of a whole patch series by Bull to ext2-devel.
You can also download the CFS e2fsprogs-1.38-cfs2 RPMs from
ftp://ftp.lustre.org/pub/lustre/other/e2fsprogs/

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

