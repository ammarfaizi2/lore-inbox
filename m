Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265421AbTFWWP5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 18:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265423AbTFWWNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:13:49 -0400
Received: from fmr02.intel.com ([192.55.52.25]:3320 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S265172AbTFWWLv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:11:51 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [ACPI] MS-6368L ACPI IRQ problem still in 2.4.21
Date: Mon, 23 Jun 2003 15:23:48 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A847E96FBE@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] MS-6368L ACPI IRQ problem still in 2.4.21
Thread-Index: AcM51VX5XsnK7d51QDyJBRZqnQWj1wAAF5GA
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Marek Michalkiewicz" <marekm@amelek.gda.pl>,
       <linux-kernel@vger.kernel.org>
Cc: <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 23 Jun 2003 22:23:48.0365 (UTC) FILETIME=[1DE223D0:01C339D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Marek Michalkiewicz [mailto:marekm@amelek.gda.pl] 
> long time ago I noticed a problem with the ACPI IRQ not working
> if it is _not_ shared with some other PCI IRQ.  The problem still
> exists in the 2.4.21 kernel, confirmed on two machines with the
> MSI MS-6368L motherboard (VIA PLE133 chipset).
> 
> I need ACPI for just one thing: to run "shutdown -h now" after the
> power button is pressed.  (The box is a server which usually has
> no keyboard connected.)
> 
> As I can see in /proc/interrupts, the BIOS usually allocates IRQ9
> for ACPI (not shared with anything else), and the IRQ9 counter is
> always zero.  Pressing the power button has no effect at all.
> 
> There is an easy workaround: in BIOS setup, set IRQ9 to "Legacy ISA"
> instead of "PCI/ISA PnP" so that ACPI gets some other IRQ, shared
> with some other PCI devices (in my case, IRQ11 is shared by: acpi,
> usb-uhci, usb-uhci, eth0).  Then the power button works fine.
> 
> Is this a known problem?  Should I complain to MSI (BIOS fix),
> or is this a Linux bug?  Any patches I should try?  This looks
> a bit unusual to me - one would expect problems if an IRQ _is_
> shared, and some broken hardware/driver doesn't like sharing...
> 
> If there is no known fix, perhaps the "Legacy ISA" workaround
> (which I discovered by accident) should be documented somewhere?

Is this an SMP machine?
What do the INT_SRC_OVR lines in the dmesg say?

Thanks -- Andy
