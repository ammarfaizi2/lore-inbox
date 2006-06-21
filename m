Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWFUCbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWFUCbL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 22:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWFUCbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 22:31:11 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:62206 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750862AbWFUCbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 22:31:10 -0400
Date: Tue, 20 Jun 2006 22:31:05 -0400
From: Brice Goglin <brice@myri.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Improve MSI detection v3
Message-ID: <20060621023104.GA16271@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 0/6] Improve MSI detection v3

Here's another set of patches to cleanup MSI detection.
There's only blacklisting (cleanup for non-PCI-E chipsets and
addition of HT cap checks).

#1 - Merge existing MSI disabling quirks
#2 - Rename PCI_CAP_ID_HT_IRQCONF to PCI_CAP_ID_HT
#3 - Blacklist PCI-E chipsets depending on Hypertransport MSI capabality
#4 - Factorize common MSI detection code from pci_enable_msi() and msix()
#5 - Stop inheriting bus flags and check root chipset bus flags instead
#6 - Drop pci_msi_quirk

Only #3 brings an important feature. The others are mostly cosmetic.
#1 defines a generic quirk to disable MSI. It will probably end up being
used for lots of MSI-broken chipset.

These patches are against 2.6.17-rc6-mm2.

Brice Goglin
