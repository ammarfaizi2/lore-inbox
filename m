Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267382AbUG2AMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267382AbUG2AMx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267373AbUG2AKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:10:09 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:28906 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267368AbUG2AJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:09:29 -0400
Date: Thu, 29 Jul 2004 11:05:46 +1000
From: Nathan Scott <nathans@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Rutt <rutt.4+news@osu.edu>, linux-kernel@vger.kernel.org
Subject: Re: clearing filesystem cache for I/O benchmarks
Message-ID: <20040729010546.GD800@frodo>
References: <87vfgeuyf5.fsf@osu.edu> <20040726002524.2ade65c3.akpm@osdl.org> <87pt6iq5u2.fsf@osu.edu> <20040726234005.597a94db.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726234005.597a94db.akpm@osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 11:40:05PM -0700, Andrew Morton wrote:
> ...
> However...  If you write any amount of data to a file with O_DIRECT, that
> will, as a side-effect, remove _all_ of that file's pagecache.  In 2.4 as
> well as 2.6.  So you could scrub the pagecache by reading the first 4k then
> writing it back with O_DIRECT.
> 
> However O_DIRECT is supported on very few filesystems in 2.4.  ext2 and
> reiserfs have it.
> 
> XFS in 2.4 has O_DIRECT, I think, but I don't know if the invalidation
> side-effect works on XFS.

Yep, it does.

cheers.

-- 
Nathan
