Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262209AbSJNWNG>; Mon, 14 Oct 2002 18:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262218AbSJNWNG>; Mon, 14 Oct 2002 18:13:06 -0400
Received: from ns0.cobite.com ([208.222.80.10]:64263 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S262209AbSJNWNF>;
	Mon, 14 Oct 2002 18:13:05 -0400
Date: Mon, 14 Oct 2002 18:18:55 -0400 (EDT)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@admin
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] raw over raid5: BUG at drivers/block/ll_rw_blk.c:1967
In-Reply-To: <3DAB2DD9.B78639C5@digeo.com>
Message-ID: <Pine.LNX.4.44.0210141815100.2876-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, Andrew Morton wrote:

> David Mansfield wrote:
> > ------------[ cut here ]------------
> > kernel BUG at drivers/block/ll_rw_blk.c:1967!
> 
> I don't think you told us the kernel version?
> 
> There have been recent fixes wrt sizing of the BIOs which the
> direct-io layer sends down.  So please make sure that you're
> testing Linus's current -bk, or 2.5.42 plus
> 

I've tried to test 2.5.42-mm2 but it doesn't compile.  There were (I 
assume 'sard') changes made to remove the DK_MAX_MAJOR etc. but there is 
to patch to drivers/md/md.c so it fails to compile:

# find -name \*.c | xargs grep DK_MAX_MAJOR
./drivers/md/md.c:static unsigned int sync_io[DK_MAX_MAJOR][DK_MAX_DISK];
./drivers/md/md.c:      if ((index >= DK_MAX_DISK) || (major >= 
DK_MAX_MAJOR))
./drivers/md/md.c:              if ((idx >= DK_MAX_DISK) || (major >= 
DK_MAX_MAJOR))

David

-- 
/==============================\
| David Mansfield              |
| david@cobite.com             |
\==============================/

