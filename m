Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWFAHJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWFAHJJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 03:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWFAHJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 03:09:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:52666 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750710AbWFAHJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 03:09:08 -0400
X-IronPort-AV: i="4.05,195,1146466800"; 
   d="scan'208"; a="44202331:sNHT14023503340"
Message-ID: <447E91CE.7010705@intel.com>
Date: Thu, 01 Jun 2006 15:05:50 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: akpm@osdl.org
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [BUG](-mm)pci_disable_device function clear bars_enabled element
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I found that in -mm tree, function pci_disable_device() clears bars_enabled variable, so that pci_release_regions can not release reserved PCI I/O and memory resource. Some device driver programs in kernel tree call pci_release_regions function after pci_disable_device(), that will cause some problem.
And I do not know whether pci_disable_device() function should be modified or device drivers should be adjusted.

Thanks
bibo,mao
