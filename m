Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbVGVT4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVGVT4L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 15:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVGVT4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 15:56:11 -0400
Received: from thunk.org ([69.25.196.29]:23187 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262152AbVGVTyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 15:54:33 -0400
Date: Fri, 22 Jul 2005 15:54:26 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Milind Dumbare <milind@linsyssoft.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: CheckFS: Checkpoints and Block Level Incremental Backup (BLIB)
Message-ID: <20050722195423.GA6851@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Milind Dumbare <milind@linsyssoft.com>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <1122041079.3556.18.camel@matrix.linsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122041079.3556.18.camel@matrix.linsyssoft.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2005 at 07:34:38PM +0530, Milind Dumbare wrote:
> Hi,
> 
> 	LinSysSoft Technologies  has taken up the challenge to incorporate
> Checkpoint and Block Level Incremental Backup (BLIB) support in the open
> source's Ext3 File System, which is very well known for its stability,
> to create a new file system called CheckFS. Block Level Incremental
> Backup enables truly efficient backup and restore mechanisms.
> Checkpoints provide administrators to create point-in-time copies of a
> live file system by keeping track of the data blocks modified in real
> time. 
> 
> For further information and a downloadable working prototype of this
> technology go to : http://checkfs.linsyssoft.com

This looks like very interesting technology, but out of curiosity, why
did you develop this as separate filesystem with a new filesystem
name, and doing a global search-and-replace of "ext3" with "checkfs"
in the source files, instead of simply just modifying ext3 and posting
diffs?  Especially since that the apparent intention is to keep ext3
compatibility using the same ext3 magic numbers, data formats, and
user-mode utilities.

I'll reserve the superblock fields and compatibility bitmap fields
used by your code in e2fsprogs to help avoid the possibility of other
folks working on ext3 extensions from colliding with the codepoints
which you "borrowed", but in the future, it would be good if people
contact me in advance so I ensure that there are no collisions with
other development groups.

What version of the source base did you originally fork checkfs from?
That way we can do a "s/checkfs/ext3/g" search and replace and then
generate some diffs to see what you changed, or alternatively, it
would be even better if you minimized differences between your version
and mainline and generated the diffs yourself.

Thanks, regards, 

						- Ted

