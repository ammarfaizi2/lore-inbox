Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267916AbUHEV6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267916AbUHEV6S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267581AbUHEV47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:56:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52650 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267900AbUHEVyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:54:52 -0400
Message-ID: <4112AC4B.9010702@pobox.com>
Date: Thu, 05 Aug 2004 17:53:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Chew <achew@nvidia.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.8-rc2] sata_nv.c
References: <DBFABB80F7FD3143A911F9E6CFD477B03F9620@hqemmail02.nvidia.com>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B03F9620@hqemmail02.nvidia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Chew wrote:
> Attached is a patch to the sata_nv driver that accounts for a few
> differences between the nForce3 and CK804/MCP04 SATA controllers.
> 
> A minor change to libata-core.c needs to accompany this patch.  This is
> in regards to the function ata_pci_remove_one(), where the
> host_set->ops->host_stop(host_set) needs to occur before the
> iounmap(host_set->mmio_base).  This is because sata_nv's host_stop
> callback needs access to the iomapped region.

Do you want to send a separate patch for this?  I don't see that change 
in the attached patch.

	Jeff


