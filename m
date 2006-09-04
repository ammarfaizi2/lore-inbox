Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWIDNJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWIDNJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWIDNJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:09:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36614 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964905AbWIDNJw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:09:52 -0400
Date: Mon, 4 Sep 2006 13:09:33 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jim Gettys <jg@laptop.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       "Brown, Len" <len.brown@intel.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org
Subject: Re: [OLPC-devel] Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM Improvements
Message-ID: <20060904130933.GC6279@ucw.cz>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com> <20060830194317.GA9116@srcf.ucam.org> <200608311713.21618.bjorn.helgaas@hp.com> <1157070616.7974.232.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157070616.7974.232.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> In short, we have novel hardware: we can have our screen on, and suspend
> the processor to RAM, and use a half a watt.  We can have our wireless
> forwarding packets in our mesh networks, with the processor suspended,
> consuming under 400mw (we hope 300mw by the time we ship).  Both on, and
> we're still under one watt.
> 
> For keyboard activity, human perception is in the 100-200 millisecond
> range; for some other stuff, it is even less much than that.  So that's
> the necessity; now the invention.
> 
> I've done a straw pole among kernel gurus at OLS and elsewhere on how
> fast Linux might be able to resume. I've gotten answers of typically
> "one second".
> 
> But, on other platforms (see attached), I have data I've measured myself
> showing Linux going from resume from RAM to *scheduling user level
> processes* 100 times faster than that, on a wimpy 200mhz ARM processor.
> Yes, Matilda, Linux can, on non-braindead hardware, resume all the way
> to scheduling user processes in 10 milliseconds on a 200mhz processor.

2.4 and 2.6 are *very* different here. You'll probably need to optimize freezer
in 2.6 a bit...
							Pavel
-- 
Thanks for all the (sleeping) penguins.
