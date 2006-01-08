Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161124AbWAHBXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbWAHBXr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 20:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161125AbWAHBXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 20:23:47 -0500
Received: from bay103-f39.bay103.hotmail.com ([65.54.174.49]:36879 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1161124AbWAHBXr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 20:23:47 -0500
Message-ID: <BAY103-F39233F9F5FF4FEFA175808DF230@phx.gbl>
X-Originating-IP: [70.131.120.122]
X-Originating-Email: [dravet@hotmail.com]
In-Reply-To: <20060107210544.GM9402@redhat.com>
From: "Jason Dravet" <dravet@hotmail.com>
To: davej@redhat.com, linux-kernel@vger.kernel.org, xavier.bestel@free.fr
Subject: Re: wrong number of serial port detected
Date: Sat, 07 Jan 2006 19:23:46 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 08 Jan 2006 01:23:46.0563 (UTC) FILETIME=[2BDE2530:01C613F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Make the number of UARTs registered configurable.
>Also add a nr_uarts module option to the 8250 code
>to override this, up to a maximum of CONFIG_SERIAL_8250_NR_UARTS
>
>This should appease people who complain about a proliferation
>of /dev/ttyS & /sysfs nodes whilst at the same time allowing
>a single kernel image to support the rarer occasions of
>lots of devices.
>
Not to keep complaining, but I now have the following issue.  I running 
Fedora Cores  2.6.15-1.1826 kernel.  When I run dmesg I now see this:

Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

before 2.6.15 I saw
Serial: 8250/16550 driver $Revision: 1.90 $ 32 ports, IRQ sharing enabled

The serial driver now correctly reports that I have two serial ports instead 
of 32.  So shouldn't the patch register the minimum of 
CONFIG_SERIAL_8250_NR_UARTS and the number of serial ports detected by the 
serial driver?

Thanks,
Jason Dravet


