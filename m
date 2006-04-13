Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWDMGmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWDMGmn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 02:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWDMGmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 02:42:43 -0400
Received: from fmmailgate04.web.de ([217.72.192.242]:1240 "EHLO
	fmmailgate04.web.de") by vger.kernel.org with ESMTP id S932437AbWDMGmn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 02:42:43 -0400
Date: Thu, 13 Apr 2006 08:42:41 +0200
Message-Id: <615249858@web.de>
MIME-Version: 1.0
From: =?iso-8859-15?Q?Burkhard_Sch=F6lpen?= <bschoelpen@web.de>
To: linux-kernel@vger.kernel.org
Subject: Reduce IRQ latency or revise hardware?
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a question concerning IRQ latency. In this context I mean the time from an irq being triggered by some hardware until the interrupt service routine of my driver is called, so particularly I'm not concerned about some scheduling latency. I'm dealing with some custom hardware which has got hard realtime requirements (for now). Because the standard linux kernel cannot satisfy this requirement I wonder in which direction I should go ahead:

1. Is it somehow possible to fulfill the realtime requirements of the hardware by e.g. a realtime kernel patch or some kernel configuration fine tuning (at the moment I need a maximum hardware latency of about 100 microseconds)?
2. Or is it better to work on the hardware design (it's an FPGA on a PCI-board), so it can deal with higher latencies? Is the requirement of a maximum hardware IRQ latency to high in general?

Again I would like to underline that the main task is to get the interrupt handler invoked early enough, so I can get data out of a hardware FIFO. If this FIFO produces overflows, I get into big trouble, because the following data stream will be corrupted and the hardware must be reset. The programmer of the FPGA says that the buffer size is already at the maximum.

I use an ASUS P5LD2 motherboard with a Pentium-D dualcore-processor and Debian stable (kernel 2.6.15). I would be very grateful for some hints.

Kind regards
Burkhard Schölpen
_______________________________________________________________
SMS schreiben mit WEB.DE FreeMail - einfach, schnell und
kostenguenstig. Jetzt gleich testen! http://f.web.de/?mc=021192

