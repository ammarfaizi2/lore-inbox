Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266998AbTBUAk5>; Thu, 20 Feb 2003 19:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267255AbTBUAk5>; Thu, 20 Feb 2003 19:40:57 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:20486 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266998AbTBUAkz>;
	Thu, 20 Feb 2003 19:40:55 -0500
Date: Thu, 20 Feb 2003 16:43:45 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI fixes for 2.5.62
Message-ID: <20030221004344.GA26723@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's three patches that remove the pci functions off of the top of
your list of "abuse the most stack space" list.  And there's a patch in
here from Louis Zhuang that cleans up some of the list handling code in
the pci core (his patch has been posted to lkml in the past).

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.5

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 arch/i386/pci/direct.c  |   34 ++++++++++++++++++++++++----------
 arch/i386/pci/legacy.c  |   27 +++++++++++++++++++--------
 drivers/pci/probe.c     |   28 +++++++++++++++++-----------
 drivers/pci/setup-bus.c |   30 ++++++++++++------------------
 4 files changed, 72 insertions(+), 47 deletions(-)
-----

ChangeSet@1.1006, 2003-02-20 16:32:48-08:00, louis.zhuang@linux.co.intel.com
  [PATCH] PCI: list code cleanup
  
  Cleans up the list handling in a few places within the pci core.

 drivers/pci/probe.c     |    5 ++---
 drivers/pci/setup-bus.c |   30 ++++++++++++------------------
 2 files changed, 14 insertions(+), 21 deletions(-)
------

ChangeSet@1.1005, 2003-02-20 14:23:58-08:00, greg@kroah.com
  [PATCH] PCI i386: remove large stack usage in pcibios_fixup_peer_bridges()

 arch/i386/pci/legacy.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)
------

ChangeSet@1.1004, 2003-02-20 14:23:43-08:00, greg@kroah.com
  [PATCH] PCI i386: remove large stack usage in pci_sanity_check()

 arch/i386/pci/direct.c |   34 ++++++++++++++++++++++++----------
 1 files changed, 24 insertions(+), 10 deletions(-)
------

ChangeSet@1.1003, 2003-02-20 14:23:27-08:00, greg@kroah.com
  [PATCH] PCI: remove large stack usage in pci_do_scan_bus()

 drivers/pci/probe.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)
------

