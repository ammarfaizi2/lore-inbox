Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131231AbQK2TJp>; Wed, 29 Nov 2000 14:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131640AbQK2TJg>; Wed, 29 Nov 2000 14:09:36 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:1802 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S131231AbQK2TJV>; Wed, 29 Nov 2000 14:09:21 -0500
Date: Wed, 29 Nov 2000 10:38:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tigran Aivazian <tigran@veritas.com>
cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <Pine.LNX.4.21.0011291806020.1306-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.10.10011291036180.11951-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Nov 2000, Tigran Aivazian wrote:

> On Wed, 29 Nov 2000, Tigran Aivazian wrote:
> 
> > On Wed, 29 Nov 2000, Linus Torvalds wrote:
> > > That still leaves the SCSI corruption, which could not have been due to
> > > the request issue. What's the pattern there for people?
> 
> one more thing I remember when this happened:
> 
> a) lots of ld processes from kernel compilation were failing with ENOSPC
> although df(1) was showing plenty of memory and I could manually "touch
> ok" in the same filesystem just fine.
> 
> b) immediately restarting "make -j4 bzImage" would go on for quite a bit
> and then hit the same set of .c files and "run out of space" again.

Ehh, this is a stupid question, but I've had that happen too, and it
turned out my /tmp filesystem was full, and it runs out of space only with
certain large link cases (never anything else, because all the other
stages of compilation are done with -pipe and do not use /tmp files).

I'm embarrassed to even mention this, but I'v ebeen confused myself.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
