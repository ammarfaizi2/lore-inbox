Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132760AbRD1KL3>; Sat, 28 Apr 2001 06:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132797AbRD1KLT>; Sat, 28 Apr 2001 06:11:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47369 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132760AbRD1KLL>;
	Sat, 28 Apr 2001 06:11:11 -0400
Date: Sat, 28 Apr 2001 12:05:14 +0200
From: Jens Axboe <axboe@suse.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Vojtech Pavlik <vojtech@suse.cz>,
        Alexander Viro <viro@math.psu.edu>, Andrea Arcangeli <andrea@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010428120514.C517@suse.de>
In-Reply-To: <Pine.LNX.4.21.0104270951270.2067-100000@penguin.transmeta.com> <200104280455.f3S4tQ8336512@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104280455.f3S4tQ8336512@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Sat, Apr 28, 2001 at 12:55:26AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28 2001, Albert D. Cahalan wrote:
> Linus Torvalds writes:
> 
> > The buffer cache is "virtual" in the sense that /dev/hda is a
> > completely separate name-space from /dev/hda1, even if there
> > is some physical overlap.
> 
> So the aliasing problems and elevator algorithm confusion remain?

At least for the I/O scheduler confusion, requests to partitions will
remap the buffer location and this problem disappears nicely. It's not a
big issue, really.

> Is this ever likely to change, and what is with the 1 kB assumptions?
> (Hmmm, cruft left over from the 1 kB Minix filesystem blocks?)

What 1kB assumption?

-- 
Jens Axboe

