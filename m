Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318627AbSHUSxP>; Wed, 21 Aug 2002 14:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318643AbSHUSxP>; Wed, 21 Aug 2002 14:53:15 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:51972 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318627AbSHUSxN>;
	Wed, 21 Aug 2002 14:53:13 -0400
Date: Wed, 21 Aug 2002 11:51:51 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.4.20-pre4
Message-ID: <20020821185151.GA1771@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pull from:  bk://linuxusb.bkbits.net/marcelo-2.4

The individual patches will be sent in follow up messages to this email.

thanks,

greg k-h

 CREDITS                         |    2 
 Documentation/Configure.help    |   17 
 Documentation/usb/auerswald.txt |    2 
 MAINTAINERS                     |    9 
 drivers/usb/auerswald.c         |    6 
 drivers/usb/brlvger.c           |    4 
 drivers/usb/hcd/ehci-hcd.c      |    9 
 drivers/usb/hcd/ehci-q.c        |    8 
 drivers/usb/hcd/ehci-sched.c    |   23 
 drivers/usb/hub.c               |   81 ++-
 drivers/usb/microtek.c          |   15 
 drivers/usb/ov511.c             |  342 ++++++--------
 drivers/usb/pegasus.c           |  971 ++++++++++++++++++----------------------
 drivers/usb/pegasus.h           |    3 
 drivers/usb/printer.c           |   13 
 drivers/usb/pwc-if.c            |    2 
 drivers/usb/rtl8150.c           |  391 +++++++---------
 drivers/usb/se401.c             |   17 
 drivers/usb/se401.h             |    2 
 drivers/usb/stv680.c            |   16 
 drivers/usb/stv680.h            |    2 
 drivers/usb/uhci.c              |   71 +-
 drivers/usb/uhci.h              |    6 
 drivers/usb/usb-ohci.c          |   21 
 drivers/usb/usb-uhci.c          |    2 
 drivers/usb/usb.c               |    9 
 drivers/usb/vicam.c             |    2 
 drivers/usb/vicamurbs.h         |    6 
 drivers/usb/wacom.c             |   17 
 include/linux/hiddev.h          |    2 
 30 files changed, 1004 insertions(+), 1067 deletions(-)
-----

ChangeSet@1.601, 2002-08-21 09:58:20-07:00, james@cobaltmountain.com
  [PATCH] drivers_usb_auerswald.c, typo: the the
  

 drivers/usb/auerswald.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.600, 2002-08-21 09:58:05-07:00, james@cobaltmountain.com
  [PATCH] drivers_usb_usb-uhci.c, typo: the the, missing 'of'
  

 drivers/usb/usb-uhci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.599, 2002-08-20 15:00:59-07:00, greg@kroah.com
  USB: uhci incorrect bit operations and FSBR timeout fixes.

 drivers/usb/uhci.c |   71 +++++++++++++++++++++++++++++------------------------
 drivers/usb/uhci.h |    6 ++--
 2 files changed, 43 insertions(+), 34 deletions(-)
------

ChangeSet@1.598, 2002-08-20 15:00:07-07:00, greg@kroah.com
  USB: usb-ohci bug fix for slow machines and cardbus bug fix.

 drivers/usb/usb-ohci.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)
------

ChangeSet@1.597, 2002-08-20 14:58:29-07:00, greg@kroah.com
  stv680 driver update to latest version.

 drivers/usb/stv680.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)
------

ChangeSet@1.596, 2002-08-20 14:58:05-07:00, greg@kroah.com
  minor printer driver fixes.

 drivers/usb/printer.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)
------

ChangeSet@1.595, 2002-08-20 14:57:06-07:00, greg@kroah.com
  update to latest version of rtl8150 driver.

 drivers/usb/rtl8150.c |  391 ++++++++++++++++++++++----------------------------
 1 files changed, 174 insertions(+), 217 deletions(-)
------

ChangeSet@1.594, 2002-08-20 14:56:35-07:00, greg@kroah.com
  USB: fix some USB 2.0 hub bugs.

 drivers/usb/hcd/ehci-hcd.c   |    9 ++--
 drivers/usb/hcd/ehci-q.c     |    8 ++--
 drivers/usb/hcd/ehci-sched.c |   23 +-----------
 drivers/usb/hub.c            |   81 ++++++++++++++++++++++++++++---------------
 4 files changed, 65 insertions(+), 56 deletions(-)
------

ChangeSet@1.593, 2002-08-20 14:55:38-07:00, greg@kroah.com
  USB: minor cleanups and __FUNCTION__ fixes.

 drivers/usb/brlvger.c   |    4 ++--
 drivers/usb/pwc-if.c    |    2 +-
 drivers/usb/se401.c     |   17 ++---------------
 drivers/usb/se401.h     |    2 +-
 drivers/usb/stv680.h    |    2 +-
 drivers/usb/usb.c       |    9 +++++----
 drivers/usb/vicam.c     |    2 +-
 drivers/usb/vicamurbs.h |    6 ------
 include/linux/hiddev.h  |    2 +-
 9 files changed, 14 insertions(+), 32 deletions(-)
------

ChangeSet@1.592, 2002-08-20 14:54:37-07:00, greg@kroah.com
  wacom driver update to fix incorrect data problem.

 drivers/usb/wacom.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)
------

ChangeSet@1.591, 2002-08-20 14:53:04-07:00, greg@kroah.com
  microtek driver update to the latest version.

 drivers/usb/microtek.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)
------

ChangeSet@1.590, 2002-08-20 14:52:35-07:00, greg@kroah.com
  USB: pegasus driver update to the latest version

 drivers/usb/pegasus.c |  971 +++++++++++++++++++++++---------------------------
 drivers/usb/pegasus.h |    3 
 2 files changed, 461 insertions(+), 513 deletions(-)
------

ChangeSet@1.589, 2002-08-20 14:51:53-07:00, greg@kroah.com
  USB: ov511 driver update to the latest version

 drivers/usb/ov511.c |  342 +++++++++++++++++++++++++---------------------------
 1 files changed, 165 insertions(+), 177 deletions(-)
------

ChangeSet@1.588, 2002-08-20 14:49:39-07:00, greg@kroah.com
  USB: documentation updates
  
  Configure.help update for missing entries,
  MAINTAINERS update for tidus
  email change for Wolfgang Muees

 CREDITS                         |    2 +-
 Documentation/Configure.help    |   17 ++++++++++++++++-
 Documentation/usb/auerswald.txt |    2 +-
 MAINTAINERS                     |    9 ++++++++-
 drivers/usb/auerswald.c         |    4 ++--
 5 files changed, 28 insertions(+), 6 deletions(-)
------

