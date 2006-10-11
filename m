Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161397AbWJKV2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161397AbWJKV2o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161396AbWJKV2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:28:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:47006 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161386AbWJKVFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:05:20 -0400
Date: Wed, 11 Oct 2006 14:04:39 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Tony Lindgren <tony@atomide.com>,
       David Brownell <david-b@pacbell.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 14/67] USB: Allow compile in g_ether, fix typo
Message-ID: <20061011210439.GO16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-allow-compile-in-g_ether-fix-typo.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Tony Lindgren <tony@atomide.com>

Allows compiling g_ether in and fixes a typo with MUSB_HDRC

Signed-off-by: Tony Lindgren <tony@atomide.com>
Cc: David Brownell <david-b@pacbell.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/gadget/ether.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18.orig/drivers/usb/gadget/ether.c
+++ linux-2.6.18/drivers/usb/gadget/ether.c
@@ -262,7 +262,7 @@ MODULE_PARM_DESC(host_addr, "Host Ethern
 #define DEV_CONFIG_CDC
 #endif
 
-#ifdef CONFIG_USB_GADGET_MUSBHDRC
+#ifdef CONFIG_USB_GADGET_MUSB_HDRC
 #define DEV_CONFIG_CDC
 #endif
 
@@ -2564,7 +2564,7 @@ static struct usb_gadget_driver eth_driv
 
 	.function	= (char *) driver_desc,
 	.bind		= eth_bind,
-	.unbind		= __exit_p(eth_unbind),
+	.unbind		= eth_unbind,
 
 	.setup		= eth_setup,
 	.disconnect	= eth_disconnect,

--
