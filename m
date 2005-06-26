Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVFZEnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVFZEnc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 00:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVFZEnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 00:43:32 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27065
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261524AbVFZEnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 00:43:31 -0400
Date: Sat, 25 Jun 2005 21:43:27 -0700 (PDT)
Message-Id: <20050625.214327.41187346.davem@davemloft.net>
To: mvolaski@aecom.yu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] What is the significance of the "Out of IOMMU Space" error?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <a06230916bee3de9dd698@[129.98.90.227]>
References: <a06230916bee3de9dd698@[129.98.90.227]>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maurice Volaski <mvolaski@aecom.yu.edu>
Date: Sun, 26 Jun 2005 00:37:08 -0400

> This error doesn't seem to be mentioned much in this space. Should it 
> be taken at face value? Is it something simple like IOMMU should be 
> set to a higher value in the HDAMA bios? A kernel bug? Or could it 
> actually be bad physical memory or even a bad card?

It could be a DMA mapping leak in some kernel driver.
Or it could be that there is more DMA in flight than
the IOMMU space available can hold.
