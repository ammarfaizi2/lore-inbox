Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWGZLUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWGZLUm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 07:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWGZLUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 07:20:42 -0400
Received: from mail.gmx.de ([213.165.64.21]:4531 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932241AbWGZLUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 07:20:42 -0400
X-Authenticated: #428038
Date: Wed, 26 Jul 2006 13:20:39 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: David Masover <ninja@slaphack.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060726112039.GA18329@merlin.emma.line.org>
Mail-Followup-To: David Masover <ninja@slaphack.com>,
	LKML <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <200607242151.k6OLpDZu009297@laptop13.inf.utfsm.cl> <200607251708.13660.vda.linux@googlemail.com> <20060725204910.GA4807@merlin.emma.line.org> <44C6A390.2040001@slaphack.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C6A390.2040001@slaphack.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006, David Masover wrote:

> Matthias Andree wrote:
> > On Tue, 25 Jul 2006, Denis Vlasenko wrote:
> > 
> >> I, on the contrary, want software to impose as few limits on me
> >> as possible.
> > 
> > As long as it's choosing some limit, I'll pick the one with fewer
> > surprises.
> 
> Running out of inodes would be pretty surprising for me.

No offense: Then it was a surprise for you because you closed your eyes
and didn't look at df -i or didn't have monitors in place.

There is no way to ask how many files with particular hash values you
can still stuff into a reiserfs 3.X. There, you're running into a brick
wall that only your forehead will "see" when you touch it.

Of course, different sites have different needs and if you need
gazillions of inodes or file names, you may see trouble.

But the assertion that some backup was the cause for inode exhaustion on
ext? is not very plausible since hard links do not take up inodes,
symlinks are not backups and everything else requires disk blocks. So,
since reformatting ext2/ext3 to one inode per block is possible
(regardless of disk capacity), I see no way how a reformatted file
system might run out of inodes before it runs out of blocks.

-- 
Matthias Andree
