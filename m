Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129834AbRADSyC>; Thu, 4 Jan 2001 13:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131730AbRADSxw>; Thu, 4 Jan 2001 13:53:52 -0500
Received: from zeus.kernel.org ([209.10.41.242]:62215 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129834AbRADSxj>;
	Thu, 4 Jan 2001 13:53:39 -0500
Date: Thu, 4 Jan 2001 18:52:04 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Schuldei <andreas@schuldei.org>
Cc: Stephen Tweedie <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: ext2's inode i_version gone, what now? (stable branch)
Message-ID: <20010104185204.B2034@redhat.com>
In-Reply-To: <20001229220820.C28926@sigrid.schuldei.com> <20001230125417.B29582@sigrid.schuldei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001230125417.B29582@sigrid.schuldei.com>; from andreas@schuldei.org on Sat, Dec 30, 2000 at 12:54:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Dec 30, 2000 at 12:54:17PM +0100, Andreas Schuldei wrote:
> > 
> > Why was it taken away? How is compatibility maintained? What could I use 
> > instead to fix the problem?
> 
> Now I think i_version was moved from ext2_fs_i.h (struct ext2_inode_info) to
> fs.h (struct inode). stegfs still has i_version in it's own stegfs_inode_info.
> I guess to cleanly move the stegfs from 2.2.14 to 2.2.18 it would be good to
> not have a own stegfs i_version. Are there any mean, hidden, desasterous
> implications waiting if I move it?

It changed from i_version to i_generation, and NFS serving will break
in subtle ways if you reuse it.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
