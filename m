Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264197AbUFGV5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbUFGV5r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbUFGV5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:57:47 -0400
Received: from mail.kroah.org ([65.200.24.183]:60614 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264197AbUFGV5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:57:45 -0400
Date: Mon, 7 Jun 2004 14:54:52 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.6.7-rc3
Message-ID: <20040607215451.GA7531@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are three bugfixes for the USB code against 2.6.7-rc3.  They do the
following:
	- fix deadlock in usbfs
	- fix bug and enable the pwc USB driver to build
	- fix bugs in cyberjack driver to enable device to work.

The first one is the most serious, but the others are good things to
have fixed in the final 2.6.7 release.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/usb-fix-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/core/devio.c       |    2 +-
 drivers/usb/media/Kconfig      |    2 +-
 drivers/usb/media/pwc-if.c     |    9 +--------
 drivers/usb/serial/cyberjack.c |   21 ++++++---------------
 include/linux/usb.h            |    1 +
 5 files changed, 10 insertions(+), 25 deletions(-)
-----

<kaie:kuix.de>:
  o USB: enable pwc usb camera driver

<siegfried.hildebrand:fernuni-hagen.de>:
  o USB: Fix problems with cyberjack usb-serial-module since kernel 2.6.2

Duncan Sands:
  o USB devio.c: deadlock fix

