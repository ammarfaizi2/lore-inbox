Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVCCQbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVCCQbN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 11:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVCCQ3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 11:29:37 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:3081
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S262115AbVCCQYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 11:24:09 -0500
Date: Thu, 3 Mar 2005 17:24:02 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050303162402.GM8880@opteron.random>
References: <20050223014233.6710fd73.akpm@osdl.org> <20050224215136.GK8651@stusta.de> <20050224224134.GE20715@opteron.random> <20050225211453.GC3311@stusta.de> <20050226013137.GO20715@opteron.random> <20050301003247.GY4021@stusta.de> <20050301004449.GV8880@opteron.random> <20050303145147.GX4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303145147.GX4608@stusta.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 03:51:47PM +0100, Adrian Bunk wrote:
> My point is simply:
> 
> The help text for an option you need only under very specific 
> circumstances shouldn't sound as if this option was nearly was 
> mandatory.
> 
> For me, that's a question principle, not of risks of breakage or code 
> size.

My point is that the size of the linux desktop userbase is already small
compared to other OS userbase, and I don't want to fragment it even
further risking people to set it to N. People setting this to N is an
huge risk. If most people set it to N I'll be forced to switch to make
drastic plan changes right away. This is why I'd prefer to leave the Y
recommandation for now ;)

Or I'll make it a syscall, do the embedded folks have a compilation
option to disable the sys_sched_setaffinity syscalls and bytecode? No
they don't. By you your same argument we should add a
CONFIG_SCHED_AFFININITY and we shouldn't recommend it to Y.

This isn't a device driver, this is a linux kernel API that some app can
depend on, and you don't know for sure which app will depend on it. So
you should definitely say Y if unsure.
