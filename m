Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWGaWxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWGaWxx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 18:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWGaWxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 18:53:53 -0400
Received: from mail.gmx.de ([213.165.64.21]:5012 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751436AbWGaWxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 18:53:52 -0400
X-Authenticated: #428038
Date: Tue, 1 Aug 2006 00:53:48 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Theodore Tso <tytso@mit.edu>, Adrian Ulrich <reiser4@blinkenlights.ch>,
       vonbrand@inf.utfsm.cl, ipso@snappymail.ca, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060731225348.GB16440@merlin.emma.line.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
	ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
	jeff@garzik.org, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
References: <20060731175958.1626513b.reiser4@blinkenlights.ch> <20060731165406.GA8526@merlin.emma.line.org> <20060731194127.GA13912@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731194127.GA13912@thunk.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso schrieb am 2006-07-31:

> With the latest e2fsprogs and 2.6 kernels, the online resizing support
> has been merged in, and as long as the filesystem was created with
> space reserved for growing the filesystem (which is now the default,
> or if the filesystem has the off-line prepration step ext2prepare run
> on it), you can run resize2fs on a mounted filesystem and grow an
> ext2/3 filesystem on-line.  And yes, you get more inodes as you add
> more disk blocks, using the original inode ratio that was established
> when the filesystem was created.

That's cool.

The interesting part for some people would be, if I read past postings
correctly, to change the inode ratio in an existing (perhaps even
mounted) file system without losing data.

(I'm not sure how many blocks have to be moved and/or changed for that
purpose, because I know too little about the on-disk ext2 layout, but
since block relocating is already in place for shrink support in the
offline resizer, some of the work appears to be done already.)

-- 
Matthias Andree
