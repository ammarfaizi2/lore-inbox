Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132002AbQK2SsM>; Wed, 29 Nov 2000 13:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131989AbQK2SsC>; Wed, 29 Nov 2000 13:48:02 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:56307 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S131919AbQK2Srw>;
        Wed, 29 Nov 2000 13:47:52 -0500
Date: Wed, 29 Nov 2000 13:17:25 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Tigran Aivazian <tigran@veritas.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <Pine.LNX.4.21.0011291806020.1306-100000@penguin.homenet>
Message-ID: <Pine.GSO.4.21.0011291316400.14112-100000@weyl.math.psu.edu>
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

Consistent with bitmap corruption - counters are out of sync with the
block/inode bitmaps.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
