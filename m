Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319534AbSIGWyD>; Sat, 7 Sep 2002 18:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319538AbSIGWyD>; Sat, 7 Sep 2002 18:54:03 -0400
Received: from packet.digeo.com ([12.110.80.53]:51600 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319534AbSIGWyC>;
	Sat, 7 Sep 2002 18:54:02 -0400
Message-ID: <3D7A87F1.F3D0865C@digeo.com>
Date: Sat, 07 Sep 2002 16:12:49 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: LMbench2.0 results
References: <20020907121854.10290.qmail@linuxmail.org> <3D7A2768.E5C85EB@digeo.com> <20020907200334.GI888@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Sep 2002 22:58:37.0005 (UTC) FILETIME=[196D8FD0:01C256C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> Paolo Ciarrocchi wrote:
> >> Hi all,
> >> I've just ran lmbench2.0 on my laptop.
> >> Here the results (again, 2.5.33 seems to be "slow", I don't know why...)
> 
> On Sat, Sep 07, 2002 at 09:20:56AM -0700, Andrew Morton wrote:
> > The fork/exec/mmap slowdown is the rmap overhead.  I have some stuff
> > which partialy improves it.
> 
> Hmm, Where does it enter the mmap() path? PTE instantiation is only done
> for the VM_LOCKED case IIRC. Otherwise it should be invisible.

Oh, is that just the mmap() call itself?

> Perhaps testing with overcommit on would be useful.

Well yes - the new overcommit code was a significant hit on the 16ways
was it not?  You have some numbers on that?
