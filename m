Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318809AbSHBL4u>; Fri, 2 Aug 2002 07:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318810AbSHBL4u>; Fri, 2 Aug 2002 07:56:50 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:2729 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S318809AbSHBL4s>; Fri, 2 Aug 2002 07:56:48 -0400
Date: Fri, 2 Aug 2002 13:34:44 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Jeff Dike <jdike@karaya.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Accelerating user mode linux
Message-ID: <20020802133444.E1948@linux-m68k.org>
References: <200208012016.g71KGwK27981@devserv.devel.redhat.com> <200208020440.XAA04793@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200208020440.XAA04793@ccure.karaya.com>; from jdike@karaya.com on Thu, Aug 01, 2002 at 11:40:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 11:40:28PM -0500, Jeff Dike wrote:
> 
> Your objection to returning through sigreturn was performance.  Is performance
> a veto of adding an mm switch to sigreturn, or it is possible to make it
> acceptible?

I have once ported Basilisk to work native on linux-m68k. It works
*slow* so I looked what the problem is - the signal delivery in
Linux is exorbitantly slow. Eg an SIGILL delivery costs ~ 1650 cycles 
on a 68060, compared to that sigreturn and getpid are 200-250 and 
sched_yield with context switch around 400.

So sigreturn is not the place I would be looking for the biggest
speedups.

Richard

