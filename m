Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbTKXVPH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 16:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbTKXVPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 16:15:07 -0500
Received: from web41307.mail.yahoo.com ([66.218.93.56]:47958 "HELO
	web41307.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261774AbTKXVPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 16:15:02 -0500
Message-ID: <20031124211500.20861.qmail@web41307.mail.yahoo.com>
Date: Mon, 24 Nov 2003 13:15:00 -0800 (PST)
From: Jing Xu <xujing_cn2001@yahoo.com>
Subject: pci=irqmask= doesn't work
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I'm having some trouble to mask PCI IRQs with
pci=irqmask= and I was hoping someone here could help.


I'm running linux 2.4.20 and rtai 24.1.11. My linux
kernel module needs to use IRQ 9 10 11 for AGP graphic
card, sound card and PCI-Dio24 IO card. These irqs are
also shared by USB controllers. My module hangs when
it tries to request the above irqs used by USB
devices. I figured it would be a good idea to remove
this apparent conflict. I have scoured the web and
found that I can reserve these IRQs by specifying
pci=irqmask= on the kernel boot line.

I have tried to set "pci=irqmask=0x0e10" to reserve
Irq 9 10 11 4 from my driver, and it hasn't had any
effect - those irqs are still used by usb controllers
on initialization. 

Why did this not work? How do I change these IRQ's? 
Is there some other configuration file I haven't
found? If anyone can provide any insight into this, I
would appreciate it greatly. If there is something I'm
missing let me know and I'll get it...

Thanks in advance,

jing 



__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
