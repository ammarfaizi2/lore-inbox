Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312412AbSDJC5J>; Tue, 9 Apr 2002 22:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312413AbSDJC5I>; Tue, 9 Apr 2002 22:57:08 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:10999 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S312412AbSDJC5I>; Tue, 9 Apr 2002 22:57:08 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 9 Apr 2002 20:55:04 -0600
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: "Alexis S. L. Carvalho" <alexis@cecm.usp.br>, linux-kernel@vger.kernel.org
Subject: Re: implementing soft-updates
Message-ID: <20020410025504.GD424@turbolinux.com>
Mail-Followup-To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	"Alexis S. L. Carvalho" <alexis@cecm.usp.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020409184605.A13621@cecm.usp.br> <200204100041.g3A0fSj00928@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 09, 2002  20:41 -0400, Albert D. Cahalan wrote:
> In case you are still thinking about what to do, here are a
> few filesystem ideas that you might like:
> 
> ext2 compression (e2compr)
- project needs polishing, integration
> delayed allocation (allocate space only when about to do IO)
- Andrew Morton has done this for 2.5
> while rw mounted: defrag, undelete (not trash bin), grow, shrink, fsck
- Andrew Morton has implemented for ext3 (kernel space, needs user tool)
> make ext2 extents work
- yes, discussion ongoing on ext2-devel, no real progress yet
> make ext2 handle huge block sizes
- kernel issues w.r.t. buffers > PAGE_SIZE
> mark idle filesystems clean; mark dirty before non-atomic updates
- maybe marginally useful
> tools for in-place filesystem conversion (ufs --> ext2)
- existing project
> try larger inodes (example: 168-byte, 3 in 512 bytes, 0,1,2,x,4,5,6,x,8...)
- discussion ongoing on ext2-devel with some good progress

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

