Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264247AbUEDGcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264247AbUEDGcr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 02:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264248AbUEDGcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 02:32:47 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:38121 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S264247AbUEDGcq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 02:32:46 -0400
From: Duncan Sands <baldrick@free.fr>
To: Joerg Pommnitz <pommnitz@yahoo.com>, linux-usb-users@lists.sourceforge.net
Subject: Re: Software based unplug of USB device?
Date: Mon, 3 May 2004 13:07:30 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20040503102120.23966.qmail@web41314.mail.yahoo.com>
In-Reply-To: <20040503102120.23966.qmail@web41314.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405031307.30527.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 May 2004 12:21, Joerg Pommnitz wrote:
> Hello listees,
> we are struggling with a 3rd party USB device. It comes with its own
> firmware and its own Linux USB serial drivers. Unfortunately the
> communication between the device and the user application seems to break
> down from time to time. This situation can easily be resolved by
> unplugging and then re-plugging the device. Unfortunately this requires
> manual intervention.
> While resolving the real issue would be the preferred way to deal with
> this problem, we would settle for a way to do a software unplug/re-plug.
> Can this be done at all? If so, is there a tool to do this?
>
> A detailed description of our environment:
> * Linux 2.4.21 with USB OHCI driver
> * Natsemi Geode integrated CPU/Chipset

This can be done in a number of ways:
(1) unload and reload the module driving the usb device.  This should disconnect
it from the device and reconnect it when reloaded.
(2) restart the hotplug system (this will disconnect and reconnect all devices).
(3) use usbfs: there is an ioctl to disconnect a kernel driver from a device,
and another to reconnect it.

I hope this helps,

Duncan.
