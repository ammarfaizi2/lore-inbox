Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263635AbUCYXD7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 18:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbUCYXB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 18:01:28 -0500
Received: from fmr11.intel.com ([192.55.52.31]:51657 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S263699AbUCYXAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:00:25 -0500
Subject: Re: [BUG 2.6.5-rc2-bk5 and 2.6.5-rc2-mm3] ACPI seems to be broken
From: Len Brown <len.brown@intel.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Rik van Ballegooijen <sleightofmind@xs4all.nl>
In-Reply-To: <200403251432.32787@WOLK>
References: <200403251432.32787@WOLK>
Content-Type: text/plain
Organization: 
Message-Id: <1080255609.757.18.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 Mar 2004 18:00:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-25 at 08:32, Marc-Christian Petersen wrote:
> Hi all,
> 
> attached you find my .config and dmesg log booting 2.6.5-rc2-mm3 with ACPI 
> enabled. Seems something is broken in there.


> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 22 low level)

> ACPI: SCI (IRQ22) allocation failed
>  ACPI-0133: *** Error: Unable to install System Control Interrupt
Handler, AE_NOT_ACQUIRED
> ACPI: Unable to start the ACPI Interpreter

yep, this failure will effect all machines with a non-identity mapped
SCI over-ride (your's maps IRQ9 in PIC mode to IRQ22 in IOAPIC mode).

another workaround would be to run this kernel with "noapic" till we get
a fix in.

working this issue here:
http://bugzilla.kernel.org/show_bug.cgi?id=2366

thanks,
-Len



