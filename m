Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbSJIND3>; Wed, 9 Oct 2002 09:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261711AbSJIND3>; Wed, 9 Oct 2002 09:03:29 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:22543 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261686AbSJIND3>; Wed, 9 Oct 2002 09:03:29 -0400
Date: Wed, 9 Oct 2002 14:09:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] [PATCH 3/4] Add extended attributes to ext2/3
Message-ID: <20021009140900.A22105@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <E17yymK-00021n-00@think.thunk.org> <20021008195322.A14585@infradead.org> <20021008222140.GB9842@think.thunk.org> <20021009064242.GW3045@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021009064242.GW3045@clusterfs.com>; from adilger@clusterfs.com on Wed, Oct 09, 2002 at 12:42:42AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 12:42:42AM -0600, Andreas Dilger wrote:
> Well, for people who are using these features, it is irrelevant whether
> you can configure them separately or not.  However, for people who do
> not use these features, it is just more "bloat" that is being added to
> their kernel.  Certainly the EA and ACL code have a noticable size, so
> having a config option can only be good for those users.  Sure - make
> it default to "on" for people who don't know any better, but it is
> still nice to be able to tune things as needed (e.g. for a small box
> which needs a journaling fs, but not fancy features).

Well, the ACL code would be depend on CONFIG_FS_POSIX_ACL as in XFS and
JFS.  We might want one XATTR config option for ext2/ext3 if this is a
real concern for people (it might be a good idea after thinking a bit
more about it).  IMHO we should end up with one option for xattr support
in ext2, one for xattrs in ext3 and one for all filesystems for ACLs.

