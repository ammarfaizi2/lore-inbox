Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWCUBMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWCUBMc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 20:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWCUBMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 20:12:31 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:7909 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932261AbWCUBMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 20:12:30 -0500
Message-ID: <441F52F7.8030309@garzik.org>
Date: Mon, 20 Mar 2006 20:12:23 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] libata updates
References: <20060320111658.GA16172@havoc.gtf.org> <1142872556.21455.7.camel@localhost.localdomain>
In-Reply-To: <1142872556.21455.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.2 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2006-03-20 at 06:16 -0500, Jeff Garzik wrote:
> 
>>Jeff Garzik:
>>      [libata] Move PCI IDE BMDMA-related code to new file libata-bmdma.c.
> 
> 
> This is a most confusing choice as 80% of the file has nothing to do
> with bus mastering DMA, and a large amount of it has nothing to do with
> PCI either. Also lots of DMA stuff is in the drivers so all the new bus
> mastering drivers don't use bmdma.c
> 
> The split makes sense, the choice of name is peculiar, if not completely
> broken 8)

Peculiar?  Probably...  :)

In my [no doubt warped] brain, I equate the SFF-8038 interface to "PCI 
IDE BMDMA", and from there, view most hardware as a subset of PCI IDE 
BMDMA.  It might not do DMA, might not be PCI, might not do irqs, but 
most PATA hardware seems able to be driven by a "bmdma driver".  Thus, 
the name :)

	Jeff



