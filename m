Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbRFTPAy>; Wed, 20 Jun 2001 11:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264887AbRFTPAo>; Wed, 20 Jun 2001 11:00:44 -0400
Received: from relay.dera.gov.uk ([192.5.29.49]:28934 "HELO relay.dera.gov.uk")
	by vger.kernel.org with SMTP id <S264886AbRFTPAd>;
	Wed, 20 Jun 2001 11:00:33 -0400
Subject: Re: [UPDATE] Directory index for ext2
From: Tony Gale <gale@syntax.dera.gov.uk>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
        Alexander Viro <viro@math.psu.edu>,
        Andreas Dilger <adilger@turbolinux.com>
In-Reply-To: <0105311813431J.06233@starship>
In-Reply-To: <0105311813431J.06233@starship>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 20 Jun 2001 15:59:58 +0100
Message-Id: <993049198.3089.2.camel@syntax.dera.gov.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The main problem I have with this is that e2fsck doesn't know how to
deal with it - at least I haven't found a version that will. This makes
it rather difficult to use, especially for your root fs.

And, since I used it, and have since stopped using it, I have a problem
in what all my disk free space disappears over a couple of days - I have
to run fsck to recover it, were it appears as deleted inodes with zero
dtime. I can't say for sure that the dir index stuff is at fault though.
I am currently using 2.4.6-pre3 without the dir patch installed. I am
using the grsecurity patch though.

I have just upgraded to e2fsprogs-1.21 in the hope of sorting it out. If
that fails I'll revert to a clean 2.4.6-pre kernel. Other ideas welcome.

-tony



On 31 May 2001 18:13:43 +0200, Daniel Phillips wrote:
> Changes:
> 
>   - Freshen to 2.4.5
>   - EXT2_FEATURE_COMPAT_DIR_INDEX flag finalized
>   - Break up ext2_add_entry for aesthetic reasons (Al Viro)
>   - Handle more than 64K directories per directory (Andreas Dilger)
>   - Bug fix: new inode no longer inherits index flag (Andreas Dilger)
>   - Bug fix: correct handling of error on index create (Al Viro)
> 
> To-Do:
> 
>   - More factoring of ext2_add_entry
>   - Fall back to linear search in case of corrupted index
>   - Finalize hash function
> 


