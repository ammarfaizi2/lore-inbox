Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWCaCgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWCaCgJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 21:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWCaCgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 21:36:09 -0500
Received: from xenotime.net ([66.160.160.81]:46983 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751200AbWCaCgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 21:36:08 -0500
Date: Thu, 30 Mar 2006 18:36:06 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Sumit Narayan <talk2sumit@gmail.com>
cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       George P Nychis <gnychis@cmu.edu>
Subject: Re: cannot get clean 2.4.20 kernel to compile
In-Reply-To: <1458d9610603301725r127cc73djb125ae56c992cb99@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0603301834210.32434@shark.he.net>
References: <5W8lY-1wF-29@gated-at.bofh.it> <442C81BC.7030605@shaw.ca>
 <1458d9610603301725r127cc73djb125ae56c992cb99@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2006, Sumit Narayan wrote:

> >From the error output 1, it appears that your directory include/asm is
> not a link to include/linux. Can you check that?
>
> Otherwise, simply delete the directory include/asm and re-compile the
> kernel from start; it should work.

Nope, include/asm is an expected directory (symlink) in 2.4.x build.
This is what you get without out:

make: *** No rule to make target `/var/linsrc/linux-2420/include/asm/param.h', needed by `/var/linsrc/linux-2420/include/linux/sched.h'.  Stop.
make: *** Waiting for unfinished jobs....


> On 3/31/06, Robert Hancock <hancockr@shaw.ca> wrote:
> > George P Nychis wrote:
> > > Hi,
> > >
> > > I have downloaded the 2.4.20 kernel from ftp.kernel.org, have checked its sign, and no matter what I try I cannot get it to compile.
> > >
> > > I do a make mrproper, I then do make dep which is fine, but then i try "make bzImage modules modules_install", selecting all the defaults, and get an SMP header error:
> > > http://rafb.net/paste/results/QzIq7v86.html
> > >
> > > I then disable SMP support and get:
> > > http://rafb.net/paste/results/muYA9t12.html
> > >
> > > I even tried using my config from the 2.4.32 kernel which works perfectly fine, and I also get the sched errors.
> >
> > What gcc version? Some old kernels might not be buildable with newer
> > compilers.

-- 
~Randy
