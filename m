Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311963AbSCQICR>; Sun, 17 Mar 2002 03:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311960AbSCQICH>; Sun, 17 Mar 2002 03:02:07 -0500
Received: from www.wen-online.de ([212.223.88.39]:38674 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S311959AbSCQIB5>;
	Sun, 17 Mar 2002 03:01:57 -0500
Date: Sun, 17 Mar 2002 09:18:25 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Daniel Egger <degger@fhm.edu>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] 7.52 second kernel compile
In-Reply-To: <1016305054.19498.13.camel@sonja>
Message-ID: <Pine.LNX.4.10.10203170915100.994-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Mar 2002, Daniel Egger wrote:

> Am Sam, 2002-03-16 um 18.37 schrieb Martin J. Bligh:
> 
> > BTW - the other tip that was in the big book of whizzy kernel
> > compiles was to set gcc to use -pipe ... you might want to try
> > that.
> 
> Interestingly -pipe doesn't give any measurable performance increases or
> even leads to a minor decrease in compile speed in my latest tests on
> bigger projects like the linux kernel or GIMP. I suspect that's because
> of the caching nature of nowadays systems: the temporary products are
> cached in memory and likely not to never end on a drive because they're
> read and removed before the point the filesystem decides to physically
> write the data.
> 
> I also benchmarked tmpfs mounts and it demonstrated - to my surprise -
> small advantages slightly above the noise range; I suspect this is due
> to the way it handles files in memory.

Yes.  Last time I tested, -pipe was _always_ a loser, and writing to
swap was measurably faster than writing to fs.

	-Mike

