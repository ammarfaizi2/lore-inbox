Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbTJ3AwQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 19:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTJ3AvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 19:51:23 -0500
Received: from mail.kroah.org ([65.200.24.183]:43700 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262074AbTJ3AvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 19:51:11 -0500
Date: Wed, 29 Oct 2003 16:48:52 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] fixes for 2.6.0-test9
Message-ID: <20031030004852.GA2042@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are 3 small fixes for 2.6.0-test9.  They fix a problem on Alphas on
boot time, remove some compiler warnings in some I2C drivers, and
disable a USB driver when building for SMP as the locking in it is all
messed up right now.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 drivers/media/video/bt832.c      |    2 --
 drivers/media/video/saa5249.c    |    2 --
 drivers/media/video/tuner-3036.c |    2 --
 drivers/pci/setup-bus.c          |   30 +++++++++++++++++++++---------
 drivers/usb/serial/Kconfig       |    2 +-
 5 files changed, 22 insertions(+), 16 deletions(-)
-----


Greg Kroah-Hartman:
  o USB: don't build the whiteheat driver if on SMP as the locking is all messed up
  o I2C: remove some MOD_INC and MOD_DEC usages that are not needed anymore

Ivan Kokshaysky:
  o PCI: fix bug in pci_setup_bridge()

