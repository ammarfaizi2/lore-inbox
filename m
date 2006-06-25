Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWFYFC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWFYFC7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 01:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWFYFC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 01:02:59 -0400
Received: from mail.gmx.de ([213.165.64.21]:12512 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751383AbWFYFC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 01:02:58 -0400
X-Authenticated: #14349625
Subject: Re: Measuring tools - top and interrupts
From: Mike Galbraith <efault@gmx.de>
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: danial_thom@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060624192523.GA3231@atjola.homenet>
References: <20060622165808.71704.qmail@web33303.mail.mud.yahoo.com>
	 <1151128763.7795.9.camel@Homer.TheSimpsons.net>
	 <1151130383.7545.1.camel@Homer.TheSimpsons.net>
	 <20060624092156.GA13142@atjola.homenet>
	 <1151142716.7797.10.camel@Homer.TheSimpsons.net>
	 <1151149317.7646.14.camel@Homer.TheSimpsons.net>
	 <20060624154037.GA2946@atjola.homenet>
	 <1151166193.8516.8.camel@Homer.TheSimpsons.net>
	 <20060624192523.GA3231@atjola.homenet>
Content-Type: text/plain; charset=utf-8
Date: Sun, 25 Jun 2006 07:06:33 +0200
Message-Id: <1151211993.8519.6.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-24 at 21:25 +0200, Björn Steinbrink wrote:
> On 2006.06.24 18:23:12 +0200, Mike Galbraith wrote:
> > 
> > let's see.  Yeah, confirmed.
> 
> OK, it also depends on IO APIC being enabled and active, ie. noapic on
> the kernel command line will fix it as well as disabling
> CONFIG_X86_IO_APIC. That doesn't help me at all to understand why it
> happens though.

Ditto.

> The only difference with IO APIC disabled seems to be that the irq
> doesn't get ACKed before update_process_times() gets called.
> And your "fix" makes it being called outside of the xtime_lock spinlock
> and with a slightly different stack usage AFAICT.

(it's still under the xtime lock)

> But none of these should make a difference, right?

Not that I can see, but then it's pretty dark down here.  Anybody got a
flashlight I can borrow? ;-)

	-Mike

