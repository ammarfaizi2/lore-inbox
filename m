Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVILKDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVILKDU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 06:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVILKDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 06:03:20 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:42448 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750709AbVILKDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 06:03:19 -0400
Subject: Re: [1/3] Add 4GB DMA32 zone
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org
In-Reply-To: <43246267.mailL4R11PXCB@suse.de>
References: <43246267.mailL4R11PXCB@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Sep 2005 11:28:19 +0100
Message-Id: <1126520900.30449.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One argument was still if the zone should be 4GB or 2GB. The main
> motivation for 2GB would be an unnamed not so unpopular hardware
> raid controller (mostly found in older machines from a particular four letter
> company) who has a strange 2GB restriction in firmware. But 

Adaptec AACRAID is one offender

> that one works ok with swiotlb/IOMMU anyways, so it doesn't really

Old aacraid actually cannot use IOMMU. It isn't alone in that
limitation. Most hardware that has a 30/31bit limit can't go via the
IOMMU because IOMMU space appears on the bus above 2GB so is itself
invisible to the hardware.

Other devices with similar limits include the broadcomm b44


