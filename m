Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310237AbSCABOH>; Thu, 28 Feb 2002 20:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310296AbSCABKq>; Thu, 28 Feb 2002 20:10:46 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:30126 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S310289AbSCABHj>; Thu, 28 Feb 2002 20:07:39 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: Fri, 1 Mar 2002 12:07:59 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15486.54383.958359.357643@notabene.cse.unsw.edu.au>
Cc: nfs-devel@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5: compile error in fs/filesystems.c
In-Reply-To: message from Olaf Dietsche on Friday March 1
In-Reply-To: <87vgchi2v8.fsf@tigram.bogus.local>
	<15486.50159.606621.827886@notabene.cse.unsw.edu.au>
	<87bse9hzok.fsf@tigram.bogus.local>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday March 1, olaf.dietsche--list.linux-kernel@exmail.de wrote:
> Hi Neil,
> 
> Neil Brown <neilb@cse.unsw.edu.au> writes:
> 
> > 2.5.6-pre2 already has a patch for this.
> 
> The compile error is gone, *but* ... :-)
> With 2.5.6-pre2 you get nfsd support, wether you want it or
> not. Consider this:

With 2.5.6-pre2 you will always get just enough code to be able to
load nfsd as a module later, even if you didn't compile nfsd as a
module this time.  Unless modules are disabled of course.

There have been a number of problem reports on linux-kernel over the
last year or two from people who cannot load nfsd.o as a module.
Often it is because they originally compiled without and NFSD support
at all, but subsequently decided that wanted to compile and load
nfsd.o

This works for many modules (e.g. filesystems)  It is reasonable that
it work for nfsd as well.

I thought that the cost of always including the hooks to load nfsd was
minimal, and worth the consistency/convenience.

Does that seem reasonable to you?

NeilBrown
