Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282376AbRKXGoB>; Sat, 24 Nov 2001 01:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282373AbRKXGnt>; Sat, 24 Nov 2001 01:43:49 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:34088 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S282383AbRKXGnm>; Sat, 24 Nov 2001 01:43:42 -0500
Date: Sat, 24 Nov 2001 07:44:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
Message-ID: <20011124074400.A1601@athlon.random>
In-Reply-To: <20011124072636.B2398@athlon.random> <Pine.GSO.4.21.0111240129470.4000-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.4.21.0111240129470.4000-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Nov 24, 2001 at 01:31:18AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 01:31:18AM -0500, Alexander Viro wrote:
> 
> 
> On Sat, 24 Nov 2001, Andrea Arcangeli wrote:
> 
> > you are screwed because you were running a broken filesystem: it is its
> > own business to drop the inodes if it fails, all it needs to do is to
> > call invalidate_inodes(s) internally before returning from the read_super
> > in the failure case.
> 
> Cute.  Do you realize that _every_ fs would have to do that?

I don't care who has to do it, but who has to do it it has to do it in a
very very very very slow path, and you want to handle it in iput fast
path instead, cute?

Andrea
