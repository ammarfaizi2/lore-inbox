Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135207AbQL3MVv>; Sat, 30 Dec 2000 07:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135208AbQL3MVl>; Sat, 30 Dec 2000 07:21:41 -0500
Received: from [195.84.105.112] ([195.84.105.112]:12462 "HELO
	petrus.schuldei.org") by vger.kernel.org with SMTP
	id <S135207AbQL3MVZ>; Sat, 30 Dec 2000 07:21:25 -0500
Date: Sat, 30 Dec 2000 12:54:17 +0100
From: Andreas Schuldei <andreas@schuldei.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2's inode i_version gone, what now? (stable branch)
Message-ID: <20001230125417.B29582@sigrid.schuldei.com>
In-Reply-To: <20001229220820.C28926@sigrid.schuldei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20001229220820.C28926@sigrid.schuldei.com>; from andreas@schuldei.org on Fri, Dec 29, 2000 at 10:08:20PM +0100
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Schuldei (andreas@schuldei.org) [001229 22:08]:
> However a real problem (for me) is that the author (whom I can not reach by
> email) build stegfs on top of the ext2 filesystem. There he uses ext2's inode
> structure and at some places reads/writes from ext2 inode's i_version.
> However, this is not there in ext2_fs_i.h. But I am working with source for
> 2.2.18 and a lot could have happend since 2.2.14. I would not have expected
> the inode struct to change, though.
> 
> Why was it taken away? How is compatibility maintained? What could I use 
> instead to fix the problem?

Now I think i_version was moved from ext2_fs_i.h (struct ext2_inode_info) to
fs.h (struct inode). stegfs still has i_version in it's own stegfs_inode_info.
I guess to cleanly move the stegfs from 2.2.14 to 2.2.18 it would be good to
not have a own stegfs i_version. Are there any mean, hidden, desasterous
implications waiting if I move it?

> Anyone who is interested in this:
> http://ban.joh.cam.ac.uk/~adm36/StegFS/download.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
