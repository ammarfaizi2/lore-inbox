Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWJHXQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWJHXQb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 19:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWJHXQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 19:16:30 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:52497 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932100AbWJHXQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 19:16:29 -0400
Date: Mon, 9 Oct 2006 01:16:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/misc/ftdi-elan.c: remove dead code
Message-ID: <20061008231624.GN6755@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted this obviously dead code.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/drivers/usb/misc/ftdi-elan.c.old	2006-10-09 00:22:57.000000000 +0200
+++ linux-2.6/drivers/usb/misc/ftdi-elan.c	2006-10-09 00:24:39.000000000 +0200
@@ -513,8 +513,6 @@
                         ftdi->disconnected += 1;
                 } else if (retval == -ENODEV) {
                         ftdi->disconnected += 1;
-                } else if (retval == -ENODEV) {
-                        ftdi->disconnected += 1;
                 } else if (retval == -EILSEQ) {
                         ftdi->disconnected += 1;
                 } else {

