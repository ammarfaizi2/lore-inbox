Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315210AbSGMRP5>; Sat, 13 Jul 2002 13:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSGMRP4>; Sat, 13 Jul 2002 13:15:56 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:54512 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315210AbSGMRPz>; Sat, 13 Jul 2002 13:15:55 -0400
Subject: Re: Linux 2.4.19-rc1-ac3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Osterlund <petero2@telia.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <m2n0svr42e.fsf@best.localdomain>
References: <Pine.LNX.4.44.0207131435570.3808-100000@linux-box.realnet.co.sz> 
	<m2n0svr42e.fsf@best.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jul 2002 19:27:41 +0100
Message-Id: <1026584861.13886.27.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 17:22, Peter Osterlund wrote:
> Not really, unfortunately. The CPU certainly runs slower, but the
> difference in power consumption between the fastest and slowest speeds
> seems to be quite small. The kernel was configured to use APM idle
> calls, but no ACPI stuff. I measured the time it took for the battery
> to go from 100% to 90% while reading the lkml mailing list with gnus,
> so the machine was mostly idle during the test.
> 
> How much power savings can be expected in this situation? Is SpeedStep
> likely to give more power savings?

Disregarding the fact that a large amount of your power consumption is
	LCD backlight
	Memory
	Disk spinning

the CPU (and to an extent thus the fan) part of the power consumption
reduces approximately linearly with the clock speed drop and also the
square of the voltage drop. There is an ever growing static component
with newer chips but even so its quite measurable done right.

Now we have the cpu speed code we can look at implementing something
like idleness is not sloth properly, and trying to keep the CPU in low
speed modes whenever possible.

