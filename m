Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSHBMJp>; Fri, 2 Aug 2002 08:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSHBMJp>; Fri, 2 Aug 2002 08:09:45 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35318 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S311885AbSHBMHy>; Fri, 2 Aug 2002 08:07:54 -0400
Subject: Re: Accelerating user mode linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard Zidlicky <rz@linux-m68k.org>
Cc: Jeff Dike <jdike@karaya.com>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020802133444.E1948@linux-m68k.org>
References: <200208012016.g71KGwK27981@devserv.devel.redhat.com>
	<200208020440.XAA04793@ccure.karaya.com> 
	<20020802133444.E1948@linux-m68k.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Aug 2002 14:28:07 +0100
Message-Id: <1028294887.18635.71.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-02 at 12:34, Richard Zidlicky wrote:
> I have once ported Basilisk to work native on linux-m68k. It works
> *slow* so I looked what the problem is - the signal delivery in
> Linux is exorbitantly slow. Eg an SIGILL delivery costs ~ 1650 cycles 
> on a 68060, compared to that sigreturn and getpid are 200-250 and 
> sched_yield with context switch around 400.

The numbers look very different on a real processor. Signal delivery is
indeed not stunningly fast but relative to a context switch its very low
indeed.

