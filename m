Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263284AbUDEV54 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbUDEVyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:54:54 -0400
Received: from prosun.first.gmd.de ([194.95.168.2]:4226 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S263483AbUDEVxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:53:12 -0400
Subject: Re: regression: oops with usb bcm203x bluetooth dongle 2.6.5
From: Soeren Sonnenburg <kernel@nn7.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1081201227.2843.27.camel@pegasus>
References: <1081196482.3591.5.camel@localhost>
	 <1081199370.2843.20.camel@pegasus>  <1081200442.3591.38.camel@localhost>
	 <1081201227.2843.27.camel@pegasus>
Content-Type: text/plain
Message-Id: <1081201957.3590.49.camel@localhost>
Mime-Version: 1.0
Date: Mon, 05 Apr 2004 23:52:38 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-05 at 23:40, Marcel Holtmann wrote:
> Hi Soeren,
> 
> > Bluetooth: Broadcom Blutonium firmware driver ver 1.0
> > bcm203x_probe: Mini driver request failed
> > bcm203x: probe of 1-1:1.0 failed with error -5
> > usb 1-1: bulk timeout on ep1in
> > usbfs: USBDEVFS_BULK failed dev 3 ep 0x81 len 10 ret -110
> 
> these are two different errors. The first is from bcm203x while the
> request of the firmware file through request_firmware() fails and the
> second is form the bluefw program. Maybe hotplug get's into to trouble
> and tries to load the bcm203x and bluefw at the same time while it also
> has to handle requesting of the firmware file with firmware.agent. Does
> it work for you if you uninstall bluefw.

That is why I removed all the bluefw stuff in /etc/hotplug before
testing bluetooth again... but it still oopsed.

Soeren

