Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274643AbRITUls>; Thu, 20 Sep 2001 16:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274642AbRITUli>; Thu, 20 Sep 2001 16:41:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:10730 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274641AbRITUla>;
	Thu, 20 Sep 2001 16:41:30 -0400
Date: Thu, 20 Sep 2001 16:41:54 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010920205942.V729@athlon.random>
Message-ID: <Pine.GSO.4.21.0109201530190.5141-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Sep 2001, Andrea Arcangeli wrote:

> The second call will do the work if there's something to do. If somebody
> did an open/read/writes/close in the middle, it should do the work as
> usual. I actually can see a problem if you use the different inodes, but
> that will be sorted out too automatically as soon as we stop pinning the
> inodes.


Sigh... Try BLKFLSBUF + write() + BLKFLSBUF.

