Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269326AbRHGTJs>; Tue, 7 Aug 2001 15:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269331AbRHGTJi>; Tue, 7 Aug 2001 15:09:38 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:63622 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269326AbRHGTJW>; Tue, 7 Aug 2001 15:09:22 -0400
Date: Tue, 7 Aug 2001 13:09:25 -0600
Message-Id: <200108071909.f77J9Pr07385@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <E15UC9a-0003kt-00@the-village.bc.nu>
In-Reply-To: <no.id>
	<E15UC9a-0003kt-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > > Very interesting. pwd should be using getcwd(2), which doesn't
> > > give a damn for inode numbers. If you have seriously old pwd binary
> > > that tries to track the thing down to root by hands - yes, it doesn't
> > > work.
> > 
> > Hm. strace suggests my pwd is walking up the path. But WTF would it
> > break? 2.4.7 was fine. What did I break?
> 
> Sounds like you are using libc5. The old style pwd should be
> reliable but its much slower and can't see across protected
> directory paths

Yes, I use libc5. And I don't care about old pwd being slower. And I
certainly don't want to break it, even if I wasn't using it.
By "protected directory paths", you mean a directory with read access?

Well, rx access is available for the whole path. And the inums looked
fine. So the breakage is odd.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
