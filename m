Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269332AbRHGTQs>; Tue, 7 Aug 2001 15:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269351AbRHGTQ3>; Tue, 7 Aug 2001 15:16:29 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:43752 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269332AbRHGTQO>;
	Tue, 7 Aug 2001 15:16:14 -0400
Date: Tue, 7 Aug 2001 15:16:24 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <E15UC9a-0003kt-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0108071510390.18565-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Aug 2001, Alan Cox wrote:

> > > Very interesting. pwd should be using getcwd(2), which doesn't
> > > give a damn for inode numbers. If you have seriously old pwd binary
> > > that tries to track the thing down to root by hands - yes, it doesn't
> > > work.
> > 
> > Hm. strace suggests my pwd is walking up the path. But WTF would it
> > break? 2.4.7 was fine. What did I break?
> 
> Sounds like you are using libc5. The old style pwd should be reliable but
> its much slower and can't see across protected directory paths

It is not reliable. E.g. on NFS inumbers are not unique - 32 bits is
not enough.

