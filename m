Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314494AbSEPIgk>; Thu, 16 May 2002 04:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314558AbSEPIgj>; Thu, 16 May 2002 04:36:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60936 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314494AbSEPIgj>; Thu, 16 May 2002 04:36:39 -0400
Date: Thu, 16 May 2002 09:36:30 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa3
Message-ID: <20020516093630.B5540@flint.arm.linux.org.uk>
In-Reply-To: <20020516020134.GC1025@dualathlon.random> <Pine.LNX.4.44L.0205152303500.32261-100000@imladris.surriel.com> <20020516023238.GE1025@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2002 at 04:32:38AM +0200, Andrea Arcangeli wrote:
> On Wed, May 15, 2002 at 11:06:51PM -0300, Rik van Riel wrote:
> > --- snip from linuxrc ----
> > mount --ro -t $rootfs $rootdev /sysroot
> > pivot_root /sysroot /sysroot/initrd
> > ------
> > 
> > This way you can specify both the root fs and - if wanted -
> > special mount options to the root fs. Then you pivot_root(2)
> > to move the root fs to / and the (old) initrd to /initrd.
> 
> both lines are completly superflous, very misleading as well. I
> recommend to drop such two lines from all the full blown bug-aware
> linuxrc out there (of course after you apply the ordering fix to the
> kernel).

Have you thought about reading Documentation/initrd.txt and following
the described method?  (last modified December 2000 according to the
comments and the mtime on the file).

The method you're using has therefore been marked "obsolete" for almost
two and a half years:

| Obsolete root change mechanism
| ------------------------------
| 
| The following mechanism was used before the introduction of pivot_root.
| Current kernels still support it, but you should _not_ rely on its
| continued availability.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

