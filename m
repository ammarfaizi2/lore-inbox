Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315784AbSFPBIk>; Sat, 15 Jun 2002 21:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315785AbSFPBIj>; Sat, 15 Jun 2002 21:08:39 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:37355 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315784AbSFPBIj>;
	Sat, 15 Jun 2002 21:08:39 -0400
Date: Sat, 15 Jun 2002 21:08:39 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
In-Reply-To: <UTC200206160048.g5G0mYg11216.aeb@smtp.cwi.nl>
Message-ID: <Pine.GSO.4.21.0206152103250.3241-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 Jun 2002 Andries.Brouwer@cwi.nl wrote:

> As far as I can see, the cycle essentially is
> link_path_walk -> do_follow_link -> page_follow_link -> vfs_follow_link ->.

[snip the obvious strategy that doesn't work]
 
> Now symlink resolution can be entirely iterative.

Wrong.  That breaks for anything with ->follow_link() that can't be expressed
as a single lookup on some path.

For fsck sake, give the folks here some credit - strategy above is _not_
hard to think up and it had been discussed on l-k several times.

