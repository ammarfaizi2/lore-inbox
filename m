Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbUCWRQw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 12:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbUCWRQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 12:16:52 -0500
Received: from hoemail1.lucent.com ([192.11.226.161]:5810 "EHLO
	hoemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S262719AbUCWRQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 12:16:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16480.28882.388997.71072@gargle.gargle.HOWL>
Date: Tue, 23 Mar 2004 12:16:02 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: arch/i386/Kconfig: CONFIG_IRQBALANCE Description
In-Reply-To: <1079996577.6595.19.camel@bach>
References: <1079996577.6595.19.camel@bach>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And hey, under 2.6.5-rc2-mm1, it doens't seem to do anything:

  > cat /proc/version 
  Linux version 2.6.5-rc2-mm1 (john@jfsnew) (gcc version 3.3.3 (Debian 20040314)) #3 SMP Sun Mar 21 15:26:27 EST 2004

  > zcat /proc/config.gz | grep IRQ
  CONFIG_IRQBALANCE=y
  CONFIG_IDEPCI_SHARE_IRQ=y

  > cat /proc/interrupts 
	     CPU0       CPU1       
    0:   46272316        487    IO-APIC-edge  timer
    1:        376          0    IO-APIC-edge  i8042
    2:          0          0          XT-PIC  cascade
    4:       4147          1    IO-APIC-edge  serial
    7:          2          0    IO-APIC-edge  parport0
    8:          4          0    IO-APIC-edge  rtc
   11:      95936          1    IO-APIC-edge  Cyclom-Y
   12:        677          0    IO-APIC-edge  i8042
   14:         87          0    IO-APIC-edge  ide0
   16:      46770          3   IO-APIC-level  ide2, ide3, ehci_hcd
   17:     307832          1   IO-APIC-level  eth0
   18:     118258          1   IO-APIC-level  aic7xxx, aic7xxx, ohci_hcd
   19:          0          0   IO-APIC-level  ohci_hcd
  NMI:          0          0 
  LOC:   46279245   46279281 
  ERR:          0
  MIS:        417


John
