Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268253AbUIPVEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268253AbUIPVEl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 17:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268260AbUIPVEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 17:04:41 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:19912 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268253AbUIPVE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 17:04:29 -0400
Subject: Re: Having problem with mmap system call!!!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: "Srinivas G." <srinivasg@esntechnologies.co.in>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0409161404001.13362@chaos>
References: <4EE0CBA31942E547B99B3D4BFAB348111078FE@mail.esn.co.in>
	 <Pine.LNX.4.53.0409160958070.12146@chaos>
	 <1095341494.22744.26.camel@localhost.localdomain>
	 <Pine.LNX.4.53.0409161050200.12305@chaos>
	 <1095350240.22750.37.camel@localhost.localdomain>
	 <Pine.LNX.4.53.0409161404001.13362@chaos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095364875.22750.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Sep 2004 21:01:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-16 at 19:13, Richard B. Johnson wrote:

> 	for (i = 0; i < v->page_count; i++) {
> 		unsigned long page = virt_to_phys((void *)v->desc[i]);
> 		if (remap_page_range(start, page, PAGE_SIZE, PAGE_READONLY)) {
> 			err = -EAGAIN;
> 			goto out;
> 		}
> 		start += PAGE_SIZE;

Actually thats a nice example of how easy it is to implement mmap
properly.


> you usually say... Anyway are you aware that ...
> 
> 	unsigned long size  = vma->vm_end - vma->vm_start;
> 
> ... ends up being 32 bytes longer than the length the user-mode
> code put into mmap()?

Its page aligned, that is what mmap() says happens.

