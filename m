Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265323AbUEUBSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265323AbUEUBSq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 21:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265326AbUEUBSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 21:18:46 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:5564 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S265323AbUEUBSn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 21:18:43 -0400
Subject: Re: peculiar problem with 2.6, 8139too + ACPI
From: Len Brown <len.brown@intel.com>
To: Robert Fendt <fendt@physik.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20040521015314.7001a9e9.fendt@physik.uni-dortmund.de>
References: <A6974D8E5F98D511BB910002A50A6647615FB5FE@hdsmsx403.hd.intel.com>
	 <1084584998.12352.306.camel@dhcppc4>
	 <20040517123011.7e12d297.fendt@physik.uni-dortmund.de>
	 <1084818282.12349.334.camel@dhcppc4>
	 <20040521015314.7001a9e9.fendt@physik.uni-dortmund.de>
Content-Type: text/plain
Organization: 
Message-Id: <1085102192.12349.508.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 20 May 2004 21:16:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-20 at 19:53, Robert Fendt wrote:
> On 17 May 2004 14:24:42 -0400

> differing network topologies.

probably not important, just shows that this is timing dependent.
System must be quiet enough that it gets into idle.

> > Does
> > cat /proc/acpi/processor/CPU0/power
> > show any C3 usage?
> 
> Yes, if I read this correctly, it does. BTW, seemingly pretty much the same on AC or battery.
> 
> betazed:~# cat /proc/acpi/processor/CPU1/power
> active state:            C2
> default state:           C1
> bus master activity:     ffffffff
> states:
>     C1:                  promotion[C2] demotion[--] latency[000] usage[00000010]
>    *C2:                  promotion[C3] demotion[C1] latency[001] usage[00025200]
>     C3:                  promotion[--] demotion[C2] latency[101] usage[00024564]
> 

Please verify that the problem goes away when you exclude the
acpi/processor module (CONFIG_ACPI_PROCESSOR) from the system.

With the recent spate of C3 issues, we should make an easier way to
disable C3 until it is fixed...

thanks,
-Len


