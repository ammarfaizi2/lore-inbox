Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVGCNDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVGCNDB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 09:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVGCNDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 09:03:01 -0400
Received: from [62.253.222.6] ([62.253.222.6]:21713 "EHLO caveman.xisl.com")
	by vger.kernel.org with ESMTP id S261425AbVGCNC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 09:02:29 -0400
Subject: Problems with USB Scanner in 2.6.11.12 kernel
From: John M Collins <jmc@xisl.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Xi Software Ltd
Date: Sun, 03 Jul 2005 14:02:21 +0100
Message-Id: <1120395741.11280.101.camel@caveman.xisl.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC to me at jmc AT xisl.com as I'm not subscribed - thanks

I recently (well about 3 weeks ago) upgraded the kernel on one of our
machines to 2.6.11.12 at the time the "latest and greatest".

However since then I've been having problems with a USB Scanner I'm
using. It seems to die after a couple of pages have been scanned with
the following message sequence in /var/log/messages:

Jul  3 13:19:22 caveman kernel: usb 3-1: device descriptor read/64,
error -19
Jul  3 13:19:22 caveman kernel: usb 3-1: USB disconnect, address 3

(note the messages either side of this happened without me doing
anything and the entry disappeared from /proc/bus/usb/003/003 and
appeared in /proc/bus/usb/003/004).

Jul  3 13:19:22 caveman kernel: usb 3-1: new full speed USB device using
uhci_hc
d and address 4
Jul  3 13:21:35 caveman kernel: usb 3-1: reset full speed USB device
using uhci_
hcd and address 4
Jul  3 13:22:39 caveman kernel: usb 3-1: reset full speed USB device
using uhci_
hcd and address 4
Jul  3 13:23:43 caveman kernel: usb 3-1: reset full speed USB device
using uhci_
hcd and address 4
Jul  3 13:24:53 caveman last message repeated 2 times
Jul  3 13:25:23 caveman kernel: usb 3-1: reset full speed USB device
using uhci_
hcd and address 4
Jul  3 13:25:41 caveman kernel: hub 3-0:1.0: port 1 disabled by hub
(EMI?), re-e
nabling...
Jul  3 13:25:41 caveman kernel: usb 3-1: reset full speed USB device
using uhci_
hcd and address 4
Jul  3 13:25:41 caveman kernel: usb 3-1: device descriptor read/64,
error -19
Jul  3 13:25:41 caveman kernel: usb 3-1: device descriptor read/64,
error -19
Jul  3 13:25:41 caveman kernel: usb 3-1: reset full speed USB device
using uhci_
hcd and address 4
Jul  3 13:25:42 caveman kernel: usb 3-1: device descriptor read/64,
error -19
Jul  3 13:25:42 caveman kernel: usb 3-1: device descriptor read/64,
error -19
Jul  3 13:25:42 caveman kernel: usb 3-1: USB disconnect, address 4

After which it doesn't appear anywhere in /proc/bus/usb

I've tried swapping usb ports - there are several on the machine.
I've tried swapping scanners (they're both Epson ones, different
models).

It seems OK with previous versions of the kernel on other machines.

I see we're now on 2.6.12.2 and there have been mods to bits of the USB
but I don't see anything directly related but I might have missed
something.

I'd be grateful for any advice you could give - thanks.

-- 
John Collins Xi Software Ltd jmc AT xisl.com

