Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVERTLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVERTLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 15:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbVERTLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 15:11:18 -0400
Received: from mail.tmr.com ([64.65.253.246]:52754 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262266AbVERTIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 15:08:13 -0400
Date: Wed, 18 May 2005 15:07:30 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andi Kleen <ak@muc.de>, Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hyper-Threading Vulnerability
In-Reply-To: <1116009347.1448.489.camel@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1050518145842.14178B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2005, Alan Cox wrote:

> > This is not a kernel problem, but a user space problem. The fix 
> > is to change the user space crypto code to need the same number of cache line
> > accesses on all keys. 
> 
> You actually also need to hit the same cache line sequence on all keys
> if you take a bit more care about it.
> 
> > Disabling HT for this would the totally wrong approach, like throwing
> > out the baby with the bath water.
> 
> HT for most users is pretty irrelevant, its a neat idea but the
> benchmarks don't suggest its too big a hit

This is one of those things which can give any result depending on the
measurement. For kernel compiles I might see a 5-30% reduction in clock
time, for threaded applications like web/mail/news not much, and for
applications which communicate via shared memory up to 50% because some
blocking system calls can be avoided and cache impact is lower.

In general I have to agree with the "too big," but I haven't seen any
indication that the hole can be exploited without being able to run a
custom application on the machine, so for single users machines and
servers the risk level seems low.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

