Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbWDMXNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbWDMXNt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWDMXLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:11:00 -0400
Received: from cantor.suse.de ([195.135.220.2]:26566 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965023AbWDMXKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:10:38 -0400
Date: Thu, 13 Apr 2006 16:09:31 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Paul Fulghum <paulkf@microgate.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       GregKH <gregkh@suse.de>
Subject: [patch 20/22] USB: remove __init from usb_console_setup
Message-ID: <20060413230931.GU5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-remove-__init-from-usb_console_setup.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Paul Fulghum <paulkf@microgate.com>

This prevents an Oops if booted with "console=ttyUSB0" but without a
USB-serial dongle, and plugged one in afterwards.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/serial/console.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.5.orig/drivers/usb/serial/console.c
+++ linux-2.6.16.5/drivers/usb/serial/console.c
@@ -54,7 +54,7 @@ static struct console usbcons;
  * serial.c code, except that the specifier is "ttyUSB" instead
  * of "ttyS".
  */
-static int __init usb_console_setup(struct console *co, char *options)
+static int usb_console_setup(struct console *co, char *options)
 {
 	struct usbcons_info *info = &usbcons_info;
 	int baud = 9600;

--
