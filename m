Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269692AbRHCXZe>; Fri, 3 Aug 2001 19:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269691AbRHCXZY>; Fri, 3 Aug 2001 19:25:24 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:12993 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269695AbRHCXZQ>;
	Fri, 3 Aug 2001 19:25:16 -0400
Date: Fri, 3 Aug 2001 19:25:19 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Wedgwood <cw@f00f.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic
 change patch)
In-Reply-To: <20010804112026.D17925@weta.f00f.org>
Message-ID: <Pine.GSO.4.21.0108031923581.5264-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Aug 2001, Chris Wedgwood wrote:

> On Fri, Aug 03, 2001 at 07:15:59PM -0400, Alexander Viro wrote:
> 
>     <shrug> credentials cache. 2.5 fodder. Notice that with NFS you
>     don't have fsync for directories. At all. So that's not a problem
>     in that particular case - you can pass NULL on all subsequent
>     iterations.  On the first step you need struct file * - NFS needs
>     credentials to pass to the server.
> 
> How about passing NULL then for now? --- and explicitly requiring
> ->fsync accept NULL for the first argument and ignore it?  It would be
> nice to know that this is the case then though, because we could stop
> immediately.

You need credentials to sync a regular file on any network filesystem.

