Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVCLDix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVCLDix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 22:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVCLDiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 22:38:52 -0500
Received: from peabody.ximian.com ([130.57.169.10]:51385 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261833AbVCLDiu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 22:38:50 -0500
Subject: Re: IBM Thinkpad G41 PCMCIA problems [Was: Yenta TI: ... no PCI
	interrupts. Fish. Please report.]
From: Adam Belay <abelay@novell.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
In-Reply-To: <Pine.LNX.4.58.0502200905060.2378@ppc970.osdl.org>
References: <1108858971.8413.147.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0502191648110.14176@ppc970.osdl.org>
	 <1108863372.8413.158.camel@localhost.localdomain>
	 <20050220082226.A7093@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0502200905060.2378@ppc970.osdl.org>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 22:36:03 -0500
Message-Id: <1110598563.12485.273.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-20 at 09:23 -0800, Linus Torvalds wrote:
> 
> On Sun, 20 Feb 2005, Russell King wrote:
> > On Sat, Feb 19, 2005 at 08:36:12PM -0500, Steven Rostedt wrote:
> > >  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
> > >  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
> > >  BIOS-e820: 00000000000d0000 - 00000000000d4000 (reserved)
> > >  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
> > >  BIOS-e820: 0000000000100000 - 000000000f6f0000 (usable)
> > >  BIOS-e820: 000000000f6f0000 - 000000000f700000 (reserved)
> > >  BIOS-e820: 000000000f700000 - 000000003fef0000 (usable)
> > >  BIOS-e820: 000000003fef0000 - 000000003fef8000 (ACPI data)
> > >  BIOS-e820: 000000003fef8000 - 000000003fefa000 (ACPI NVS)
> > >  BIOS-e820: 000000003ff00000 - 0000000040000000 (reserved)
> > 
> > Your BIOS is broken.  You probably have 1GB of RAM which extends from
> > 0x00000000 to 0x40000000.  However, there's a hole in the ACPI map
> > between 0x3fefa000 and 0x3ff00000.
> 
> Good point. And dammit, we've had that problem too many times before.

ACPI will report the ranges available to a PCI root bridge, even on
single root machines.  I'm hoping to take advantage of this in my PCI
bus changes.  It should help with these sort of problems.

Thanks,
Adam


