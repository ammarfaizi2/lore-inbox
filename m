Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292248AbSCDIgo>; Mon, 4 Mar 2002 03:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292254AbSCDIge>; Mon, 4 Mar 2002 03:36:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30221 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292248AbSCDIgV>;
	Mon, 4 Mar 2002 03:36:21 -0500
Message-ID: <3C83318D.D79F887A@zip.com.au>
Date: Mon, 04 Mar 2002 00:34:21 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Andreas Dilger <adilger@clusterfs.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] delayed disk block allocation
In-Reply-To: <3C7F3B4A.41DB7754@zip.com.au> <20020303223103.J4188@lynx.adilger.int> <3C83280A.A8CF7CC8@zip.com.au>,
		<3C83280A.A8CF7CC8@zip.com.au> <E16hnUV-0000aa-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> ..
> I guess 4K PAGE_CACHE_SIZE will serve us well for another couple of years,

Having reviewed the archives, it seems that the multipage PAGE_CACHE_SIZE
patches which Hugh and Ben were working on were mainly designed to increase
I/O efficiency.

If that's the only reason for large pages then yeah, I think we can stick
with 4k PAGE_CACHE_SIZE :).  There really are tremendous efficiencies
available in the current code.

Another (and very significant) reason for large pages is to decrease
TLB misses.   Said to be very important for large-working-set scientific
apps and such.  But that doesn't seem to have a lot to do with PAGE_CACHE_SIZE?

> ...
> By the way, have you ever seen a sparse 1K blocksize file?
> ...

Sure I have.  I just created one.  (I'm writing test cases for my
emails now.  Sheesh).

-
