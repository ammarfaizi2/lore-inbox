Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267605AbUGWKju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267605AbUGWKju (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 06:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267615AbUGWKjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 06:39:49 -0400
Received: from math.ut.ee ([193.40.5.125]:46576 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S267605AbUGWKjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 06:39:48 -0400
Date: Fri, 23 Jul 2004 13:39:46 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: serial8250: too much work for irq4
Message-ID: <Pine.GSO.4.44.0407231336130.18996-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Often when I use my PC (Celeron 900 with i815 chipset) as a serial
console for pther computers (mostly Suns), I get dmesg full of lines

serial8250: too much work for irq4

This might or might not be the cause of garbled output from the Sun -
many characters are dropped.

I turned off PREEMPT and 4KSTACKS and recompiled, this doesn't change
anything.

Load is normal desktop use, sometimes background compilations. IDE disk
is in DMA mode.

           CPU0
  0:   62787447          XT-PIC  timer
  1:       1474          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  7:        631          XT-PIC  parport0
  8:          4          XT-PIC  rtc
  9:          0          XT-PIC  acpi, Intel 82801BA-ICH2, tr1
 10:       5251          XT-PIC  uhci_hcd
 11:    5455136          XT-PIC  uhci_hcd, eth0, r128@PCI:3:0:0
 14:     382770          XT-PIC  ide0
 15:         68          XT-PIC  ide1
NMI:       4322
LOC:   62795747
ERR:         74
MIS:          0


-- 
Meelis Roos (mroos@linux.ee)

