Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265353AbUAHQwD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 11:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265371AbUAHQwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 11:52:03 -0500
Received: from lightning.hereintown.net ([141.157.132.3]:42936 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S265353AbUAHQv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 11:51:59 -0500
Subject: Re: MegaRAID on AMD64 under 2.6.1
From: Chris Meadors <clubneon@hereintown.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040108121227.B8987@infradead.org>
References: <1073512887.8211.39.camel@clubneon.priv.hereintown.net>
	 <20040108121227.B8987@infradead.org>
Content-Type: text/plain
Message-Id: <1073580718.8870.45.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 08 Jan 2004 11:51:58 -0500
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1AedO2-0006Je-S6*D1GriAy6GxY*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-08 at 07:12, Christoph Hellwig wrote:

> Can you put a printk into megaraid_probe_one() whether that one actually
> gets called?

It looks like megaraid_probe_one() only gets called if
megaraid_pci_tbl[] contains the right IDs.

> Also lspci -n output would be very nice to have.

02:07.0 Class 0104: 1000:1960 (rev 01)

i.e. PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_AMI_MEGARAID3

When I added the lines for that combination to megaraid_pci_tbl[], the
driver found the card.  So, I'm cool now.

-- 
Chris

