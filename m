Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbTLKBqI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbTLKBbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:31:13 -0500
Received: from mail.kroah.org ([65.200.24.183]:60111 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264331AbTLKBaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:30:14 -0500
Date: Wed, 10 Dec 2003 17:27:31 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB Fixes for 2.6.0-test11
Message-ID: <20031211012731.GA10632@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB fixes for 2.6.0-test11.  They all fix real bugs, and
are 1-4 line fixes with the exception of the usb-serial close() fix,
which is a bit larger, but has been well tested by a number of different
users.

Please pull from:  bk://linuxusb.bkbits.net/gregkh-2.6

Patches will be posted as a follow-up thread for those who want to see
them.

thanks,

greg k-h

 drivers/usb/core/devio.c        |    2 -
 drivers/usb/core/hub.c          |   10 +++++---
 drivers/usb/core/usb.c          |    1 
 drivers/usb/image/Kconfig       |    4 ++-
 drivers/usb/misc/auerswald.c    |    4 +--
 drivers/usb/serial/usb-serial.c |   50 +++++++++++-----------------------------
 drivers/usb/storage/datafab.c   |    2 -
 drivers/usb/storage/jumpshot.c  |    2 -
 scripts/file2alias.c            |    7 +++++
 9 files changed, 37 insertions(+), 45 deletions(-)
-----

Alan Stern:
  o USB: fix bug not setting device state following usb_device_reset()

Andrey Borzenkov:
  o USB: prevent catch-all USB aliases in modules.alias

David Brownell:
  o USB: fix remove device after set_configuration

Greg Kroah-Hartman:
  o USB: fix bug for multiple opens on ttyUSB devices
  o USB: fix race with hub devices disconnecting while stuff is still happening to them
  o USB: register usb-serial ports in the proper place in sysfs

Herbert Xu:
  o USB: Fix connect/disconnect race

Matthew Dharm:
  o USB storage: fix for jumpshot and datafab devices

Oliver Neukum:
  o USB: fix race with signal delivery in usbfs
  o USB: fix sleping in interrupt bug in auerswald driver

Tom Rini:
  o USB: mark the scanner driver as obsolete

