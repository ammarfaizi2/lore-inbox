Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267103AbRGOWPW>; Sun, 15 Jul 2001 18:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267101AbRGOWPD>; Sun, 15 Jul 2001 18:15:03 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:36365 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267100AbRGOWOx>; Sun, 15 Jul 2001 18:14:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
Date: Mon, 16 Jul 2001 00:18:50 +0200
X-Mailer: KMail [version 1.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Adam Schrotenboer <ajschrotenboer@lycosmail.com>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <E15LopT-0004Cm-00@the-village.bc.nu> <01071523304400.06482@starship> <3B5213BB.12F792C3@namesys.com>
In-Reply-To: <3B5213BB.12F792C3@namesys.com>
MIME-Version: 1.0
Message-Id: <01071600185002.06482@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 July 2001 00:05, Hans Reiser wrote:
> Daniel Phillips wrote:
> > On Sunday 15 July 2001 18:44, Hans Reiser wrote:
> > > The limits for reiserfs and ext2 for kernels 2.4.x are the same
> > > (and they are 2Tb not 1Tb).  The limits are not in the individual
> > > filesystems.  We need to have Linux go to 64 bit blocknumbers in
> > > 2.5.x, I am seeing a lot of customer demand for it.  (Or we could
> > > use scalable integers, which would be better.)
> >
> > Or we could introduce the notion of logical blocksize for each
> > block minor so that we can measure blocks in the same units the
> > filesystem uses.  This would give us 16 TB while being able to stay
> > with 32 bits everywhere outside the block drivers themselves.
> >
> > We are not that far away from being able to handle 8K blocks, so
> > that would bump it up to 32 TB.
> >
> > --
> > Daniel
>
> 16TB is not enough.
>
> I agree that blocknumbers are a significant space user in FS
> metadata, which is why I think scalable integers are correct.

I must have missed the place where you defined what scalable integers
are.  I'd think the prefered way of representing a logical block size
is as a bit shift, not an absolute size, because it's far more
efficient to use that way.  Is this the same as a scalable integer?

--
Daniel
