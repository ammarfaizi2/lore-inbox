Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132725AbRDXDID>; Mon, 23 Apr 2001 23:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132727AbRDXDHw>; Mon, 23 Apr 2001 23:07:52 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:16141 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132725AbRDXDHo>; Mon, 23 Apr 2001 23:07:44 -0400
Date: Mon, 23 Apr 2001 22:27:40 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] Move __GFP_IO check in shrink_icache_memory to prune_icache()
In-Reply-To: <Pine.LNX.4.21.0104231837360.1179-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0104232222030.1512-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Apr 2001, Marcelo Tosatti wrote:

> 
> Linus,
> 
> With the prune_icache() modifications which were integrated in pre5 there
> is no more need to avoid non __GFP_IO allocations to go down to
> prune_icache().
> 
> The following patch moves the __GFP_IO check down to prune_icache(),
> allowing !__GFP_IO allocations to free clean unused inodes.

Forget about this. 

We may have to write quota information back to disk while freeing the
inode and then we are fucked. 

