Return-Path: <linux-kernel-owner+willy=40w.ods.org-S277370AbUKBArh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S277370AbUKBArh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 19:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S387689AbUKBArh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 19:47:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14981 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S387674AbUKBAqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 19:46:44 -0500
Date: Mon, 1 Nov 2004 16:46:15 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Wolfgang Scheicher <worf@sbox.tu-graz.ac.at>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 USB storage problems
Message-ID: <20041101164615.13a04a7c@lembas.zaitcev.lan>
References: <200410121424.59584.worf@sbox.tu-graz.ac.at>
	<200411012040.33285.worf@sbox.tu-graz.ac.at>
	<20041101213501.GD18227@one-eyed-alien.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004 23:19:13 +0100, Wolfgang Scheicher <worf@sbox.tu-graz.ac.at> wrote:

> >> And: could maybe somebody put some hints into the ub help?
> >> "This driver supports certain USB attached storage devices such as flash
> >> keys." didn't sound so bad to me...
> >
> > That should definately happen.  Along with a note that this blocks
> > usb-storage from working with many devices if enabled.
> 
> Yep. Absolutely.

I don't like too much wordage. How about this:

diff -urp -X dontdiff linux-2.6.10-rc1/drivers/block/Kconfig linux-2.6.10-rc1-ub/drivers/block/Kconfig
--- linux-2.6.10-rc1/drivers/block/Kconfig	2004-10-28 09:46:38.000000000 -0700
+++ linux-2.6.10-rc1-ub/drivers/block/Kconfig	2004-11-01 16:09:13.727453544 -0800
@@ -308,6 +308,8 @@ config BLK_DEV_UB
 	  This driver supports certain USB attached storage devices
 	  such as flash keys.
 
+	  Warning: Enabling this cripples the usb-storage driver.
+
 	  If unsure, say N.
 
 config BLK_DEV_RAM

-- Pete
