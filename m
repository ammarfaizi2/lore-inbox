Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWGMOYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWGMOYV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 10:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbWGMOYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 10:24:21 -0400
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:47122 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S1751542AbWGMOYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 10:24:20 -0400
Date: Thu, 13 Jul 2006 16:24:18 +0200
From: Manuel Lauss <mano@roarinelk.homelinux.net>
To: Sergej Pupykin <ps@lx-ltd.ru>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Bugs in usb-skeleton.c??? :)
Message-ID: <20060713142418.GA14320@roarinelk.homelinux.net>
References: <m3odvtvj8w.fsf@lx-ltd.ru> <1152791917.3024.39.camel@laptopd505.fenrus.org> <m37j2helb4.fsf@lx-ltd.ru> <1152795650.3024.44.camel@laptopd505.fenrus.org> <m364i17irn.fsf@lx-ltd.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m364i17irn.fsf@lx-ltd.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 05:10:20PM +0400, Sergej Pupykin wrote:
>  >> Does kmalloc always allocate pages that can be used in DMA?
> 
>  AvdV> normally yes. HOWEVER....
> 
> I use sh4 cpu...

on SH-4 traditionally the whole memory space is mapped all the
time, so any space returned by kmalloc is DMA-able.
(I don't know if this applies to the SH-4A core, too)
 
>  AvdV> ..it is nicer to use the DMA allocation API (which internally may fall
>  AvdV> back to kmalloc etc), while kmalloc may work, it can be quite slow in
>  AvdV> how it's made to work. So it's just nicer to just use the DMA memory
>  AvdV> allocators... (see Documentation/DMA-API.txt file for a description of
>  AvdV> this)

agree

-- 
 ml.
