Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266491AbUIPVeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266491AbUIPVeL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 17:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUIPVeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 17:34:11 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:61148 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S266491AbUIPVeA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 17:34:00 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: 2.6.9-rc2-mm1: Setting IDE DMA fails
Date: Fri, 17 Sep 2004 05:34:24 +0800
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409170534.24034.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

IDE DMA setting fails in 2.6.9-rc2-mm1 with the ff. dmesg:
...
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI interrupt 0000:00:11.1[A]: no GSI
ACPI: PCI interrupt 0000:00:11.1[A]: no GSI
VP_IDE: (ide_setup_pci_device:) Could not enable device.
...

Reversing the following patches fixed it for me:

incorrect-pci-interrupt-assignment-on-es7000-for-pin-zero.patch
incorrect-pci-interrupt-assignment-on-es7000-for-platform-gsi-fix.patch
incorrect-pci-interrupt-assignment-on-es7000-for-platform-gsi.patch

Tony


