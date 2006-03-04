Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWCDHR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWCDHR0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 02:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWCDHR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 02:17:26 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:14491 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751374AbWCDHRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 02:17:25 -0500
Date: Sat, 4 Mar 2006 08:15:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, zippel@linux-m68k.org, rmk@arm.linux.org.uk,
       schwidefsky@de.ibm.com, tony.luck@intel.com, davidm@hpl.hp.com,
       clameter@sgi.com, george@mvista.com, ak@suse.de, paulus@samba.org,
       benh@kernel.crashing.org, arnd@arndb.de
Subject: Re: [RFC][PATCHSET] Time: Generic Timeofday Subsystem (v B20)
Message-ID: <20060304071510.GA3893@elte.hu>
References: <1141447396.9727.139.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141447396.9727.139.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john stultz <johnstul@us.ibm.com> wrote:

> Summary:
> 	This patchset provides a generic timekeeping subsystem that is 
> independent of the timer interrupt. This allows for robust and correct 
> behavior in cases of late or lost ticks, avoids interpolation errors, 
> reduces duplication in arch specific code, and allows or assists 
> future changes such as high-res timers, dynamic ticks, or realtime 
> preemption.  Additionally, it provides finer nanosecond resolution 
> values to the clock_gettime functions.
> 
> Why do we need this?

i'd like to add the following to the list of reasons as well: the 
current -hrt patch-queue (high resolution timers, which enables true 
microsecond-level resolution for POSIX timers and nanosleep()), which is 
working pretty well in the -rt tree and implements an important feature 
for Linux, is based on the generic timekeeping subsystem as well.

	Ingo
