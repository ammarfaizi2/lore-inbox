Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311555AbSCNIPD>; Thu, 14 Mar 2002 03:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311556AbSCNIOx>; Thu, 14 Mar 2002 03:14:53 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:3090 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311555AbSCNIOl>; Thu, 14 Mar 2002 03:14:41 -0500
Message-ID: <3C905B9D.A1E3ACF6@zip.com.au>
Date: Thu, 14 Mar 2002 00:13:17 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roberto Nibali <ratz@drugphish.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: Question about the ide related ioctl's BLK* in 2.5.7-pre1 kernel
In-Reply-To: <3C9007F5.1000003@drugphish.ch> <3C900A11.55BA4B32@zip.com.au> <3C905894.90407@drugphish.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Nibali wrote:
> 
> > They got collaterally damaged in the IDE "cleanup".  The patch at
> > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6/dallocbase-10-readahead.patch
> > resurrects them.
> 
> Oh, I see. I've missed that patch of yours. I certainly enjoyed (maybe
> much to your grief) the comments in the code :).

hmm.  I'd better go back and check them then ;)

> Is GFP_READAHEAD still a wish or did you drop that idea?

Dropped.  Bad idea.  If we have to do I/O to gather the readahead pages
then so be it.  That I/O will cluster well, as will the subsequent readahead,
which is better than giving up on the readahead.

> AFAICS you only
> addressed the i386 arch with that patch, do you want the specific arch
> maintainers to clean up their part when your patch is finished?

?  There's nothing arch-specific in any of this...

-
