Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbTH2OjG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbTH2OjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:39:06 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:39595 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261173AbTH2OjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:39:04 -0400
Subject: Re: Single P4, many IDE PCI cards == trouble??
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Urbanik <nicku@vtc.edu.hk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F4F5C9A.5BAA1542@vtc.edu.hk>
References: <3F4EA30C.CEA49F2F@vtc.edu.hk>
	 <1062150643.26753.4.camel@dhcp23.swansea.linux.org.uk>
	 <3F4F5C9A.5BAA1542@vtc.edu.hk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062167896.27561.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 29 Aug 2003 15:38:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-08-29 at 15:00, Nick Urbanik wrote:
> Is there _anyone_ who is using a number of ATA133 IDE disks (>=6), each on
> its own IDE channel, on a number of PCI IDE cards, and doing so

The most I know of is 8, and that was one of the people who found the
shared IRQ/IDE race cases that 2.4.21 or so fixed.

> > A freeze in an IRQ handler would cause that kind of thing, turning on
> > the NMI watchdog might get you a trace in such a failure case - and
> > that would help.
> 
> If the NMI count is positive in /proc/interrupts, and I have nmi_watchdog=2
> in /proc/cmdline, does that mean that the NMI watchdog is turned on?  If

nmi watchdog trigger failure would indicate hardware problems in just
about any situation I can imagine. The nmi is just that -not maskable-
by software.


