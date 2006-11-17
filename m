Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424610AbWKQAHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424610AbWKQAHw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 19:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424620AbWKQAHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 19:07:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:65179 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1424610AbWKQAHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 19:07:51 -0500
Date: Thu, 16 Nov 2006 16:07:23 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] USB fixes for 2.6.19-rc6
Message-ID: <20061117000723.GA687@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some USB bugfixes for 2.6.19-rc6.

They include a fix on the Adrian's list-o-regressions, and a number of
other minor things and new device ids.

All of these changes have been in the last few -mm releases.

Please pull from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 drivers/usb/core/message.c         |    5 +----
 drivers/usb/host/ohci-hcd.c        |   25 +++++++++++++++----------
 drivers/usb/host/ohci-hub.c        |    6 ++++--
 drivers/usb/input/hid-core.c       |    5 +++--
 drivers/usb/input/hid-input.c      |   17 +++++++++++++++++
 drivers/usb/input/hid.h            |    1 +
 drivers/usb/misc/auerswald.c       |    2 +-
 drivers/usb/serial/ftdi_sio.c      |    2 ++
 drivers/usb/serial/ftdi_sio.h      |   11 ++++++++++-
 drivers/usb/serial/ipaq.c          |    1 +
 drivers/usb/storage/unusual_devs.h |   18 +++---------------
 11 files changed, 58 insertions(+), 35 deletions(-)

---------------

Alan Stern (2):
      OHCI: disallow autostop when wakeup is not available
      USB: OHCI: fix root-hub resume bug

Alex Sanks (1):
      USB: ipaq: Add HTC Modem Support

Frank Sievertsen (1):
      USB: ftdi driver pid for dmx-interfaces

Jan Mate (1):
      USB Storage: unusual_devs.h entry for Sony Ericsson P990i

Julien BLACHE (1):
      USB: hid-core: Add quirk for new Apple keyboard/trackpad

Kjell Myksvoll (1):
      USB: ftdi_sio: adds vendor/product id for a RFID construction kit

Laurent Pinchart (1):
      USB: Fixed outdated usb_get_device_descriptor() documentation

Mariusz Kozlowski (1):
      USB: auerswald possible memleak fix

Olaf Hering (1):
      USB: correct keymapping on Powerbook built-in USB ISO keyboards

Phil Dibowitz (1):
      USB: Fix UCR-61S2B unusual_dev entry

Sergey Vlasov (1):
      usb-storage: Remove duplicated unusual_devs.h entries for Sony Ericsson P990i

