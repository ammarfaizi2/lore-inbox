Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTABMHo>; Thu, 2 Jan 2003 07:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbTABMHo>; Thu, 2 Jan 2003 07:07:44 -0500
Received: from packet.digeo.com ([12.110.80.53]:63683 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261463AbTABMHn>;
	Thu, 2 Jan 2003 07:07:43 -0500
Message-ID: <3E142D85.71FFA06C@digeo.com>
Date: Thu, 02 Jan 2003 04:16:05 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix kallsyms crashes in 2.5.54
References: <20030102091325.GA24352@averell> <3E1427FD.16A7B021@digeo.com> <20030102120033.GA4266@averell>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jan 2003 12:16:06.0475 (UTC) FILETIME=[B9DA41B0:01C2B258]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Thu, Jan 02, 2003 at 12:52:29PM +0100, Andrew Morton wrote:
> > Andi Kleen wrote:
> > >
> > > The kernel symbol stem compression patch included in 2.5.54 unfortunately
> > > had a few problems, triggered by various circumstances.
> > >
> >
> > With your patch I am still seeing an instant oops when running top(1):
> 
> Did you make sure the .tmp_kallsym* files in your kernel build were
> regenerated ?
> 

I retested.  A `cat /proc/1/wchan' still ooopses in the same manner.

(Shouldn't `make clean' remove that gunk?  It doesn't...)
