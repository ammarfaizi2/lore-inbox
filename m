Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265219AbTIFAMR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 20:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbTIFAMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 20:12:17 -0400
Received: from mail.kroah.org ([65.200.24.183]:58526 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265219AbTIFAMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 20:12:16 -0400
Date: Fri, 5 Sep 2003 17:12:22 -0700
From: Greg KH <greg@kroah.com>
To: marcelo.tosatti@cyclades.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.4.23-pre3
Message-ID: <20030906001222.GA18614@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB bugfixes against 2.4.23-pre3.  They include a
copy_*_user audit of the usb tree, and a usb-serial fix that solves an
oops for a lot of people.  There is also some pl2303 driver fixes based
on changes that are in the 2.6 tree.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/marcelo-2.4

The individual patches will be sent in follow up messages to this email
to you and the linux-usb-devel mailing list.

thanks,

greg k-h

 drivers/usb/acm.c                  |    7 +-
 drivers/usb/aiptek.c               |    3 
 drivers/usb/host/uhci-debug.h      |    3 
 drivers/usb/mdc800.c               |    3 
 drivers/usb/serial/pl2303.c        |  114 +++++++++++++++++++++++++++----------
 drivers/usb/serial/usb-serial.h    |   28 +++++++--
 drivers/usb/serial/usbserial.c     |   12 +--
 drivers/usb/storage/unusual_devs.h |    7 ++
 drivers/usb/stv680.c               |    1 
 drivers/usb/vicam.c                |   17 +++--
 10 files changed, 141 insertions(+), 54 deletions(-)
-----

<joris:struyve.be>:
  o unusual_devs.h entry

Greg Kroah-Hartman:
  o USB: fix copy_to_user calls in vicam driver
  o USB: remove duplicated copy_from_user call in stv680 driver
  o USB: fix copy_to_user call in mdc800 driver
  o USB: fix copy_to_user call in uhci-debug.h
  o USB: fix copy_from_user call in aiptek.c
  o USB: fix copy_from_user call in acm.c
  o USB: fix oops when yanking a usb-serial device from the system with the port still opened
  o USB: backport some pl2303 B0 fixes
  o USB: update usb-serial.h with spelling fixes and get and set functions
  o USB: fix data toggle problem for pl2303 driver

