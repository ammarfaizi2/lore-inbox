Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272226AbTHIA6o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272161AbTHIA5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:57:19 -0400
Received: from mail.kroah.org ([65.200.24.183]:52671 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272153AbTHIAcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:32:09 -0400
Date: Fri, 8 Aug 2003 17:30:36 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] More PCI fixes for 2.6.0-test2
Message-ID: <20030809003036.GA3163@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a few more fixes for the PCI core code for 2.6.0-test2-bk.
I've removed all of the struct device.name usages as that field is about
to go away, and there is a fix from Ivan in here too.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 drivers/char/agp/hp-agp.c |    2 +-
 drivers/net/eepro100.c    |    2 +-
 drivers/pci/names.c       |    2 +-
 drivers/pci/pci.c         |    2 +-
 drivers/pci/pci.ids       |    3 ++-
 drivers/pci/probe.c       |    9 +++------
 drivers/pci/proc.c        |    7 ++++++-
 drivers/pci/quirks.c      |    2 +-
 drivers/pci/setup-bus.c   |    6 ++++--
 drivers/pci/setup-res.c   |    2 +-
 include/linux/pci.h       |    3 +++
 include/linux/pci_ids.h   |    3 ++-
 12 files changed, 26 insertions(+), 17 deletions(-)
-----

Alex Williamson:
  o PCI: trivial 2.4/2.6 PCI name change/addition

Greg Kroah-Hartman:
  o PCI: make eepro100 driver use pci_name() instead of dev.name
  o PCI: remove all struct device.name usage from the PCI core code

Ivan Kokshaysky:
  o PCI: pci_enable_device vs bridges bugs

