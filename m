Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbTFFQ3h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 12:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbTFFQ3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 12:29:37 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:6917 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261989AbTFFQ3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 12:29:34 -0400
Date: Fri, 6 Jun 2003 12:36:15 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [REPOST][REPOST][REPOST] Killing processes in D state
In-Reply-To: <200306021158.13429.roy@karlsbakk.net>
Message-ID: <Pine.LNX.3.96.1030606122650.4191F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jun 2003, Roy Sigurd Karlsbakk wrote:

> this discussion has been up a few times, but I want it again. I _REALLY_ want 
> to be able to kill processes in D state. I am aware of that this is not good, 
> but compared to other parts of the linux kernel, there's quite a lot suicidal 
> stuff there already, so why not. There is, for instance, in 2.5, the 
> possibility to forcably remove loaded modules - FAR worse than merely killing 
> a userspace process in D state.
> 
> So please, dear kernel people, Free Thy Users From Those Terrible Unreasonable 
> Reboots.

Do you understand why processes in D state are unkillable? What do you
think you would gain by killing them, since the memory couldn't be safely
reused? Just not seeing the process in ps?

I can see wanting to avoid having processes in D state, but once you get
such a thing I don't see why the kernel should have a lot of code added to
hide a problem. A reboot *is* a way to kill a process in D state.

In general most of the process should page out, so you only lose some swap
space. I don't get processes in this state, so I can't really check the
RSS and verify that.

Tell the developers how you get the processes in that state and ask for
that to be prevented, and you will find a lot more support.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

