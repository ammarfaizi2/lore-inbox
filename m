Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263197AbVGAENW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263197AbVGAENW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 00:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbVGAENW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 00:13:22 -0400
Received: from smtp.nuvox.net ([64.89.70.9]:31121 "EHLO
	smtp04.gnvlscdb.sys.nuvox.net") by vger.kernel.org with ESMTP
	id S263197AbVGAENP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 00:13:15 -0400
Subject: Re: Problems with Firewire and -mm kernels
From: Dan Dennedy <dan@dennedy.org>
To: Ben Collins <bcollins@debian.org>
Cc: rbrito@ime.usp.br, Andrew Morton <akpm@osdl.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
In-Reply-To: <20050701031801.GA12915@phunnypharm.org>
References: <20050628161500.GA25788@phunnypharm.org>
	 <20050701010157.GA7877@ime.usp.br> <20050701011226.GB2067@phunnypharm.org>
	 <20050701024432.GA18150@ime.usp.br>
	 <20050701031801.GA12915@phunnypharm.org>
Content-Type: text/plain
Date: Fri, 01 Jul 2005 00:01:19 -0400
Message-Id: <1120190479.4847.6.camel@kino.dennedy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-30 at 23:18 -0400, Ben Collins wrote:
> Most of this is class_simple changes.
> 
> However, there is a huge set of changes to sbp2. One thing that sticks out
> is the entire sbp2_check_sbp2_command() function being ripped out. There's
> some changes related to TYPE_SDAD devices (where did this come from?).

This is the TYPE_RBC cache fixes patch by Al Viro. That discussion went
on for a while with additional changes suggested, and I did not know the
resolution. Now we do. :-)

> Try reverting just the sbp2.[ch] changes from the 2.6.13-rc1 tree.
> 
> I'll see if I can figure out why our tree and kernel tree have gotten so
> far out of whack and how such huge changes that don't seem to fix anything

Obviously, much of the diff Rogerio produced (not in history below)
shows changes in our repo not yet submitted to kernel.

> (like the large changes to sbp2) have gotten into the kernel proper
> without being tested. Most of the sbp2 changes seem to be a new feature
> rather than fixing minor or even major bugs.
> 
> On Thu, Jun 30, 2005 at 11:44:33PM -0300, Rog?rio Brito wrote:
> > On Jun 30 2005, Ben Collins wrote:
> > > Also, have you tried using 2.6.13-rc1 using linux1394.org's subversion tree?
> > 
> > Here is what I get when I try to substitute 2.6.13-rc1 with linux1394
> > trunk's tree:
> > - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> > (...)
> >   CC [M]  drivers/block/loop.o
> >   CC [M]  drivers/block/pktcdvd.o
> >   CC [M]  drivers/block/cryptoloop.o
> >   CC [M]  drivers/char/agp/intel-agp.o
> >   CC [M]  drivers/ieee1394/ieee1394_core.o
> > drivers/ieee1394/ieee1394_core.c: In function `hpsbpkt_thread':
> > drivers/ieee1394/ieee1394_core.c:1048: error: too many arguments to function `refrigerator'
> > drivers/ieee1394/ieee1394_core.c: In function `ieee1394_init':
> > drivers/ieee1394/ieee1394_core.c:1127: warning: implicit declaration of function `class_simple_create'
> > drivers/ieee1394/ieee1394_core.c:1127: warning: assignment makes pointer from integer without a cast
> > drivers/ieee1394/ieee1394_core.c:1165: warning: implicit declaration of function `class_simple_destroy'
> > make[3]: *** [drivers/ieee1394/ieee1394_core.o] Error 1
> > make[2]: *** [drivers/ieee1394] Error 2
> > make[1]: *** [drivers] Error 2
> > make[1]: Leaving directory `/usr/local/media/progs/linux/linux'
> > make: *** [stamp-build] Error 2
> > - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> > 
> > Thanks, Rog?rio Brito.
> > 
> > -- 
> > Rog?rio Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
> > Homepage of the algorithms package : http://algorithms.berlios.de
> > Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
> 

