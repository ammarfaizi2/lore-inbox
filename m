Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbUA3O0L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 09:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUA3O0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 09:26:11 -0500
Received: from linux-bt.org ([217.160.111.169]:36563 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S261539AbUA3O0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 09:26:08 -0500
Subject: Re: Bluetooth oddity
From: Marcel Holtmann <marcel@holtmann.org>
To: Anders Karlsson <anders@trudheim.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1075471246.11889.5.camel@tor.trudheim.com>
References: <1075462349.9698.4.camel@tor.trudheim.com>
	 <1075469610.26729.108.camel@pegasus>
	 <1075471246.11889.5.camel@tor.trudheim.com>
Content-Type: text/plain
Message-Id: <1075472736.26729.132.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 30 Jan 2004 15:25:36 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders,

> > I assume that you have enabled the SCO support of the HCI USB driver.
> > The unlink of ISOC URB's fails on UHCI host controllers and actually I
> > don't know why. So disable the SCO support of the HCI USB driver and you
> > can switch on and off your Bluetooth device as often as you like.
> 
> I just checked, and I did have the SCO support switched on. Shows that
> the name can not be trusted... ;-)

the CONFIG_BT_SCO option is not problematic, you can leave this on. But
for now you must disable CONFIG_BT_HCIUSB_SCO if you have an UHCI host
controller.

> > What is your USB host controller chipset? Do you see an oops?
> 
> No oops, rebuilding the kernel with serial support built in so I can
> attach serial console. After that I should be able to capture any
> information required.

Apply patch-2.6.1-mh3 and rebuild your kernel. This patch only updates
your Bluetooth subsystem. To not run into problems with your modules
undiff the change to the Makefile EXTRAVERSION before calling make.

> > This was a bug in the RFCOMM layer that has been already fixed. Why
> > don't you say what 2.6 kernel do you use? Try the latest 2.6.2-rc2 or
> > 2.6.1-mh3 and this will go away.
> 
> I am currently using 2.6.1 proper, but saw it in 2.6.0 and a couple of
> half-way houses between 2.6.0 and 2.6.1.

I know, but our big resync with 2.6 was first in 2.6.2-rc1. And this bug
only occurred on incoming RFCOMM connections.

Regards

Marcel


