Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932723AbWFUXhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbWFUXhJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 19:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbWFUXhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 19:37:09 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45835 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932723AbWFUXhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 19:37:07 -0400
Date: Thu, 22 Jun 2006 01:37:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Oliver Bock <o.bock@fh-wolfenbuettel.de>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-usb-devel@lists.sourceforge.net
Subject: [-mm patch] make drivers/usb/misc/cy7c63.c:vendor_command() static
Message-ID: <20060621233706.GU9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 03:48:57AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc6-mm2:
>...
> +gregkh-usb-usb-new-driver-for-cypress-cy7c63xxx-mirco-controllers.patch
>...
>  USB tree updates
>...

This patch makes the needlessly global vendor_command() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm1-full/drivers/usb/misc/cy7c63.c.old	2006-06-22 01:25:08.000000000 +0200
+++ linux-2.6.17-mm1-full/drivers/usb/misc/cy7c63.c	2006-06-22 01:25:57.000000000 +0200
@@ -63,8 +63,8 @@
 };
 
 /* used to send usb control messages to device */
-int vendor_command(struct cy7c63 *dev, unsigned char request,
-			 unsigned char address, unsigned char data) {
+static int vendor_command(struct cy7c63 *dev, unsigned char request,
+			  unsigned char address, unsigned char data) {
 
 	int retval = 0;
 	unsigned int pipe;

