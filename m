Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQL2CCv>; Thu, 28 Dec 2000 21:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQL2CCm>; Thu, 28 Dec 2000 21:02:42 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:29191
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129345AbQL2CC3>; Thu, 28 Dec 2000 21:02:29 -0500
Date: Fri, 29 Dec 2000 14:32:00 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: innd mmap bug in 2.4.0-test12
Message-ID: <20001229143200.A16930@metastasis.f00f.org>
In-Reply-To: <20001228160005.B14479@metastasis.f00f.org> <Pine.LNX.4.10.10012281049140.12260-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012281049140.12260-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 28, 2000 at 10:50:48AM -0800
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 10:50:48AM -0800, Linus Torvalds wrote:

    > I use ramfs for /tmp on my laptop -- it's very handy because it
    > extends the amount of the the disk had spent spun down and therefore
    > battery life; but writing large files into /tmp can blow away the
    > system or at the very least eat away at otherwise usable ram. Not
    > terribly desirable.
    
    Jeff Garzik had the code to do this, and the new shared memory code should
    be able to be massaged to handle this all without actually bloating the
    kernel (ie "ramfs" would still stay very very tiny, just taking advantage
    of the common code that the VM layer already has to support for other
    things).

I would prefer we leave ramfs alone as is -- it makes an excellent
starting point for a new fs and is fairly simple to grok. If we are
to add any more complexity here like the size limiting patches or the
use of a backing store, I'd like to have this as a new filesystem,
something like 'vmfs' or some such.

ramfs is small simple and elegant; for mere mortals like me it
contains enough to help understand what is required of a filesystem
without obscuring this fact. I'd hate to see that change.

Jeff (or indeed anyone); if you have the patch Linus is talking about
somewhere (even and old one) could you sen it my way please (off the
list).




  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
