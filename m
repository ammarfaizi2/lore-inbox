Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262728AbUKLXvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbUKLXvG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbUKLXs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:48:56 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:34279 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262682AbUKLX0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:26:12 -0500
Date: Fri, 12 Nov 2004 15:26:04 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] I2C fixes for 2.6.10-rc1
Message-ID: <20041112232604.GA17203@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a few small i2c bugfixes for 2.6.10-rc1

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

That's it, bug fixes only from me for now till 2.6.10 is out :)

thanks,

greg k-h

 Documentation/i2c/dev-interface |    4 +--
 drivers/i2c/chips/rtc8564.c     |    3 ++
 drivers/i2c/i2c-core.c          |   19 +++++++++++++++++-
 drivers/i2c/i2c-dev.c           |    2 -
 drivers/i2c/i2c-sensor-detect.c |    2 -
 include/linux/i2c.h             |   16 +++------------
 sound/ppc/daca.c                |   24 ++++++++++++-----------
 sound/ppc/pmac.h                |    2 -
 sound/ppc/tumbler.c             |   41 ++++++++++++++++++++++------------------
 9 files changed, 65 insertions(+), 48 deletions(-)
-----

Gabriel Paubert:
  o I2C: Recent I2C "dead code removal" breaks pmac sound

Greg Kroah-Hartman:
  o I2C: fix up rtc8564 which should not have been changed in my previous cleanups
  o I2C: fix up some out of date Documentation

Jean Delvare:
  o I2C: Missing newlines in debug messages

