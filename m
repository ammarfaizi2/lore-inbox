Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293400AbSCWPq0>; Sat, 23 Mar 2002 10:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293447AbSCWPqR>; Sat, 23 Mar 2002 10:46:17 -0500
Received: from www.wen-online.de ([212.223.88.39]:45577 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S293400AbSCWPqF>;
	Sat, 23 Mar 2002 10:46:05 -0500
Date: Sat, 23 Mar 2002 17:04:36 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [datapoint] Re: 2.5.7 rm -r in tmpfs problem
In-Reply-To: <Pine.GSO.4.21.0203231038320.3631-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10203231703450.397-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2002, Alexander Viro wrote:

> On Sat, 23 Mar 2002, Mike Galbraith wrote:
> 
> > On Fri, 22 Mar 2002, Mike Galbraith wrote:
> > 
> > > Greetings,
> > > 
> > > While doing some testing, I ran into a problem where rm -r doesn't
> > > remove all files in a tmpfs directory is there are lots of files
> > > in that directory.  (rm -rf linux is failing)
> > 
> > I traced this back to the locking changes introduced in 2.5.5-pre1,
> > and verified it by moving the changes for the filesystems I use into
> > an otherwise pristine 2.4.4.
> 
> 2.5.4, probably?

Uh, yes.

> There are known problems with rm(1) on ramfs/tmpfs/etc. - the thing assumes
> that offsets in directory remain stable after unlink(2), but locking changes
> didn't affect.  Could you send me strace for 2.5.4 and 2.5.5-pre1?

Will do as soon as I revert/conpile 2.5.4.

	-Mike

