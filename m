Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbVEGVzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbVEGVzw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 17:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbVEGVzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 17:55:51 -0400
Received: from [84.4.184.197] ([84.4.184.197]:43684 "EHLO neo.systheo.com")
	by vger.kernel.org with ESMTP id S262747AbVEGVzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 17:55:47 -0400
From: =?iso-8859-15?q?=C9ric_BURGHARD?= <eric.burghard@systheo.com>
Organization: Systheo
To: gregkh@suse.de
Subject: quirks.c patch for Asus W1N laptop model support (asus_hides_smbus)
Date: Sun, 8 May 2005 00:01:15 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505080001.15329.eric.burghard@systheo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a patch for W1N notebook.

Thanks.

--- quirks.c.old        2005-05-07 04:18:38.000000000 +0200
+++ quirks.c    2005-05-07 11:52:07.000000000 +0200
@@ -787,6 +787,7 @@
                if (dev->device == PCI_DEVICE_ID_INTEL_82855PM_HB)
                        switch (dev->subsystem_device) {
                        case 0x186a: /* M6Ne notebook */
+                       case 0x184b: /* W1N notebook */
                                asus_hides_smbus = 1;
                        }
        } else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_HP)) {
