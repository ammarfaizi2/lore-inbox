Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313695AbSDPOrc>; Tue, 16 Apr 2002 10:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313699AbSDPOrb>; Tue, 16 Apr 2002 10:47:31 -0400
Received: from [195.223.140.120] ([195.223.140.120]:16964 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313695AbSDPOra>; Tue, 16 Apr 2002 10:47:30 -0400
Date: Tue, 16 Apr 2002 16:47:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre5aa1 and splitted vm-33
Message-ID: <20020416164748.C29747@dualathlon.random>
In-Reply-To: <20020331164815.A1331@dualathlon.random> <20020406170703.A32084@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2002 at 05:07:03PM +0100, Christoph Hellwig wrote:
> > Only in 2.4.19pre5aa1: 20_kiobuf-slab-2
> > 
> > 	Other patch from Chuck Lever to allocate the whole kiobuf from slab,
> > 	using pointer to arrays, to have small structures not larger
> > 	than one page (that would otherwise become sensitive to
> > 	physical ram page granular fragmentation). While auditing and
> > 	merging the patch I also did various small fixes, so please rely
> > 	on this patch as a final version, because the original one had a few
> > 	bugs/leftovers.
> 
> What is the reason for adding kio_ prefixes to the 'blocks' and 'bh' members
> of struct kiobuf? - These fields haven't any new semantics at all, but that
> change increases the delta dramatically.

just a grep feature. Chuck did it and I liked it.

> > 	Merged various fixes, in particular delayed writes should now be
> > 	really flushed by the VM, previously the fact the vm holds
> > 	the page lock was forbidding that. New logic is much cleaner too.
> 
> Do you plan to submit the XFS delalloc changes back to SGI?

They came from the xfs tree actually, so we should be in sync.

Andrea
