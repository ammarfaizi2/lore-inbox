Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131653AbRCOHYm>; Thu, 15 Mar 2001 02:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131654AbRCOHYd>; Thu, 15 Mar 2001 02:24:33 -0500
Received: from list.framfab.se ([195.54.96.202]:42249 "EHLO list.framfab.se")
	by vger.kernel.org with ESMTP id <S131653AbRCOHYX> convert rfc822-to-8bit;
	Thu, 15 Mar 2001 02:24:23 -0500
Message-ID: <E6D22E487D45D411931B00508BCF93E75C0326@storeg001.framfab.se>
From: Mårten Wikström <Marten.Wikstrom@framfab.se>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: How to optimize routing performance
Date: Thu, 15 Mar 2001 08:23:37 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've performed a test on the routing capacity of a Linux 2.4.2 box versus a
FreeBSD 4.2 box. I used two Pentium Pro 200Mhz computers with 64Mb memory,
and two DEC 100Mbit ethernet cards. I used a Smartbits test-tool to measure
the packet throughput and the packet size was set to 64 bytes. Linux dropped
no packets up to about 27000 packets/s, but then it started to drop packets
at higher rates. Worse yet, the output rate actually decreased, so at the
input rate of 40000 packets/s almost no packets got through. The behaviour
of FreeBSD was different, it showed a steadily increased output rate up to
about 70000 packets/s before the output rate decreased. (Then the output
rate was apprx. 40000 packets/s).
I have not made any special optimizations, aside from not having any
background processes running.

So, my question is: are these figures true, or is it possible to optimize
the kernel somehow? The only changes I have made to the kernel config was to
disable advanced routing.

Thanks,

Mårten

