Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWB1KE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWB1KE6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 05:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWB1KE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 05:04:58 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:1945
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750738AbWB1KE5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 05:04:57 -0500
Subject: Re: + fix-next_timer_interrupt-for-hrtimer.patch added to -mm tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Tony Lindgren <tony@atomide.com>
Cc: akpm@osdl.org, heiko.carstens@de.ibm.com, johnstul@us.ibm.com,
       rmk@arm.linux.org.uk, schwidefsky@de.ibm.com,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060228095100.GA31105@atomide.com>
References: <200602250219.k1P2JLqY018864@shell0.pdx.osdl.net>
	 <1140884243.5237.104.camel@localhost.localdomain>
	 <20060225185731.GA4294@atomide.com> <20060228032900.GE4486@atomide.com>
	 <1141117500.5237.112.camel@localhost.localdomain>
	 <20060228095100.GA31105@atomide.com>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 11:06:31 +0100
Message-Id: <1141121191.5237.130.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony,

On Tue, 2006-02-28 at 01:51 -0800, Tony Lindgren wrote:
> Cool, after a quick test seems to work OK here. Any ideas how to fix the
> locking problem above?
> 
> Maybe one option would be to just reprogram the hardware timer when a
> new hrtimer is added. That would then allow subjiffie timers too.

You might have a look into the high resolution timer patches on top of
hrtimers at http://www.tglx.de/projects/hrtimers

The clockevents abstraction layer is a quick attempt to generalize the
problem around event generation. I'm stuck in some other work right now,
but I'm going to rework this layer soon. IMO John Stultz GTOD patches
and the generalization of clock events will be a sane base for high
resolution timers and dynamic ticks.

	tglx





