Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVF2AmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVF2AmC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVF2AkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:40:21 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:41575 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262324AbVF2ABX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:01:23 -0400
Message-ID: <42C1E5CA.6060507@gentoo.org>
Date: Wed, 29 Jun 2005 01:05:30 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050403)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davej@codemonkey.org.uk
Cc: ak@suse.de, linux-kernel@vger.kernel.org, sfudally@fau.edu
Subject: [PATCH] amd64-agp: Add SIS760 PCI ID
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080308020209010705030502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080308020209010705030502
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From: Scott Fudally <sfudally@fau.edu>

This patch adds the SiS 760 ID to the amd64-agp driver, so that agpgart can be
used on Athlon64 boards based on this chip.

Scott already submitted this but did not recieve any response. To ensure it
has been sent in correctly, I am resubmitting this now on his behalf.

Signed-off-by: Daniel Drake <dsd@gentoo.org>


--------------080308020209010705030502
Content-Type: text/x-patch;
 name="sis760-agp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sis760-agp.patch"

--- linux/drivers/char/agp/amd64-agp.c.orig	2005-06-29 00:54:37.000000000 +0100
+++ linux/drivers/char/agp/amd64-agp.c	2005-06-29 00:56:16.000000000 +0100
@@ -686,6 +686,15 @@ static struct pci_device_id agp_amd64_pc
 	.subvendor	= PCI_ANY_ID,
 	.subdevice	= PCI_ANY_ID,
 	},
+	/* SIS 760 */
+	{
+	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
+	.class_mask	= ~0,
+	.vendor		= PCI_VENDOR_ID_SI,
+	.device		= PCI_DEVICE_ID_SI_760,
+	.subvendor	= PCI_ANY_ID,
+	.subdevice	= PCI_ANY_ID,
+	},
 	{ }
 };
 

--------------080308020209010705030502--
