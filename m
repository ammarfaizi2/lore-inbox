Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269223AbRHCOPd>; Fri, 3 Aug 2001 10:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269134AbRHCOPW>; Fri, 3 Aug 2001 10:15:22 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:37899 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269186AbRHCOPD>; Fri, 3 Aug 2001 10:15:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
Date: Fri, 3 Aug 2001 15:09:06 +0200
X-Mailer: KMail [version 1.2]
Cc: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0108022312211.1494-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0108022312211.1494-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <01080315090600.01827@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 August 2001 05:13, Alexander Viro wrote:
> On Fri, 3 Aug 2001, Daniel Phillips wrote:
> > There is only one chain of directories from the fd's dentry up to
> > the root, that's the one to sync.
>
> You forgot ".. at any given moment". IOW, operation you propose is
> inherently racy. You want to do that - you do that in userland.

Are you saying that there may not be a ".." some of the time?  Or just 
that it may spontaneously be relinked?  If it does spontaneously change 
it doesn't matter, you have still made sure there is access by at least 
one path.

The trouble with doing this in userland is, the locked chain of dcache 
entries isn't there.

--
Daniel
