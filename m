Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132203AbRCVVY7>; Thu, 22 Mar 2001 16:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132201AbRCVVYu>; Thu, 22 Mar 2001 16:24:50 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50953 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132202AbRCVVYe>; Thu, 22 Mar 2001 16:24:34 -0500
Subject: Re: Incorrect mdelay() results on Power Managed Machines x86
To: twoller@crystal.cirrus.com (Woller, Thomas)
Date: Thu, 22 Mar 2001 21:26:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <973C11FE0E3ED41183B200508BC7774C0124F06D@csexchange.crystal.cirrus.com> from "Woller, Thomas" at Mar 22, 2001 02:29:48 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gCbN-0003Kn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Problem: Certain Laptops (IBM Thinkpads is where i see the issue) reduce the
> CPU frequency based upon whether the unit is on battery power or direct
> power.  When the Linux kernel boots up, then the cpu_khz (time.c) value is

This is commonly done using the speedstep feature on intel cpus. Speedstep
can generate events so the OS knows about it but Intel are not telling
people about how this works.

> Appreciate any responses or thoughts on the subject, 

Boot with the 'notsc' option is one approach. We certainly could recalibrate
the clock if we could get events out of ACPI, APM or some other source. Maybe
someone at IBM knows something on the thinkpad front here. If there is for
example an additional apm event or irq we can enable for the thinkpads to see
the speed change we can make it work

