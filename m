Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261406AbSJCWh3>; Thu, 3 Oct 2002 18:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbSJCWh3>; Thu, 3 Oct 2002 18:37:29 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:26637 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261406AbSJCWh2>;
	Thu, 3 Oct 2002 18:37:28 -0400
Date: Thu, 3 Oct 2002 15:40:11 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] pcibios_* removals for 2.5.40
Message-ID: <20021003224011.GA2289@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's some changesets that remove the pcibios_find_class(),
pci_find_device(), and pcibios_present() functions.  These functions
have been marked as obsolete since the 2.2 kernel, so it's about time
that we removed them.

Please pull from:  http://linuxusb.bkbits.net/pci-2.5

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.

 drivers/net/hp100.c       |    4 ++--
 drivers/net/tulip/de4x5.c |    4 ++--
 drivers/pci/compat.c      |   42 ------------------------------------------
 drivers/pci/syscall.c     |    2 +-
 include/linux/pci.h       |   27 ++++++++++-----------------
 5 files changed, 15 insertions(+), 64 deletions(-)
-----

ChangeSet@1.685, 2002-10-03 14:06:24-07:00, greg@kroah.com
  PCI: removed pcibios_present()

 drivers/net/hp100.c       |    4 ++--
 drivers/net/tulip/de4x5.c |    4 ++--
 drivers/pci/compat.c      |    8 --------
 drivers/pci/syscall.c     |    2 +-
 include/linux/pci.h       |   21 ++++++++++-----------
 5 files changed, 15 insertions(+), 24 deletions(-)
------

ChangeSet@1.684, 2002-10-03 13:45:53-07:00, greg@kroah.com
  PCI: remove pci_find_device()

 drivers/pci/compat.c |   17 -----------------
 include/linux/pci.h  |    3 ---
 2 files changed, 20 deletions(-)
------

ChangeSet@1.683, 2002-10-03 13:36:51-07:00, greg@kroah.com
  PCI: remove pcibios_find_class()

 drivers/pci/compat.c |   17 -----------------
 include/linux/pci.h  |    3 ---
 2 files changed, 20 deletions(-)
------

