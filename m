Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264365AbUEISLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbUEISLv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 14:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbUEISLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 14:11:51 -0400
Received: from waste.org ([209.173.204.2]:17366 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264365AbUEISLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 14:11:49 -0400
Date: Sun, 9 May 2004 13:11:22 -0500
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Andrew Morton <akpm@osdl.org>, dipankar@in.ibm.com,
       manfred@colorfullife.com, davej@redhat.com, wli@holomorphy.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, maneesh@in.ibm.com
Subject: Re: dentry bloat.
Message-ID: <20040509181122.GK5414@waste.org>
References: <Pine.LNX.4.44.0405091058300.2106-100000@poirot.grange> <Pine.LNX.4.58.0405090832310.24865@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405090832310.24865@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2004 at 08:35:55AM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 9 May 2004, Guennadi Liakhovetski wrote:
> 
> > On Sat, 8 May 2004, Linus Torvalds wrote:
> > 
> > >    1:     5.04 % (    5.04 % cum -- 2246)
> > >    2:     5.19 % (   10.23 % cum -- 2312)
> > 
> > Ok, risking to state the obvious - it was intentional to count "."s and
> > ".."s, wasn't it? Just this makes it a bit non-trivial to compare this
> > statistics with Andrew's.
> 
> Ok, here's a version that doesn't count "." and "..". My numbers don't 
> really change much for the kernel:
> 
> and we've reached over 90% coverage with the 24-byte inline name.

I hacked up something and ran it on my webserver (which has something
like 200 shell accounts). My histogram peaked at 12 rather than 10 but
still hit 90% cumulative at 21 characters.

I suspect worst case is a large LAN fileserver with Samba shares and
whatnot, I suspect there are a large number of "A picture of my cute
puppy I took last summer.JPG" style filenames there. Anyone have stats
for such an FS?

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
