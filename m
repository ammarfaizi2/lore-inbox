Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266575AbUBMO2n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 09:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUBMO2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 09:28:42 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:13456 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266575AbUBMO2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 09:28:00 -0500
Subject: Re: [Patch] dma_sync_to_device
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Martin Diehl <lists@mdiehl.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 13 Feb 2004 09:27:54 -0500
Message-Id: <1076682474.2159.17.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to be sure we eliminate all confusion (and it amazes me how
frequently this comes up), could you add some words DMA-mapping.txt to
make clear that this new API does not address PCI posting (which is a
problem with onward write cache flushing in the PCI bridge)---otherwise
I can see device driver writers thinking that
pci_dma_sync_to_device_single(... DMA_TO_DEVICE) will flush posted
writes.

Thanks,

James


