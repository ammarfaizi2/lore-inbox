Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135904AbRDZT5Q>; Thu, 26 Apr 2001 15:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135902AbRDZT5I>; Thu, 26 Apr 2001 15:57:08 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:32208 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135477AbRDZT4w>;
	Thu, 26 Apr 2001 15:56:52 -0400
Date: Thu, 26 Apr 2001 15:55:19 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <20010426214444.B819@athlon.random>
Message-ID: <Pine.GSO.4.21.0104261554050.15385-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Apr 2001, Andrea Arcangeli wrote:

> On Thu, Apr 26, 2001 at 03:34:00PM -0400, Alexander Viro wrote:
> > Same scenario, but with read-in-progress started before we do getblk(). BTW,
> 
> how can the read in progress see a branch that we didn't spliced yet? We

fd = open("/dev/hda1", O_RDONLY);
read(fd, buf, sizeof(buf));

