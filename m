Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132770AbRDQQ7h>; Tue, 17 Apr 2001 12:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132769AbRDQQ7a>; Tue, 17 Apr 2001 12:59:30 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:25650 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S132762AbRDQQ7I>; Tue, 17 Apr 2001 12:59:08 -0400
Date: Tue, 17 Apr 2001 12:59:06 -0400 (EDT)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Scalable FD Management using Read-Copy-Update
In-Reply-To: <20010417145809.A21310@in.ibm.com>
Message-ID: <Pine.LNX.4.10.10104171257310.9534-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > isn't this a solution in search of a problem?
> > does it make sense to redesign parts of the kernel for the sole
> > purpose of making a completely unrealistic benchmark run faster?
> 
> Irrespective of the usefulness of the "chat" benchmark, it seems
> that there is a problem of scalability as long as CLONE_FILES is
> supported. John Hawkes (SGI) posted some nasty numbers on a
> 32 CPU mips machine in the lse-tech list some time ago.

that's not the point.  the point is that this has every sign of 
being premature optimization.  the "chat" benchmark does no work,
it only generates load.  and yes, indeed, you can cause contention
if you apply enough load in the right places.  this does NOT indicate
that any real apps apply the same load in the same places.

