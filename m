Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131679AbQL1T1w>; Thu, 28 Dec 2000 14:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131752AbQL1T1m>; Thu, 28 Dec 2000 14:27:42 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56594 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131679AbQL1T1Y>; Thu, 28 Dec 2000 14:27:24 -0500
Subject: Re: innd mmap bug in 2.4.0-test12
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 28 Dec 2000 18:57:41 +0000 (GMT)
Cc: cw@f00f.org (Chris Wedgwood), riel@conectiva.com.br (Rik van Riel),
        viro@math.psu.edu (Alexander Viro),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.4.10.10012281049140.12260-100000@penguin.transmeta.com> from "Linus Torvalds" at Dec 28, 2000 10:50:48 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14BiFF-00045E-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I use ramfs for /tmp on my laptop -- it's very handy because it
> > extends the amount of the the disk had spent spun down and therefore
> > battery life; but writing large files into /tmp can blow away the
> > system or at the very least eat away at otherwise usable ram. Not
> > terribly desirable.
> 
> Jeff Garzik had the code to do this, and the new shared memory code should
> be able to be massaged to handle this all without actually bloating the
> kernel (ie "ramfs" would still stay very very tiny, just taking advantage
> of the common code that the VM layer already has to support for other
> things).

The ramfs maintainer has patches (in -ac) which deal with the size limiting
of RAMfs. I'm using it on a PDA and its really really nice to be able to 
pop up a GUI app and drag the bar to '60% for apps' like other PDA systems ;)

They do touch the core vm/vfs code for one callback, which would be nice to
lose but not obvious it can be

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
