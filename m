Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269120AbRHFWzO>; Mon, 6 Aug 2001 18:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269137AbRHFWzF>; Mon, 6 Aug 2001 18:55:05 -0400
Received: from weta.f00f.org ([203.167.249.89]:4241 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S269120AbRHFWyw>;
	Mon, 6 Aug 2001 18:54:52 -0400
Date: Tue, 7 Aug 2001 10:55:47 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jakub Jelinek <jakub@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>,
        David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: /proc/<n>/maps growing...
Message-ID: <20010807105547.A24783@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.33.0108061015450.8972-100000@penguin.transmeta.com> <E15To9U-0001PL-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15To9U-0001PL-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 06:26:52PM +0100, Alan Cox wrote:

    The resource one is a kernel problem. I am curious why only
    specific apps trip the second case

See my longish posting about about this, depending on the 'growth' of
memory, glibc uses different allocation meachnisms, for allocationes
between 8k and 1M, this pattern happens to really suck.

Different memory allocators behave differently, I tried to write a
library to wrap malloc with libhoard but become horribly unstuck when
dlsym wanted to start calling malloc (and I couldn't get ld --wrap to
do what I wanted).



  --cw

