Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135621AbRDSLH0>; Thu, 19 Apr 2001 07:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135622AbRDSLHQ>; Thu, 19 Apr 2001 07:07:16 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:25098 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S135621AbRDSLHM>; Thu, 19 Apr 2001 07:07:12 -0400
From: Daniel Phillips <phillips@nl.linux.org>
To: phillips@nl.linux.org, riel@conectiva.com.br
Subject: Re: Ext2 Directory Index - Delete Performance
Cc: adilger@turbolinux.com, ext2-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Message-Id: <20010419104208Z92271-11631+4@humbolt.nl.linux.org>
Date: Thu, 19 Apr 2001 12:42:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> On Thu, 19 Apr 2001, Daniel Phillips wrote:
> 
> > OK, now I know what's happening, the next question is, what should be
> > dones about it.  If anything.
> 
> [ discovered by alexey on #kernelnewbies ]
> 
> One thing we should do is make sure the buffer cache code sets
> the referenced bit on pages, so we don't recycle buffer cache
> pages early.
> 
> This should leave more space for the buffercache and lead to us
> reclaiming the (now unused) space in the dentry cache instead...            
                                                                 
Yes, absolutely, that one should have been on my list.  The closer we get to
perfect cache balancing and perfect LRU, the higher the theshhold for
thrashing and the more gently it will degrade.
--
Daniel
