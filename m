Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbREaPA6>; Thu, 31 May 2001 11:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263106AbREaPAi>; Thu, 31 May 2001 11:00:38 -0400
Received: from zeus.kernel.org ([209.10.41.242]:26792 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263105AbREaPA1>;
	Thu, 31 May 2001 11:00:27 -0400
Date: Wed, 30 May 2001 22:07:39 -0400 (EDT)
From: Feng Xian <fxian@fxian.jukie.net>
X-X-Sender: <fxian@tiger>
To: <linux-kernel@vger.kernel.org>
cc: Feng Xian <fxian@chrysalis-its.com>
Subject: APIC problem or 3com 3c590 driver problem in smp kernel 2.4.x
Message-ID: <Pine.LNX.4.33.0105302155180.31379-100000@tiger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

I have one pci device in my dell optiplex gx300 dual pIII box. when this
device in a certain pci slot, it shares the same IRQ with the on mother
board 3com NIC(3c905) (irq=5). when I run the kernel smp-2.4.x, my PCI
device can not receive any interrupt while the /proc/interrupts shows that
3c905 receives over million of interrupts and number grows very fast. then
I moved my pci device to another pci slot, now, 3c905's irq=5, my device's
irq=0xb, my device behaves normal, the interrupt number for 3c905 also
looks normal. 	I also tried to use a uni-processor kernel without APIC
support enabled, my pci device shares irq with 3c905, but works fine.

It looks more like APIC support problem. but it also may be 3c905
driver's ISR's problem. Anyone who owns the code has any idea about this?

Thanks in advance.

Alex


-- 
        Feng Xian
   _o)     .~.      (o_
   /\\     /V\      //\
  _\_V    // \\     V_/_
         /(   )\
          ^^-^^
           ALEX

