Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVEaPxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVEaPxl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 11:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVEaPxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 11:53:41 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:62137 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261915AbVEaPxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 11:53:40 -0400
Message-ID: <429C87FF.5070003@ammasso.com>
Date: Tue, 31 May 2005 10:51:27 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Gerd Knorr <kraxel@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Will __pa(vmalloc()) ever work?
References: <4297746C.10900@ammasso.com> <873bs5yrxj.fsf@bytesex.org>
In-Reply-To: <873bs5yrxj.fsf@bytesex.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:

> You should use vmalloc_to_page() (this does the page-table walking
> with correct locking), then the usual dma mapping interface
> (pci_map_page() or pci_map_sg()) to get bus address(es) you can pass
> to your device for DMA.

My problem is that I don't know where the memory came from.  It could have been allocated 
via kmalloc, or vmalloc, or anywhere else.  Can I call vmalloc_to_page() on memory 
allocated via kmalloc()?  If the answer is no, then how can I tell whether the memory was 
allocated via vmalloc() or some other method?  I need a reliable virtual-to-physical (or 
virtual-to-bus, which is the same thing on x86 architectures) method for any memory address.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
