Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317012AbSH1SSA>; Wed, 28 Aug 2002 14:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318166AbSH1SSA>; Wed, 28 Aug 2002 14:18:00 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:8462 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317012AbSH1SR6>; Wed, 28 Aug 2002 14:17:58 -0400
Date: Wed, 28 Aug 2002 11:20:16 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Tomas Szepe <szepe@pinerecords.com>
cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: ide-2.4.20-pre4-ac2.patch
In-Reply-To: <20020828175957.GA15860@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.10.10208281118340.24156-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


WHOA Tomas,

That is a major problem, are you using legacy patch or taskfile io?
Ben H reported he was having problems with legacy path on PPC, but the new
taskfile io worked fine.

On Wed, 28 Aug 2002, Tomas Szepe wrote:

> > This is out and has been forwarded to AC for review.
> 
> Okay, I tested this the hard way -- the root of one of my machines
> got trashed. The controller used was a PDC20268 (Ultra100TX2), the
> disks (with two partitions of equal size on each forming a raid0)
> are IBM and WD. Soon after the kernel came up, it started spitting
> messages like 'DMA disabled' and 'No DRQ after WRITE has been issued',
> after which the machine froze entirely. Rebooting w/ an alternate
> kernel revealed massive fs corruption with the superblock completely
> overwritten.
> 
>   *** Everybody please treat this patch with extreme care. ***
> 
> Reiserfs people, this unfortunate event also made me find out about
> the inability of reiserfsck 3.6.3-pre1 to rebuild the node tree --
> the program pretends to work just fine but the in-kernel fs code
> barfs when it's to operate on a repaired fs. 3.x.1b was able to
> get the job done for me, though.
> 
> T.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

