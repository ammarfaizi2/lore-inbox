Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269537AbRHCSVP>; Fri, 3 Aug 2001 14:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269538AbRHCSVF>; Fri, 3 Aug 2001 14:21:05 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:16653 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269537AbRHCSUx>; Fri, 3 Aug 2001 14:20:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
Date: Fri, 3 Aug 2001 20:26:14 +0200
X-Mailer: KMail [version 1.2]
Cc: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <0108032026140F.01827@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 August 2001 20:08, Alexander Viro wrote:
> On Fri, 3 Aug 2001, Daniel Phillips wrote:
> > Are you saying that there may not be a ".." some of the time?  Or just
> > that it may spontaneously be relinked?  If it does spontaneously change
> > it doesn't matter, you have still made sure there is access by at least
> > one path.
> >
> > The trouble with doing this in userland is, the locked chain of dcache
> > entries isn't there.
>
> There is no _locked_ chain.

Locked as in can't be destroyed (refcount) not i_sem or such, sorry for the
loose usage.

> And if you want to grab the locks on all
> ancestors - think again. It means sorting the inodes by address _and_
> relocking if any of them had been moved while you were locking the
> previous ones. I absolutely refuse to add such crap to the tree and I
> seriously suspect that Linus and Alan will do the same.

--
Daniel
