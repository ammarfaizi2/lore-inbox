Return-Path: <linux-kernel-owner+w=401wt.eu-S932442AbXAGJC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbXAGJC4 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 04:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbXAGJC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 04:02:56 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3149 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932439AbXAGJCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 04:02:54 -0500
Date: Sun, 7 Jan 2007 09:02:35 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Brownell <david-b@pacbell.net>
Cc: Woody Suwalski <woodys@xandros.com>,
       Alessandro Zummo <alessandro.zummo@towertech.it>,
       rtc-linux@googlegroups.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2.6.20-rc3 1/3] rtc-cmos driver
Message-ID: <20070107090235.GA21613@flint.arm.linux.org.uk>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	Woody Suwalski <woodys@xandros.com>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <200701051001.58472.david-b@pacbell.net> <200701051933.26368.david-b@pacbell.net> <459FD993.3070909@xandros.com> <200701061317.25567.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200701061317.25567.david-b@pacbell.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 01:17:25PM -0800, David Brownell wrote:
> On Saturday 06 January 2007 9:17 am, Woody Suwalski wrote:
> > >> There are PPC, M68K, SPARC, and other boards that could also
> > >> use this; ARMs tend to integrate some other RTC on-chip.  ...
> > 
> > > Let me put that differently.  That should be done as a separate
> > > patch, adding (a) that platform_device, and maybe platform_data
> > > if it's got additional alarm registers, and (b) Kconfig support
> > > to let that work.  I'd call it a "patch #4 of 3".  ;)
> > > ...
> > 
> > I will try to play with the new code on Monday on ARM...
> 
> Thanks.  Could you describe your ARM board?  None of mine have an
> RTC using this register API.  Does it support system sleep states
> (/sys/power/state) with a wakeup-capable (enable_irq_wake) RTC irq? 

Woody will be using a Netwinder (he's part of the original development
team.)  So no sleep states and therefore no wakeup.

There's various other ARM-based systems using the PC RTC, but none of
them have sleep or wakeup abilities afaik.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
