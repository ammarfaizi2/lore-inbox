Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268860AbUHUGH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268860AbUHUGH2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 02:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268861AbUHUGH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 02:07:28 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:29355 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S268860AbUHUGH0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 02:07:26 -0400
Subject: Re: HCI USB on USB 2.0: hci_usb_intr_rx_submit (works with USB 1.1)
From: Marcel Holtmann <marcel@holtmann.org>
To: "Raf D'Halleweyn" <list@noduck.net>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1093014039.28268.10.camel@base>
References: <1091581193.15561.3.camel@alto.dhalleweyn.com>
	 <1092049263.21815.18.camel@pegasus>
	 <1092966777.5230.4.camel@alto.dhalleweyn.com>
	 <1092990717.18082.60.camel@pegasus>  <1093014039.28268.10.camel@base>
Content-Type: text/plain
Message-Id: <1093068439.3544.2.camel@notepaq>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 21 Aug 2004 08:07:19 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

> Okay, I had bluez-bluefw installed (Debian package) but it seems that
> bluez now uses the standard firmware loading mechanism (request_firmware
> ()). As such, I copied the BCM2033-FW.bin and BCM2033-MD.hex files from
> that package into /usr/lib/hotplug/firmware and removed bluez-bluefw.
> 
> However, I cannot find any evidence of the firmware actually being
> loaded. I believe that my hotplug install is correctly installed (it can
> load the ipw2100 firmware). I added some debugging
> to /etc/hotplug/firmware.agent, but couldn't find any evidence of any
> firmware being requested for the dongle.
> 
> Any suggestions what I could try next? Should I add USB_DEVICE(0x0a12,
> 0x0001) to the usb_device_id array in bcm203x.c?

this is getting weird, because 0a12:0001 is a CSR based dongle and not a
Broadcom one. So firmware loading is not needed. It should simply work.
Give 2.6.8 a try.

Regards

Marcel


