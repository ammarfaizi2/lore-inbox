Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbTISJIC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 05:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbTISJIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 05:08:02 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:7345 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261421AbTISJIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 05:08:00 -0400
Subject: Re: vmalloc and DMA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stevie-O <oliver@klozoff.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F6A61E9.1060407@klozoff.com>
References: <3F6A61E9.1060407@klozoff.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063962334.18308.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Fri, 19 Sep 2003 10:05:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-09-19 at 02:54, Stevie-O wrote:
> I need to treat a large number of pages (about 128) as continuous. 

Continuous to whom ?

> (2) Is it appropriate to vmalloc_32(512<<10) and then grab the underlying 
> addresses for DMA?
> (3) If it *is* appropriate, what's the proper way to get to those underlying 
> addresses? I saw a virt_to_page macro somewhere...

If you use the pci_alloc interfaces you'll get what you want except for
them not being fake contiguous to the kernel. You can still make them 
contiguous to user space.

