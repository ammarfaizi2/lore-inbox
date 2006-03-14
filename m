Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWCNXaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWCNXaX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 18:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWCNXaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 18:30:23 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:4591 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932170AbWCNXaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 18:30:22 -0500
Message-ID: <4417540C.8030003@gentoo.org>
Date: Tue, 14 Mar 2006 23:38:52 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060207)
MIME-Version: 1.0
To: Peter Chubb <peterc@gelato.unsw.edu.au>
CC: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stern@rowland.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: HP CDRW CD4E hasn't worked since 2.6.11
References: <17430.14259.90181.849542@berry.ken.nicta.com.au>	<20060314221958.GD12257@suse.de>	<44174DA0.5020105@gentoo.org> <17431.19680.579155.54647@wombat.chubb.wattle.id.au>
In-Reply-To: <17431.19680.579155.54647@wombat.chubb.wattle.id.au>
Content-Type: multipart/mixed;
 boundary="------------050409030404070807070103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050409030404070807070103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Peter Chubb wrote:
> Patch appended.

Thats very intrusive. Please try a more simplistic approach, and send 
new logs if it is still detected as a disk :)

Daniel

--------------050409030404070807070103
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- linux/drivers/usb/storage/shuttle_usbat.c.orig	2006-03-14 23:36:57.000000000 +0000
+++ linux/drivers/usb/storage/shuttle_usbat.c	2006-03-14 23:37:18.000000000 +0000
@@ -855,6 +855,9 @@ static int usbat_identify_device(struct 
 		return rc;
 	msleep(500);
 
+	info->devicetype = USBAT_DEV_FLASH;
+	return USB_STOR_TRANSPORT_GOOD;
+
 	/*
 	 * In attempt to distinguish between HP CDRW's and Flash readers, we now
 	 * execute the IDENTIFY PACKET DEVICE command. On ATA devices (i.e. flash

--------------050409030404070807070103--
