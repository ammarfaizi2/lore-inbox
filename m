Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293306AbSDFQHH>; Sat, 6 Apr 2002 11:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311879AbSDFQHG>; Sat, 6 Apr 2002 11:07:06 -0500
Received: from imladris.infradead.org ([194.205.184.45]:32015 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S293306AbSDFQHF>; Sat, 6 Apr 2002 11:07:05 -0500
Date: Sat, 6 Apr 2002 17:07:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre5aa1 and splitted vm-33
Message-ID: <20020406170703.A32084@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020331164815.A1331@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Only in 2.4.19pre5aa1: 20_kiobuf-slab-2
> 
> 	Other patch from Chuck Lever to allocate the whole kiobuf from slab,
> 	using pointer to arrays, to have small structures not larger
> 	than one page (that would otherwise become sensitive to
> 	physical ram page granular fragmentation). While auditing and
> 	merging the patch I also did various small fixes, so please rely
> 	on this patch as a final version, because the original one had a few
> 	bugs/leftovers.

What is the reason for adding kio_ prefixes to the 'blocks' and 'bh' members
of struct kiobuf? - These fields haven't any new semantics at all, but that
change increases the delta dramatically.

> 	Merged various fixes, in particular delayed writes should now be
> 	really flushed by the VM, previously the fact the vm holds
> 	the page lock was forbidding that. New logic is much cleaner too.

Do you plan to submit the XFS delalloc changes back to SGI?

	Christoph

