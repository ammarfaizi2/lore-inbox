Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbTJDADe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 20:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbTJDABm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 20:01:42 -0400
Received: from mail.kroah.org ([65.200.24.183]:55437 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261673AbTJCX7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:59:10 -0400
Date: Fri, 3 Oct 2003 16:57:00 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.6.0-test6
Message-ID: <20031003235700.GA4329@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB fixes for 2.6.0-test6.  These are all bugfixes or
added support for new USB devices.  The patches here fix a number of
different bugzilla entries:
	- problems with UHCI controllers
	- freecom device breakage
	- usbfs options not working properly.
I've also fixed up some improper license wording in some of the keyspan
header files, as per conversations with that company.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/core/inode.c              |  149 ++++++------
 drivers/usb/host/uhci-debug.c         |  166 ++++++-------
 drivers/usb/host/uhci-hcd.c           |    2 
 drivers/usb/input/Kconfig             |    7 
 drivers/usb/misc/brlvger.c            |    6 
 drivers/usb/misc/speedtch.c           |  120 +++++----
 drivers/usb/serial/keyspan.c          |  420 ++++++++++++++++++++++++++++++++--
 drivers/usb/serial/keyspan.h          |   33 ++
 drivers/usb/serial/keyspan_usa26msg.h |    8 
 drivers/usb/serial/keyspan_usa28msg.h |    8 
 drivers/usb/serial/keyspan_usa49msg.h |    8 
 drivers/usb/serial/keyspan_usa90msg.h |  198 ++++++++++++++++
 drivers/usb/storage/freecom.c         |   16 -
 drivers/usb/storage/unusual_devs.h    |    8 
 include/linux/usb.h                   |    6 
 15 files changed, 884 insertions(+), 271 deletions(-)
-----

<amn3s1a:ono.com>:
  o USB: New unusual_devs.h entry (Minolta DiMAGE E223 Digital Camera)

Alan Stern:
  o USB: unusual_devs.h update

Daniel Drake:
  o USB brlvger: Debug code fixes

Duncan Sands:
  o USB speedtouch: neater check
  o USB speedtouch: reduce memory usage
  o USB speedtouch: extra debug messages

Greg Kroah-Hartman:
  o USB: fix up some non-GPL friendly license wording
  o USB: port keyspan patch from 2.4 to 2.6
  o USB: convert usbfs to use new fs parser code

Joe Perches:
  o USB: include/linux/usb.h

Luiz Capitulino:
  o USB: fix drivers/usb/host/uhci-debug.c warning when !CONFIG_PROC_FS

Matthew Dharm:
  o USB: fix freecom.c

Steven Cole:
  o USB: remove reference to modules.txt in drivers/usb/input/Kconfig

Wim Van Sebroeck:
  o USB: problem with uhci-hcd in versions 2.6.0-test5 and 2.6.0-test6

