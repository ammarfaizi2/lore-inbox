Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVCSScg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVCSScg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 13:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVCSScc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 13:32:32 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:50563 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261618AbVCSSc3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 13:32:29 -0500
Subject: Re: bcm203x broadcom dongle firmware upload fails...
From: Marcel Holtmann <marcel@holtmann.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1111244625.6115.6.camel@localhost>
References: <1111244625.6115.6.camel@localhost>
Content-Type: text/plain
Date: Sat, 19 Mar 2005 19:32:24 +0100
Message-Id: <1111257144.9930.5.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Soeren,

> I don't see why, it used to work reliably at some point but now it does
> not. It even won't work without hotplug and then manually typing:
> 
> echo 1 > /sys/class/firmware/2-1/loading
> cat /lib/firmware/BCM2033-FW.bin >/sys/class/firmware/2-1/data
> echo 0 > /sys/class/firmware/2-1/loading
> 
> usb 2-1: new full speed USB device using ohci_hcd and address 2
> Bluetooth: Broadcom Blutonium firmware driver ver 1.0
> bcm203x_probe: Mini driver request failed
> bcm203x: probe of 2-1:1.0 failed with error -5
> usbcore: registered new driver bcm203x
> 
> It does not work with kernel 2.6.10/11 any ideas ?

I think this is a general request_firmware() problem. Check the Hotplug
mailing list archive. Hannes, Kay and Greg discussed problems with the
firmware_class and udev. I haven't found the time to look at it.

Regards

Marcel


