Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264870AbTLWAbt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 19:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbTLWA34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 19:29:56 -0500
Received: from mail.kroah.org ([65.200.24.183]:36525 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264870AbTLWA31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 19:29:27 -0500
Date: Mon, 22 Dec 2003 16:21:26 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] some sysfs patches for 2.6.0 [0/4]
Message-ID: <20031223002126.GA4805@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 4 sysfs related patches for 2.6.0.  They do the following:

  - fix an oops in sysfs when a kobject has been unregistered before
    it's child has.  An example of this is the oops that happens in
    2.6.0 whenever a usb-serial device is removed that has a port open
    by a user (almost all Pilot devices do this by virtue of the
    protocol...)


  - add sysfs support to the following char drivers:
  	- mem devices (/dev/null and friends)
	- misc devices (/dev/psaux and other odd devices)
	- vc devices

Please apply these to 2.6.0 or your -mm tree depending on how
comfortable you are with them.

thanks,

greg k-h
	
