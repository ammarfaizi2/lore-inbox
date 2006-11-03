Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753515AbWKCUBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515AbWKCUBI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753520AbWKCUBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:01:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:53702 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1753515AbWKCUBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:01:05 -0500
Date: Fri, 3 Nov 2006 11:56:13 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: [GIT PATCH] PCI fixes for 2.6.19-rc4
Message-ID: <20061103195613.GA4034@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are two PCI bug fixes.

One is a revert of a previous patch that had caused some PCI problems for
suspend/resume.  The other one marks PCI_MULTITHREAD_PROBE depend on
CONFIG_BROKEN to make it so that users don't have so many problems with the
2.6.19 release (because we all know that they don't read the help text for new
config options very carefully at times...)

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing list, if anyone
wants to see them.

thanks,

greg k-h

 arch/i386/pci/common.c |    1 -
 arch/i386/pci/i386.c   |    9 ---------
 arch/i386/pci/pci.h    |    1 -
 drivers/pci/Kconfig    |    2 +-
 4 files changed, 1 insertions(+), 12 deletions(-)

---------------

Adrian Bunk (1):
      PCI: Let PCI_MULTITHREAD_PROBE depend on BROKEN

Greg Kroah-Hartman (1):
      PCI: Revert "PCI: i386/x86_84: disable PCI resource decode on device disable"

