Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbTLCBDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 20:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbTLCBDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 20:03:52 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:44024 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264441AbTLCBDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 20:03:50 -0500
Subject: Re: System clock and speedstepping
From: john stultz <johnstul@us.ibm.com>
To: Raffaele Sandrini <rasa@gmx.ch>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200312022316.21477.rasa@gmx.ch>
References: <200311261943.38002.rasa@gmx.ch>
	 <1070318452.23568.577.camel@cog.beaverton.ibm.com>
	 <200312022316.21477.rasa@gmx.ch>
Content-Type: text/plain
Organization: 
Message-Id: <1070412974.1047.8.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Dec 2003 16:56:15 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-02 at 14:16, Raffaele Sandrini wrote:
> On Monday 01 December 2003 23:40, john stultz wrote:
> >
> > The "sane timesource" is the PIT (programmable interval timer). The TSC
> > is the Time-Stamp-Counter which is basically a cycle counter on the cpu.
> > If you want to boot using the PIT instead of the TSC, you can override
> > the default time source by using  "clock=pit" as a boot option. However
> > hopefully the problem can be fixed by adjusting the cpufreq code. As I
> > don't have any such hardware, would you be interested in testing
> > possible patches?

> Im willing to solve it another way: There is a patch around (included in the 
> mm paches) for the kernel wich introduces a ACPI timer (timesource). As im 
> successfully using ACPI here ill switch over to it. A collegue of mine (who 
> had equal problems) reportet that this driver solves the problem completly.

I'm glad the ACPI PM time source is working for you. I hope it will
solve a great number of these sorts of issues on systems that support
it, but its not quite ready to be included. So the more testing the
better! Thanks!


> About your patches: I would surely test your patches... i think its necessray 
> to have a good bug less standard implementation  of the timesource.

Indeed. There are many systems that do not have working ACPI PM
timesource, so making sure the cpufreq code works for the TSC timesource
is important. I appreciate your offer. 

> BTW: The time screw was huge. Especially if i ran programms wich needed all 
> the recources avalible (while(1){}).

Very interesting. Give me some time to generate a patch that will give
more debug info, and then we can sort out what is happening for sure. 

thanks
-john


