Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262721AbTCTXo7>; Thu, 20 Mar 2003 18:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbTCTXnn>; Thu, 20 Mar 2003 18:43:43 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:8148 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id <S262695AbTCTXn3>;
	Thu, 20 Mar 2003 18:43:29 -0500
Date: Thu, 20 Mar 2003 23:54:21 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Poor performance with pcnet32 on SMP
Message-ID: <Pine.LNX.4.53.0303202346220.3340@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have being noticing some seriously poor network performance with SMP
enabled. The machine is a xSeries 350 with quad xeon procesors. Under UP,
I get decent transfer rates but with SMP enabled, it won't get over 2kB/s.
I tried binding interrupts to one processor with

echo 1 > /proc/irq/16/smp_affinity

which, according to mail archives fixed the problem for other people, but
the result is the same. A CVS checkout from a server on the local lan of a
source tree less than 1MB took over an hour to complete but under UP
completes in about 2 seconds. This occurs with both 2.4.20 and 2.5.64.

In case it is relevant, the dmesg output related to the card on 2.5.64 is

pcnet32.c:v1.27b 01.10.2002 tsbogend@alpha.franken.de
pcnet32: PCnet/FAST III 79C975 at 0x2200, 00 02 55 fc 6d 21 assigned IRQ 16.
eth0: registered as PCnet/FAST III 79C975
pcnet32: 1 cards_found.
eth0: link up, 10Mbps, half-duplex, lpa 0x0021
Module pcnet32 cannot be unloaded due to unsafe usage in include/linux/module.h:457

Any suggestions on how to fix this are appreciated

-- 
Mel Gorman
