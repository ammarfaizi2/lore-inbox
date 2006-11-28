Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934961AbWK1Aj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934961AbWK1Aj4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 19:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934962AbWK1Aj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 19:39:56 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:43682 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S934961AbWK1Ajz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 19:39:55 -0500
Date: Mon, 27 Nov 2006 18:38:47 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Reserving a fixed physical address page of RAM.
In-reply-to: <fa.LC2HgQx8572p2lwOKfUm6cxg95s@ifi.uio.no>
To: linux-kernel@vger.kernel.org
Cc: Jon Ringle <JRingle@vertical.com>
Message-id: <456B8517.7040502@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.LC2HgQx8572p2lwOKfUm6cxg95s@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Ringle wrote:
> Hi,
> 
> I need to reserve a page of memory at a specific area of RAM that will
> be used as a "shared memory" with another processor over PCI. How can I
> ensure that the this area of RAM gets reseved so that the Linux's memory
> management (kmalloc() and friends) don't use it?
> 
> Some things that I've considered are iotable_init() and ioremap().
> However, I've seen these used for memory mapped IO devices which are
> outside of the RAM memory. Can I use them for reseving RAM too?
> 
> I appreciate any advice in this regard.

Sounds to me like dma_alloc_coherent is what you want..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

