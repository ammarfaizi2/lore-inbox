Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbTENUbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbTENUbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:31:15 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:42453 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261225AbTENUbH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:31:07 -0400
Date: Wed, 14 May 2003 13:45:48 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More USB changes for 2.5.69
Message-ID: <20030514204548.GA3868@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more USB changes and fixes for 2.5.69.  They are basically
a lot of tiny bugfixes and coding style cleanups.


Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.5


Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/class/Kconfig          |    2 
 drivers/usb/class/cdc-acm.c        |   42 +++-
 drivers/usb/class/usb-midi.c       |   62 ++++--
 drivers/usb/class/usblp.c          |   28 ++-
 drivers/usb/core/hcd-pci.c         |    3 
 drivers/usb/gadget/Kconfig         |   21 +-
 drivers/usb/gadget/net2280.c       |   42 +++-
 drivers/usb/host/ehci-hcd.c        |    1 
 drivers/usb/host/ohci-hcd.c        |    1 
 drivers/usb/host/ohci-sa1111.c     |    6 
 drivers/usb/input/hid-core.c       |   42 +++-
 drivers/usb/input/hid-input.c      |    3 
 drivers/usb/input/hid-lgff.c       |    6 
 drivers/usb/input/hid-tmff.c       |    3 
 drivers/usb/input/hiddev.c         |   27 ++-
 drivers/usb/input/pid.c            |    6 
 drivers/usb/input/usbkbd.c         |    3 
 drivers/usb/media/ov511.c          |  332 ++++++++++++++++++++++---------------
 drivers/usb/media/se401.c          |   19 +-
 drivers/usb/media/vicam.c          |    3 
 drivers/usb/misc/auerswald.c       |   33 ++-
 drivers/usb/misc/uss720.c          |    2 
 drivers/usb/net/catc.c             |   12 -
 drivers/usb/net/kaweth.c           |    3 
 drivers/usb/serial/belkin_sa.c     |    7 
 drivers/usb/serial/console.c       |    9 -
 drivers/usb/serial/cyberjack.c     |    9 -
 drivers/usb/serial/io_ti.c         |    3 
 drivers/usb/serial/ir-usb.c        |    3 
 drivers/usb/serial/pl2303.c        |    2 
 drivers/usb/storage/unusual_devs.h |    9 +
 31 files changed, 480 insertions(+), 264 deletions(-)
-----

<smb@smbnet.de>:
  o USB: another usb storage addition

Andrew Morton <akpm@digeo.com>:
  o USB: net2280 writel fix

Ben Collins <bcollins@debian.org>:
  o USB: Happ UGCI added as BADPAD for workaround

David Brownell <david-b@pacbell.net>:
  o USB: net2280, PPC fixes
  o USB: net2280 minor updates
  o USB: fix for multiple definition of `usb_gadget_get_string'
  o USB: rm debug printks in ehci and ohci

François Romieu <romieu@fr.zoreil.com>:
  o USB: patch to fix up coding style violations

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: fix break control for pl2303 driver
  o USB: fix jiffies warning in uss720.c

Vojtech Pavlik <vojtech@suse.cz>:
  o USB: Fix Kconfig for usb printers

