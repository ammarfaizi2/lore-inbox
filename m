Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275582AbTHNX47 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 19:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275584AbTHNX47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 19:56:59 -0400
Received: from fw1.masirv.com ([65.205.206.2]:22408 "EHLO NEWMAN.masirv.com")
	by vger.kernel.org with ESMTP id S275582AbTHNX46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 19:56:58 -0400
Message-ID: <1060852129.15790.42.camel@huykhoi>
From: Anthony Truong <Anthony.Truong@mascorp.com>
To: linux-kernel@vger.kernel.org
Subject: pci_set_dma_mask() on masks other than 0xffffffff (32-bit systems
	)
Date: Thu, 14 Aug 2003 02:08:49 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Isn't this another reason for having the (controlled) bigphysarea into
the mainstream?
If our DMA devices are capable of handling only sub 32-bit DMA memory,
then they are limited to the first 16 MB set aside for GFP_DMA?  So if
we need more than 16 MB or if there is not enough left in this tiny
region, then we are finished :-(
Even when blessed with SG capable DMA engines, we have to make sure the
DMA processor capable of handling the worst-case scenario.  Like for a 4
MB buffer, it has to be able to fetch 1001 entry SG table.
Or maybe it's time to throw away all old and substandard HW.  Why do we
need to support them? :-(

Regards,
Anthony Dominic Truong.





Disclaimer: The information contained in this transmission, including any
attachments, may contain confidential information of Matsushita Avionics
Systems Corporation.  This transmission is intended only for the use of the
addressee(s) listed above.  Unauthorized review, dissemination or other use
of the information contained in this transmission is strictly prohibited.
If you have received this transmission in error or have reason to believe
you are not authorized to receive it, please notify the sender by return
email and promptly delete the transmission.


