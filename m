Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261614AbTCLPOS>; Wed, 12 Mar 2003 10:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261655AbTCLPOS>; Wed, 12 Mar 2003 10:14:18 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:1834 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261614AbTCLPOQ>; Wed, 12 Mar 2003 10:14:16 -0500
Date: Wed, 12 Mar 2003 15:24:57 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Szakacsits Szabolcs <szaka@sienet.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
Message-ID: <20030312152457.E32093@devserv.devel.redhat.com>
References: <1047464392.1556.4.camel@laptop.fenrus.com> <Pine.LNX.4.44.0303120717270.13807-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0303120717270.13807-100000@home.transmeta.com>; from torvalds@transmeta.com on Wed, Mar 12, 2003 at 07:20:39AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 07:20:39AM -0800, Linus Torvalds wrote:
> 
> On 12 Mar 2003, Arjan van de Ven wrote:
> > 
> > and all vendors always ship -fno-frame-pointer kernels so far so those
> > users are ok! Until recently there was no way to build a non
> > -fno-frame-pointer kernel!
> 
> Not entirely true.
> 
> Even with the traditional -fomit-frame-pointer build, "sched.c" has always
> been built with -fno-fomit-frame-pointer in order to get the correct
> "wchan" of callers of schedule() and wait_on().
> 
> See kernel/Makefile for details.
> 
> So yes, old kernels (and CONFIG_FRAME_POINTER=n) have traditionally
> avoided the bug _mostly_. But it could still bite us in some rather
> important functions.

I know. And when the gcc bug was found (and fixed)
we audited the disassembly of sched.o  for this and it
didn't get triggered by this bug. 
