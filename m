Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbVLNUOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbVLNUOp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 15:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbVLNUOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 15:14:45 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:57753 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964927AbVLNUOo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 15:14:44 -0500
Subject: Re: tsc clock issues with dual core and question about
	irq	balancing
From: john stultz <johnstul@us.ibm.com>
To: Adrian Yee <brewt-linux-kernel@brewt.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <GMail.1134551267.12292355.45625751005@brewt.org>
References: <GMail.1134458797.49013860.4106109506@brewt.org>
	 <1134522289.3897.21.camel@leatherman>
	 <GMail.1134551267.12292355.45625751005@brewt.org>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 12:14:32 -0800
Message-Id: <1134591272.16294.3.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 01:07 -0800, Adrian Yee wrote:
> Hi John,
> 
> >> I'm currently testing the system with "nosmp noapic acpi=off
> >> clock=tsc" (it was losing interrupts and wouldn't boot properly
> >> with apic/acpi on) and so far everything seems to work (this
> >> includes ssh and desktop usage is better).
> > 
> > So keeping the above settings, does removing just the "clock=tsc"
> > cause the sluggishness to appear?
> 
> I just tried booting with the pmtmr enabled and incoming ssh is bad
> (I had an ls pause for over 20 seconds, while another connection was
> somewhat fine).  I wish I had more concrete tests since the problems
> I'm seeing are so subjective.  I guess I'll have to ignore this
> problem until I get a better test.

>From your dmesg, you're still running w/ smp, apic, acpi as well. I was
curious if you could run just as you had before without issue using 
"nosmp noapic acpi=off clock=tsc", only drop the clock=tsc bit.

I just want to be sure we're only changing one variable at a time. :)


> > Also would you open a bugzilla bug on this and attach your .config
> > and dmesg?
> 
> Done: http://bugzilla.kernel.org/show_bug.cgi?id=5740

Thanks for filling that out! I'll see if I cannot reproduce anything
similar using your config.


thanks again,
-john

