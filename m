Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261650AbSJNO14>; Mon, 14 Oct 2002 10:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261663AbSJNO14>; Mon, 14 Oct 2002 10:27:56 -0400
Received: from SCULLY.TRAFFORD.DEMENTIA.ORG ([128.2.100.230]:45530 "EHLO
	scully.trafford.dementia.org") by vger.kernel.org with ESMTP
	id <S261650AbSJNO1z>; Mon, 14 Oct 2002 10:27:55 -0400
Date: Mon, 14 Oct 2002 10:31:41 -0400 (EDT)
From: Derrick J Brashear <shadow@dementia.org>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: AFS system call registration function (was Re: Two fixes for 2.4.19-pre5-ac3)
In-Reply-To: <20021014152353.A16334@infradead.org>
Message-ID: <Pine.LNX.3.96L.1021014102625.5586G-100000@scully.trafford.dementia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, Christoph Hellwig wrote:

> On Sun, Oct 13, 2002 at 09:58:00PM -0400, Derrick J Brashear wrote:
> > The version we have now uses long, so... (read on)
> 
> I know..
>
> > we have people with deployed utilities which call the afs system call,
> > because, well, it's the AFS system call. it would be good to maintain
> > compatibility with those, which means we should
> > a) keep using the same system call if we can
> > b) if so, keep using "long".
> 
> 
> AFS is currently not in mainline.  You request a new feature, in this
> case an optional syscall that only was reserved previously.  

Well, given the previous commentary I would have expected the hook to have
already existed, and if it had we would have changed to conform to it
months ago. 

> In
> general we don|t merge random stuff asis in the kernel just because it
> happens to exist.  There is no reason you can't add a sane API
> for openafs 1.3

No disagreement (on that). Do you propose we orphan old versions?  (Which
isn't to say "Yes" is a wrong answer)

Also, we're not ready for 1.3 yet. RedHat 8.0's kernel sort of forced the
issue sooner than we would have liked to have dealt with this, and
actually causes another problem; It means the "extra groups" encoding for
PAGs breaks. That's certainly not the end of the world, but the obvious
solution is a Linux Security Module, and at least as yet that's not in
their kernel.







