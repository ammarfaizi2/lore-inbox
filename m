Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbUCEAUv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 19:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbUCEAUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 19:20:51 -0500
Received: from moraine.clusterfs.com ([66.246.132.190]:16558 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262033AbUCEAUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 19:20:50 -0500
Date: Thu, 4 Mar 2004 17:20:46 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Blaschke <blaschke@us.ibm.com>
Subject: Re: [PATCH] JFS DMAPI
Message-ID: <20040305002046.GM1219@schnapps.adilger.int>
Mail-Followup-To: Dave Kleikamp <shaggy@austin.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Dave Blaschke <blaschke@us.ibm.com>
References: <1078444492.9162.56.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078444492.9162.56.camel@shaggy.austin.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 04, 2004  17:54 -0600, Dave Kleikamp wrote:
> Would you consider adding this patch to -mm?  This would add the DMAPI
> interface to JFS.  This function has long been requested by HSMs
> (Hierarchical Storage Managers).  It is based on SGI's XFS
> implementation, but has been clean up to avoid their vnode interface.
> 
> Most of the code is in the fs/jfs/dmapi subdirectory.  The amount of
> code in the normal jfs codepaths is quite small.  There is no code
> outside of fs/jfs.

It looks like the largest portion of this code is actually not JFS specific.
Why not put the common code into fs/dmapi instead of fs/jfs/dmapi and then
there will be some possibility that the XFS and JFS DMAPI implementations
will become a single one (only one place to fix bugs, etc), and also give
the opportunity to have DMAPI support in other filesystems?

I'm sure Christoph will jump all over this (even though his name is in the
code), so I thought I'd do it nicely first ;-).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

