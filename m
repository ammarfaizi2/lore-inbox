Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261789AbSJNBnn>; Sun, 13 Oct 2002 21:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261795AbSJNBnn>; Sun, 13 Oct 2002 21:43:43 -0400
Received: from SCULLY.TRAFFORD.DEMENTIA.ORG ([128.2.100.230]:59348 "EHLO
	scully.trafford.dementia.org") by vger.kernel.org with ESMTP
	id <S261789AbSJNBnm>; Sun, 13 Oct 2002 21:43:42 -0400
Date: Sun, 13 Oct 2002 21:48:10 -0400 (EDT)
From: Derrick J Brashear <shadow@dementia.org>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: AFS system call registration function (was Re: Two fixes for 2.4.19-pre5-ac3)
In-Reply-To: <20021013141135.A15708@infradead.org>
Message-ID: <Pine.LNX.3.96L.1021013214541.5586B-100000@scully.trafford.dementia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002, Christoph Hellwig wrote:

> On Sat, Oct 12, 2002 at 05:58:29PM -0400, shadow@andrew.cmu.edu wrote:
> > And then, xyzzy, and nothing happened.
> > Anyhow, this implements more or less exactly what's in 2.4.19 for nfs,
> > and adds the necessary wrapper for s390x.
> 
> Please don't put it into the NFS files. 

what NFS files? It changes sys call tables, adds a header which is
completely new, and augments fs/filesystems.c, which in my source is:
"table of configured filesystems"

> And I'd suggest to use u32
> instead of long for the interface, to simplify 32bit compatiblity.

Ok.

> Also, what exactly is this call doing?  I seems to be yet another
> multiplexer syscall and we already have more than enough of those.

Who wants to share theirs with us? Note that it was already reserved for
us (look at the comments in the sys call table diffs) and we've been using
it for years.





