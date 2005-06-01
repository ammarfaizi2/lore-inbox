Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVFAFHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVFAFHq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 01:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVFAFGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 01:06:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:34014 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261264AbVFAFBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 01:01:34 -0400
Date: Tue, 31 May 2005 22:11:24 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB bugfixes for 2.6.12-rc5
Message-ID: <20050601051124.GB26927@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 4 patches for the 2.6.12-rc4 tree that fix some USB bugs.  All
of these patches have been in the past few -mm releases.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

Full patches will be sent to the linux-usb-devel mailing list, if anyone
wants to see them.

thanks,

greg k-h

 drivers/usb/host/Kconfig        |   11 
 drivers/usb/host/Makefile       |    1 
 drivers/usb/host/sl811-hcd.c    |  146 +++++++------
 drivers/usb/host/sl811_cs.c     |  442 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/serial/ftdi_sio.c   |    3 
 drivers/usb/serial/ftdi_sio.h   |    2 
 drivers/usb/serial/usb-serial.c |   20 -
 7 files changed, 550 insertions(+), 75 deletions(-)

---------------

Botond Botyanszki:
  o USB: add sl811_cs support

David Brownell:
  o USB: sl811-hcd fixes

Greg Kroah-Hartman:
  o USB: fix usb-serial generic initialization

Ian Abbott:
  o USB: ftdi_sio: new PID for ELV UM100

