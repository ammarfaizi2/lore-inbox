Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVKMBZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVKMBZJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 20:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVKMBZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 20:25:09 -0500
Received: from ns.suse.de ([195.135.220.2]:20655 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750742AbVKMBZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 20:25:07 -0500
To: john stultz <johnstul@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B10)
References: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>
From: Andi Kleen <ak@suse.de>
Date: 13 Nov 2005 02:24:36 +0100
In-Reply-To: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>
Message-ID: <p73lkzt49wr.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> writes:

> All,
> 	I had hoped to submit this to -mm today, but since Ingo pointed
> out an issue in the __delay code, I'm going to wait a week so the new fix
> can be better tested.

At least on x86-64 there is currently so much other timer related
development going on (per CPU TSC timers, no idle tick, 64bit HPET
etc.)  that I don't want any x86-64 bits of that merged for the next
time. The other stuff needs to settle first.

I haven't read the patchset in full detail, but from a quick look
it's also not obvious too me in which way it is easier and cleaner
than the old setup. While the old code was quirky in parts the
new one seems to fall more in the overmodularization/too many
indirect callbacks trap.

It is also totally unclear how it will interact with vsyscall.

-Andi
