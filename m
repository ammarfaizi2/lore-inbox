Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbTLDFLs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 00:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbTLDFLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 00:11:48 -0500
Received: from hqemgate00.nvidia.com ([216.228.112.144]:53513 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S263106AbTLDFLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 00:11:47 -0500
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F874@mail-sc-6.nvidia.com>
From: Allen Martin <AMartin@nvidia.com>
To: "'Jesse Allen'" <the3dfxdude@hotmail.com>, b@netzentry.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: NForce2 pseudoscience stability testing (2.6.0-test11)
Date: Wed, 3 Dec 2003 21:11:37 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jesse Allen [mailto:the3dfxdude@hotmail.com] 
> Sent: Wednesday, December 03, 2003 6:46 PM
> To: b@netzentry.com
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
> 
> I suppose I could try right now.  I don't have a pci ide with 
> me right now, but I do have pci scsi cards.  But doesn't 
> running with the generic ide driver basically prove the same 
> thing?  APIC & Generic IDE: works, PIC & nForce IDE: works, 
> APIC & nForce IDE: deadlocks.  It's not like we are expecting 
> faulty nforce ide hardware, or are we?

I don't think there's any faulty nForce IDE hardware or we would have heard
about it from windows users (and we haven't).  

The problem with comparing the nForce IDE driver against the generic IDE
driver is that the generic IDE driver won't enable DMA, so the interrupt
rate will be much different.  If there's some interrupt race condition in
APIC mode, disabling DMA may mask it.

Also are people who are having problems using rounded or flat cables?  It's
possible the problem could be related to DMA CRC errors.  Switching to flat
cables can help with that.

-Allen
