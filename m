Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbULFBdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbULFBdY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 20:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbULFBdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 20:33:24 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:49249 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261449AbULFBdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 20:33:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=cO5CyyyyogdoxxXKPmQVlVi66FwwtF5bi2bmZEpKoMQxnTFHYG1+LaTPHqNrH/tcmJW91Uggaa/v7NStSGPkazLAWe/Wdto03+58bbbmphc4FF+cJkHa19C8zNh/3RGWHfTNgxz6qBrXmxY3WaEi+l0l0ZUZnS+eEv6jnW8Z+1U=
Message-ID: <3b2b32004120517312d1cfe6c@mail.gmail.com>
Date: Sun, 5 Dec 2004 20:31:11 -0500
From: Linh Dang <dang.linh@gmail.com>
Reply-To: Linh Dang <dang.linh@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH][PPC32[NEWBIE] enhancement to virt_to_bus/bus_to_virt (try 2)
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <16819.31194.561882.514591@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3b2b32004120206497a471367@mail.gmail.com>
	 <3b2b320041202082812ee4709@mail.gmail.com>
	 <16815.31634.698591.747661@cargo.ozlabs.ibm.com>
	 <3b2b32004120306463b016029@mail.gmail.com>
	 <16819.31194.561882.514591@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004 08:12:58 +1100, Paul Mackerras <paulus@samba.org> wrote:
> Linh Dang writes:
> 
> > I wrote a DMA engine (to used by other drivers) that (would like to) accept
> > all kind of buffers as input (vmalloced, dual-access shared RAM mapped
> > by BATs, etc). The DMA engine has to decode the virtual address of the
> > input buffer to (possibly multiple) physical  address(es). virt_to_phys()
> > has the right name for the job except it only works for the kernel virtual
> > addresses initially mapped at KERNELBASE
> 
> Have you read Documentation/DMA-API.txt?  It explains the official
> kernel API for DMA, and drivers should use it in order to be portable
> to more than just one architecture.

Thanx for the pointer, I'll read that carefully

> 
> If you want to create a competing DMA API, you'll have to show us at
> least one driver that really needs your new API.
> 

I think I'll implement the official DMA API for my card (the card uses the
Marvell 64460 as bridge).

> Also, please don't change the existing virt_to_*/*_to_virt functions.
> Instead define your own functions (with different names) in the same
> source file as your other new code.

Thanx for the answers.

-- 
Linh Dang
