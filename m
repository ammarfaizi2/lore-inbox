Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317579AbSFIHPY>; Sun, 9 Jun 2002 03:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317580AbSFIHPX>; Sun, 9 Jun 2002 03:15:23 -0400
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:12551 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id <S317579AbSFIHPW>; Sun, 9 Jun 2002 03:15:22 -0400
Message-Id: <200206090709.g5979UX14894@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Sun, 9 Jun 2002 09:15:12 +0200
X-Mailer: KMail [version 1.3.1]
Cc: davem@redhat.com (David S. Miller), linux-kernel@vger.kernel.org
In-Reply-To: <200206090657.g596vQj403167@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 9. Juni 2002 08:57 schrieb Albert D. Cahalan:
> Oliver Neukum writes:
> >> For memory --> device DMA:
> >>
> >> 1. write back all cache lines affected by the DMA
> >> 2. start the DMA
> >> 3. invalidate the above cache lines
> >
> > Why the third step ? That data should still
> > be valid.
>
> I made a mistake, but perhaps it is a good one.
> There is no need to invalidate the cache lines,
> but I'd guess that commonly the data won't be
> used again. Doing the invalidate would free up
> some cache lines, meaning that the CPU would
> have empty slots to use for other stuff.

Then this should be made commonly available
and could be used eg. on kfree.
The choice of kicking the data out or not could then
be made.

	Regards
		Oliver

