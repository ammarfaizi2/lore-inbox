Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265133AbTFEUtA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbTFEUrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:47:47 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:6838 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265134AbTFEUrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:47:22 -0400
Date: Thu, 5 Jun 2003 13:55:15 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: [BK PATCH] i2c driver changes for 2.5.70
Message-ID: <20030605205515.GA6846@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver changes for 2.5.70.  These consist of some
small bug fixes to the i2c core which fixes some oopses, a update to the w83781d.c driver, and a sync with the cvs version of the i2c-id.h file.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/i2c/chips/w83781d.c |  306 +++++++++++++++++++++++++-------------------
 drivers/i2c/i2c-core.c      |    9 -
 include/linux/i2c-id.h      |    7 +
 3 files changed, 185 insertions(+), 137 deletions(-)
-----

<aschultz:warp10.net>:
  o I2C: fix unsafe usage of list_for_each in i2c-core

<mhoffman:lightlink.com>:
  o I2C: more w83781d fixes
  o I2C: fix oops w83781d during rmmod

Greg Kroah-Hartman:
  o I2C: sync i2c-id.h with cvs version

