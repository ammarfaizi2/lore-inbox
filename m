Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131307AbREFCPI>; Sat, 5 May 2001 22:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131244AbREFCO5>; Sat, 5 May 2001 22:14:57 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:47632 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S130900AbREFCOq>; Sat, 5 May 2001 22:14:46 -0400
Date: Sun, 6 May 2001 14:14:37 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jens Axboe <axboe@suse.de>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010506141437.A31269@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.4.21.0105031017460.30346-100000@penguin.transmeta.com> <200105041140.NAA03391@cave.bitwizard.nl> <20010504135614.S16507@suse.de> <20010504172940.U3762@athlon.random> <20010505151808.A29451@metastasis.f00f.org> <20010506023723.A22850@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010506023723.A22850@athlon.random>; from andrea@suse.de on Sun, May 06, 2001 at 02:37:23AM +0200
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Basically there will still be a use for the block devices as far
    as there are fsck and other userspace applications that want to
    use it.

You don't need block device for fsck, in fact some OS require you use
character devices (e.g. Solaris).

I'm not saying we don't need block devices, but I really don't see
much of a use for them once everything in in the page cache... I
assume this is why others have got rid of them completely.


  --cw
