Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWCVD4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWCVD4J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 22:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWCVD4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 22:56:09 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:62142 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750722AbWCVD4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 22:56:06 -0500
Message-ID: <4420CAD4.60700@garzik.org>
Date: Tue, 21 Mar 2006 22:56:04 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Sweetman <safemode@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: libata ignores non-dma disks?
References: <4420B7D6.4020706@comcast.net>
In-Reply-To: <4420B7D6.4020706@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.5 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:
> I'm using 2.6.16-rc6-ide1 (alan's patchset) and using the sata_nv and
> pata_amd drivers.  I have all UDMA drives except a CF disk -> IDE
> interface, which should be running in PIO mode4.   Libata detects the
> device, but spits out a message about "no dma" and then says it's not
> supported and is ignoring it.   Is this device not supported because
> it's not using dma or for some other reason?
> It's the only device on it's channel (secondary pata)
> 
> ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
> ata6: dev 0 cfg 49:0e00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000
> 88:0000
> ata6: no dma
> ata6: dev 0 not supported, ignoring
> scsi5 : pata_amd

Delete the "no dma" check, and debug from there...  PIO support is in 
there, just needs a few final fixes.

	Jeff



