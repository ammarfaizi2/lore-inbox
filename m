Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314208AbSEBBT7>; Wed, 1 May 2002 21:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314210AbSEBBT6>; Wed, 1 May 2002 21:19:58 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:1932 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S314208AbSEBBT6>;
	Wed, 1 May 2002 21:19:58 -0400
Subject: Re: [STATUS 2.5]  May 1, 2002
From: Stephen Lord <lord@sgi.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Mike Fedyk <mfedyk@matchmail.com>,
        Guillaume Boissiere <boissiere@attbi.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3CD0605D.ACC42AA2@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 01 May 2002 20:11:33 -0500
Message-Id: <1020301894.1171.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-01 at 16:38, Andrew Morton wrote:
> Mike Fedyk wrote:
> > 
> > On Wed, May 01, 2002 at 09:53:37AM -0400, Guillaume Boissiere wrote:
> > > new framebuffer layer, as well as some more delayed disk block
> > > allocation bits.
> > 
> > Actually Andrews work on address_space based writeback is related somewhat,
> > but really it's a rewrite/cleanup of the buffer layer.  Delayed block
> > alocation is helped alot by this, and almost depends on it IIRC.
> > 
> > One vote for a seperate listing in the status for "Address Space based
> > Writeback / Buffer layer cleanup".
> 
> Well the next major step here is going direct
> pagecache<->BIO, bypassing the intermediate submit_bh
> for most I/O.
> 
> Probably that will make most of the performance benefits
> of delayed-allocate go away.

Most of the performance benefits of delayed allocate are that
you do not the hard work of allocating the disk space in each
write call, you get to do it once, in potentially larger chunks,
and often not in the user's context.

Steve



