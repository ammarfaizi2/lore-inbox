Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263687AbSJHUaQ>; Tue, 8 Oct 2002 16:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263690AbSJHU30>; Tue, 8 Oct 2002 16:29:26 -0400
Received: from pdbn-d9bb8651.pool.mediaWays.net ([217.187.134.81]:8200 "EHLO
	citd.de") by vger.kernel.org with ESMTP id <S263696AbSJHU3G>;
	Tue, 8 Oct 2002 16:29:06 -0400
Date: Tue, 8 Oct 2002 22:34:34 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Chris Wedgwood <cw@f00f.org>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021008203433.GA2576@citd.de>
References: <1034044736.29463.318.camel@phantasy> <20021008183824.GA4494@tapu.f00f.org> <1034102950.30670.1433.camel@phantasy> <20021008190513.GA4728@tapu.f00f.org> <20021008195332.GA2313@citd.de> <3DA339FF.4DCEF31E@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA339FF.4DCEF31E@digeo.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 01:03:11PM -0700, Andrew Morton wrote:
> Matthias Schniedermeyer wrote:
> > 
> > ...
> > I only have 3 GB of RAM, and creating and writing trashes the whole
> > cache twice.
> 
> That's actually something completely dumb and irritating which
> Linux has done for ever ;)
> 
> What we need is to detect the situation where someone is linearly
> walking through a file which is preposterously too large to cache,
> and just start dropping it.
> 
> It's not hard to implement the lower machinery to do that - it would
> basically be an internal call to posix_fadvise(), which we don't
> have but could and perhaps should...
> 
> The tricky part is designing the algorithm which decides when to
> pull the trigger.

I have more of this cases.

I use a program called VDR. This is for recording digital-TV-program
from satallite.

After a recording is finished i cut the recordings. I my case i "stream"
the input-data via NFS from the recording machine(s) through a converter
into the local temporary directory. After i have enough files i create
ISO-images of the files. When i create an ISO-images i "stream" the
files from HDD1 to HDD2 because otherwise it would completly kill the
performance. Then i burn the ISO-Image onto a DVD-R.


Every single part in the whole process trashes the cache.




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

