Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311121AbSDMXc7>; Sat, 13 Apr 2002 19:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311147AbSDMXc6>; Sat, 13 Apr 2002 19:32:58 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:20580 "EHLO
	server0011.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S311121AbSDMXc5>; Sat, 13 Apr 2002 19:32:57 -0400
Date: Sun, 14 Apr 2002 00:40:22 +0100
From: Ian Molton <spyro@armlinux.org>
To: linux-kernel@vger.kernel.org
Subject: usb-uhci *BUG*
Message-Id: <20020414004022.6450f038.spyro@armlinux.org>
Reply-To: spyro@armlinux.org
Organization: The dragon roost
X-Mailer: Sylpheed version 0.7.4cvs5 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm not familiar with the USB code, but I've been hitting a BUG() with my
new OHCI card (sorry, it was cheap :(   )

the BUG() is at line 464 in usb-ohci.h, which seems to be a linked-list
traversal failing to find an entry.

the backtrace /does/ seem to be the same every time. I dont have ksymoops
(on ARM I decode oopses with grep and system.map :). This appears not to
work so well for X86, but here goes...

c583708b  - n/a
c01098fc  - follows handle_IRQ_event
c0109a62  - preceeds request_irq
c0106c10  - default_idle
c0106c10  - default_idle
c0106c33  - follows default_idle
c0106c97  - follows cpu_idle
c0105000  - _stext
c0105027  - follows rest_init
