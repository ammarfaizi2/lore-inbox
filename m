Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143381AbREKUBl>; Fri, 11 May 2001 16:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143372AbREKUBO>; Fri, 11 May 2001 16:01:14 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:7850 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S143386AbREKUAv>;
	Fri, 11 May 2001 16:00:51 -0400
Date: Fri, 11 May 2001 16:00:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Pavel Machek <pavel@suse.cz>
cc: Chris Wedgwood <cw@f00f.org>, Andrea Arcangeli <andrea@suse.de>,
        Jens Axboe <axboe@suse.de>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <20010507184224.A32@(none)>
Message-ID: <Pine.GSO.4.21.0105111549540.8203-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 May 2001, Pavel Machek wrote:
> OTOH with current way if you make mistake in kernel, fsck will not
> automatically inherit it; therefore fsck is likely to work even if
> kernel ext2 is b0rken [and that's fairly important]

... and by the same logics you should make fsck implement its own
drivers - after all, right now b0rken driver affects both the kernel
ext2 and fsck ;-)

I'm not sure that fsck of fs mounted read/write is worth doing in the
first place, but I'd rather do that via fs/ext2 exporting its metadata
explicitly than by playing silly buggers with device/fs coherency.

