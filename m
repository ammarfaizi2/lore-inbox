Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317196AbSEXQZu>; Fri, 24 May 2002 12:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSEXQZs>; Fri, 24 May 2002 12:25:48 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:38851 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317196AbSEXQYj>;
	Fri, 24 May 2002 12:24:39 -0400
Date: Fri, 24 May 2002 12:24:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: negative dentries wasting ram
In-Reply-To: <20020524162119.GA15703@dualathlon.random>
Message-ID: <Pine.GSO.4.21.0205241222380.9792-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 May 2002, Andrea Arcangeli wrote:

> it's not a common case to delete a file and then to try to access it,

I'm less than sure about that.

> while there are common cases that wants to avoid stale dentries around
> for deleted files.

Keep in mind that e.g. rm -rf on a tree _will_ evict the dentries in
question, so quite a few of these cases actually don't leave the stuff
behind.

