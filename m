Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269618AbSIRXfN>; Wed, 18 Sep 2002 19:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269645AbSIRXfN>; Wed, 18 Sep 2002 19:35:13 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:15880 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S269618AbSIRXfM>;
	Wed, 18 Sep 2002 19:35:12 -0400
Date: Wed, 18 Sep 2002 16:40:14 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.4.20-pre7
Message-ID: <20020918234014.GC12040@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB updates for 2.4.20-pre7.

Pull from:  bk://linuxusb.bkbits.net/marcelo-2.4

The individual patches will be sent in follow up messages to this email.

thanks,

greg k-h

 Documentation/Configure.help   |   12 
 drivers/usb/hpusbscsi.c        |    6 
 drivers/usb/serial/usbserial.c |    2 
 drivers/usb/usblcd.c           |   11 
 drivers/usb/usbnet.c           |  584 ++++++++++++++++++++++++++++-------------
 include/linux/usb.h            |   55 +++
 6 files changed, 474 insertions(+), 196 deletions(-)
-----

ChangeSet@1.688, 2002-09-18 16:32:54-07:00, info@usblcd.de
  [PATCH] USBLCD updates
  
  -changed minor number from 128 to 144. Is that now really the right one ?
  -increased timeout value because some people reported problems
  -(important!) Vender ID has changed from 0x1212 to 0x10D2 , my official
    assigned one.
  -added usblcd driver to configure.help

 Documentation/Configure.help |   12 ++++++++++++
 drivers/usb/usblcd.c         |   11 ++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)
------

ChangeSet@1.687, 2002-09-18 16:23:38-07:00, greg@kroah.com
  USB: document struct usb_driver and add module owner field.

 include/linux/usb.h |   55 +++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 46 insertions(+), 9 deletions(-)
------

ChangeSet@1.686, 2002-09-18 16:12:40-07:00, greg@kroah.com
  USB: fix timeout value for ezusb firmware download function.

 drivers/usb/serial/usbserial.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.685, 2002-09-18 16:10:11-07:00, david-b@pacbell.net
  [PATCH] usbnet sync w/2.5: new devs, ethtool, etc
  
  Syncing this driver with the more recent 2.5 version.
  Changes of note:
  
      - Supports Yopy PDA, and Epson SOC client firmware
      - Ethtool 1.5 support
      - Uses usb_make_path() when exposing device ids
      - Uses keventd in more fault recovery scenarios
      - Cleanup (comments, C99 initializers, etc)
      - Bugfixes
  
  It's not literally the same code as 2.5, I just #defined
  around some API differences for now.

 drivers/usb/usbnet.c |  584 +++++++++++++++++++++++++++++++++++----------------
 1 files changed, 403 insertions(+), 181 deletions(-)
------

ChangeSet@1.684, 2002-09-18 16:09:57-07:00, oliver@neukum.name
  [PATCH] hpusbscsi disconnect fix
  
  this fixes an oops that may happen if a device is used
  after it is disconnected.

 drivers/usb/hpusbscsi.c |    6 ++++++
 1 files changed, 6 insertions(+)
------

