Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267122AbTAKCq2>; Fri, 10 Jan 2003 21:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267124AbTAKCq2>; Fri, 10 Jan 2003 21:46:28 -0500
Received: from eastgate.starhub.net.sg ([203.116.1.189]:35600 "EHLO
	eastgate.starhub.net.sg") by vger.kernel.org with ESMTP
	id <S267122AbTAKCq0>; Fri, 10 Jan 2003 21:46:26 -0500
Date: Sat, 11 Jan 2003 10:45:55 +0800
From: Richard Chan <rspchan@starhub.net.sg>
Subject: 2.5.56 CardBus not accepting USB 2.0 adapter
To: linux-kernel@vger.kernel.org
Message-id: <3E1F8563.4070004@starhub.net.sg>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021218
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.5.56 CardBus is not accepting a USB 2.0 adapter due to
the infamous PCI resource collision problem.  This was
also seen in 2.5.54, 2.5.55. The card works under 2.4.18.

lspci has
02:03.0 CardBus bridge: Texas Instruments PCI1420
02:03.1 CardBus bridge: Texas Instruments PCI1420

dmesg shows:
cs: cb_alloc(bus 3): vendor 0x1033, device 0x0035
PCI: Device 03:00.0 not available because of resource collisions
PCI: Device 03:00.1 not available because of resource collisions
PCI: Device 03:00.2 not available because of resource collisions

Other people on this list seem to have problems with network cards.
I reported this on the usb devel list but apparently it is CardBus
b0rkeness rather than a usb problem.

Any ideas?

Richard Chan




