Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbULGE3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbULGE3c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 23:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbULGE3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 23:29:32 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:48523 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261742AbULGE33
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 23:29:29 -0500
From: David Brownell <david-b@pacbell.net>
To: florian_kr@gmx.de
Subject: Re: [<02282da7>] (usb_hcd_irq+0x0/0x4b) Disabling IRQ #5 - USB Devices
Date: Mon, 6 Dec 2004 20:27:33 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412062027.33561.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> My Questions:
> 
> How can I enable "USB Legacy Support" without errors?

As a rule, Linux will be happier without it.
Why do you want to enable it?


> How can I resolve the problem with the USB devices?

Have you tried adding "usb-handoff" to your
kernel command line?  That was added specifically
to help work around BIOS bugs like those you've
run into ...


> I've found via google some BIOS Bugs for "USB Legacy Support", but this
> bug occurs only on Windows XP (I don't found this for Linux). I tried
> allready to update my BIOS and now USB is disabled for all devices
> (Mouse, Printer, Scanner, USB-FlashMemory)

As a rule, if BIOS bugs affect XP I'd not be surprised
if to find them affecting Linux too.


> irq 12: nobody cared! (screaming interrupt?)
> irq 12: Please try booting with acpi=off and report a bug
> Stack pointer is garbage, not printing trace
> handlers:
> [<0223aede>] (i8042_interrupt+0x0/0x251)
> Disabling IRQ #12

That was interesting ... not directly related to USB,
looks like maybe the "legacy" support didn't work
very well either; maybe that's what the BIOS update
was solving.

- Dave

