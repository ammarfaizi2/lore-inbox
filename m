Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263356AbSJVQGr>; Tue, 22 Oct 2002 12:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbSJVQGr>; Tue, 22 Oct 2002 12:06:47 -0400
Received: from packet.digeo.com ([12.110.80.53]:42421 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263356AbSJVQGq>;
	Tue, 22 Oct 2002 12:06:46 -0400
Message-ID: <3DB578FE.9CDD870A@digeo.com>
Date: Tue, 22 Oct 2002 09:12:46 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andi Kleen <ak@muc.de>, Jeff Dike <jdike@karaya.com>,
       Andrea Arcangeli <andrea@suse.de>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
References: <3DB4D41E.12454389@digeo.com> <1035279556.31917.12.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2002 16:12:47.0489 (UTC) FILETIME=[DC930710:01C279E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Tue, 2002-10-22 at 05:29, Andrew Morton wrote:
> > Andi Kleen wrote:
> > >
> > > For example
> > > you would need to special case this in uaccess.h's access_ok(), which
> > > would be quite a lot of overhead (any change to this function causes
> > > many KB of binary bloat because *_user is so heavily used all over the kernel)
> >
> > That's all uninlined in the -mm patches.  Saves 33k of text.
> 
> I assume it saves a sizable amount of exception tables too ?

Strangely, no.  3/4 came from .text and 1/4 from __ex_table.
