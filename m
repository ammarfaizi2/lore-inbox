Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVCCNlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVCCNlu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 08:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVCCNlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 08:41:50 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:53431 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261661AbVCCNkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 08:40:17 -0500
Date: Thu, 3 Mar 2005 14:40:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: pci_find_class obsolete
Message-ID: <Pine.LNX.4.61.0503031436490.22266@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,


after switching to 2.6.11-rc5-bk2 (from 2.6.9-rc2), I found that the nvidia 
module (1.0-4996, old, I know) does not compile anymore, because it
requires pci_find_class():

nv.c:
static int
nvos_probe_devices(void)
{
    ...
    struct pci_dev *dev;
    ...
    dev = pci_find_class(PCI_CLASS_DISPLAY_VGA << 8, dev);
    ...
}

What function would I need to use, now that pci_find_class is gone?


Jan Engelhardt
-- 
