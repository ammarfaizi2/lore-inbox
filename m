Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbUDEW0x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 18:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbUDEVl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:41:57 -0400
Received: from linux-bt.org ([217.160.111.169]:49074 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S263315AbUDEVkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:40:16 -0400
Subject: Re: regression: oops with usb bcm203x bluetooth dongle 2.6.5
From: Marcel Holtmann <marcel@holtmann.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1081200442.3591.38.camel@localhost>
References: <1081196482.3591.5.camel@localhost>
	 <1081199370.2843.20.camel@pegasus>  <1081200442.3591.38.camel@localhost>
Content-Type: text/plain
Message-Id: <1081201227.2843.27.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 05 Apr 2004 23:40:27 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Soeren,

> Bluetooth: Broadcom Blutonium firmware driver ver 1.0
> bcm203x_probe: Mini driver request failed
> bcm203x: probe of 1-1:1.0 failed with error -5
> usb 1-1: bulk timeout on ep1in
> usbfs: USBDEVFS_BULK failed dev 3 ep 0x81 len 10 ret -110

these are two different errors. The first is from bcm203x while the
request of the firmware file through request_firmware() fails and the
second is form the bluefw program. Maybe hotplug get's into to trouble
and tries to load the bcm203x and bluefw at the same time while it also
has to handle requesting of the firmware file with firmware.agent. Does
it work for you if you uninstall bluefw.

Regards

Marcel


