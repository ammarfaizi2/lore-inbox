Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTH3Dqx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 23:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbTH3Dqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 23:46:53 -0400
Received: from mail.vtc.edu.hk ([202.75.80.229]:61484 "EHLO pandora.vtc.edu.hk")
	by vger.kernel.org with ESMTP id S262423AbTH3Dql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 23:46:41 -0400
Message-ID: <3F501E13.DFFBE6B2@vtc.edu.hk>
Date: Sat, 30 Aug 2003 11:46:27 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Single P4, many IDE PCI cards == trouble??
References: <3F4EA30C.CEA49F2F@vtc.edu.hk>
	 <1062150643.26753.4.camel@dhcp23.swansea.linux.org.uk>
	 <3F4F5C9A.5BAA1542@vtc.edu.hk> <1062167896.27561.4.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Junkmail-Whitelist: YES (by domain whitelist at pandora.vtc.edu.hk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Folks,
Alan Cox wrote:

> On Gwe, 2003-08-29 at 15:00, Nick Urbanik wrote:
> > Is there _anyone_ who is using a number of ATA133 IDE disks (>=6), each on
> > its own IDE channel, on a number of PCI IDE cards, and doing so
>
> The most I know of is 8, and that was one of the people who found the
> shared IRQ/IDE race cases that 2.4.21 or so fixed.

Do you know what chipsets they were using?  I would love to know!  Any success
stories, anyone?

> > > A freeze in an IRQ handler would cause that kind of thing, turning on
> > > the NMI watchdog might get you a trace in such a failure case - and
> > > that would help.
> >
> > If the NMI count is positive in /proc/interrupts, and I have nmi_watchdog=2
> > in /proc/cmdline, does that mean that the NMI watchdog is turned on?  If
>
> nmi watchdog trigger failure would indicate hardware problems in just
> about any situation I can imagine. The nmi is just that -not maskable-
> by software.

Yes, that's what I thought.  But I've replaced every piece of hardware in the
machine except the motherboard.  If the problem persists after the 3ware 7506-8
is finally installed at considerable expense, then I'll buy an Intel
motherboard.  Does the kernel work well with the chipset on the Intel
S875WP1-E?
<http://www.intel.com/design/servers/s875wp1-e/index.htm?iid=ipp_srvr_mthrbds+s875wpie_srvr>

I guess I would disable the Promise PDC20319 IDE and stick with the 3ware.

It's just that I am trying to set up servers that use cheap storage at the
college and teach students to build them.  It looks like we still have to pay
big bucks for SCSI and 3ware.  And that part of my teaching will be replaced
with something else.  Until I understand the problem and how to solve it.

--
Nick Urbanik   RHCE                               nicku(at)vtc.edu.hk
Dept. of Information & Communications Technology
Hong Kong Institute of Vocational Education (Tsing Yi)
Tel:   (852) 2436 8576, (852) 2436 8713          Fax: (852) 2436 8526
PGP: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B     ID: 7529555D
GPG: 7FFA CDC7 5A77 0558 DC7A 790A 16DF EC5B BB9D 2C24   ID: BB9D2C24



