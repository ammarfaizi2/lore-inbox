Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263693AbTKFQEp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 11:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263688AbTKFQEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 11:04:45 -0500
Received: from pop3.galileo.co.il ([199.203.130.130]:62892 "EHLO
	mail.galileo.co.il") by vger.kernel.org with ESMTP id S263681AbTKFQEl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 11:04:41 -0500
Message-ID: <3FAA712F.2030409@il.marvell.com>
Date: Thu, 06 Nov 2003 18:05:03 +0200
From: Mark Mokryn <markm@il.marvell.com>
Organization: Marvell Semiconductor
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm@vger.kernel.org
Subject: Highmem SCSI driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are trying to test 64-bit PCI DMA for a SCSI driver on a Xeon box, 
RH9 2.4.20-8 bigmem kernel, 6GB RAM.
The machine shows 6GB in top, we set highmem_io in the driver, PCI DMA 
mask covers 64-bit range, etc.

Of course we're trying to make sure that the system does not create 
bounce buffers unnecessarily. On a 64-bit box (AMD64) everything works 
as expected. On the Xeon, no matter what we try, we never see I/Os 
mapped above 4GB.

Any ideas on how we can drive I/Os mapped above 4GB down to our driver?

Thanks,
-Mark

