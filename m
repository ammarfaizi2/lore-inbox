Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVASXe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVASXe7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVASXdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:33:52 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:55688 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261976AbVASXc2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:32:28 -0500
Date: Wed, 19 Jan 2005 15:32:14 -0800
From: Tony Lindgren <tony@atomide.com>
To: George Anzinger <george@mvista.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: VST patches ported to 2.6.11-rc1
Message-ID: <20050119233214.GA9975@atomide.com>
References: <20050113132641.GA4380@elf.ucw.cz> <20050114001118.GA1367@elf.ucw.cz> <41E71A78.8050507@mvista.com> <41EEE9E4.4070105@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EEE9E4.4070105@mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* George Anzinger <george@mvista.com> [050119 15:21]:
> George Anzinger wrote:
> >Pavel Machek wrote:
> >
> >>Hi!
> >>
> >>
> >>>I really hate sf download system... Here are those patches (only
> >>>common+i386) ported to 2.6.11-rc1.
> >>
> >>
> >>
> >>Good news is it booted. But I could not measure any powersavings by
> >>turning it on. (I could measure difference between HZ=100 and
> >>HZ=1000).
> >>
> >>Hmm, it does not want to do anything. threshold used to be 1000, does
> >>it mean that it would not use vst unless there was one second of quiet
> >>state? I tried to lower it to 10 ("get me HZ=100 power consumption")
> >>but it does not seem to be used, anyway:
> 
> I wonder if the problem is that we are not disabling the PIT interrupt.  I 
> have a PIII SMP system so the interrupt path may be different and the code 
> to stop interrupts may be wrong.  The normal system does not admit to 
> stopping the time base so it is possible that this is wrong.

That could make a difference as hlt and ACPI C2/C3 will wake to PIT
interrupt AFAIK.

Tony
