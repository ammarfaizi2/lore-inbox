Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRADEm6>; Wed, 3 Jan 2001 23:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRADEmt>; Wed, 3 Jan 2001 23:42:49 -0500
Received: from waste.org ([209.173.204.2]:9990 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S129324AbRADEmj>;
	Wed, 3 Jan 2001 23:42:39 -0500
Date: Wed, 3 Jan 2001 22:42:20 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alexander Viro <viro@math.psu.edu>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Andreas Dilger <adilger@enel.ucalgary.ca>,
        Andreas Dilger <adilger@turbolinux.com>,
        <linux-kernel@vger.kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] Re: [RFC] ext2_new_block() behaviour
In-Reply-To: <Pine.GSO.4.21.0101031051080.15658-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0101032234450.1971-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Alexander Viro wrote:

> On Wed, 3 Jan 2001, Stephen C. Tweedie wrote:
>
> > Having preallocated blocks allocated immediately is deliberate:
> > directories grow slowly and remain closed most of the time, so the
> > normal preallocation regime of only preallocating open files and
> > discarding preallocation on close just doesn't work.
>
> Erm. For directories we would not have the call of discard_prealloc()
> on close(2) - they have NULL ->release() anyway and for them it would
> happen only on ext2_put_inode(), i.e. upon the final dput(). Which would
> not happen while some descendent would stay in dcache.

I bet it long predates dcache though..

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
