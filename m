Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbUCZV74 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUCZV6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:58:15 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:40853 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261357AbUCZV57
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:57:59 -0500
Subject: Re: System clock speed too high - 2.6.3 kernel
From: john stultz <johnstul@us.ibm.com>
To: Praedor Atrebates <praedor@yahoo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       Len Brown <len.brown@intel.com>
In-Reply-To: <200403261800.32717.praedor@yahoo.com>
References: <200403261430.18629.praedor@yahoo.com>
	 <1080336165.5408.307.camel@cog.beaverton.ibm.com>
	 <200403261800.32717.praedor@yahoo.com>
Content-Type: text/plain
Message-Id: <1080338266.5408.316.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 26 Mar 2004 13:57:46 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-26 at 15:00, Praedor Atrebates wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Friday 26 March 2004 04:22 pm, john stultz held forth thus:
> > On Fri, 2004-03-26 at 11:30, Praedor Atrebates wrote:
> > > In doing a web search on system clock speeds being too high, I found
> > > entries describing exactly what I am experiencing in the linux-kernel
> > > list archives, but have not yet found a resolution.
> > >
> > > I have Mandrake 10.0, kernel-2.6.3-7mdk installed, on an IBM Thinkpad
> > > 1412 laptop, celeron 366, 512MB RAM.  I am finding that my system clock
> > > is ticking away at a rate of about 3:1 vs reality, ie, I count ~3 seconds
> [...]
> > Could you please send me dmesg output for this system?
> >
> > Does booting w/ "clock=pit" help?
> 
> Attached is the output of dmesg.  As I scanned it I see that I still have APIC 
> disabled in Bios.  I'll try enabling it and, if that doesn't help, then I 
> will try the "clock=pit" switch.

I noticed in the dmesg you sent me that you're using the ACPI PM time
source. There has just recently been a bug opened for a very similar
issue (see http://bugme.osdl.org/show_bug.cgi?id=2375 ). 

First of all, scratch trying "clock=pit" and test booting w/
"clock=tsc". If that resolves the issue, disable ACPI PM timesource
support (under the ACPI menu) in your kerel and that should fix you for
the short term. 

As for the long term, I'm curious if this is a BIOS/Hardware quirk on
some systems or if there is just something we missed. 

Dominik/Len: Any clue on this?

thanks
-john

