Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265223AbSJRUuB>; Fri, 18 Oct 2002 16:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265311AbSJRUuB>; Fri, 18 Oct 2002 16:50:01 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:34293 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S265223AbSJRUuA>; Fri, 18 Oct 2002 16:50:00 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 18 Oct 2002 14:50:43 -0600
To: tytso@mit.edu
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] Add default mount options support to ext2/3
Message-ID: <20021018205043.GO14989@clusterfs.com>
Mail-Followup-To: tytso@mit.edu, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <E182cAR-0000vl-00@snap.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E182cAR-0000vl-00@snap.thunk.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 18, 2002  14:48 -0400, tytso@mit.edu wrote:
> This patch adds support for default mount options to be stored in the
> superblock, so they don't have to be specified on the mount command line
> (or in /etc/fstab).
> 
> This patch assumes that the ext2/3 extended attribute and ACL patches
> have been applied first.  Support for setting this new superblock field
> is available in the e2fsprogs BK repository.

I think this one is a stand-alone patch that could be applied without
the others, and could probably be submitted as a prereq to the EA and
ACL patches instead of the other way around...

You also are missing the settings for default journaling mode - a few
people have expressed interest in this, especially for the root fs,
where it is somewhat non-obvious to specify the journaling mode.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

