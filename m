Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVEORNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVEORNI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 13:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVEORNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 13:13:08 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:40398 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261655AbVEORNC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 13:13:02 -0400
Date: Sun, 15 May 2005 19:14:37 +0200
From: DervishD <lkml@dervishd.net>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2 optimal partition size
Message-ID: <20050515171437.GC248@DervishD>
Mail-Followup-To: Helge Hafting <helgehaf@aitel.hist.no>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050515160037.GE134@DervishD> <20050515164307.GB26197@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050515164307.GB26197@hh.idb.hist.no>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Helge :)

 * Helge Hafting <helgehaf@aitel.hist.no> dixit:
> On Sun, May 15, 2005 at 06:00:37PM +0200, DervishD wrote:
> >     Hi all :)
> > 
> >     Let's assume I want to partition a hard disk so the partition
> > size is optimal for a given block size and bytes per inode ratio in
> > an ext2/ext3 filesystem. By 'optimal' I mean that no space in the
> > partition is wasted, that is, the metadata and the data blocks fit
> > perfectly in the partition, and no space is left unused because that
> > space is less than a data block.
> > 
> >     For example, if disk structures occupy 1024 bytes and each data
> > block is 1024 bytes too, the partition size must be a multiple of
> > 1024: if I allocate 2049 bytes for the partition, then one byte will
> > be lost because ext2/3 cannot have blocks smaller than the block
> > size.
> > 
> >     So: which is the optimal partition size for a given block size
> > and a given bytes per inode ratio? Can it be easily calculated?
> > 
> You can't allocate 2049 bytes for a partition - it is always a
> whole number of 512-byte blocks.

    That's was just an example, and anyway I can create an ext2/3
filesystem on a file.
 
> Just make sure your partition is a whole number of blocks,
> ext2/ext3 should then be able to utilize the partition fully to the
> last block.

    Do that means that metadata (disk structures, block groups
structs and the like) all fits in block-size chunks???
 
> Using a blocksize equal to the pagesize (i.e. 4096) is usually optimal.

    Thanks, I'll try it :) My main doubt was if the metadata was
managed in block-sized chunks, it seems so.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
