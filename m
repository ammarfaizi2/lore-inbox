Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268034AbTAIXDC>; Thu, 9 Jan 2003 18:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268036AbTAIXDC>; Thu, 9 Jan 2003 18:03:02 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:38153 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S268034AbTAIXDB>; Thu, 9 Jan 2003 18:03:01 -0500
Date: Thu, 9 Jan 2003 18:09:20 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] /proc/sys/kernel/pointer_size
In-Reply-To: <Pine.LNX.4.44.0301081502270.7688-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96.1030109175030.30393B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2003, Linus Torvalds wrote:

> Nope.
> 
> System binaries match the kernel. It's as easy as that. So what if 90% of 
> the user binaries use 32-bit mode because it's smaller and faster? We're 
> talking about a system binary that is _very_ intimate with the kernel.
> 
> Just make it a compile-time option and be done with it. 

s/the kernel/the booted kernel/ in that. Isn't the reason for wanting this
information because it isn't (necessarily) constant? You could rebuild the
tools that care at boot time, with configuration options, but you still
have to be able to get the information to do the rebuild.

Rather than fight this battle repeatedly, is there some way to make
information like this available at run time, in some more reliable way
than uname, so that useful tools could simply configure themselves.

Depending on the kernel and all the tools to set things like this via
configurations is less robust than providing a way for the applications to
tell for certain the environment. There are not all that many values to
check, so perhaps having a single way to make them all available is
desirable. Like various config options for extra checking in kernel
builds, in some cases reliability justifies the overhead. 

I'm not making any suggestings on how to do this, /proc certainly makes
the information readily available to shell/perl scripts, some magic value
to sysconf? Whatever, this is not the first time someone has wanted to be
able to access config information, a good solution in one place might be
appropriate.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

