Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753514AbWKCUBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbWKCUBG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753518AbWKCUBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:01:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:53446 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1753514AbWKCUBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:01:05 -0500
Date: Fri, 3 Nov 2006 12:00:55 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB fixes for 2.6.18-rc4
Message-ID: <20061103200055.GA26092@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some USB bugfixes for 2.6.18-rc4.

They include a number of fixes for different regressions reported (the HID
bitmask issue and the Kconfig issue for USB network drivers) as well as some
suspend issues and of course a few new device ids and unusual_devs entries were
added.

All of these changes have been in the last few -mm releases.

Please pull from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 Documentation/usb/usb-serial.txt   |    6 ---
 drivers/usb/class/usblp.c          |    3 +-
 drivers/usb/core/hub.c             |    3 +-
 drivers/usb/input/hid-core.c       |   63 ++++++++++++++++++++++++++----------
 drivers/usb/input/usbtouchscreen.c |    2 +-
 drivers/usb/input/xpad.c           |   41 +++++++++++++++++++++++-
 drivers/usb/net/Kconfig            |    8 ++++-
 drivers/usb/net/usbnet.c           |   58 ++++++++++++++++++---------------
 drivers/usb/serial/Kconfig         |    4 +-
 drivers/usb/serial/cp2101.c        |    3 ++
 drivers/usb/serial/sierra.c        |    3 ++
 drivers/usb/storage/unusual_devs.h |    9 ++++-
 12 files changed, 144 insertions(+), 59 deletions(-)

---------------

Bjorn Schneider (1):
      USB: new VID/PID-combos for cp2101

Daniel Ritz (1):
      usbtouchscreen: use endpoint address from endpoint descriptor

David Brownell (2):
      USB: fix compiler issues with newer gcc versions
      USB: use MII hooks only if CONFIG_MII is enabled

Dominic Cerquetti (1):
      USB: xpad: additional USB id's added

Grant Grundler (1):
      hid-core: big-endian fix fix

Greg Kroah-Hartman (1):
      USB: add another sierra wireless device id

Jan Luebbe (1):
      USB: sierra: Fix id for Sierra Wireless MC8755 in new table

Jan Mate (1):
      USB Storage: unusual_devs.h entry for Sony Ericsson P990i

Naranjo Manuel Francisco (1):
      USB: HID: add blacklist AIRcable USB, little beautification

Oliver Neukum (2):
      USB: failure in usblp's error path
      USB: usblp: fix system suspend for some systems

Phil Dibowitz (1):
      USB: usb-storage: Unusual_dev update

