Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266256AbSKSOw1>; Tue, 19 Nov 2002 09:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266274AbSKSOw1>; Tue, 19 Nov 2002 09:52:27 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:51639 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266256AbSKSOw0>; Tue, 19 Nov 2002 09:52:26 -0500
Subject: Re: [LTP] Re: LTP - gettimeofday02 FAIL
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Paul Larson <plars@linuxtestproject.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <p73adk5vdra.fsf@oldwotan.suse.de>
References: <200211190127.gAJ1RWg11023@linux.local.suse.lists.linux.kernel>
	<1037713044.24031.15.camel@plars.suse.lists.linux.kernel> 
	<p73adk5vdra.fsf@oldwotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Nov 2002 15:27:31 +0000
Message-Id: <1037719651.12118.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-19 at 14:24, Andi Kleen wrote:
> It is very hard to solve properly and efficiently. When you search the
> list archives you will find long threads about the problem
> (search for "TSC" and gettimeofday and perhaps HPET or cyclone). Last one 
> was one or two weeks ago.
> 
> The problem has been there always in some way in linux, now it is just
> exposed in LTP because it tests for it.

Dual ppro boxes normally run with a locked synchronous TSC clock. That
suggests the newer code broke stuff. It may also be due to the bug in
the 2.5 timer handling code (missing delays on timer reads, incorrect
assumption that the timer never reads its limit value during the timer 
switch back to zero)

