Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282372AbRKXGcJ>; Sat, 24 Nov 2001 01:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282373AbRKXGb7>; Sat, 24 Nov 2001 01:31:59 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:57527 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282372AbRKXGbm>;
	Sat, 24 Nov 2001 01:31:42 -0500
Date: Sat, 24 Nov 2001 01:31:18 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
In-Reply-To: <20011124072636.B2398@athlon.random>
Message-ID: <Pine.GSO.4.21.0111240129470.4000-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Nov 2001, Andrea Arcangeli wrote:

> you are screwed because you were running a broken filesystem: it is its
> own business to drop the inodes if it fails, all it needs to do is to
> call invalidate_inodes(s) internally before returning from the read_super
> in the failure case.

Cute.  Do you realize that _every_ fs would have to do that?

