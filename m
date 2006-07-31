Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWGaTmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWGaTmM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWGaTmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:42:11 -0400
Received: from thunk.org ([69.25.196.29]:33159 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932243AbWGaTmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:42:05 -0400
Date: Mon, 31 Jul 2006 15:41:28 -0400
From: Theodore Tso <tytso@mit.edu>
To: Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060731194127.GA13912@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
	ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
	jeff@garzik.org, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
References: <20060731175958.1626513b.reiser4@blinkenlights.ch> <20060731165406.GA8526@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731165406.GA8526@merlin.emma.line.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 06:54:06PM +0200, Matthias Andree wrote:
> > > This looks rather like an education issue rather than a technical limit.
> > 
> > We aren't talking about the same issue: I was asking to do it
> > on-the-fly. Umounting the filesystem, running e2fsck and resize2fs
> > is something different ;-)
> 
> There was stuff by Andreas Dilger, to support "online" resizing of
> mounted ext2 file systems. I never cared to look for this (does it
> support ext3, does it work with current kernels, merge status) since
> offline resizing was always sufficient for me.

With the latest e2fsprogs and 2.6 kernels, the online resizing support
has been merged in, and as long as the filesystem was created with
space reserved for growing the filesystem (which is now the default,
or if the filesystem has the off-line prepration step ext2prepare run
on it), you can run resize2fs on a mounted filesystem and grow an
ext2/3 filesystem on-line.  And yes, you get more inodes as you add
more disk blocks, using the original inode ratio that was established
when the filesystem was created.

						- Ted
