Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWILKVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWILKVZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 06:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWILKVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 06:21:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:36026 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750932AbWILKVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 06:21:24 -0400
Date: Tue, 12 Sep 2006 03:15:30 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [GIT PATCH] more USB fixes for 2.6.18-rc6
Message-ID: <20060912101530.GA25136@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a two more bugfixes for USB issues that were recently
discovered with 2.6.18-rc6

They do:
	- fix a leak on /proc/tty/drivers/usb-serial
	- fix a oops when unloading the yealink driver

Please pull from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/

The full patches will be sent to the linux-usb-devel mailing lists, if
anyone wants to see them.

thanks,

greg k-h

 drivers/usb/input/yealink.c     |   12 ++++++------
 drivers/usb/serial/usb-serial.c |    4 +++-
 2 files changed, 9 insertions(+), 7 deletions(-)

---------------

Henk Vergonet:
      USB: Fix unload oops and memory leak in yealink driver

Matthias Urlichs:
      usbserial: Reference leak

