Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293502AbSBZEG4>; Mon, 25 Feb 2002 23:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293505AbSBZEGq>; Mon, 25 Feb 2002 23:06:46 -0500
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:64389 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S293502AbSBZEG3>;
	Mon, 25 Feb 2002 23:06:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Lightweight userspace semaphores...
Date: Sun, 24 Feb 2002 05:57:39 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Rusty Russell <rusty@rustcorp.com.au>, <mingo@elte.hu>,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        <linux-kernel@vger.kernel.org>, Larry McVoy <lm@bitmover.com>
In-Reply-To: <Pine.LNX.4.33.0202251129480.8991-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0202251129480.8991-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16eqjD-0001QM-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 25, 2002 08:31 pm, Linus Torvalds wrote:
> On Mon, 25 Feb 2002, Alan Cox wrote:
> > Ok I see where you are coming from now -- that makes sense for a few 
> > cases.
> 
> Note that the "few cases" in question imply _all_ of the current broken 
> library spinlocks, for example. 
> 
> Don't think "POSIX semaphores", but think "fast locking" in the general
> case. I will bet you $1 in small change that most normal locking by far is
> for the kind of thread-safe stuff libc does right now.

This looks like another piece of the equation needed to make Larry's smp 
cluster concept come true.  So...

-- 
Daniel
