Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbTBJWlV>; Mon, 10 Feb 2003 17:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265506AbTBJWlV>; Mon, 10 Feb 2003 17:41:21 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:38617 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S265508AbTBJWlU>; Mon, 10 Feb 2003 17:41:20 -0500
Date: Tue, 11 Feb 2003 00:50:28 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Kevin Corry <corryk@us.ibm.com>
Cc: James Lamanna <james.lamanna@appliedminds.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.60 Compile error
Message-ID: <20030210225028.GB22081@actcom.co.il>
References: <021d01c2d148$3de259d0$39140b0a@amthinking.net> <03021015384004.02639@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03021015384004.02639@boiler>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 03:38:40PM -0600, Kevin Corry wrote:
> On Monday 10 February 2003 15:06, James Lamanna wrote:
> > Another compiler error that's been around for a little while:
> > Looks like some weird gcc problem.
> > gcc version: 2.95.4 20011002 (Debian prerelease)
> >
> > make -f scripts/Makefile.build obj=scripts
> > make -f scripts/Makefile.build obj=drivers/md drivers/md/linear.o
> >   gcc -Wp,-MD,drivers/md/.linear.o.d -D__KERNEL__ -Iinclude -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> > -pipe -mpreferred-stack-boundary=2 -march=i686
> > -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
> > -DKBUILD_BASENAME=linear -DKBUILD_MODNAME=linear -c -o
> > drivers/md/linear.o drivers/md/linear.c
> > drivers/md/linear.c: In function `linear_run':
> > drivers/md/linear.c:159: Internal compiler error:
> > drivers/md/linear.c:159: internal error--unrecognizable insn:
> > (insn 316 315 673 (parallel[

[snipped] 

> Anyone else seeing these errors? Any comments on the validity of
> the above patches?

This bug has been around for a while ... it's tracked in bugzilla in
bug http://bugme.osdl.org/show_bug.cgi?id=290. It needs someone who
will take it up with the gcc folks. 

As for your patches, I don't think working around an obvious compiler
bug in the kernel source is a good idea, except as an interim
workaround. 
-- 
Muli Ben-Yehuda
http://www.mulix.org
http://syscalltrack.sf.net

