Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268928AbUIQRnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268928AbUIQRnb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 13:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268937AbUIQRnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 13:43:31 -0400
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90]:17574 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id S268933AbUIQRnJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 13:43:09 -0400
Subject: Annoying DVD and IRQ problem.
From: Kenneth Johansson <ken@kenjo.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1095442870.4157.18.camel@tiger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 17 Sep 2004 19:41:10 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem using the DVD drive under kernel 2.6 in all the
versions I tested(up to 2.6.8.1). Since I do not use the dvd that often
it has not been a big problem but now I stating to get tired of it. 

First is there any valid way for the interrupt rate to drop below 1000 ?
This is a sample from vmstat during a copy from the dvd drive.
----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  3      0   3812  21876 591388    0    0  2340 15260  455   230 25 75  0  0
 2  3      0   4700  21844 590828    0    0  1288     0  422   133 17 83  0  0
 2  4      0   4024  21828 592028    0    0  1288   136  233   121 11 89  0  0
 2  1      0   3856  21852 592272    0    0  2712   116  412   232 21 71  0  7
 2  2      0   3820  21876 592236    0    0  2736     0  330   214 17 83  0  0
 3  3      0   3840  20376 592924    0    0  2468     0  495   332 53 47  0  0
 3  3      0   4092  20396 592092    0    0  2612     0  794   257 29 71  0  0
----

During use the mouse pointer sometimes get just crazy for a few seconds
it seams like X is getting fake mouse and keyboard events. resulting in
all sort of fun things ranging from the mouse pointer just moving around
to quiting some program.

The only unusual thing is that I do not have any device on hda and hdb
and a dvd writer on hdc and a dvd rom on hdd. Could this confuse the IDE
driver? 

0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)

cat /proc/interrupts
           CPU0
  0:    7232433    IO-APIC-edge  timer
  1:      11872    IO-APIC-edge  i8042
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:     150886    IO-APIC-edge  i8042
 15:     169584    IO-APIC-edge  ide1
 16:    7325765   IO-APIC-level  eth0, nvidia
 17:     205210   IO-APIC-level  libata
 18:      75514   IO-APIC-level  EMU10K1
 19:       5970   IO-APIC-level  bttv0
 21:         78   IO-APIC-level  uhci_hcd, uhci_hcd
NMI:          0
LOC:    7242394
ERR:          0
MIS:          4


