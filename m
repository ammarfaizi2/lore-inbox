Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVBSG3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVBSG3v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 01:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVBSG3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 01:29:50 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:57267 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261642AbVBSG3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 01:29:48 -0500
Subject: Should kirqd work on HT?
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1108794699.4098.28.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 19 Feb 2005 17:31:39 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I've noticed this problem for a while, but only now decided to ask.
Interrupt balancing doesn't do anything on my system.

           CPU0       CPU1
  0:   31931808          0    IO-APIC-edge  timer
  1:      76595          0    IO-APIC-edge  i8042
  8:          1          0    IO-APIC-edge  rtc
  9:          1          0   IO-APIC-level  acpi
 14:        122          1    IO-APIC-edge  ide0
 16:    4074456          0   IO-APIC-level  uhci_hcd, uhci_hcd, radeon@PCI:1:0:0
 17:    4295132          0   IO-APIC-level  Intel ICH5
 18:    2070933          0   IO-APIC-level  libata, uhci_hcd, eth0
 19:     887311          0   IO-APIC-level  uhci_hcd
 22:     572530          0   IO-APIC-level  ath0
NMI:   31931749   31931636 (I've since disabled the nmi_watchdog)
LOC:   31931252   31931251
ERR:          0
MIS:          0

I enabled the debugging and found that it doesn't think it's worth the
effort. Is that correct? Not a complaint, just curious!

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

