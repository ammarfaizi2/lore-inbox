Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136244AbRD0WPp>; Fri, 27 Apr 2001 18:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136247AbRD0WPf>; Fri, 27 Apr 2001 18:15:35 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:55563 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136244AbRD0WPZ>; Fri, 27 Apr 2001 18:15:25 -0400
Date: Fri, 27 Apr 2001 15:14:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Pavel Machek <pavel@suse.cz>, Chris Mason <mason@suse.com>,
        <viro@math.psu.edu>, kernel list <linux-kernel@vger.kernel.org>,
        <jack@atrey.karlin.mff.cuni.cz>
Subject: Re: [patch] linux likes to kill bad inodes
In-Reply-To: <200104272207.QAA06020@lynx.turbolabs.com>
Message-ID: <Pine.LNX.4.31.0104271513410.25046-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Apr 2001, Andreas Dilger wrote:
>
> However, since make_bad_inode() only changes the file methods and not
> the superblock

Please just make "make_bad_inode()" just do

	inode->i_sb = bad_super_block;

and do everything else too.

It's not acceptable to make low-level filesystems care about these things.

		Linus

