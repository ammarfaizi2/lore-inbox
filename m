Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283503AbRLDOob>; Tue, 4 Dec 2001 09:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283506AbRLDOmu>; Tue, 4 Dec 2001 09:42:50 -0500
Received: from dsl-213-023-038-097.arcor-ip.net ([213.23.38.97]:64522 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S284382AbRLDOfI>;
	Tue, 4 Dec 2001 09:35:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Donald Becker <becker@scyld.com>, Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Linux/Pro  -- clusters
Date: Tue, 4 Dec 2001 15:37:41 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10112032057070.978-100000@vaio.greennet>
In-Reply-To: <Pine.LNX.4.10.10112032057070.978-100000@vaio.greennet>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16BGhe-0000Pq-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 4, 2001 03:09 am, Donald Becker wrote:
> To bring this branch back on point: we should distinguish between
> design for an arbitrary and unpredictable goal (e.g. 128 way SMP)
> vs. putting some design into things that we are supposed to already
> understan
>    [...]
>    a VFS layer that doesn't require the kernel to know a priori all of
>      the filesystem types that might be loaded

Right, there's a consensus that the fs includes have to fixed and that it 
should be in 2.5.lownum.  The precise plan isn't fully evolved yet ;)

See fsdevel for the thread, 3-4 months ago.  IIRC, the favored idea (Linus's) 
was to make the generic struct inode part of the fs-specific inode instead of 
the other way around, which resolves the question of how the compiler 
calculates the size/layout of an inode.

This is going to be a pervasive change that someone has to do all in one
day, so it remains to be seen when/if that is actually going to happen.

It's also going to break every out-of-tree filesystem.

--
Daniel
