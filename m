Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVHBOl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVHBOl4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 10:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVHBOjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 10:39:31 -0400
Received: from mail.dvmed.net ([216.237.124.58]:64999 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261573AbVHBObp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 10:31:45 -0400
Message-ID: <42EF83C8.3070003@pobox.com>
Date: Tue, 02 Aug 2005 10:31:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][PATCH] libata ATAPI alignment
References: <20050729050654.GA10413@havoc.gtf.org> <20050802082719.GA22569@suse.de>
In-Reply-To: <20050802082719.GA22569@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.2 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Jens Axboe wrote: > On Fri, Jul 29 2005, Jeff Garzik
	wrote: >>diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c >>---
	a/drivers/scsi/ahci.c >>+++ b/drivers/scsi/ahci.c >>@@ -44,7 +44,7 @@
	>> >> enum { >> AHCI_PCI_BAR = 5, >>- AHCI_MAX_SG = 168, /* hardware
	max is 64K */ >>+ AHCI_MAX_SG = 300, /* hardware max is 64K */ >>
	AHCI_DMA_BOUNDARY = 0xffffffff, >> AHCI_USE_CLUSTERING = 0, >>
	AHCI_CMD_SLOT_SZ = 32 * 32, > > > Reasoning? I agree, just wondering...
	How big is the allocated area now? [...] 
	Content analysis details:   (0.2 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.2 UPPERCASE_25_50        message body is 25-50% uppercase
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Jul 29 2005, Jeff Garzik wrote:
>>diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
>>--- a/drivers/scsi/ahci.c
>>+++ b/drivers/scsi/ahci.c
>>@@ -44,7 +44,7 @@
>> 
>> enum {
>> 	AHCI_PCI_BAR		= 5,
>>-	AHCI_MAX_SG		= 168, /* hardware max is 64K */
>>+	AHCI_MAX_SG		= 300, /* hardware max is 64K */
>> 	AHCI_DMA_BOUNDARY	= 0xffffffff,
>> 	AHCI_USE_CLUSTERING	= 0,
>> 	AHCI_CMD_SLOT_SZ	= 32 * 32,
> 
> 
> Reasoning? I agree, just wondering... How big is the allocated area now?

168 kept the entire allocated DMA area to 4K.

300 increases that to <I don't care>K.  ;-)

	Jeff


