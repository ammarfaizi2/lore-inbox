Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319040AbSHMS4u>; Tue, 13 Aug 2002 14:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319060AbSHMS4t>; Tue, 13 Aug 2002 14:56:49 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:7824 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319040AbSHMS4s>;
	Tue, 13 Aug 2002 14:56:48 -0400
Date: Tue, 13 Aug 2002 11:58:22 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
Message-ID: <2009430000.1029265102@flay>
In-Reply-To: <Pine.LNX.4.44.0208131117190.7411-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208131117190.7411-100000@home.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I know, but you pays your money, you choose your breakage ;-)
> 
> Well, in this case, it is _you_ who end up having to choose your breakage.

Indeed. Empower the user.

>> Forcing it on for every machine just because P4s are borked sounds wrong.
> 
> THAT IS NOT WHAT I SAID. Go back and read it. I said that since the P4

OK, I was being unclear, that's not really what I meant. If I may rephrase:
I don't like the performance hit it gives on P3 standard SMP machines (not
NUMA-Q) though it does work on there too, and there's no easy way for 
people to disable it.

> needs it, you don't have the choice of just ignoring it. Especially since
> there are about a million more P4's out there than NUMA-Q machines.
>  
> It needs to be dynamic, not "disable it".

I did read what you said, but this isn't just about NUMA-Q. There are two issues here:

1. It doesn't work at all for some machines. Yes, we can get rid of that problem by
dynamic disable, or hanging off the existing config option. If that's all you'll accept,
we can cut a minimal patch to do that (that's actually what Matt did originally)

2. It makes performance worse on some normal SMP machines. That's what I want
the manual config option for. If you want it forced on for P4s, fine. I suspect this
may be able to be removed if someone can fix the code so it's performant.

M.

