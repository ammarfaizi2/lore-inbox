Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264451AbRFTQ4P>; Wed, 20 Jun 2001 12:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264443AbRFTQ4F>; Wed, 20 Jun 2001 12:56:05 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:33806 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264401AbRFTQzw>; Wed, 20 Jun 2001 12:55:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Tony Gale <gale@syntax.dera.gov.uk>
Subject: Re: [UPDATE] Directory index for ext2
Date: Wed, 20 Jun 2001 18:58:43 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
        Alexander Viro <viro@math.psu.edu>,
        Andreas Dilger <adilger@turbolinux.com>
In-Reply-To: <0105311813431J.06233@starship> <993049198.3089.2.camel@syntax.dera.gov.uk>
In-Reply-To: <993049198.3089.2.camel@syntax.dera.gov.uk>
MIME-Version: 1.0
Message-Id: <01062018584308.00439@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 June 2001 16:59, Tony Gale wrote:
> The main problem I have with this is that e2fsck doesn't know how to
> deal with it - at least I haven't found a version that will. This makes
> it rather difficult to use, especially for your root fs.

Good, the file format isn't finalized, this is only recommended for use on a 
test partition.

> And, since I used it, and have since stopped using it, I have a problem
> in what all my disk free space disappears over a couple of days - I have
> to run fsck to recover it, were it appears as deleted inodes with zero
> dtime. I can't say for sure that the dir index stuff is at fault though.

It could well be, I'd appreciate any more data you have on that.

> I am currently using 2.4.6-pre3 without the dir patch installed. I am
> using the grsecurity patch though.
>
> I have just upgraded to e2fsprogs-1.21 in the hope of sorting it out. If
> that fails I'll revert to a clean 2.4.6-pre kernel. Other ideas welcome.
>
> -tony
>
> On 31 May 2001 18:13:43 +0200, Daniel Phillips wrote:
> > Changes:
> >
> >   - Freshen to 2.4.5
> >   - EXT2_FEATURE_COMPAT_DIR_INDEX flag finalized
> >   - Break up ext2_add_entry for aesthetic reasons (Al Viro)
> >   - Handle more than 64K directories per directory (Andreas Dilger)
> >   - Bug fix: new inode no longer inherits index flag (Andreas Dilger)
> >   - Bug fix: correct handling of error on index create (Al Viro)
> >
> > To-Do:
> >
> >   - More factoring of ext2_add_entry
> >   - Fall back to linear search in case of corrupted index
> >   - Finalize hash function
