Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWDCAsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWDCAsS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 20:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWDCAsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 20:48:17 -0400
Received: from zydeco.triplehelix.org ([64.20.44.103]:35528 "EHLO
	triplehelix.org") by vger.kernel.org with ESMTP id S932147AbWDCAsR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 20:48:17 -0400
Date: Sun, 2 Apr 2006 17:48:06 -0700
To: linux-kernel@vger.kernel.org
Cc: linux-usb-devel@lists.sourceforge.net
Subject: Problems with USB setup with Linux 2.6.16
Message-ID: <20060403004806.GA25553@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've got some problems getting my USB stuff to work in 2.6.16.

I see normal USB initialization as the machine comes up, then suddenly:

ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:10.4: irq 17, io mem 0xf9e00000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
usb 2-1: USB disconnect, address 2
hub 5-0:1.0: 8 ports detected
usb 2-2: USB disconnect, address 3
usb 3-1: USB disconnect, address 2
Initializing USB Mass Storage driver...
GSI 21 sharing vector 0xD1 and IRQ 21
usb 1-1: USB disconnect, address 2
drivers/usb/class/usblp.c: usblp0: removed

Everything that just got probed gets 'disconnected', udev's startup
script times out, and cupsd will hang forever looking for my printer.

Interestingly, it worked perfectly one time, and I saw a 'EHCI BIOS handoff
failed' message way at the top of dmesg.

What's going on? I assume this is EHCI's fault. I'm on a VIA K8T800 chipset,
Asus A8V Deluxe motherboard.

Please CC me on replies as I'm not subscribed to either list.

Thanks!

-- 
Joshua Kwan
