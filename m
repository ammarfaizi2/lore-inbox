Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbTBCVct>; Mon, 3 Feb 2003 16:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266043AbTBCVct>; Mon, 3 Feb 2003 16:32:49 -0500
Received: from salud.unm.edu ([129.24.128.127]:58375 "EHLO salud.unm.edu")
	by vger.kernel.org with ESMTP id <S265894AbTBCVcs>;
	Mon, 3 Feb 2003 16:32:48 -0500
Message-Id: <se3e7fca.052@salud.unm.edu>
X-Mailer: Novell GroupWise Internet Agent 6.0.3 Beta
Date: Mon, 03 Feb 2003 14:42:08 -0700
From: "Cameron Goble" <cgoble@salud.unm.edu>
To: <linux-kernel@vger.kernel.org>
Subject: SIS900 module detects two transceivers, picks the wrong one
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am having trouble with the SIS900 driver module v1.08.04. The module
installs correctly and does not return an error, but ... well... 

Perhaps dmesg will explain better:

eth0: AMD79C901 HomePNA PHY transceiver found at address 2.
eth0: AMD79C901 10BASE-T PHY transceiver found at address 3.
eth0: using transceiver found at address 2 as default
eth0: SiS 900 PCI Fast Ethernet at 0xec400, IRQ 11, 00:30:67:09:53:81.

So the network interface is a multi-function device, built onto the
motherboard. The driver picks the HomePNA transceiver, but I want to use
the 10BASE-T transceiver. Is there an option I can pass, or some code I
can edit that force the driver to pick the 10BASE-T transceiver at
address 3?

I have attempted to manually configure the device with ifconfig, but I
get the feeling that ifconfig talks to the hardware through the driver,
and since the driver is pointing to the wrong place... I have gotten
nowhere with that approach.

This is an AMD EasyNow PC -- The POST does not display useful
information (it's a graphic of the computer that lights up). I have yet
to find a way into the BIOS configuration screen, or I would try turning
the HomePNA device off from there.

The documentation for this module lists cmhuang@sis.com.tw and
ollie@sis.com.tw as maintainers for the SIS900 module, but my e-mail
to them apparently did not go through. 

Thanks in advance for any help that can be offered. Please cc: replies
to  me at cgoble@salud.unm.edu . 
Cameron Goble
Albuquerque NM USA
cgoble@salud.unm.edu
