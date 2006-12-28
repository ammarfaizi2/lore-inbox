Return-Path: <linux-kernel-owner+w=401wt.eu-S933023AbWL1SdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933023AbWL1SdG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 13:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933021AbWL1SdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 13:33:06 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:62144 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933023AbWL1SdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 13:33:05 -0500
Date: Thu, 28 Dec 2006 12:34:39 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] introduce config option to disable DMA zone on i386
In-reply-to: <fa.XVmR+7tQ0v2oWVb7eyfQ8pGFhp8@ifi.uio.no>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>
Message-id: <45940E3F.1050506@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.Nb4Y/frBNPmoag6ZL4pL3qEyDOs@ifi.uio.no>
 <fa.XVmR+7tQ0v2oWVb7eyfQ8pGFhp8@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> Hi,
> 
> since one gets random corruption if a user gets this wrong, at least
> make things like floppy and all CONFIG_ISA stuff conflict with this
> option.... without that your patch feels like a walking time bomb...
> (and please include all PCI drivers that only can do 24 bit or 28bit
> or .. non-32bit dma as well)

That sounds like a bug if this can happen. Drivers should be failing to 
initialize if they can't set the proper DMA mask, and the DMA API calls 
should be failing if the requested DMA mask can't be provided.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

