Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264727AbSJOV7H>; Tue, 15 Oct 2002 17:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264731AbSJOV7H>; Tue, 15 Oct 2002 17:59:07 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:38894 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S264727AbSJOV6o>; Tue, 15 Oct 2002 17:58:44 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 15 Oct 2002 16:01:44 -0600
To: Andreas Gruenbacher <agruen@suse.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Add extended attributes to ext2/3
Message-ID: <20021015220144.GK15552@clusterfs.com>
Mail-Followup-To: Andreas Gruenbacher <agruen@suse.de>,
	Theodore Ts'o <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <200210151640.15581.agruen@suse.de> <20021015182943.GA1335@think.thunk.org> <200210152300.32190.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210152300.32190.agruen@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 15, 2002  23:00 +0200, Andreas Gruenbacher wrote:
> The original ext2_new_inode with no xattr/acl patches calls mark_inode_dirty 
> before unlock_super. This call is not removed in 0.8.50 or 0.8.51, but a 
> second call is added below ext2_init_acl. Since ext2_init_acl takes care of 
> dirtying the inode itself this second call is no longer needed (I hope!)

Just as an FYI - marking ext3 inodes dirty is an expensive operation,
and should be done only once if at all possible (not sure if the same
code applies to ext3 as you are discussing ext2, but I thought I should
mention it).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

