Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbTIRRnV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 13:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbTIRRnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 13:43:21 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51463 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261955AbTIRRnU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 13:43:20 -0400
Date: Thu, 18 Sep 2003 13:34:04 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Pavel Machek <pavel@ucw.cz>
cc: richard.brunner@amd.com, alan@lxorguk.ukuu.org.uk, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
In-Reply-To: <20030918074331.GA386@elf.ucw.cz>
Message-ID: <Pine.LNX.3.96.1030918130129.7139D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Sep 2003, Pavel Machek wrote:

> > I think Alan brought up a very good point. Even if you
> > use a generic kernel that avoids prefetch use on Athlon
> > (which I am opposed to), it doesn't solve the problem
> > of user space programs detecting that the ISA supports
> > prefetch and using prefetch instructions and hitting the
> > errata on Athlon.
> > 
> > The user space problem worries me more, because the expectation
> > is that if CPUID says the program can use perfetch, it could
> > and should regardless of what the kernel decided to do here.
> 
> User programs should not rely on cpuid; they should read /proc/cpuinfo
> exactly because this kind of errata.

That's fine, but impacts portability. I don't think there is a right
way, since the o/s may not know about some features and the CPU may be
optimistic. Unless they are "recent Linux only" programs they may well
check the CPU itself, there are reasons for it in portable code.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

