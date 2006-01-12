Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030469AbWALQ3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbWALQ3y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 11:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbWALQ3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 11:29:54 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:63369 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030461AbWALQ3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 11:29:53 -0500
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 00/13] USBATM: summary
Date: Thu, 12 Jan 2006 17:29:51 +0100
User-Agent: KMail/1.9.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       usbatm@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601121729.52596.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, here are some fixes and improvements to the USB ATM
modem drivers, in thirteen patches:

01: trivial modifications (formatting, changes to variable names,
comments, log level changes, printk rate limiting).

02: have minidrivers tell the core about special requirements
using a flags field.

03: remove the unused .owner field in struct usbatm_driver.

04: use kzalloc rather than kmalloc + memset.

05: make xusbatm useable.

06: sternly tell open connections that the game is up when the
modem is disconnected.

07: return the correct error code when out of memory.

08: use dev_kfree_skb_any rather than dev_kfree_skb.

09: specify buffer sizes in bytes, rather than in ATM cells.

10: add mechanism for turning on isochronous urb support.

11: remove the assumption that incoming urbs contain
complete ATM cells.

12: bump some version numbers.

13: EILSEQ hack needed by the ueagle.

All the best,

Duncan.
