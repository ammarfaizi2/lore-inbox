Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTLLX0P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 18:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbTLLX0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 18:26:15 -0500
Received: from mail.kroah.org ([65.200.24.183]:4273 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261464AbTLLX0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 18:26:09 -0500
Date: Fri, 12 Dec 2003 15:25:21 -0800
From: Greg KH <greg@kroah.com>
To: marcelo.tosatti@cyclades.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.4.24-pre1
Message-ID: <20031212232521.GA21789@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB bugfixes and changes against 2.4.24-pre1.  There is
one new driver (w9968cf) and a nice update of the usb printer driver.
Everything else is small updates that are present in 2.6 (or in the
patch queue for 2.6 acceptance.)

Please pull from:  bk://linuxusb.bkbits.net/usb-devel-2.4

The individual patches will be sent in follow up messages to this email
to you and the linux-usb-devel mailing list.

thanks,

greg k-h


 CREDITS                            |    6 
 Documentation/Configure.help       |   15 
 Documentation/usb/w9968cf.txt      |  158 +++----
 MAINTAINERS                        |   10 
 drivers/usb/pegasus.c              |    5 
 drivers/usb/pegasus.h              |    8 
 drivers/usb/printer.c              |  285 +++++++++----
 drivers/usb/scanner.c              |    4 
 drivers/usb/scanner.h              |   17 
 drivers/usb/serial/ftdi_sio.c      |   12 
 drivers/usb/serial/ftdi_sio.h      |    8 
 drivers/usb/serial/io_edgeport.c   |   12 
 drivers/usb/serial/io_fw_boot.h    |    2 
 drivers/usb/serial/io_fw_boot2.h   |    2 
 drivers/usb/serial/io_fw_down.h    |    2 
 drivers/usb/serial/io_fw_down2.h   |    2 
 drivers/usb/serial/mct_u232.c      |   37 +
 drivers/usb/serial/mct_u232.h      |  101 +++-
 drivers/usb/serial/pl2303.c        |   44 ++
 drivers/usb/serial/pl2303.h        |    1 
 drivers/usb/serial/visor.c         |    2 
 drivers/usb/serial/visor.h         |    1 
 drivers/usb/storage/unusual_devs.h |   91 +++-
 drivers/usb/w9968cf.c              |  782 ++++++++++++++++++-------------------
 drivers/usb/w9968cf.h              |   66 +--
 drivers/usb/w9968cf_decoder.h      |    2 
 drivers/usb/w9968cf_externaldef.h  |   13 
 27 files changed, 1024 insertions(+), 664 deletions(-)
-----

<alexander:all-2.com>:
  o USB storage: patch for unusual_devs.h

<berentsen:sent5.uni-duisburg.de>:
  o USB storage: Minolta Dimage S414 usb patch

<dancy:dancysoft.com>:
  o USB: add TIOCMIWAIT support to pl2303 driver

<fello:libero.it>:
  o USB storage: patch for Fujifilm EX-20

<luca.risolia:studio.unibo.it>:
  o USB: W996[87]CF driver update

<marr:flex.com>:
  o USB: MCT-U232 Patch for cts

<mbp:samba.org>:
  o USB storage: add unusual storage device entry for Minolta DiMAGE

<per.winkvist:uk.com>:
  o USB storage: Make Pentax Optio S4 work

<petkan:nucleusys.com>:
  o USB: pegasus driver update

<stephane.galles:free.fr>:
  o USB storage: patch for Kyocera S5 camera

<tchen:on-go.com>:
  o USB: fix io_edgeport driver alignment issues
  o USB: fix bug when errors happen in ioedgeport driver

<_nessuno_:katamail.com>:
  o USB storage: Medion 6047 Digital Camera

Alan Stern:
  o USB storage: Unusual_devs.h addition
  o USB storage: Another unusual_devs.h update
  o USB storage: unusual_devs.h entry revision

Greg Kroah-Hartman:
  o USB: add support for Sony UX50 device to visor driver
  o USB: add support for another pl2303 device
  o USB: add support for Protego devices to ftdi_sio driver

Henning Meier-Geinitz:
  o USB: scanner driver: new device ids

Herbert Xu:
  o USB Storage: freecom dvd-rw fx-50 usb-ide patch

Pete Zaitcev:
  o USB: Backport of printer 2.6=>2.4

