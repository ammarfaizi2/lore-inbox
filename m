Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbTJOSmy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbTJOSma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:42:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:62897 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263936AbTJOS03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:26:29 -0400
Date: Wed, 15 Oct 2003 11:16:10 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More USB fixes for 2.6.0-test7
Message-ID: <20031015181610.GB22159@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more USB fixes for 2.6.0-test7.  They fix a bug in the
visor driver that just about everyone except me has tripped over, EHCI
fixes for SPARC platforms and other oops fixes, OHCI power management
fixes, and build fixes for PPC kernels and the keyspan driver.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/host/ehci-dbg.c           |   10 +++---
 drivers/usb/host/ehci-q.c             |   30 ++++++++++--------
 drivers/usb/host/ehci.h               |   16 ----------
 drivers/usb/host/ohci-hcd.c           |   54 +++++++++++++++-------------------
 drivers/usb/host/ohci-hub.c           |    2 -
 drivers/usb/host/ohci-pci.c           |   44 ++++++++++++---------------
 drivers/usb/host/ohci-q.c             |   23 ++++++++++----
 drivers/usb/host/ohci.h               |    5 ---
 drivers/usb/input/Kconfig             |    1 
 drivers/usb/serial/keyspan_usa90msg.h |   14 ++++----
 drivers/usb/serial/visor.c            |    3 -
 11 files changed, 93 insertions(+), 109 deletions(-)
-----


Benjamin Herrenschmidt:
  o USB: Conflicting definitions in keyspan driver

David Brownell:
  o USB: ohci-hcd PM fixes
  o USB: ehci-hcd, misc bugfixes

Greg Kroah-Hartman:
  o USB: fix visor driver to work with Palm OS 4+ devices

John Levon:
  o USB: default input core support to y

