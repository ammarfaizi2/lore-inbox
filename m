Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261806AbSJNBxa>; Sun, 13 Oct 2002 21:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261808AbSJNBxa>; Sun, 13 Oct 2002 21:53:30 -0400
Received: from SCULLY.TRAFFORD.DEMENTIA.ORG ([128.2.100.230]:61908 "EHLO
	scully.trafford.dementia.org") by vger.kernel.org with ESMTP
	id <S261806AbSJNBx3>; Sun, 13 Oct 2002 21:53:29 -0400
Date: Sun, 13 Oct 2002 21:58:00 -0400 (EDT)
From: Derrick J Brashear <shadow@dementia.org>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: AFS system call registration function (was Re: Two fixes for 2.4.19-pre5-ac3)
In-Reply-To: <Pine.LNX.3.96L.1021013214541.5586B-100000@scully.trafford.dementia.org>
Message-ID: <Pine.LNX.3.96L.1021013215608.5586C-100000@scully.trafford.dementia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002, Derrick J Brashear wrote:

Actually:

> > And I'd suggest to use u32
> > instead of long for the interface, to simplify 32bit compatiblity.
> 
> Ok.

The version we have now uses long, so... (read on)

> > Also, what exactly is this call doing?  I seems to be yet another
> > multiplexer syscall and we already have more than enough of those.
> 
> Who wants to share theirs with us? Note that it was already reserved for
> us (look at the comments in the sys call table diffs) and we've been using
> it for years.

we have people with deployed utilities which call the afs system call,
because, well, it's the AFS system call. it would be good to maintain
compatibility with those, which means we should
a) keep using the same system call if we can
b) if so, keep using "long".



