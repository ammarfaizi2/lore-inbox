Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSCWPlh>; Sat, 23 Mar 2002 10:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293326AbSCWPl0>; Sat, 23 Mar 2002 10:41:26 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:41397 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S293306AbSCWPlS>;
	Sat, 23 Mar 2002 10:41:18 -0500
Date: Sat, 23 Mar 2002 10:41:17 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Mike Galbraith <mikeg@wen-online.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [datapoint] Re: 2.5.7 rm -r in tmpfs problem
In-Reply-To: <Pine.LNX.4.10.10203231619490.292-100000@mikeg.wen-online.de>
Message-ID: <Pine.GSO.4.21.0203231038320.3631-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Mar 2002, Mike Galbraith wrote:

> On Fri, 22 Mar 2002, Mike Galbraith wrote:
> 
> > Greetings,
> > 
> > While doing some testing, I ran into a problem where rm -r doesn't
> > remove all files in a tmpfs directory is there are lots of files
> > in that directory.  (rm -rf linux is failing)
> 
> I traced this back to the locking changes introduced in 2.5.5-pre1,
> and verified it by moving the changes for the filesystems I use into
> an otherwise pristine 2.4.4.

2.5.4, probably?

There are known problems with rm(1) on ramfs/tmpfs/etc. - the thing assumes
that offsets in directory remain stable after unlink(2), but locking changes
didn't affect.  Could you send me strace for 2.5.4 and 2.5.5-pre1?

