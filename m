Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314484AbSEXQMW>; Fri, 24 May 2002 12:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317183AbSEXQMV>; Fri, 24 May 2002 12:12:21 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:17571 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314484AbSEXQMT>;
	Fri, 24 May 2002 12:12:19 -0400
Date: Fri, 24 May 2002 12:12:16 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: negative dentries wasting ram
In-Reply-To: <20020524153624.GL21164@dualathlon.random>
Message-ID: <Pine.GSO.4.21.0205241210210.9792-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 May 2002, Andrea Arcangeli wrote:

> The fs access will be exactly the same, only the dentry won't be
> allocated because it's just in the hash, but it has no inode and it
> doesn't correspond to any on-disk dentry, we simply cannot defer the

RTFS.

Lookup on a name that has hashed negative dentry does not touch fs code.
At all.

