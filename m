Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbUEWANE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUEWANE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 20:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUEWANE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 20:13:04 -0400
Received: from adsl-208-201-231-6.sonic.net ([208.201.231.6]:18948 "EHLO
	mail.carmelfly.net") by vger.kernel.org with ESMTP id S261991AbUEWANB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 20:13:01 -0400
Subject: USB/EHCI boot freeze on 2.6.6-mm5 (and 2.6.6-mm4)
From: Mike Javorski <mikej@carmelfly.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1085271177.13466.13.camel@simsoft.carmelfly.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 22 May 2004 17:12:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me as I am not subscribed to the lkml]

Been running into a wall with this issue on my machine:
- Amd AthlonXP-2800
- Asus A7N8X-E Deluxe (nForce2 Chipset)
- 512MB RAM
- single PATA HD


This motherboard supports USB 2.0 and up until 2.6.6-rc3(+patches) I was
not running into any problems with it. Now with everything after 2.6.6,
my systems locks on boot-up after the following 3 lines:

<snip>
...
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
ehci_hcd 0000:00:02.2: irq 11, pci mem e0885000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
<snip>

If I disable USB 2 (in bios) but leave USB 1.1 active, the system boots
completely (I am typing this from 2.6.6-mm5 + patches). I am guessing it
has something to do with the amount of changes that were included in
Linus' patches that are included with mm4 and mm5 as there seems to be
some ehci related stuff in there, and noted in the changelog. None of my
other patches touch the USB stuff at all.

Anyone have any words of advise. I would love to help, but I don't think
I am quite ready to enter the realm of kernel debugging. I can add other
peoples patches, but actually trying to diagnose crashes is pushing it
for me.

- mike

