Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTKXV3x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 16:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbTKXV3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 16:29:53 -0500
Received: from web40904.mail.yahoo.com ([66.218.78.201]:32938 "HELO
	web40904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261605AbTKXV3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 16:29:48 -0500
Message-ID: <20031124212929.94319.qmail@web40904.mail.yahoo.com>
Date: Mon, 24 Nov 2003 13:29:29 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0311242202430.2874-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Liakhovetski,

--- Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> On Mon, 24 Nov 2003, Bradley Chapman wrote:
> 
> > I saw in Linus' 2.6.0-test10 announcement that preempt is suffering from some
> > problems and should not be used. However, I am currently running 2.6.0-test10
> > with CONFIG_PREEMPT=y and nothing has appeared yet. To see if the problem
> appeared
> > under stress, I started an A/V trailer playback with mplayer and then ran the
> > find command on both my home directory and the 2.6.0-test10 kernel source
> directory,
> > with the expected result - mplayer did not skip, neither find invocation broke,
> > and there were no nasty errors in dmesg.
> >
> > So what exactly is the problem?
> 
> Well, FWIW, I'm getting 100% reproducible Oopses on __boot__ by enabling
> preemption AND (almost) all kernel-hacking CONFIG_DEBUG_* options - see my
> post of 21.11.2003 with subject "[OOPS] 2.6.0-test7 + preempt + hacking".
> If required, could try to narrow it down to 1 CONFIG option. However, the
> Oops itself happens somewhere in NFS code (see backtrace in above email
> for details).

Hmmm. This is what I have enabled under "Kernel hacking":

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_INFO is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

So far, though, not a single problem -- I was playing Flash animations while
printing a huge document without a single hiccup (I have an HP DeskJet 880C with
very little memory, so there was a lot of in-kernel activity).

> 
> Guennadi

Brad

=====


__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
