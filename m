Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946246AbWKAFiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946246AbWKAFiN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946369AbWKAFhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:37:47 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:11153 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946246AbWKAFhj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:37:39 -0500
Message-Id: <20061101053742.368996000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:33:57 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Brian King <brking@us.ibm.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 17/61] SCSI: DAC960: PCI id table fixup
Content-Disposition: inline; filename=scsi-dac960-pci-id-table-fixup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Brian King <brking@us.ibm.com>

[SCSI] DAC960: PCI id table fixup

The PCI ID table in the DAC960 driver conflicts with some devices
that use the ipr driver. All ipr adapters that use this chip
have an IBM subvendor ID and all DAC960 adapters that use this
chip have a Mylex subvendor id.

Signed-off-by: Brian King <brking@us.ibm.com>
Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/block/DAC960.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.1.orig/drivers/block/DAC960.c
+++ linux-2.6.18.1/drivers/block/DAC960.c
@@ -7115,7 +7115,7 @@ static struct pci_device_id DAC960_id_ta
 	{
 		.vendor 	= PCI_VENDOR_ID_MYLEX,
 		.device		= PCI_DEVICE_ID_MYLEX_DAC960_GEM,
-		.subvendor	= PCI_ANY_ID,
+		.subvendor	= PCI_VENDOR_ID_MYLEX,
 		.subdevice	= PCI_ANY_ID,
 		.driver_data	= (unsigned long) &DAC960_GEM_privdata,
 	},

--
