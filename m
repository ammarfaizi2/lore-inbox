Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293189AbSBYB7U>; Sun, 24 Feb 2002 20:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293257AbSBYB7J>; Sun, 24 Feb 2002 20:59:09 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:44785 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S293189AbSBYB6y>;
	Sun, 24 Feb 2002 20:58:54 -0500
Date: Sun, 24 Feb 2002 20:58:49 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>, mingo@elte.hu,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <E16fA92-0007en-00@wagner.rustcorp.com.au>
Message-ID: <Pine.GSO.4.21.0202242054410.1329-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Feb 2002, Rusty Russell wrote:

> > Note that getting a file descriptor is really quite useful - it means that
> > you can pass the file descriptor around through unix domain sockets, for
> > example, and allow sharing of the semaphore across unrelated processes
> > that way.
> 
> First, fd passing sucks: you can't leave an fd somewhere and wait for
> someone to pick it up, and they vanish when you exit.  Secondly, you

Yes, you can.  Please, RTFS - what is passed is not a descriptor, it's
struct file *.  As soon as datagram is sent, descriptors are resolved and
after that point descriptor table of sender (or, for that matter, survival
of sender) doesn't matter.

