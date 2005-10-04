Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbVJDSTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbVJDSTO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 14:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbVJDSTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 14:19:13 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:64649
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S964898AbVJDSTN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 14:19:13 -0400
Subject: Re: 2.6.14-rc3-rt2
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Mark Knecht <markknecht@gmail.com>
Cc: Steven Rostedt <rostedt@kihontech.com>, Ingo Molnar <mingo@elte.hu>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
In-Reply-To: <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com>
	 <20051004130009.GB31466@elte.hu>
	 <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com>
	 <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 04 Oct 2005 20:20:29 +0200
Message-Id: <1128450029.13057.60.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-04 at 11:11 -0700, Mark Knecht wrote:

> I have now had one burst of xruns. As best I can tell I was
> downloading some video files for mplayer to look at, or possibly
> running one of them. I see this in qjackctl:
> 

I guess its related to the priority leak I'm tracking down right now.
Can you please set following config options and check if you get a bug
similar to this ?

BUG: init/1: leaked RT prio 98 (116)?

Steven, it goes away when deadlock detection is enabled. Any pointers ?

tglx


# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_PRINTK_IGNORE_LOGLEVEL is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=17
# CONFIG_DETECT_SOFTLOCKUP is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_IRQ_FLAGS=y
# CONFIG_WAKEUP_TIMING is not set
CONFIG_PREEMPT_TRACE=y
# CONFIG_CRITICAL_PREEMPT_TIMING is not set
# CONFIG_CRITICAL_IRQSOFF_TIMING is not set
# CONFIG_RT_DEADLOCK_DETECT is not set
# CONFIG_DEBUG_RT_LOCKING_MODE is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_FS is not set
# CONFIG_USE_FRAME_POINTER is not set
# CONFIG_EARLY_PRINTK is not set
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y


