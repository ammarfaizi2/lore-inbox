Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVBQUA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVBQUA4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVBQUAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:00:54 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22748 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262324AbVBQUAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:00:07 -0500
Date: Thu, 17 Feb 2005 20:54:57 +0100
From: Pavel Machek <pavel@suse.cz>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, seife@suse.de,
       rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
Message-ID: <20050217195456.GA5963@openzaurus.ucw.cz>
References: <20050214211105.GA12808@elf.ucw.cz> <1108621005.2096.412.camel@d845pe> <1108638021.4085.143.camel@tyrosine> <4214C3B8.30502@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4214C3B8.30502@gmx.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > to reinitialise the graphics hardware, few are going to care about
> > making life easier for Linux.
> 
> 1. A first step towards better DSDTs would be to make the ASL compiler
> complain about the same things which are complained about by the
> in-kernel ACPI interpreter. An example would be the following:
> 
> acpi_processor-0496 [10] acpi_processor_get_inf: Invalid PBLK length [7]
> 
> The ASL compiler will not complain about it, yet the kernel will
> refuse to do any processor throttling with a PBLK length of 7.

Not sure if you can check all interesting stuff statically.

> 2. Urge/force vendors to use the latest ASL compiler available.

Heh, good luck.

> 3. Get some shiny certification/label going that can be put on
> fully conforming products as a sticker. Something like the old
> "EPA pollution preventer" logo, but with a more appealing design.
> Perhaps a "InstantOn/PowerSave" sticker, you get the idea.

Like "This machine actually works" sticker? :-)

> 4. Include a mandantory description of video bringup after resume

That sounds overcomplicated. Simply add this to the specs:
"BIOS must POST video during S3 wakeup. Video mujst be working
and in 80x25 text mode when it jumps to OS. VESA BIOS calls must be available to the OS."

BIOS must do that during normal boot; this should be very little additional
work.
			Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

