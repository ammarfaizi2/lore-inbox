Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbUKVTfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbUKVTfx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbUKVTbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:31:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:41939 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262492AbUKVTYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:24:15 -0500
Date: Mon, 22 Nov 2004 11:23:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Len Brown <len.brown@intel.com>
cc: Chris Wright <chrisw@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
In-Reply-To: <1101150469.20006.46.camel@d845pe>
Message-ID: <Pine.LNX.4.58.0411221116480.20993@ppc970.osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net>  <1100819685.987.120.camel@d845pe>
 <20041118230948.W2357@build.pdx.osdl.net>  <1100941324.987.238.camel@d845pe>
  <Pine.LNX.4.58.0411200831560.20993@ppc970.osdl.org> <1101150469.20006.46.camel@d845pe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Nov 2004, Len Brown wrote:
> 
> I agree that the system should work properly even if the legacy device
> drivers are broken.  Please understand, however, that the legacy device
> drivers _are_ broken.  The BIOS via ACPI clearly tells them if the
> devices are present or not, and Linux isn't yet listening.

I really disagree.

I realize that you like ACPI, or you would have shot yourself long long 
ago.

But I have a totally different view on things. To me, firmware is not 
something cool to be used. It's a necessary evil, and it should be avoided 
and mistrusted as far as humanly possible, because it is always buggy, and 
we can't fix the bugs in it.

Yes, the current ACPI layer in the kernel is a lot better at working
around the bugs, and it's getting to the point where I suspect Linux
vendors actually decide that enabing ACPI by default causes fewer problems 
than it solves. That clearly didn't use to be true.

> ACPI-compliant systems have three types of interrupts:

Stop right there. 

"ACPI-compliant systems". The fact is, there is no such thing. There are 
systems that users buy, and they are not "ACPI compliant", they are "one 
implementation of ACPI that was tested with a single vendor usage test".

Call me cynical, but I believe in standards papers just about as much as I 
believe in the voices in my attic that tell me to kill the Queen of 
England. 

Papers is so much dead trees. The only thing that matters is real life.  
And like it or not, real life does NOT implement standards properly, even
if the standards are well written and unambiguous (which also doesn't
actually happen in real life).

> If somebody bolts motherboard hardware on and doesn't tell ACPI about
> it, then they need to disable ACPI, which _owns_ configuration of
> motherboard devices when it is enabled.

No. The only thing that owns the motherboard is the user. ACPI shouldn't 
get uppity.

> The damn good reason is that doing otherwise breaks systems.

And not doing it breaks systems.

See a pattern?

This is why I don't trust firmware. It's always buggy. 

		Linus
