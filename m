Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269377AbUJSKhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269377AbUJSKhv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269405AbUJSKg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:36:57 -0400
Received: from holomorphy.com ([207.189.100.168]:15783 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269377AbUJSKNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 06:13:09 -0400
Date: Tue, 19 Oct 2004 03:13:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
Cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: DMA memory allocation --how to  more than 1 MB
Message-ID: <20041019101303.GK5607@holomorphy.com>
References: <4EE0CBA31942E547B99B3D4BFAB34811175F32@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB34811175F32@mail.esn.co.in>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 11:18:13AM +0530, Srinivas G. wrote:
> I have a doubt about allocating the DMA memory using kmalloc OR
> __get_dma_pages OR pci_alloc_consistent. I was unable to allocate the
> memory greater than 1 MB using any one of the above memory functions. 
> Is there any other method which will allocate the DMA memory greater
> than 1 MB?
> My system configuration is: Red Hat 7.3 with 2.4.18-3 kernel version on
> IA32 platform. 

This is not supported at runtime. If this is an absolute requirement,
using the bootmem.c physical memory reservation system from architecture-
specific initialization code is the way.

It's more likely that you should be using scatter/gather than that you
should try to carry that out.


-- wli
