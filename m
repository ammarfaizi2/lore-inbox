Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUDGOIh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 10:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263811AbUDGOIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 10:08:05 -0400
Received: from web01-imail.bloor.is.net.cable.rogers.com ([66.185.86.75]:51507
	"EHLO web01-imail.rogers.com") by vger.kernel.org with ESMTP
	id S263762AbUDGOHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:07:45 -0400
X-Mailer: Openwave WebEngine, version 2.8.11 (webedge20-101-194-20030622)
From: <shawn.starr@rogers.com>
To: "Brown, Len" <len.brown@intel.com>,
       "Feldman, Scott" <scott.feldman@intel.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: RE: [BUG][2.6.5 final][e100] NETDEV_WATCHDOG Timeout - Was not a problem wit
Date: Wed, 7 Apr 2004 10:07:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at web01-imail.rogers.com from [127.0.0.1] using ID <shawn.starr@rogers.com> at Wed, 7 Apr 2004 10:07:18 -0400
Message-Id: <20040407140718.MVHW491735.web01-imail.rogers.com@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will give this a try today and report back

I should also note, I tried using the older ee100pro driver and also had the same problems. I know it cannot be the network card as older 2.6 kernels did not exhibit this problem. If this is an ACPI change, what can we do to fix this? Currently, I let ACPI do the IRQ routing as I have various hardware that has issues with IRQs (ISA).

I haven't disabled ACPI as it was working fine before.

As a side note, I need to restart testing of the ACPI in general to see if it can route all my ISA devices properly using the new options added to kernel boot.
> 
> From: "Brown, Len" <len.brown@intel.com>
> Date: 2004/04/06 Tue PM 06:58:41 EDT> To: "Feldman, Scott" <scott.feldman@intel.com>, 
>    "Shawn Starr" <shawn.starr@rogers.com>,  <linux-kernel@vger.kernel.org>
> Subject: RE: [BUG][2.6.5 final][e100] NETDEV_WATCHDOG Timeout - Was not a problem with 2.6.5-rc3
> 
> 
> >> When I try to access the eth0 device I get:
> >> 
> >> Apr  4 15:39:01 coredump kernel: NETDEV WATCHDOG: eth0: 
> >> transmit timed out Apr  4 16:22:12 coredump kernel: NETDEV 
> >> WATCHDOG: eth0: transmit timed out
> >
> >Shawn, try turning off ACPI for interrupt routing.  Load the 
> >kernel with
> >the kernel parameter "noapci" set.
> 
> You mean "acpi=off", or "pci=noacpi".  If either of these fix the
> problem, please let me know.  (and send me the dmesg and
> /proc/interrupts for both cases)
> 
> "noapic" (note spelling) would have no effect on this box b/c it is
> running in PIC-mode.
> 
> Cheers,
> -Len> 

1

