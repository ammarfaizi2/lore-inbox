Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbRADWbq>; Thu, 4 Jan 2001 17:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbRADWbg>; Thu, 4 Jan 2001 17:31:36 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:13264 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132263AbRADWbZ>;
	Thu, 4 Jan 2001 17:31:25 -0500
Date: Thu, 4 Jan 2001 17:31:12 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Andreas Dilger <adilger@enel.ucalgary.ca>,
        Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] Re: [RFC] ext2_new_block() behaviour
In-Reply-To: <20010104220433.T1290@redhat.com>
Message-ID: <Pine.GSO.4.21.0101041721531.20875-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2001, Stephen C. Tweedie wrote:

> The problem with directories is that they don't always grow rapidly
> like that.  Spool directories are perfect examples of directories
> which grow sporadically over a long time, which is why we wanted
> persistent preallocation.

OK... It could be dealt with analog of defragmentation-on-write a-la *BSD,
but that's a different story. Oh, well... I still think that we would
benefit from doing normal prealloc for all objects, though. In addition
to persistent prealloc for directories, that is - the latter will become
faster and ext2_alloc_block() will become simpler.

BTW, what inumber do you want for whiteouts? IIRC, we decided to use
the same entry type as UFS does (14), but I don't remember what was
the decision on inumber. UFS uses 1 for them, is it OK with you?

Al, putting together fs patches for -bird...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
