Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269290AbRHGS4E>; Tue, 7 Aug 2001 14:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269292AbRHGSzy>; Tue, 7 Aug 2001 14:55:54 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:59526 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269290AbRHGSzf>; Tue, 7 Aug 2001 14:55:35 -0400
Date: Tue, 7 Aug 2001 12:55:47 -0600
Message-Id: <200108071855.f77Itl207144@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <Pine.GSO.4.21.0108071419470.18565-100000@weyl.math.psu.edu>
In-Reply-To: <200108071811.f77IBqq06242@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0108071419470.18565-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Removed Linus and Alan from the Cc: list: I'm sure they're getting
bored by now]

Alexander Viro writes:
> 
> 
> On Tue, 7 Aug 2001, Richard Gooch wrote:
> 
> > OK, I've implemented variant 2. Everything looked OK, but then I
> > noticed that pwd no longer works in subdirectories in devfs. Sigh.
> 
> Very interesting. pwd should be using getcwd(2), which doesn't
> give a damn for inode numbers. If you have seriously old pwd binary
> that tries to track the thing down to root by hands - yes, it doesn't
> work.

Hm. strace suggests my pwd is walking up the path. But WTF would it
break? 2.4.7 was fine. What did I break?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
