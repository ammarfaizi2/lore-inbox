Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVD0T4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVD0T4S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 15:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVD0T4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 15:56:18 -0400
Received: from thunk.org ([69.25.196.29]:25270 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261984AbVD0T4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 15:56:14 -0400
Date: Wed, 27 Apr 2005 15:55:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, magnus.damm@gmail.com, mason@suse.com,
       mike.taht@timesys.com, mpm@selenic.com, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
Message-ID: <20050427195554.GA7793@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	magnus.damm@gmail.com, mason@suse.com, mike.taht@timesys.com,
	mpm@selenic.com, linux-kernel@vger.kernel.org, git@vger.kernel.org
References: <20050426004111.GI21897@waste.org> <200504260713.26020.mason@suse.com> <aec7e5c305042608095731d571@mail.gmail.com> <200504261138.46339.mason@suse.com> <aec7e5c305042609231a5d3f0@mail.gmail.com> <20050426135606.7b21a2e2.akpm@osdl.org> <Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org> <20050426155609.06e3ddcf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426155609.06e3ddcf.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 03:56:09PM -0700, Andrew Morton wrote:
> - umount the fs
> - tune2fs -O ^has_journal /dev/whatever
> - fsck -fy                              (to clean up the now-orphaned journal inode)

Using moderately recent versions of e2fsprogs, tune2fs will clean up
the journal inode, so there's no reason to do an fsck.  (Harmless, but
it shouldn't be necessary and it takes time).

> - tune2fs -j -J size=nblocks    (normally 4k blocks)

The argument to "-J size" is in megabytes, not in blocks.

						- Ted
