Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVDJN3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVDJN3r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 09:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVDJN3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 09:29:47 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:28802 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261497AbVDJN3c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 09:29:32 -0400
Date: Sun, 10 Apr 2005 15:26:01 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: TommyDrum <mycooc@yahoo.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: r8169 native module problems on 2.6.11
Message-ID: <20050410132601.GA9027@electric-eye.fr.zoreil.com>
References: <42591914.2000800@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42591914.2000800@yahoo.it>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

TommyDrum <mycooc@yahoo.it> :
[new brand of r8169 adapter coming into town]
> and dmesg for both:
> 
> kernel native:
> 
> ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 11 (level, low) -> IRQ 11
> eth0: Identified chip type is 'RTL8169s/8110s'.
> eth0: U.S. Robotics 10/100/1000 PCI NIC driver version 2.0 at
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 0xe08ee000, 00:c0:49:f2:86:1e, IRQ 11
> eth0: Auto-negotiation Enabled.

Can you check that the message above is _really_ the output of your
native kernel ? I have not checked gentoo's sources but the real vanilla
kernel can not issue this string.

> USR module:
> 
> ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 11 (level, low) -> IRQ 11
> eth0: Identified chip type is 'RTL8169s/8110s'.
> eth0: U.S. Robotics 10/100/1000 PCI NIC driver version 2.0 at
> 0xe08e6000, 00:c0:49:f2:86:1e, IRQ 11
> eth0: Auto-negotiation Enabled.

> I don't understand exactly the difference between the two, thought I
> could help by posting this fact. Please if you find it irrelevant don't
> flame me, since it's my first post to the kernel mailing list, I'd
> welcome any suggestions and I will try to post any other information you
> request.

You can send for both working/non-working after module insertion (wait
for a few seconds):
- complete dmesg (the beginning of it could be in /var/log/dmesg or such)
- lspci -vx
- lsmod
- ifconfig -a
- ethtool eth0
- cat /proc/interrupts
- source code

Also:
- brand name of the motherboard
- the name given by USR to the adapter (check the box)

I do not mind if the info is mailed, available on some web site or stuffed
at bugzilla.kernel.org. Please Cc: netdev@oss.sgi.com on further messages.

--
Ueimor
