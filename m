Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276341AbRJHPNF>; Mon, 8 Oct 2001 11:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276336AbRJHPMy>; Mon, 8 Oct 2001 11:12:54 -0400
Received: from [216.191.240.114] ([216.191.240.114]:34181 "EHLO
	shell.cyberus.ca") by vger.kernel.org with ESMTP id <S276341AbRJHPMq>;
	Mon, 8 Oct 2001 11:12:46 -0400
Date: Mon, 8 Oct 2001 11:09:57 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Andrea Arcangeli <andrea@suse.de>,
        Ingo Molnar <mingo@elte.hu>,
        Linux-Kernel <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <E15qc5N-0000p5-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.30.0110081106500.5473-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Oct 2001, Alan Cox wrote:

> NAPI is important - the irq disable tactic is a last resort. If the right
> hardware is irq flood aware it should only ever trigger to save us from
> irq routing errors (eg cardbus hangs)

Agreed. As long as the IRQ flood protector can do proper isolation.
Here's hat i see on my dell latitude laptop with a built in ethernet (not
cardbus related ;->)

-------------------------------
[root@jzny /root]# cat /proc/interrupts
           CPU0
  0:   29408219          XT-PIC  timer
  1:     332192          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
 10:     643040          XT-PIC  Texas Instruments PCI1410 PC card Cardbus
Controller, eth0
 11:         17          XT-PIC  usb-uhci
 12:    2207062          XT-PIC  PS/2 Mouse
 14:     307504          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0
MIS:          0
-----------------------------

cheers,
jamal

