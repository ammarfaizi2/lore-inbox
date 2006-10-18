Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbWJROir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbWJROir (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbWJROir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:38:47 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:57826 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1161039AbWJROiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:38:46 -0400
Date: Wed, 18 Oct 2006 10:38:10 -0400
From: Chris Mason <chris.mason@oracle.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, hch@infradead.org, mhalcrow@us.ibm.com,
       penberg@cs.helsinki.fi, linux-fsdevel@vger.kernel.org
Subject: Re: fsstack: struct path
Message-ID: <20061018143810.GB16570@think.oraclecorp.com>
References: <20061018042323.GA8537@filer.fsl.cs.sunysb.edu> <20061018013103.4ad6311a.akpm@osdl.org> <20061018083527.GJ29920@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018083527.GJ29920@ftp.linux.org.uk>
User-Agent: Mutt/1.5.12-2006-07-14
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 09:35:27AM +0100, Al Viro wrote:
> On Wed, Oct 18, 2006 at 01:31:03AM -0700, Andrew Morton wrote:
> > > One, rather unfortunate, fact is that struct path is also defined in
> > > include/linux/reiserfs_fs.h as something completely different - reiserfs
> > > specific.
> > > 
> > > Any thoughts?
> > > 
> > 
> > reiserfs is being bad.  s/path/reiserfs_path/g
> 
> Indeed.  That's one pending patch that never got around to be submitted
> (and had bitrotten at least 3 times, IIRC).
> 
> ACK, provided that reiserfs folks are OK with the replacement name for
> their struct.  Note that "path" in question has very little to do with
> pathnames - it's a path in balanced tree, IIRC.  So if we get around
> to renaming that sucker, it might be a good time to pick better name.

Aside from having to reindent the reiserfs tree afterwards, I doubt
anyone would mind (please cc reiserfs-dev on the patch though).  Al is
right, it's a path in the balanced tree.

-chris

