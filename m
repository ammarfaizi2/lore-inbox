Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRAEHHQ>; Fri, 5 Jan 2001 02:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130759AbRAEHHG>; Fri, 5 Jan 2001 02:07:06 -0500
Received: from [24.65.192.120] ([24.65.192.120]:60406 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S129610AbRAEHG5>;
	Fri, 5 Jan 2001 02:06:57 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101050706.f0576lB12236@webber.adilger.net>
Subject: Re: [Ext2-devel] Re: [RFC] ext2_new_block() behaviour
In-Reply-To: <20010104232541.J1290@redhat.com> "from Stephen C. Tweedie at Jan
 4, 2001 11:25:41 pm"
To: "Stephen C. Tweedie" <sct@redhat.com>
Date: Fri, 5 Jan 2001 00:06:47 -0700 (MST)
CC: Alexander Viro <viro@math.psu.edu>,
        Andreas Dilger <adilger@enel.ucalgary.ca>,
        Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen, you write:
> On Thu, Jan 04, 2001 at 05:31:12PM -0500, Alexander Viro wrote:
> > BTW, what inumber do you want for whiteouts? IIRC, we decided to use
> > the same entry type as UFS does (14), but I don't remember what was
> > the decision on inumber. UFS uses 1 for them, is it OK with you?
> 
> 0 is used for padding, so 1 makes sense, yes.

Sorry, but what are whiteouts?  Inode 1 in ext2 is the bad blocks inode,
so it will never be used for a valid directory entry, but depending on
what it is we may want to make sure e2fsck is OK with it as well.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
