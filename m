Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbTFEWNp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 18:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbTFEWNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 18:13:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:64191 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265225AbTFEWMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 18:12:51 -0400
Date: Thu, 5 Jun 2003 15:27:31 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, Kurt.Robideau@comtrol.com
Subject: [BK PATCH] TTY changes for 2.5.70
Message-ID: <20030605222731.GA7717@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some TTY changesets for the latest 2.5.70 bk tree.  They do the
following:
	- update the Rocketport driver to the latest version.
	- fix the race condition with the tty_class devices that was
	  pointed out by Al Viro.
  
Please pull from:
        bk://kernel.bkbits.net/gregkh/linux/tty-2.5

Patches will be posted as a followup to lkml.

thanks,

greg k-h


 include/linux/rocket.h    |   55 
 Documentation/00-INDEX    |    2 
 Documentation/rocket.txt  |   87 +
 MAINTAINERS               |    6 
 drivers/char/Kconfig      |   13 
 drivers/char/rocket.c     | 3344 ++++++++++++++++++++++++++++------------------
 drivers/char/rocket.h     |  131 +
 drivers/char/rocket_int.h |  968 +++++++------
 drivers/char/tty_io.c     |   30 
 drivers/pci/pci.ids       |   33 
 include/linux/pci_ids.h   |   11 
 11 files changed, 2897 insertions(+), 1783 deletions(-)
-----

<kurt.robideau:comtrol.com>:
  o Rocketport driver against 2.5.70-bk7

Greg Kroah-Hartman:
  o TTY: release function should be set in the class, not the class_device
  o TTY: add a release function for tty_class devices

