Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264110AbTLAW2e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 17:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264112AbTLAW2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 17:28:34 -0500
Received: from web41301.mail.yahoo.com ([66.218.93.186]:38777 "HELO
	web41301.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264110AbTLAW2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 17:28:33 -0500
Message-ID: <20031201222832.9385.qmail@web41301.mail.yahoo.com>
Date: Mon, 1 Dec 2003 14:28:32 -0800 (PST)
From: Jing Xu <xujing_cn2001@yahoo.com>
Subject: how to reserve irqs at boot time
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 
 
I'm running linux 2.4.20 and rtai 24.1.11. My linux
kernel module needs to use IRQ 9 10 11 for AGP graphic
card, sound card and PCI-Dio24 IO card. These irqs are
also shared by USB controllers. My module hangs when
it tries to request the above irqs used by USB
devices. I figured it would be a good idea to remove
this apparent conflict. I have scoured the web and
found that I can reserve these IRQs by specifying
pci=irqmask= on the kernel boot line.

I have tried to set "pci=irqmask=0xf1e8" to reserve
Irq 9 10 11 4 from my driver, and it hasn't had any
effect - those irqs are still used by usb controllers
on initialization. 
 
How do I reserve these IRQ's?  Is there some other
configuration file I haven't found? 

Thanks in advance,

jing 


__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
