Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289631AbSAJTTJ>; Thu, 10 Jan 2002 14:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289651AbSAJTSu>; Thu, 10 Jan 2002 14:18:50 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:59054 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289624AbSAJTQn>;
	Thu, 10 Jan 2002 14:16:43 -0500
Date: Thu, 10 Jan 2002 11:15:55 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        george anzinger <george@mvista.com>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
Message-ID: <20020110111555.A15171@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20020110102105.B1162@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.40.0201101107350.1493-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0201101107350.1493-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Thu, Jan 10, 2002 at 11:08:21AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 11:08:21AM -0800, Davide Libenzi wrote:
> On Thu, 10 Jan 2002, Mike Kravetz wrote:
> > >
> > > I just kicked off another benchmark run to compare pre10, pre10 & G1
> > > patch, pre10 & Davide's patch.
> >
> > It wasn't a good night for benchmarking.  I had a typo in the
> > script to run chat reniced and as a result didn't collect any
> > numbers for this.  In addition, the kernel with Davide's patch
> > failed to boot with 8 CPUs enabled.  Can't see any '# CPU specific'
> > mods in the patch.  In any case, here is what I do have.
> 
> Doh !! Do you have a panic dump Mike ?

It didn't panic, but hung during the boot process.  After
reading other mail, this may be caused by the out of order
locking bug/deadlock that existed in this version of the
O(1) scheduler.  I may be able to try and verify later today.
Right now the machine is being used for something else.

-- 
Mike
