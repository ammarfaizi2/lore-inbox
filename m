Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbQL0LCD>; Wed, 27 Dec 2000 06:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129818AbQL0LBx>; Wed, 27 Dec 2000 06:01:53 -0500
Received: from linuxcare.com.au ([203.29.91.49]:49165 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129742AbQL0LBn>; Wed, 27 Dec 2000 06:01:43 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Wed, 27 Dec 2000 21:29:31 +1100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Chris Wedgwood <cw@f00f.org>, "Marco d'Itri" <md@Linux.IT>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
Message-ID: <20001227212930.A445@linuxcare.com>
In-Reply-To: <20001226175057.A12275@metastasis.f00f.org> <Pine.LNX.4.10.10012252135390.7059-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012252135390.7059-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Dec 25, 2000 at 09:37:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> This all only matters to things that do shared writable mmap's.
> 
> Almost nothing does that. innd is (sadly) the only regular thing that uses
> this, which is why it's always innd that breaks, even if everything else
> works.

btw samba 2.2 makes extensive use of shared writable mmaps (well it uses tdb
which uses shared writable mmaps). In fact it picked up a bug with virtual
aliasing of shared writable mmaps on sparc64 recently.

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
