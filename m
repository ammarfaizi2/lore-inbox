Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263758AbTJCPZO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 11:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbTJCPZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 11:25:14 -0400
Received: from kogut.o2.pl ([212.126.20.61]:61865 "EHLO kogut.o2.pl")
	by vger.kernel.org with ESMTP id S263758AbTJCPZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 11:25:09 -0400
From: Mariusz Kozlowski <madx@tlen.pl>
To: linux-kernel@vger.kernel.org
Subject: problem with USB on Sony Vaio laptop
Date: Fri, 3 Oct 2003 17:25:23 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310031725.23040.madx@tlen.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I've been using linux succesfully for quite long time. Recently I decided to 
move to 2.6.x kernel series and all is fine but USB support. The problem 
looks like this: 

- Without USB support linux boots fine.

- With USB support linux stops booting at some time and computer is just 
frozen. Keyboard doesn't work. The only thing I can observe is that just 
during loading USB modules hard disk starts working louder until the manual 
power_off which is necessary because machine is dead at that time.

All was fine with 2.4.x series. The problems started when I moved to 2.6.x. I 
tried all 2.6.x versions released until now. None of them works fine with my 
machine with USB support enabled.

here is a little output from console during booting sequence:


drivers/usb/core/usb.c: registered new driver hub
ehci_hcd 0000:00:0c.2: EHCI Host Controller
ehci_hcd 0000:00:0c.2: irq 11, pci mem df9e7800
ehci_hcd 0000:00:0c.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0c.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver 
v2.1
uhci-hcd 0000:00:0c.0: UHCI Host Controller

That's the last thing i can see. After this computer is dead. 

some more details:
- Sony Vaio PCG-FR285M laptop
- linux 2.6.0-test6-bk4
- no devices connected to USB ports during booting sequence
- gcc 3.2.2
- module-init-tools-0.9.15-pre2

Any suggestions on this? If you need some more information please feel free to 
ask me.

Best Regards,

	Mariusz Kozlowski

