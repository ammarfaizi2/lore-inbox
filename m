Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbUCCRbZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 12:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbUCCRbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 12:31:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20390 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262529AbUCCRbY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 12:31:24 -0500
Message-ID: <4046165E.1000802@pobox.com>
Date: Wed, 03 Mar 2004 12:31:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: RANDAZZO@ddc-web.com
CC: linux-kernel@vger.kernel.org
Subject: Re: custom Pci netdevice using DMA
References: <89760D3F308BD41183B000508BAFAC4104B16FC0@DDCNYNTD>
In-Reply-To: <89760D3F308BD41183B000508BAFAC4104B16FC0@DDCNYNTD>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RANDAZZO@ddc-web.com wrote:
> All:
> 
> I have a PCI device (uses DMA), that was originally designed for an RTOS...
> 
> The device takes physical host address pointers (written to the card via bar
> space).
> 
> When data is received from the network, the pci card will DMA the data
> directly to the
> host asynchronously....
> 
> after a certain amt of data is received, an interrupt is gen'd and the host
> goes and looks at the data..
> 
> For transmitting, the host gives the pci device a physical host address
> value and the pci device will DMA the
> data, from the host, that is pointed to......
> 
> ...............................
> This above design does not work in Linux 2.4.  I understand that I must use
> the dma functions (pci_alloc_*,
> virt_to_bus, etc), but can't figure out what is the best way???


Documentation/DMA-mapping.txt, Documentation/DMA-API.txt

	Jeff



