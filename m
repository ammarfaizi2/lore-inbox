Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbUDFVvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 17:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264022AbUDFVvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 17:51:08 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:56061 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263274AbUDFVvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 17:51:05 -0400
Date: Tue, 6 Apr 2004 23:46:16 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Praedor Atrebates <praedor@yahoo.com>, lkml <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: System clock speed too high - 2.6.3 kernel
Message-ID: <20040406214616.GC11010@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	john stultz <johnstul@us.ibm.com>,
	Praedor Atrebates <praedor@yahoo.com>,
	lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
References: <200403261430.18629.praedor@yahoo.com> <1080336165.5408.307.camel@cog.beaverton.ibm.com> <200403261800.32717.praedor@yahoo.com> <1080660339.5408.356.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080660339.5408.356.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 07:25:39AM -0800, john stultz wrote:
> On Fri, 2004-03-26 at 15:00, Praedor Atrebates wrote:
> > On Friday 26 March 2004 04:22 pm, john stultz held forth thus:
> > > On Fri, 2004-03-26 at 11:30, Praedor Atrebates wrote:
> > > > In doing a web search on system clock speeds being too high, I found
> > > > entries describing exactly what I am experiencing in the linux-kernel
> > > > list archives, but have not yet found a resolution.
> > > >
> > > > I have Mandrake 10.0, kernel-2.6.3-7mdk installed, on an IBM Thinkpad
> > > > 1412 laptop, celeron 366, 512MB RAM.  I am finding that my system clock
> > > > is ticking away at a rate of about 3:1 vs reality, ie, I count ~3 seconds
> > [...]
> > > Could you please send me dmesg output for this system?
> > >
> > Attached is the output of dmesg.  
> 
> You mentioned that your system is an older laptop, and you're setting
> "acpi=on" in your boot arguments. What happens when you omit "acpi=on"?
> Do you get a message saying something to the effect of your system being
> too old for ACPI? Does everything still work as it ought?

Hm, could you please verify that ACPI throttling and cpufreq is _disabled_
when you do this check? For throttling, please do

echo 1 > /proc/acpi/processor/./throttling
echo 0 > /proc/acpi/processor/./throttling

[just echo'ing 0 is a noop if ACPI thinks it's at T0... and we want to force
T0].

	Dominik
