Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315222AbSFTQa6>; Thu, 20 Jun 2002 12:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSFTQax>; Thu, 20 Jun 2002 12:30:53 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:26889 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315213AbSFTQav>; Thu, 20 Jun 2002 12:30:51 -0400
Date: Thu, 20 Jun 2002 12:26:24 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andreas Dilger <adilger@clusterfs.com>
cc: Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
In-Reply-To: <20020620101812.GL22427@clusterfs.com>
Message-ID: <Pine.LNX.3.96.1020620122107.7612A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2002, Andreas Dilger wrote:

> Remember also that each leaf block merge will incur a copy from the tail
> block (which may need to be read from disk) and then a truncate to drop
> that block.  We _could_ leave some number of empty dir blocks at the end
> of the directory file if we had some sort of dir prealloc scheme happening.
> There would be some amount of hysteresis there to avoid the repeated
> alloc/free overhead (i.e. keep no more than 8 free blocks, but allocate
> 8 blocks at a time if you need more).

Wouldn't the hysteresis be the frag or block size? Is there benefit to
truncating if it doesn't free any disk space? Actually, there might be
benefit to leaving a few empty blocks at the end of the dir when doing
trunc as a means of reducing alloc.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

