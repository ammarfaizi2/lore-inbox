Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293327AbSBZBgn>; Mon, 25 Feb 2002 20:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292944AbSBZBgd>; Mon, 25 Feb 2002 20:36:33 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:16837 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S292631AbSBZBg1>;
	Mon, 25 Feb 2002 20:36:27 -0500
Date: Mon, 25 Feb 2002 20:36:25 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Craig Christophel <merlin@transgeek.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alpha -- quota locking -- rfh
In-Reply-To: <20020226011851Z289189-18099+56@thor.valueweb.net>
Message-ID: <Pine.GSO.4.21.0202252023310.3162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Feb 2002, Craig Christophel wrote:

> Ok,
> 
> 	I have changed the quota locking schematics.  dquot_lock is now used to 
> protect all of the non-blocking operations.  lock_kernel is reduced to 
> inode->i_blocks coverage.  Be warned this patch is very alpha, but any extra 
> eyes on the source are very welcome.  

Sigh...  I guess I'm to blame here - I should've warned you when you had sent
the first mail.  My apologies.  Situation with quota:

	* variant in the tree is obsolete and needs resync with Jan (quota
maintainer)
	* threading old (== in-tree) quota is counterproductive - it will need
to be done from scratch after merge _and_ it will only make merge harder.
	* said merge ( basically, split of delta into edible pieces and
feeding them to Linus) won't be trivial - patch is large.
	* if you are willing to do that - great, coordinate this stuff with
Jan and go ahead.  I'd be glad to help if there are any troubles.

