Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273163AbRIRS2q>; Tue, 18 Sep 2001 14:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273170AbRIRS20>; Tue, 18 Sep 2001 14:28:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57872 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273163AbRIRS2Z>; Tue, 18 Sep 2001 14:28:25 -0400
Date: Tue, 18 Sep 2001 11:27:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <Pine.GSO.4.21.0109181354470.27125-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0109181122550.9711-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Sep 2001, Alexander Viro wrote:
>
> It can be modified so that combination with lazy-bdev and pipefs-like tree
> would work.  And yes, most of the ugliness would just go away.

That's the part I like about the page-cache bdev patch. It has a lot of
fairly ugly warts, but all of them seem to be really fixable with _other_
cleanups, at which point only the good parts remain.

I agree that the timing may leave something to be desired. But we had the
discussion about fixing pagecache-bdev consistency wrt the regular buffer
cache filesystem accesses a week or so ago, and the fact is that nobody
really seems to have started working on it - because everybody felt that
you have to get everything done at once.

I don't have that feeling. I'm happy with having partial merge with ugly
warts, if it means that you can get to the final stage _without_ having to
have all the problems fixed at one time.

So now we have two _smaller_ merges that will fix two other issues, and
remove all the horridness from the original merge.

		Linus

