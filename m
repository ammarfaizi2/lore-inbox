Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264674AbRFYQIO>; Mon, 25 Jun 2001 12:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264770AbRFYQIE>; Mon, 25 Jun 2001 12:08:04 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:57611 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264674AbRFYQHw>; Mon, 25 Jun 2001 12:07:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Tony Gale <gale@syntax.dera.gov.uk>
Subject: Re: [UPDATE] Directory index for ext2
Date: Mon, 25 Jun 2001 18:10:50 +0200
X-Mailer: KMail [version 1.2]
Cc: Heusden@mail.bonn-fries.net, Folkert van <f.v.heusden@ftr.nl>,
        linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
        Alexander Viro <viro@math.psu.edu>,
        Andreas Dilger <adilger@turbolinux.com>
In-Reply-To: <0105311813431J.06233@starship> <01062018584308.00439@starship> <993462395.9593.0.camel@syntax.dera.gov.uk>
In-Reply-To: <993462395.9593.0.camel@syntax.dera.gov.uk>
MIME-Version: 1.0
Message-Id: <01062518105001.01008@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 June 2001 11:46, Tony Gale wrote:
> After some testing, removing the grsecurity patch seems to have solved
> the disappearing-free-space problem. Now just need to find out why.
>
> On 20 Jun 2001 18:58:43 +0200, Daniel Phillips wrote:
> > On Wednesday 20 June 2001 16:59, Tony Gale wrote:
> > > The main problem I have with this is that e2fsck doesn't know how to
> > > deal with it - at least I haven't found a version that will. This makes
> > > it rather difficult to use, especially for your root fs.
> >
> > Good, the file format isn't finalized, this is only recommended for use
> > on a test partition.
>
> It was a test partition, just happended to be a root one. AFAIAA, isn't
> the fact that the file format may change irrelevant. You want people to
> test this stuff or not? If it's not tested on a root fs then how do you
> know there won't be any problems.
>
> Sorry, but when someone reports a problem, and then you say, well don't
> test it like that then, it is really not acceptable.

Sure, if your root partition is expendable, by all means go ahead.  Ted has 
already offered to start the required changes to e2fsck, which reminds me, I 
have to send the promised docs.  For now, just use normal fsck and it will 
(in theory) turn the directory indexes back into normal file blocks, and have 
no effect on inodes.  Lets take advantage of the opportunity to test that 
feature.  The new improved e2fsck should be capable of re-adding the indexes, 
so we'll get to test that too ;-)

Lets continue this privately and see what's going on with your inode leak.

--
Daniel
