Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTKUVYO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 16:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbTKUVYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 16:24:14 -0500
Received: from web41315.mail.yahoo.com ([66.218.93.64]:54409 "HELO
	web41315.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263172AbTKUVYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 16:24:13 -0500
Message-ID: <20031121212412.13302.qmail@web41315.mail.yahoo.com>
Date: Fri, 21 Nov 2003 13:24:12 -0800 (PST)
From: Jing Xu <xujing_cn2001@yahoo.com>
Subject: cannot mask irqs by pci=irqmask=
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I'm having some trouble with PCI IRQ's and I was
hoping someone here could help. 

I'm running linux 2.4.20 and rtai 24.1.11. My linux
kernel module needs to use IRQ 9 10 11 for AGP graphic
card, sound card and PCI-Dio24 IO card. These irqs are
also shared by USB controllers. My module hangs when
it tries to request the above irqs used by USB
devices. I figured it would be a good idea to remove
this apparent conflict. I have scoured the web and
found that I can reserve these IRQs by specifying
pci=irqmask=0x0e10 on the kernel boot line.

I have tried to set "pci=irqmask=0x0e10" to reserve
Irq 9 10 11 4 from my driver, and it hasn't had any
effect - those irqs are still used by usb controllers
on initialization. 

How do I change these IRQ's?  Is there some other
configuration file I haven't found? If anyone can
provide any insight into this, I would appreciate it
greatly. Let me know what/if any details you need - I
am by no means an expert in this area and didn't want
to post reams of irrelevant information, but if there
is something I'm missing let me know and I'll get
it...

Thanks in advance,

jing 

__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
