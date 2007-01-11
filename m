Return-Path: <linux-kernel-owner+w=401wt.eu-S1030187AbXAKBan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbXAKBan (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 20:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbXAKBaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 20:30:01 -0500
Received: from imf18aec.mail.bellsouth.net ([205.152.59.66]:32975 "EHLO
	imf18aec.mail.bellsouth.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030186AbXAKB3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 20:29:51 -0500
X-Greylist: delayed 2991 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jan 2007 20:29:44 EST
Date: Wed, 10 Jan 2007 18:39:51 -0600
From: Jay Cliburn <jacliburn@bellsouth.net>
To: jeff@garzik.org
Cc: shemminger@osdl.org, csnook@redhat.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, atl1-devel@lists.sourceforge.net
Subject: [PATCH 0/4] atl1: Attansic L1 ethernet driver
Message-ID: <20070111003951.GA2624@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the latest submittal of the patchset providing support for the 
Attansic L1 gigabit ethernet adapter.  This patchset is built against 
kernel version 2.6.20-rc4 current git as of 20070109.

The monolithic version of this patchset may be found at:
ftp://hogchain.net/pub/linux/m2v/attansic/kernel_driver/atl1-2.0.3/atl1-2.0.3-linux-2.6.20.rc4.patch.bz2

As a reminder, this driver is a modified version of the Attansic reference 
driver for the L1 ethernet adapter.  Attansic has granted permission for 
its inclusion in the mainline kernel.

Changes for this version include:
* Incorporation of previous comments from Arnd Bergmann, Alan Cox, and
  Jan Engelhardt.
* Conversion to the new workqueue method.
* Addition of MSI support (thanks to Luca Tettamanti).

NOTES:
1.  TSO is broken (order of magnitude decrease in Tx peformance as compared
to Rx performance) and therefore the feature has been disabled until it's
fixed.  We have not been able to find the source of the problem in the 
driver itself, so we've requested that Attansic take a look at the hardware.
We've not yet heard back from them.  We encourage any experienced netdev
folks to take a look at the TSO code and let us know if you see the problem.

2.  Given the download statistics from Sourceforge (current home of the
driver) and hogchain.net (the original home of the driver), we believe the 
driver to be in use by dozens, if not hundreds, of users.  We've received 
remarkably few bug reports:  a couple of typos and and the TSO performance 
issue.

This patch contains:

drivers/net/Kconfig             |   11 +
drivers/net/Makefile            |    1 +
drivers/net/atl1/Makefile       |   30 +
drivers/net/atl1/atl1.h         |  266 +++++
drivers/net/atl1/atl1_ethtool.c |  528 +++++++++
drivers/net/atl1/atl1_hw.c      |  797 +++++++++++++
drivers/net/atl1/atl1_hw.h      | 1053 +++++++++++++++++
drivers/net/atl1/atl1_main.c    | 2464 +++++++++++++++++++++++++++++++++++++++
drivers/net/atl1/atl1_param.c   |  223 ++++ 
9 files changed, 5373 insertions(+), 0 deletions(-)

